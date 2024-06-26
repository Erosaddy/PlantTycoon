package kr.co.planttycoon.domain;

import lombok.Data;
import lombok.Getter;
import lombok.extern.log4j.Log4j;

@Data
@Log4j
public class PageDTO {
	private int startPage;
	private int endPage;
	private boolean prev, next;
	
	private int total;
	private Criteria cri;
	
	private int realEnd; // realEnd 필드 추가
	
	public PageDTO(int total, Criteria cri) {
		this.total = total;
		this.cri = cri;
		
		//끝페이지
		this.endPage = (int)(Math.ceil(cri.getPageNum() / 5.0)) * 5;
		log.info("endPage =============> " + endPage);
		//시작페이지
		this.startPage = this.endPage - 4;
		
		//찐 끝페이지
		this.realEnd = (int) (Math.ceil((total * 1.0) / cri.getAmount()));
		log.info("realEnd==========>" + realEnd);
		//찐 끝페이지 보정
		if(realEnd < this.endPage) {
			this.endPage = realEnd;
		}
		
		//이전페이지 버튼 유무
		this.prev = this.startPage >1;
		
		//다음페이지 버튼 유무
		this.next = this.endPage < realEnd;
		}
		
		public int getNextPageNum() {
	        return endPage < realEnd ? endPage + 1 : realEnd; 
	    }
		
		public int getPrevPageNum() {
	        return startPage > 1 ? startPage - 1 : 1;
	    }

}
