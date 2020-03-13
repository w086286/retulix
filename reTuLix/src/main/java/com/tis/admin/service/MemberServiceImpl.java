package com.tis.admin.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.tis.admin.mapper.MemberMapper;
import com.tis.common.model.PagingVO;
import com.tis.retulix.domain.MemberVO;

@Service(value="memberService")
public class MemberServiceImpl implements MemberService {
	
	/* mapper주입 */
	@Inject
	private MemberMapper memberMapper; 
	
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
	public int getTotalMember() {
		return memberMapper.getTotalMember();
	}

	@Override
	public int getTotalSearchMember(PagingVO paging) {
		return memberMapper.getTotalSearchMember(paging);
	}

	@Override
	public List<MemberVO> getMemberList(PagingVO paging) {
		return memberMapper.getMemberList(paging);
	}

	@Override
	public List<MemberVO> getSearchMember(PagingVO paging) {
		return memberMapper.getSearchMember(paging);
	}

	@Override
	public MemberVO getMemberByEmail(String email) {
		return memberMapper.getMemberByEmail(email);
	}

	@Override
	public int updateMember(MemberVO member) {
		return memberMapper.updateMember(member);
	}

	@Override
	public int deleteMember(String email) {
		return memberMapper.deleteMember(email);
	}

}
