package com.poly.controller.admin;

import java.io.IOException;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import javax.validation.Valid;

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
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.poly.dto.ColorDto;
import com.poly.model.Category;
import com.poly.model.Color;
import com.poly.service.ColorService;
import com.poly.service.SessionService;

@Controller
@RequestMapping(value = "colors")
public class ColorController {

	@Autowired
	ColorService colorService;

	@Autowired
	SessionService session;

	@GetMapping(value = "")
	public String list(Model model, @RequestParam(name = "field") Optional<String> field,
			@RequestParam(name = "page") Optional<Integer> page, @RequestParam(name = "size") Optional<Integer> size,
			@RequestParam(name = "keywords", defaultValue = "") Optional<String> keywords) {
		String keyword = keywords.orElse(session.get("keywords"));
		session.set("keywords", keyword);
		Sort sort = Sort.by(Direction.DESC, field.orElse("id"));
		Pageable pageable = PageRequest.of(page.orElse(1) - 1, size.orElse(5), sort);
		Page<Color> resultPage = colorService.findAllByNameLike("%" + keyword + "%", pageable);
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
		return "admin/color/color-list";
	}

	@DeleteMapping(value = "/delete/{id}")
	public ResponseEntity<Color> deleteApi(@PathVariable(name = "id") Long id) throws IOException {
		// Kiểm tra xem có sản phẩm nào liên quan đến category không
		Optional<Color> color = colorService.findById(id);
		if (colorService.hasProducts(id)) {
			return new ResponseEntity<Color>(color.get(), HttpStatus.BAD_REQUEST);
		}

		// Nếu không có sản phẩm liên quan, tiến hành xóa category
		colorService.deleteById(id);

		return new ResponseEntity<Color>(color.get(), HttpStatus.OK);
	}

	@GetMapping(value = "/view/{id}")
	public ResponseEntity<Color> viewApi(@PathVariable(name = "id") Long id) {
		Optional<Color> category = colorService.findById(id);
		return new ResponseEntity<Color>(category.get(), HttpStatus.OK);
	}

	@GetMapping(value = "/saveOrUpdate")
	public String saveOrUpdate(Model model, @ModelAttribute("colorDto") ColorDto colorDto) {
		return "admin/color/color-form";
	}

	@GetMapping(value = "/edit")
	public String saveOrUpdateId(Model model, @RequestParam(value = "id") Long id) {
		Color color = colorService.findById(id).get();
		ColorDto colorDto = new ColorDto();
		colorDto.setId(id);
		colorDto.setName(color.getName());
		model.addAttribute("colorDto", colorDto);
		return "admin/color/color-form";
	}

	@PostMapping(value = "/saveOrUpdate/submit")
	public String saveOrUpdate(Model model, @Valid @ModelAttribute("colorDto") ColorDto colorDto,
			BindingResult result) {
		if (result.hasErrors()) {
			model.addAttribute("error", "Lỗi định dạng");
			return "admin/color/color-form";
		}
		Color color;
		if (colorDto.getId() != null) {
			color = colorService.findById(colorDto.getId()).get();
		} else {
			color = new Color();
		}
		color.setName(colorDto.getName());
		colorService.saveOrUpdate(color);
		return "redirect:/colors";
	}

}
