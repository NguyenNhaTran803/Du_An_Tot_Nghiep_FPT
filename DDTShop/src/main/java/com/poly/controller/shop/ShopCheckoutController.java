package com.poly.controller.shop;

import java.io.IOException;
import java.util.Collection;

import javax.transaction.Transactional;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.poly.common.Pay;
import com.poly.common.Ship;
import com.poly.common.Status;
import com.poly.dto.Item;
import com.poly.dto.OrderAddressDto;
import com.poly.model.Order;
import com.poly.model.OrderAddress;
import com.poly.model.OrderDetail;
import com.poly.model.Product;
import com.poly.model.User;
import com.poly.service.CartService;
import com.poly.service.OrderAddressService;
import com.poly.service.OrderDetailService;
import com.poly.service.OrderService;
import com.poly.service.ProductService;
import com.poly.service.SecurityService;
import com.poly.service.SessionService;
import com.poly.service.UserService;

@Transactional
@Controller
@RequestMapping(value = "ddt/check-out")
public class ShopCheckoutController {

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

	@GetMapping(value = "")
	public String checkOut(Model model) {
		Collection<Item> items = cartService.getItems();
		model.addAttribute("carts", items);

		float totail = cartService.getTotail();
		if (session.get("shipping") != null) {
			model.addAttribute("shipping", session.get("shipping").toString());
			if (session.get("shipping").toString().equals("1"))
				totail = totail + 10000;
			else if (session.get("shipping").toString().equals("2"))
				totail = totail + 30000;
		}
		model.addAttribute("totalCart", totail);

		OrderAddressDto orderAddressDto = new OrderAddressDto();
		if (securityService.isAuthenticated()) {
			String username = securityService.username();
			User user = userService.findByUsername(username).get();
			if (orderAddressService.existsByEmail(user.getEmail())) {
				OrderAddress orderAddress = orderAddressService.findByEmail(user.getEmail()).get();
				orderAddressDto.setId(orderAddress.getId());
				orderAddressDto.setFirstName(orderAddress.getFirstName());
				orderAddressDto.setLastName(orderAddress.getLastName());
				orderAddressDto.setProvince(orderAddress.getProvince());
				orderAddressDto.setDistrict(orderAddress.getDistrict());
				orderAddressDto.setWard(orderAddress.getWard());
				orderAddressDto.setAddress(orderAddress.getAddress());
				orderAddressDto.setPhone(orderAddress.getPhone());
				orderAddressDto.setEmail(orderAddress.getEmail());
			} else {
				orderAddressDto.setFirstName(user.getFirstName());
				orderAddressDto.setLastName(user.getLastName());
				orderAddressDto.setAddress(user.getAddress());
				orderAddressDto.setEmail(user.getEmail());
			}
		}
		model.addAttribute("orderAddressDto", orderAddressDto);
		return "shop/cart/check-out";
	}

	@PostMapping(value = "/submit")
	public String checkOutSubmit(Model model, @Valid @ModelAttribute("orderAddressDto") OrderAddressDto orderAddressDto,
			BindingResult result, @RequestParam(name = "note") String note)
			throws IOException {
		Collection<Item> itemsCart = cartService.getItems();
		model.addAttribute("carts", itemsCart);

		float totail = cartService.getTotail();
		if (session.get("shipping") != null) {
			model.addAttribute("shipping", session.get("shipping").toString());
			if (session.get("shipping").toString().equals("1"))
				totail = totail + 10000;
			else if (session.get("shipping").toString().equals("2"))
				totail = totail + 30000;
		}
		model.addAttribute("totalCart", totail);
		//
		if (result.hasErrors()) {
			model.addAttribute("error", "Lỗi định dạng");
			return "shop/cart/check-out";
		}
		if (!securityService.isAuthenticated()) {
			if (userService.existsByEmail(orderAddressDto.getEmail())) {
				model.addAttribute("error", "Email đã được sử dụng");
				return "shop/cart/check-out";
			}
		}
		OrderAddress orderAddress = new OrderAddress();
		orderAddress.setId(orderAddressDto.getId());
		orderAddress.setFirstName(orderAddressDto.getFirstName());
		orderAddress.setLastName(orderAddressDto.getLastName());
		orderAddress.setAddress(orderAddressDto.getAddress());
		orderAddress.setPhone(orderAddressDto.getPhone());
		orderAddress.setEmail(orderAddressDto.getEmail());
		OrderAddress orderAddressOld = orderAddressService.saveOrUpdate(orderAddress).get();
		
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
		order.setPay(Pay.UNPAID);
		order.setOrderAddress(orderAddressOld);
		Order orderOld = orderService.saveOrUpdate(order).get();
		
		Collection<Item> items = cartService.getItems();
		items.forEach(item -> {
			Product product = productService.findById(item.getId()).get();
			
			OrderDetail orderDetail = new OrderDetail();
			orderDetail.setName(item.getName());
			orderDetail.setBanner(item.getImage());
//			orderDetail.setSize(item.getSize());
			orderDetail.setPrice(item.getPrice());
			orderDetail.setDiscount(item.getDiscount());
			orderDetail.setQuantity(item.getQuantity());
			orderDetail.setProduct(product);
			orderDetail.setOrder(orderOld);
			orderDetailService.saveOrUpdate(orderDetail);
			product.setQuantity(product.getQuantity() - item.getQuantity());
			productService.saveOrUpdate(product);
		});
		cartService.clear();
		session.remove("shipping");
		return "redirect:/ddt/home";
	}
}
