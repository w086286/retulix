package com.tis.common.model;

import lombok.Data;

@Data
public class PagingVO {
	
	private int cpage=1;	//현재 페이지, default=1
	private int pageSize=20;//한 페이지 당 출력 게시글 수, default=20
	private int totalCount;	//총 게시글 수
	private int pageCount;	//현제 페이지 count
	
	private int start;
	private int end;
	
	private int pagingBlock=5;
	private int prevBlock;
	private int nextBlock;

	
	private String findType;
	private String findKeyword;
	
	public PagingVO() {
		
	}
	
	public PagingVO(int cpage, int pageSize, int totalCount, int pagingBlock) {
		this.cpage=cpage;
		this.pageSize=pageSize;
		this.totalCount=totalCount;
		this.pagingBlock=pagingBlock;
		
		init();
	}

	public void init() {
		pageCount=(totalCount-1)/pageSize+1;
		if(cpage<1) cpage=1;
		if(cpage>pageCount) cpage=pageCount;
		end=cpage*pageSize;
		start=end-(pageSize-1);

		prevBlock=(cpage-1)/pagingBlock*pagingBlock;
		nextBlock=prevBlock+(pagingBlock+1);
	}
	
	public String getPageNavi(String myctx, String loc) {
		findType=(findType==null)?"":findType;
		findKeyword=(findKeyword==null)?"":findKeyword;
		
		String qStr="?findType="+findType+"&findKeyword="+findKeyword;
		StringBuffer buf=new StringBuffer()
		.append("<ul class='pagination pagination-sm'>");
		
		if(prevBlock>0) {
			buf.append("<li><a href='"+myctx+"/"+loc+qStr+"&cpage="+prevBlock+"'>");
			buf.append("Prev</a></li>");
		}
		for(int i=prevBlock+1;i<=nextBlock-1 && i<=pageCount ;i++) {
			
			if(i==cpage) {
			buf.append("<li class='active'><a href='#'>")
				.append(i+"</a></li>");
			}else {
			buf.append("<li><a href='"+myctx+"/"+loc+qStr+"&cpage="+i+"'>");
			buf.append(i+"</a></li>");
			}
			
		}
		if(nextBlock<=pageCount) {
			buf.append("<li><a href='"+myctx+"/"+loc+qStr+"&cpage="+nextBlock+"'>");
			buf.append("Next</a></li>");
		}
		
		buf.append("</ul>");
		String str=buf.toString();
		return str;
	}
	
}
