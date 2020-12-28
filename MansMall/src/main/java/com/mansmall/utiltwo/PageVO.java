package com.mansmall.utiltwo;

public class PageVO {
	
	// 페이징 기능에서 페이지 번호 출력을 위한 부분
		private int page;			// 현재 페이지 (클릭한 페이지)
		private int countPerPage;   // 페이지 당 글의 게시물 개수
		
		// mapper 페이징 sql문에서 사용됨.
		private int boardRowStart;		// 행 시작(페이지의 시작번호)
		private int boardRowEnd;			// 행 끝
		
		public PageVO(){	// 기본 설정
			this.page=1;	// 현재 페이지 번호.
			this.countPerPage=10; 	// 페이지에 출력 게시물 개수
		}

		public int getPage() {
			return page;
		}

		public void setPage(int page) {
			if(page <= 0) {
				this.page=1;
				return;
			}
			this.page = page;
		}

		public int getCountPerPage() {
			return countPerPage;
		}

		public void setCountPerPage(int countPerPage) {
			if(countPerPage <= 0 || countPerPage > 100) {
				 this.countPerPage = 10;
				 return;
			}
			this.countPerPage = countPerPage;
		}
		
		public int getBoardRowStart() {
			return ((page -1)*countPerPage) +1;
		}

		public void setBoardRowStart(int boardRowStart) {
			this.boardRowStart = boardRowStart;
		}

		public int getBoardRowEnd() {
			return getBoardRowStart() + countPerPage -1;
		}

		public void setBoardRowEnd(int boardRowEnd) {
			this.boardRowEnd = boardRowEnd;
		}

		public int getPageStart() 
		{
		    return (this.page - 1) * countPerPage;
		}

		@Override
		public String toString() {
			return "PageVO [page=" + page + ", countPerPage=" + countPerPage + ", getBoardRowStart()=" + getBoardRowStart()
					+ ", getBoardRowEnd()=" + getBoardRowEnd() + "]";
		}
		
		
}
