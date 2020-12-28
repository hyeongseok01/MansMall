package com.mansmall.service;

import java.util.List;
import java.util.Map;

import com.mansmall.domain.ReviewVO;
import com.mansmall.util.Criteria;

public interface ReviewService {
	
		//상품후기 총 개수.
		public int countReview(int pdt_num) throws Exception;
		
		//상품 후기 쓰기.
		public void writeReview(ReviewVO vo, String mb_id) throws Exception;
		
		//상품후기 리스트(페이지포함)  
		public List<ReviewVO> listReview(int pdt_num, Criteria cri) throws Exception;
		
		// 상품후기 삭제
		public void deleteReview(int rev_num) throws Exception;
		
		// 상품후기 수정
		public void modifyReview(ReviewVO vo) throws Exception;	
}
