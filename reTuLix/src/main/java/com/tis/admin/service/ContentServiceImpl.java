package com.tis.admin.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.tis.admin.domain.ContentVO;
import com.tis.admin.mapper.ContentMapper;
import com.tis.common.model.PagingVO;

@Service(value="contentService")
public class ContentServiceImpl implements ContentService {

	/* mapper 주입 */
	@Inject
	private ContentMapper contentMapper;
	
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
	@Override
	public int getTotalContent() {
		return contentMapper.getTotalContent();
	}

	@Override
	public int getTotalSearchContent(PagingVO paging) {
		return contentMapper.getTotalSearchContent(paging);
	}

	@Override
	public int getTotalContentByEmail(String email) {
		return contentMapper.getTotalContentByEmail(email);
	}

	@Override
	public List<ContentVO> getContent(PagingVO paging) {
		return contentMapper.getContent(paging);
	}

	@Override
	public List<ContentVO> getSearchContent(PagingVO paging) {
		return contentMapper.getSearchContent(paging);
	}

	@Override
	public List<ContentVO> getContentByEmail(PagingVO paging, String email) {
		return contentMapper.getContentByEmail(paging, email);
	}

	@Override
	public int updateContent(ContentVO content) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteContent(String idx) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public ContentVO getContentByIdx(String idx) {
		return this.contentMapper.getContentByIdx(idx);
	}
	
	
	

}
