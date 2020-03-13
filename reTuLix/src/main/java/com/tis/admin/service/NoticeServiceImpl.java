package com.tis.admin.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.tis.admin.mapper.NoticeMapper;
import com.tis.common.model.PagingVO;
import com.tis.retulix.domain.NoticeVO;

import lombok.extern.log4j.Log4j;

@Service(value="noticeService")
@Log4j
public class NoticeServiceImpl implements NoticeService {

	/* mapper 주입 */
	@Inject
	private NoticeMapper noticeMapper;
	/* mapper는 context-datasource.xml 의 <mybatis-spring:scan>에 넣어줘야함
	 * <!-- 4. mybatis-spring:scan 설정 -->
		<mybatis-spring:scan base-package="com.tis.user.mapper, com.tis.shop.mapper"/>
	 * 
	 * 그리고 mybatis-config.xml 에도 등록해줘야함
	 * <!-- mapper 등록 -->
		<mappers>
			<mapper resource="spring/mapper/MemoMapper.xml"/>
			<mapper resource="spring/mapper/UserMapper.xml"/>
			<mapper resource="spring/mapper/ProductMapper.xml"/>
			...
		</mappers> 
	 */
	
	/* 공지사항 총개수 */
	@Override
	public int getTotalNotice() {
		return this.noticeMapper.getTotalNotice();
	}
	
	/* 검색한 공지사항 개수 */
	@Override
	public int getTotalSearchNotice(PagingVO paging) {
		return this.noticeMapper.getTotalSearchNotice(paging);
	}

	/* 모든 공지사항 가져오기 */
	@Override
	public List<NoticeVO> getNoticeList(PagingVO paging) {
		return this.noticeMapper.getNoticeList(paging);
	}

	/* 검색한 공지사항 가져오기 */
	@Override
	public List<NoticeVO> getSearchNotice(PagingVO paging) {
		return this.noticeMapper.getSearchNotice(paging);
	}

	/* idx로 공지사항 가져오기 */
	@Override
	public NoticeVO getNoticeByIdx(String idx) {
		return this.noticeMapper.getNoticeByIdx(idx);
	}

	/* 조회시 클릭수 증가 */
	@Override
	public int updateClick(String idx) {
		return this.noticeMapper.updateClick(idx);
	}

	/* 공지사항 작성 */
	@Override
	public int insertNotice(NoticeVO vo) {
		return this.noticeMapper.insertNotice(vo);
	}

	/* 공지사항 수정 */
	@Override
	public int updateNotice(NoticeVO vo) {
		return this.noticeMapper.updateNotice(vo);
	}

	/* 공지사항 삭제 */
	@Override
	public int deleteNotice(String idx) {
		return this.noticeMapper.deleteNotice(idx);
	}

}
