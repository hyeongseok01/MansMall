package com.mansmall.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mansmall.domain.CategoryVO;
import com.mansmall.domain.ProductVO;
import com.mansmall.persistence.AdProductDAO;
import com.mansmall.util.SearchCriteria;

@Service
public class AdProductServiceImpl implements AdProductService {
	
	@Autowired
	AdProductDAO dao; 
	
	// 상품 등록
	@Override
	public void insertProduct(ProductVO vo) throws Exception {
		dao.insertProduct(vo);
	}

	// 1차 카테고리 출력
	@Override
	public List<CategoryVO> mainCGList() throws Exception {
		return dao.mainCGList();
	}
	
	// 2차 카테고리 출력
	@Override
	public List<CategoryVO> subCGList(String cg_code) throws Exception {
		return dao.subCGList(cg_code);
	}
	// 검색 조건에 맞는 상품 개수
	@Override
	public int searchListCount(SearchCriteria cri) throws Exception {
		return dao.searchListCount(cri);
	}
	
	// 상품 리스트
	@Override
	public List<ProductVO> searchListProduct(SearchCriteria cri) throws Exception {
		return dao.searchListProduct(cri);
	}
	// 상품 정보
	@Override
	public ProductVO readProduct(int pdt_num) throws Exception {
		return dao.readProduct(pdt_num);
	}

	// 상품 수정
	@Override
	public void editProduct(ProductVO vo) throws Exception {
		dao.editProduct(vo);
	}

	// 상품 삭제
	@Transactional
	@Override
	public void deleteProduct(int pdt_num) throws Exception {
		dao.deleteProduct(pdt_num);
	}

	// 선택한 상품 수정
	@Override
	public void editChecked(Map<String, Object> map) throws Exception {
		dao.editChecked(map);
	}

	
	
}
