package com.poly.controller.shop;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "ddt/about")
public class ShopAboutController {

	@GetMapping(value = "")
	public String about() {
		return "shop/about/about";
	}
}
