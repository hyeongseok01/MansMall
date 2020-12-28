package com.mansmall.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mansmall.domain.ReviewVO;
import com.mansmall.persistence.ReviewDAO;
import com.mansmall.util.Criteria;
@Service
public class ReviewServiceImpl implements ReviewService {
	
	@Autowired
	private ReviewDAO dao;
	
	// 상품후기 총 개수
	@Override
	public int countReview(int pdt_num) throws Exception {
		return dao.countReview(pdt_num);
	}
	
	// 상품후기 쓰기
	@Override
	public void writeReview(ReviewVO vo, String mb_id) throws Exception {
		vo.setMb_id(mb_id);
		dao.writeReview(vo);
	}
	
	// 상품후기 리스트(페이지포함)
	@Override
	public List<ReviewVO> listReview(int pdt_num, Criteria cri) throws Exception {
		
		Map<String, Object> map = new HashMap<>();
		map.put("pdt_num", pdt_num);
		map.put("cri", cri);
		
		return dao.listReview(map);
	}
	
	// 상품후기 삭제
	@Override
	public void deleteReview(int rev_num) throws Exception {
		dao.deleteReview(rev_num);
	}
	
	// 상품후기 수정
	@Override
	public void modifyReview(ReviewVO vo) throws Exception {
		dao.modifyReview(vo);
	}

}
