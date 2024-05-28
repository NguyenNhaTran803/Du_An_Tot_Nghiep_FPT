package com.poly.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.poly.model.Color;
import com.poly.model.Size;

public interface ColorService {
	Optional<Color> saveOrUpdate(Color user);

	Optional<Color> findById(Long id);

	void deleteById(Long id);

	List<Color> findAll();

	Page<Color> findAllByNameLike(String keyword, Pageable pageable);

	boolean hasProducts(Long colorId);
	
	List<Color> getAllColors();
}
