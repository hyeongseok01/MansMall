package com.mansmall.service;

import java.util.List;
import java.util.Map;

import com.mansmall.domain.OrderVO;
import com.mansmall.util.Criteria;

public interface AdOrderListService {
	
	// 주문 목록 
	public List<OrderVO> adOrderList(Criteria cri)throws Exception;
	
	//주문 리스트 개수
	public int adOrderListCount(String odr_code)throws Exception;
		
	//배송현황 수정
	public void deliveryModify(Map map)throws Exception;
	
}
