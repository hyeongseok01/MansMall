package com.mansmall.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mansmall.domain.OrderDetailVO;
import com.mansmall.domain.OrderListVO;
import com.mansmall.domain.OrderReadDetailVO;
import com.mansmall.domain.OrderVO;

@Repository
public class OrderDAOImpl implements OrderDAO {
	
	@Autowired
	private SqlSession session;
	public final static String NS="com.mansmall.mappers.orderMapper";
	
	// 주문코드 시퀀스 가져오기
	@Override
	public int readOrderCode() throws Exception {
		return session.selectOne(NS+".readOrderCode");
	}
	// 주문정보 추가
	@Override
	public void addOrder(OrderVO vo) throws Exception {
		session.insert(NS+".addOrder", vo);
		
	}
	
	// 주문내역 추가
	@Override
	public void addOrderDetail(OrderDetailVO vo) throws Exception {
		session.insert(NS+ ".addOrderDetail", vo);
	}
	// 주문 목록
	@Override
	public List<OrderListVO> orderList(String mb_id) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(NS+".orderList", mb_id);
	}
	// 주문 상세 정보
	@Override
	public List<OrderReadDetailVO> readOrder(int odr_code) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(NS+".readOrder", odr_code);
	}
	// 주문자 정보
	@Override
	public OrderVO getOrder(int odr_code) throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(NS+".getOrder", odr_code);
	}

}
