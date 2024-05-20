package com.poly.controller.shop;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.poly.model.Product;
import com.poly.service.ProductService;

@Controller
@RequestMapping(value = "ddt/home")
public class ShopHomeController {
	
	@Autowired
	ProductService productService;

	@GetMapping(value = "")
	public String home(Model model) {
		List<Product> listshirt = productService.findAllByCategoryId(Long.valueOf(1));
		model.addAttribute("listshirt", listshirt);
		
		List<Product> listtrousers = productService.findAllByCategoryId(Long.valueOf(7));
		model.addAttribute("listtrousers", listtrousers);
		return "shop/home/index";
	}
}
