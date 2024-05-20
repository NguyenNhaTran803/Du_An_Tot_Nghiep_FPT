package com.poly.service;

import java.util.List;
import java.util.Optional;

import com.poly.model.Like;

public interface LikeService {

	Optional<Like> saveOrUpdate(Like like);
	
	void deleteById(Long id);
	
	List<Like> findAllByUserId(String id);
	
	List<Object[]> statisticsLikeMonthByYear(int year);
	
	List<Object[]> statisticsLikeCategory();

}
