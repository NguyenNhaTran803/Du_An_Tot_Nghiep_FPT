package com.poly.controller.shop;

import java.util.Collection;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.poly.dto.Item;
import com.poly.model.Brand;
import com.poly.model.Category;
import com.poly.service.BrandService;
import com.poly.service.CartService;
import com.poly.service.CategoryService;

@Controller
@RequestMapping(value = "ddt/layout")
public class ShopLayoutController {

	@Autowired
	CategoryService categoryService;
	
	@Autowired
	BrandService brandService;
	
	@Autowired
	CartService cart;

	@GetMapping(value = "/category")
	public ResponseEntity<List<Category>> categoryApi() {
		List<Category> list = categoryService.findAll();
		return new ResponseEntity<List<Category>>(list, HttpStatus.OK);
	}
	
	@GetMapping(value = "/brand")
	public ResponseEntity<List<Brand>> brandApi() {
		List<Brand> list = brandService.findAll();
		return new ResponseEntity<List<Brand>>(list, HttpStatus.OK);
	}
	
	@GetMapping(value = "/get-count-cart")
	public ResponseEntity<Integer> getCountApi() {
		return new ResponseEntity<Integer>(cart.getCount(), HttpStatus.OK);
	}
	
	@GetMapping(value = "/get-cart-items")
	public ResponseEntity<Collection<Item>> getItemApi() {
		return new ResponseEntity<Collection<Item>>(cart.getItems(), HttpStatus.OK);
	}
}
