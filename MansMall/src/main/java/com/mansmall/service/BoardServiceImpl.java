package com.mansmall.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mansmall.domain.BoardVO;
import com.mansmall.persistence.BoardDAO;
import com.mansmall.util.Criteria;
import com.mansmall.utiltwo.PageVO;
import com.mansmall.utiltwo.SearchVO;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	public BoardDAO dao;

	@Override
	public void insert(BoardVO vo) throws Exception {
		dao.insert(vo);
	}

	@Override
	public List<BoardVO> getArticleList(SearchVO search) throws Exception {
		List<BoardVO> list = dao.getArticleList(search);
		// 1일 이내 신규글 new 마크 처리 로직
		for(BoardVO vo : list){
			// 현재 시간 읽어오기
			long now = System.currentTimeMillis(); //밀리초로 읽기 15억 *1000 초
			// 각 게시물의 작성 시간 밀리초로 읽어오기
			Date regDate = vo.getBrd_date_reg();
			long regTime = regDate.getTime();
			
			if(now - regTime < 60*60*24*1000){   //1일을 초로 -> 60*60*24 *(1000 밀리초 표현)
				vo.setNewMark(true);
			}
		}

		return list;
	}

	@Override
	public BoardVO getArticle(int brd_num) throws Exception {
		
		return dao.getArticle(brd_num);
	}

	@Override
	public void update(BoardVO vo) throws Exception {
		dao.update(vo);
	}

	@Override
	public void delete(int brd_num) throws Exception {
		dao.delete(brd_num);
	}

	@Override
	public int BoardCount(SearchVO search) throws Exception {

		return dao.BoardCount(search);
	}

	@Override
	public void updateViewCnt(int brd_num) throws Exception {
		dao.updateViewCnt(brd_num);
		
	}

}
