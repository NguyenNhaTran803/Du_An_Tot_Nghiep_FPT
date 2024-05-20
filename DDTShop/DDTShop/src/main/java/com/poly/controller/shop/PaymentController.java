package com.poly.controller.shop;


import java.util.Collection;

import javax.servlet.http.HttpServletRequest;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.poly.common.Pay;
import com.poly.common.Ship;
import com.poly.common.Status;
import com.poly.dto.Item;
import com.poly.dto.OrderAddressDto;

import com.poly.service.CartService;
import com.poly.service.ColorService;
import com.poly.service.OrderAddressService;
import com.poly.service.OrderDetailService;
import com.poly.service.OrderService;
import com.poly.service.ProductService;
import com.poly.service.SecurityService;
import com.poly.service.SessionService;
import com.poly.service.SizeService;
import com.poly.service.UserService;
import com.poly.model.Color;
import com.poly.model.Order;
import com.poly.model.OrderAddress;
import com.poly.model.OrderDetail;
import com.poly.model.Product;
import com.poly.model.Size;
import com.poly.service.VNPayService;

@Controller
@RequestMapping("")
public class PaymentController {

	@Autowired
	private VNPayService vnPayService;

	@Autowired
	CartService cartService;

	@Autowired
	SessionService session;

	@Autowired
	SecurityService securityService;

	@Autowired
	UserService userService;

	@Autowired
	OrderAddressService orderAddressService;

	@Autowired
	OrderService orderService;

	@Autowired
	OrderDetailService orderDetailService;

	@Autowired
	ProductService productService;
	
	@Autowired
	SizeService sizeService;
	
	@Autowired
	ColorService colorService;

	@GetMapping(value = "/create_payment")
	public String home(Model model, @RequestParam(name = "amount", defaultValue = "0") int totalCart,
			@RequestParam(name = "note", required = false) String note, OrderAddressDto orderAddressDto,
			BindingResult result, HttpServletRequest request) {
		
		// Lấy danh sách sản phẩm trong giỏ hàng
		Collection<Item> items = cartService.getItems();
		model.addAttribute("carts", items);
		// Tính tổng giá trị đơn hàng
		float totail = cartService.getTotail();
		if (session.get("shipping") != null) {
			model.addAttribute("shipping", session.get("shipping").toString());
			if (session.get("shipping").toString().equals("1"))
				totail = totail + 10000;
			else if (session.get("shipping").toString().equals("2"))
				totail = totail + 30000;
		}
		model.addAttribute("totalCart", totail);
		// Xử lý lỗi định dạng
		if (result.hasErrors()) {
			model.addAttribute("error", "Lỗi định dạng");
			return "shop/cart/check-out";
		}
		// Kiểm tra đăng nhập
		if (!securityService.isAuthenticated()) {
			if (userService.existsByEmail(orderAddressDto.getEmail())) {
				model.addAttribute("error", "Email đã được sử dụng");
				return "shop/cart/check-out";
			}
		}
		// Lưu thông tin địa chỉ đơn hàng
		OrderAddress orderAddress = new OrderAddress();
		orderAddress.setId(orderAddressDto.getId());
		orderAddress.setFirstName(orderAddressDto.getFirstName());
		orderAddress.setLastName(orderAddressDto.getLastName());
		orderAddress.setProvince(orderAddressDto.getProvince());
		orderAddress.setDistrict(orderAddressDto.getDistrict());
		orderAddress.setWard(orderAddressDto.getWard());
		orderAddress.setAddress(orderAddressDto.getAddress());
		orderAddress.setPhone(orderAddressDto.getPhone());
		orderAddress.setEmail(orderAddressDto.getEmail());

		OrderAddress orderAddressOld = orderAddressService.saveOrUpdate(orderAddress).get();
		
		// Lưu thông tin đơn hàng
		Order order = new Order();
		order.setNote(note);
		order.setStatus(Status.AWAITING_CONFIRMATION);
		if (session.get("shipping") != null) {
			if (session.get("shipping").toString().equals("1"))
				order.setShip(Ship.STANDART);
			else if (session.get("shipping").toString().equals("2"))
				order.setShip(Ship.EXPRESS);
			else
				order.setShip(Ship.FREE);
		}
		order.setPay(Pay.PAID);
		order.setOrderAddress(orderAddressOld);
		Order orderOld = orderService.saveOrUpdate(order).get();
		// Lưu thông tin chi tiết đơn hàng và cập nhật số lượng sản phẩm
		/*
		 * items.forEach(item -> { Product product =
		 * productService.findById(item.getId()).get(); // Size size =
		 * sizeService.findById(item.getId()).get(); // Color color =
		 * colorService.findById(item.getId()).get(); OrderDetail orderDetail = new
		 * OrderDetail(); orderDetail.setName(item.getName());
		 * orderDetail.setBanner(item.getImage()); // orderDetail.setSize(size); //
		 * orderDetail.setColor(color);
		 * 
		 * orderDetail.setPrice(item.getPrice());
		 * orderDetail.setDiscount(item.getDiscount());
		 * orderDetail.setQuantity(item.getQuantity()); orderDetail.setProduct(product);
		 * orderDetail.setOrder(orderOld); orderDetailService.saveOrUpdate(orderDetail);
		 * product.setQuantity(product.getQuantity() - item.getQuantity());
		 * productService.saveOrUpdate(product); });
		 */
		items.forEach(item -> {
		    Product product = productService.findById(item.getId()).orElse(null);

		    if (product != null) {
		        OrderDetail orderDetail = new OrderDetail();
		        orderDetail.setName(item.getName());
		        orderDetail.setBanner(item.getImage());

		        orderDetail.setPrice(item.getPrice());
		        orderDetail.setDiscount(item.getDiscount());
		        orderDetail.setQuantity(item.getQuantity());
		        orderDetail.setProduct(product);
		        orderDetail.setOrder(orderOld);
		        
		        // Lấy thông tin về Size và Color từ Product
		        Size size = product.getSize();
		        Color color = product.getColor();

		        orderDetail.setSize(size);
		        orderDetail.setColor(color);

		        orderDetailService.saveOrUpdate(orderDetail);

		        // Giảm số lượng của Product
		        product.setQuantity(product.getQuantity() - item.getQuantity());
		        productService.saveOrUpdate(product);
		    }
		});

		/* cartService.clear(); */
		session.remove("shipping");

		return "shop/vnpay/index";
	}

	@PostMapping("/submitOrder")
	public String submidOrder(@RequestParam("amount") int orderTotal, @RequestParam("orderInfo") String orderInfo,
			HttpServletRequest request, Model model) {

		// Tạo URL thanh toán và chuyển hướng
		String baseUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();
		String vnpayUrl = vnPayService.createOrder(orderTotal, orderInfo, baseUrl);
		System.out.println(vnpayUrl);
		return "redirect:" + vnpayUrl;
	}

	@GetMapping("/vnpay-payment")
	public String GetMapping(HttpServletRequest request, Model model) {
		int paymentStatus = vnPayService.orderReturn(request);

		String orderInfo = request.getParameter("vnp_OrderInfo");
		String paymentTime = request.getParameter("vnp_PayDate");
		String transactionId = request.getParameter("vnp_TransactionNo");
		String totalPrice = request.getParameter("vnp_Amount");

		model.addAttribute("orderId", orderInfo);
		model.addAttribute("totalPrice", totalPrice);
		model.addAttribute("paymentTime", paymentTime);
		model.addAttribute("transactionId", transactionId);
		cartService.clear();
		return paymentStatus == 1 ? "shop/vnpay/ordersuccess" : "shop/vnpay/orderfail";
	}
}
