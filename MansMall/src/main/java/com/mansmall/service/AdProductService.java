package com.mansmall.service;

import java.util.List;
import java.util.Map;

import com.mansmall.domain.CategoryVO;
import com.mansmall.domain.ProductVO;
import com.mansmall.util.SearchCriteria;

public interface AdProductService {
	
	//상품 등록
	public void insertProduct(ProductVO vo) throws Exception;
	
	// 1차 카테고리 출력
	public List<CategoryVO> mainCGList() throws Exception;
		
	// 2차 카테고리 출력
	public List<CategoryVO> subCGList(String cg_code) throws Exception;
	
	// 검색조건에 해당하는 상품 개수 
	public int searchListCount(SearchCriteria cri) throws Exception;
	
	// 상품리스트
	public List<ProductVO> searchListProduct(SearchCriteria cri) throws Exception;
	
	// 상품 정보
	public ProductVO readProduct(int pdt_num) throws Exception;

	// 상품 수정
	public void editProduct(ProductVO vo) throws Exception;
		
	// 상품 삭제
	public void deleteProduct(int pdt_num) throws Exception;
		
	// 선택한 상품 수정
	public void editChecked(Map<String, Object> map) throws Exception;
	
}
