package com.mansmall.service;

import java.util.List;

import com.mansmall.domain.OrderDetailVOList;
import com.mansmall.domain.OrderListVO;
import com.mansmall.domain.OrderReadDetailVO;
import com.mansmall.domain.OrderVO;

public interface OrderService {
	
	// 주문정보 추가(상품 상세/ 바로구매)
	public void addOrder(OrderVO order, OrderDetailVOList orderdetailvolist )throws Exception;
	
	// 주문정보 추가(장바구니)
	public void addOrderCart(OrderVO order, OrderDetailVOList orderDetailList, String mb_id) throws Exception;
	
	//주문목록
	public List<OrderListVO>  orderList(String mb_id) throws Exception;
		
	// 주문 상세 정보
	public List<OrderReadDetailVO> readOrder(int odr_code) throws Exception;
			
	// 주문자 정보
	public OrderVO getOrder(int odr_code) throws Exception;
	

}
