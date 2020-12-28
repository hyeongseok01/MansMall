package com.mansmall.utiltwo;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

public class PageMakerVO {

	private int totalCount;
	
	private int startPage;
	private int endPage;
	private boolean prev;
	private boolean next;
	
	//페이지 번호의 개수: 12345
	private int displayPageNum = 5;
	
	//1 2 3 4 5 : 페이지번호에 링크 기능을 적용시 사용할 파라미터
	//this.page =1; // 현재 페이지 번호. this.perPageNum=6; // 페이지에 출력 게시물 개수
	private PageVO paging;

	public PageVO getPaging() {
		return paging;
	}
	public void setPaging(PageVO paging) {
		this.paging = paging;
	}
	
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		calcDate();
	}
	

	
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	public boolean isPrev() {
		return prev;
	}
	public void setPrev(boolean prev) {
		this.prev = prev;
	}
	public boolean isNext() {
		return next;
	}
	public void setNext(boolean next) {
		this.next = next;
	}
	public int getDisplayPageNum() {
		return displayPageNum;
	}
	public void setDisplayPageNum(int displayPageNum) {
		this.displayPageNum = displayPageNum;
	}
	private void calcDate() {
		// 현재 페이지에서의 종료페이지  
		// Math.ceil() : 입력 인자 값보다 크거나 같은 가장 작은 정수 값을 double형으로 반환합니다.
		/*
		 * Math.ceil 은 소수값이 존재할 때 값을 올리는 역활을 하는 함수이며,
		 * Math.floor 는 소수값이 존재할 때 소수값을 버리는 역활을 하는 함수이며,
		 * Math.round 는 소수값에 따라 올리거나 버리는 역활을 하는 반올림 함수입니다.
		 */
		endPage = (int)Math.ceil(paging.getPage()/(double) displayPageNum) * displayPageNum;
		//현재 페이지에서의 시작페이지
		startPage = (endPage - displayPageNum) +1;
		
		//전체 종료 페이지
		int tempEndPage = (int)(Math.ceil(totalCount/(double) paging.getCountPerPage()));
		if(endPage > tempEndPage) {
			endPage = tempEndPage;
		}
		
		//[이전]/[다음] 표시 유무
		prev = startPage == 1 ? false : true;
		next = endPage * paging.getCountPerPage() >= totalCount ? false : true;
		
	}
	
	/*
	 * page와 perPageNum 을 이용한 쿼리스트링을 생성 후 반환
	 * 
	 * @return
	 * String : ex)?page=1&countPerPage=5
	 */
	public String makeQuery(int page) {
		UriComponents uriComponents = 
				UriComponentsBuilder.newInstance()
				.queryParam("page", page)
				.queryParam("countPerPage", paging.getCountPerPage())
				.build();
		return uriComponents.toString();
	}
	/*
	 * 페이지 정보와 검색조건을 이용한 쿼리스트링을 생성 후 반환
	 * 
	 * @return
	 * String : ex)?page=1&perPageNum=5&searchType=all&keyword=3
	 */
	public String makeSearch(int page){
		UriComponents uriComponents = 
				UriComponentsBuilder.newInstance()
				.queryParam("page", page)
				.queryParam("countPerPage", paging.getCountPerPage())
				.queryParam("searchType", ((SearchVO)paging).getSearchType())
				.queryParam("keyword", ((SearchVO)paging).getKeyword())
				.build();

		return uriComponents.toUriString();
	}

	@Override
	public String toString() {
		return "PageMakerVO [totalCount=" + totalCount + ", startPage=" + startPage + ", endPage=" + endPage + ", prev="
				+ prev + ", next=" + next + ", displayPageNum=" + displayPageNum + ", paging=" + paging + "]";
	}

	
	
}
