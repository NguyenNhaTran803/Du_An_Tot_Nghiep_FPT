package com.poly.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.poly.model.Category;

public interface CategoryService {
	Optional<Category> saveOrUpdate(Category user);
	
	Optional<Category> findById(Long id);
	
	void deleteById(Long id);
	
	List<Category> findAll();
	
	Page<Category> findAllByNameLike(String keyword, Pageable pageable);

	boolean hasProducts(Long categoryId);
	
}
