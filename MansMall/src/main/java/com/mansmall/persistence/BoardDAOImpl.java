package com.mansmall.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mansmall.domain.BoardVO;
import com.mansmall.util.Criteria;
import com.mansmall.utiltwo.PageVO;
import com.mansmall.utiltwo.SearchVO;
@Repository
public class BoardDAOImpl implements BoardDAO {

	@Autowired
	private SqlSession session;
	
	public final static String NS="com.mansmall.mappers.BoardMapper";
	
	@Override
	public void insert(BoardVO vo) throws Exception {
	 session.insert(NS+".insert",vo);
	}
	@Override
	public List<BoardVO> getArticleList(SearchVO search) throws Exception {
		return session.selectList(NS+".getArticleList",search);
	}
	@Override
	public int BoardCount(SearchVO search) throws Exception {
		return session.selectOne(NS+".BoardCount",search);
	}
	@Override
	public BoardVO getArticle(int brd_num) throws Exception {
		return session.selectOne(NS+".getArticle", brd_num);
	}

	@Override
	public void update(BoardVO vo)  throws Exception{
		session.update(NS+".update", vo);
	}

	@Override
	public void delete(int brd_num) throws Exception {
		session.delete(NS+".delete", brd_num);
	}
	@Override
	public void updateViewCnt(int brd_num) throws Exception {
		session.update(NS+".updateViewCnt", brd_num);
		
	}
	

}
