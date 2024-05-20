package com.poly.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.poly.model.Category;
import com.poly.model.Color;
import com.poly.model.Size;
import com.poly.repository.ColorRepository;
import com.poly.service.ColorService;

@Service
public class ColorServiceImpl implements ColorService {

	@Autowired
	ColorRepository colorRepository;

	@Override
	public Optional<Color> saveOrUpdate(Color color) {
		Color colorOld = colorRepository.save(color);
		return Optional.of(colorOld);
	}

	@Override
	public Optional<Color> findById(Long id) {
		return colorRepository.findById(id);
	}

	@Override
	public void deleteById(Long id) {
		colorRepository.deleteById(id);
	}

	@Override
	public List<Color> findAll() {
		return colorRepository.findAll();
	}

	@Override
	public Page<Color> findAllByNameLike(String keyword, Pageable pageable) {
		return colorRepository.findAllByNameLike(keyword, pageable);
	}
	
	@Override
	public boolean hasProducts(Long colorId) {
        // Kiểm tra xem có sản phẩm nào liên quan đến category không
        Color color = colorRepository.findById(colorId).orElse(null);

        if (color != null && color.getProducts() != null && !color.getProducts().isEmpty()) {
            return true;
        }

        return false;
    }
	
	@Override
	public List<Color> getAllColors() {
		return colorRepository.findAll();
	}
}
