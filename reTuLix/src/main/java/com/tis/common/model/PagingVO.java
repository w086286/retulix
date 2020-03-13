package com.tis.common.model;

import lombok.Data;

@Data
public class PagingVO {

	private int cpage = 1; // 현재 페이지, default=1
	private int pageSize = 20;// 한 페이지 당 출력 게시글 수, default=20
	private int totalCount; // 총 게시글 수
	private int pageCount; // 현제 페이지 count

	private int start;
	private int end;

	private int pagingBlock = 10;
	private int prevBlock;
	private int nextBlock;

	private String selectBox;
	private String searchInput;

	public PagingVO() {

	}

	public PagingVO(int totalCount, int cpage, int pageSize, int pagingBlock) {
		this.totalCount = totalCount;
		this.cpage = cpage;
		this.pageSize = pageSize;
		this.pagingBlock = pagingBlock;

		init();
	}

	public void init() {
		pageCount = (totalCount - 1) / pageSize + 1;
		if (cpage < 1)
			cpage = 1;
		if (cpage > pageCount)
			cpage = pageCount;
		end = cpage * pageSize;
		start = end - (pageSize - 1);
		prevBlock = (cpage - 1) / pagingBlock * pagingBlock;
		nextBlock = prevBlock + (pagingBlock + 1);
	}

	public String getPageNavi(String myctx, String loc, boolean isParam) {
		/*
		 * isParam==true: 검색타입, 검색어 파라미터로 넘길 때 isParam==false: 파라미터 넘기지 않을 때
		 */
		selectBox = (selectBox == null) ? "" : selectBox;
		searchInput = (searchInput == null) ? "" : searchInput;

		String qStr = "?selectBox=" + selectBox + "&searchInput=" + searchInput; // false
		String qStr2 = "&selectBox=" + selectBox + "&searchInput=" + searchInput; // true

		StringBuffer buffer = new StringBuffer();
		String str = null;

		if (isParam == false) {
			// 파라미터를 쿼리스트링으로 넘기지 않을경우
			if (prevBlock > 0) {
				buffer.append("<a href='" + myctx + "/" + loc + qStr + "&cpage=" + prevBlock
						+ "' class='page' style='margin-right:20px;'>Prev</a>");
			}

			for (int i = prevBlock + 1; i <= nextBlock - 1 && i <= pageCount; i++) {
				if (i == cpage) {
					buffer.append("<a href='#' class='page active'>" + i + "</a>");
				} else {
					buffer.append(
							"<a href='" + myctx + "/" + loc + qStr + "&cpage=" + i + "' class='page'>" + i + "</a>");
				}
			}

			if (nextBlock <= pageCount) {
				buffer.append("<a href='" + myctx + "/" + loc + qStr + "&cpage=" + nextBlock
						+ "' class='page' style='margin-left:20px;'>Next</a>");
			}

			str = buffer.toString();
		} else {
			// 파라미터를 쿼리스트링으로 넘겨줄 경우

		}
		return str;
	}

}
