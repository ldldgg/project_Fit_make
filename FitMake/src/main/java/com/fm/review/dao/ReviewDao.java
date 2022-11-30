package com.fm.review.dao;

import java.util.List;
import java.util.Map;

import com.fm.review.model.ReviewDto;

public interface ReviewDao {
//	C
	public int reviewInsert(ReviewDto reviewDto);
	public void insertFile(Map<String,Object> map);
	
//	R
	public List<ReviewDto> reviewSelectList(int iNo);
	public Map<String, Object> fileSelectOne(int rNo);
	
	public ReviewDto reviewSelectOne(int rNo);
	public List<Map<String, Object>> fileSelectList(int rNo);

}
