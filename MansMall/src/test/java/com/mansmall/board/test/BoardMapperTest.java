package com.mansmall.board.test;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.mansmall.domain.BoardVO;
import com.mansmall.persistence.BoardDAO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "file:src/main/webapp/web-inf/spring/**/*.xml")
public class BoardMapperTest {

	@Autowired
	private BoardDAO mapper;
	
	
	//게시글 등록 단위 테스트
	@Test
	public void insertTest() throws Exception {
		
		for(int i=1; i<=320; i++) {
		
			BoardVO article = new BoardVO();
			article.setBrd_title("테스트 제목입니다."+i);
			article.setMb_id("a1234");
			article.setBrd_content("테스트 중이니까 말시키지 마시오!" + i);
			mapper.insert(article);
		
		}
		
		System.out.println("게시물 등록 성공!");
	}
}
