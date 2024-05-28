package com.poly.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.poly.model.Category;
import com.poly.repository.CategoryRepository;
import com.poly.service.CategoryService;

@Service
public class CategoryServiceImpl implements CategoryService {

	@Autowired
	CategoryRepository categoryRepository;

	@Override
	public Optional<Category> saveOrUpdate(Category category) {
		Category categoryOld = categoryRepository.save(category);
		return Optional.of(categoryOld);
	}

	@Override
	public Optional<Category> findById(Long id) {
		return categoryRepository.findById(id);
	}

	@Override
	public void deleteById(Long id) {
		categoryRepository.deleteById(id);
	}

	@Override
	public List<Category> findAll() {
		return categoryRepository.findAll();
	}

	@Override
	public Page<Category> findAllByNameLike(String keyword, Pageable pageable) {
		return categoryRepository.findAllByNameLike(keyword, pageable);
	}
	
	@Override
	public boolean hasProducts(Long categoryId) {
        // Kiểm tra xem có sản phẩm nào liên quan đến category không
        Category category = categoryRepository.findById(categoryId).orElse(null);

        if (category != null && category.getProducts() != null && !category.getProducts().isEmpty()) {
            return true;
        }

        return false;
    }
}
