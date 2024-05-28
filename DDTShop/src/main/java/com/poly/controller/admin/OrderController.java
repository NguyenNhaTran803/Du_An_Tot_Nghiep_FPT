package com.poly.controller.admin;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.poly.dto.UpdateOrder;
import com.poly.model.Order;
import com.poly.model.OrderDetail;
import com.poly.service.OrderDetailService;
import com.poly.service.OrderService;
import com.poly.service.SessionService;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import javax.swing.JFileChooser;
import javax.swing.filechooser.FileNameExtensionFilter;
import org.apache.commons.io.FileUtils;

@Controller
@RequestMapping(value = "orders")
public class OrderController {

	@Autowired
	OrderService orderService;
	
	@Autowired
	OrderDetailService orderDetailService;

	@Autowired
	SessionService session;

	@GetMapping(value = "")
	public String list(Model model, 
			@RequestParam(name = "field") Optional<String> field,
			@RequestParam(name = "page") Optional<Integer> page, 
			@RequestParam(name = "size") Optional<Integer> size,
			@RequestParam(name = "keywords", defaultValue = "") Optional<String> keywords) {
		String keyword = keywords.orElse(session.get("keywords"));
		session.set("keywords", keyword);
		Sort sort = Sort.by(Direction.DESC, field.orElse("id"));
		Pageable pageable = PageRequest.of(page.orElse(1) - 1, size.orElse(5), sort);
		Page<Order> resultPage = orderService.findAllByOrderAddressEmailLike("%" + keyword + "%", pageable);
		int totalPages = resultPage.getTotalPages();
		int startPage = Math.max(1, page.orElse(1) - 2);
		int endPage = Math.min(page.orElse(1) + 2, totalPages);
		if (totalPages > 5) {
			if (endPage == totalPages)
				startPage = endPage - 5;
			else if (startPage == 1)
				endPage = startPage + 5;
		}
		List<Integer> pageNumbers = IntStream.rangeClosed(startPage, endPage).boxed().collect(Collectors.toList());
		model.addAttribute("pageNumbers", pageNumbers);
		model.addAttribute("field", field.orElse("id"));
		model.addAttribute("size", size.orElse(5));
		model.addAttribute("keywords", keyword);
		model.addAttribute("resultPage", resultPage);
		return "admin/orders/order-list";
	}
	
	@GetMapping(value = "/view/{id}")
	public ResponseEntity<Order> viewByOrderId(@PathVariable(name = "id") Long id) {
		Order order = orderService.findById(id).get();
		return new ResponseEntity<Order>(order, HttpStatus.OK);
	}
	
	@GetMapping(value = "/view-order-detail/{id}")
	public ResponseEntity<List<OrderDetail>> viewOrderDetailByOrderId(@PathVariable(name = "id") Long id) {
		List<OrderDetail> list = orderDetailService.findAllByOrderId(id);
		return new ResponseEntity<List<OrderDetail>>(list, HttpStatus.OK);
	}
	
//	@GetMapping(value = "/export/{id}")
//	public ResponseEntity<Order> exportByOrderId(@PathVariable(name = "id") Long id) {
//		Order order = orderService.findById(id).get();
//		return new ResponseEntity<Order>(order, HttpStatus.OK);
//	}
	
	// phương thức xử lý in hóa đơn ra file excel
	@GetMapping(value = "/export/{id}")
    public void exportOrderToExcel(@PathVariable(name = "id") Long id, HttpServletResponse response) throws IOException {
        Order order = orderService.findById(id).orElse(null);
        if (order == null) {
            // Xử lý trường hợp không tìm thấy đơn hàng
            // Bạn có thể trả về lỗi hoặc thực hiện hành động khác tùy thuộc vào yêu cầu của ứng dụng
            return;
        }

        List<OrderDetail> orderDetails = orderDetailService.findAllByOrderId(id);

        // Tạo workbook mới
        Workbook workbook = new XSSFWorkbook();

        // Tạo một trang tính mới
        Sheet sheet = workbook.createSheet("Hóa đơn sản phẩm");

        // Tạo tiêu đề
        String[] headerArr = {"ID", "Tên sản phẩm", "Giá", "Số lượng", "Giảm giá"};
        Row headerRow = sheet.createRow(0);

        for (int i = 0; i < headerArr.length; i++) {
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(headerArr[i]);
        }

        // Đổ dữ liệu hóa đơn vào sheet
        int rowNum = 1;
        for (OrderDetail orderDetail : orderDetails) {
            Row row = sheet.createRow(rowNum++);
            row.createCell(0).setCellValue(orderDetail.getProduct().getId());
            row.createCell(1).setCellValue(orderDetail.getProduct().getName()); 
            row.createCell(2).setCellValue(orderDetail.getPrice());
            row.createCell(3).setCellValue(orderDetail.getQuantity());
            row.createCell(4).setCellValue(orderDetail.getDiscount());
          //  row.createCell(5).setCellValue(orderDetail.get());
        }

        // Ghi workbook vào response
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=order_" + id + ".xlsx");

        workbook.write(response.getOutputStream());
        workbook.close();
        
//        // chọn đường dẫn lưu file excel
//        JFileChooser fileChooser = new JFileChooser();
//        fileChooser.setDialogTitle("Chọn nơi lưu file");
//        fileChooser.setFileFilter(new FileNameExtensionFilter("Excel Files (*.xlsx)", "xlsx"));
//
//        int userSelection = fileChooser.showSaveDialog(null);
//
//        if (userSelection == JFileChooser.APPROVE_OPTION) {
//            File fileToSave = fileChooser.getSelectedFile();
//
//            // Ghi workbook vào file đã chọn
//            try {
//                workbook.write(new FileOutputStream(fileToSave.getAbsolutePath()));
//                workbook.close();
//            } catch (IOException e) {
//                e.printStackTrace();
//            }
//          }
    }

	
	@PutMapping(value = "/update")
	@ResponseBody
	public ResponseEntity<?> updateApi(@RequestBody UpdateOrder item) {
		Order order = orderService.findById(item.getId()).get();
		order.setStatus(item.getStatus());
		order.setPay(item.getPay());
		orderService.saveOrUpdate(order);
		return new ResponseEntity<Void>(HttpStatus.OK);
	}
	
}
