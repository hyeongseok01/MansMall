package com.mansmall.persistence;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mansmall.domain.ReviewVO;

@Repository
public class ReviewDAOImple implements ReviewDAO {
	
	@Autowired
	private SqlSession session;
	public final static String NS="com.mansmall.mappers.reviewMapper";
	
	// 상품후기 총 개수
	@Override
	public int countReview(int pdt_num) throws Exception {
		return session.selectOne(NS+".countReview", pdt_num);
	}
	// 상품후기 쓰기
	@Override
	public void writeReview(ReviewVO vo) throws Exception {
		session.insert(NS+".writeReview", vo);
	}
	// 상품후기 리스트(페이지포함)
	@Override
	public List<ReviewVO> listReview(Map<String, Object> map) throws Exception {
		return session.selectList(NS+".listReview", map);
	}
	// 상품후기 삭제
	@Override
	public void deleteReview(int rev_num) throws Exception {
		session.delete(NS+".deleteReview", rev_num);
	}
	// 상품후기 수정
	@Override
	public void modifyReview(ReviewVO vo) throws Exception {
		session.update(NS+".modifyReview", vo);
	}

}
