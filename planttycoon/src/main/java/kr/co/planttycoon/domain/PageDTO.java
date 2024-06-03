package kr.co.planttycoon.domain;

import lombok.Getter;

@Getter
public class PageDTO {
	private int startPage;
	private int endPage;
	private boolean prev, next;
	
	private int total;
	private Criteria cri;
	
	public PageDTO(int total, Criteria cri) {
		this.total = total;
		this.cri = cri;
		
		//끝페이지
		this.endPage = (int)(Math.ceil(cri.getPageNum() / 10.0)) * 10;
		
		//시작페이지
		this.startPage = this.endPage - 9;
		
		//찐 끝페이지
		int realEnd = (int) (Math.ceil((total * 1.0) / cri.getAmount()));
		
		//찐 끝페이지 보정
		if(realEnd < this.endPage) {
			this.endPage = realEnd;
		}
		
		//이전페이지 버튼 유무
		this.prev = this.startPage >1;
		
		//다음페이지 버튼 유무
		this.next = this.endPage < realEnd;
	}
}
