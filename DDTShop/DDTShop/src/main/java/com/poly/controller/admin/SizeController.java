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

import com.poly.dto.SizeDto;
import com.poly.model.Color;
import com.poly.model.Size;
import com.poly.service.SessionService;
import com.poly.service.SizeService;



@Controller
@RequestMapping(value = "sizes")
public class SizeController {

	@Autowired
	SizeService sizeService;

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
		Page<Size> resultPage = sizeService.findAllByNameLike("%" + keyword + "%", pageable);
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
		return "admin/size/size-list";
	}

	@DeleteMapping(value = "/delete/{id}")
	public ResponseEntity<Size> deleteApi(@PathVariable(name = "id") Long id) throws IOException {
		// Kiểm tra xem có sản phẩm nào liên quan đến category không
				Optional<Size> size = sizeService.findById(id);
				if (sizeService.hasProducts(id)) {
					return new ResponseEntity<Size>(size.get(), HttpStatus.BAD_REQUEST);
				}

				// Nếu không có sản phẩm liên quan, tiến hành xóa category
				sizeService.deleteById(id);

				return new ResponseEntity<Size>(size.get(), HttpStatus.OK);
	}

	@GetMapping(value = "/view/{id}")
	public ResponseEntity<Size> viewApi(@PathVariable(name = "id") Long id) {
		Optional<Size> size = sizeService.findById(id);
		return new ResponseEntity<Size>(size.get(), HttpStatus.OK);
	}

	@GetMapping(value = "/saveOrUpdate")
	public String saveOrUpdate(Model model, @ModelAttribute("sizeDto") SizeDto sizeDto) {
		return "admin/size/size-form";
	}

	@GetMapping(value = "/edit")
	public String saveOrUpdateId(Model model, @RequestParam(value = "id") Long id) {
		Size size = sizeService.findById(id).get();
		SizeDto sizeDto = new SizeDto();
		sizeDto.setId(id);
		sizeDto.setName(size.getName());
		model.addAttribute("sizeDto", sizeDto);
		return "admin/size/size-form";
	}

	@PostMapping(value = "/saveOrUpdate/submit")
	public String saveOrUpdate(Model model, @Valid @ModelAttribute("sizeDto") SizeDto sizeDto,
			BindingResult result) {
		if (result.hasErrors()) {
			model.addAttribute("error", "Lỗi định dạng");
			return "admin/size/size-form";
		}
		Size size;
		if (sizeDto.getId() != null) {
			size = sizeService.findById(sizeDto.getId()).get();
		} else {
			size = new Size();
		}
		size.setName(sizeDto.getName());
		sizeService.saveOrUpdate(size);
		return "redirect:/sizes";
	}

}
