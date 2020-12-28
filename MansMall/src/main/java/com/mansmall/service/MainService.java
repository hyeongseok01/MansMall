package com.mansmall.service;

import java.util.List;
import java.util.Map;

import com.mansmall.domain.ProductVO;
import com.mansmall.util.Criteria;

public interface MainService {

	// 상품리스트(페이지에 맞춰서)
	public List<ProductVO> mainList(Criteria cri)throws Exception;
		
	//해당 카테고리의 상품 개수
	public int mainCount() throws Exception;
		
}
