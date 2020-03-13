package com.tis.admin.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.tis.admin.mapper.TrailerMapper;
import com.tis.common.model.PagingVO;
import com.tis.retulix.domain.TrailerVO;

@Service(value="trailerService")
public class TrailerServiceImpl implements TrailerService {

	/* mapper 주입 */
	@Inject
	private TrailerMapper trailerMapper;
	
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
	public int getTotalTrailer() {
		return this.trailerMapper.getTotalTrailer();
	}

	@Override
	public int getTotalSearchTrailer(PagingVO paging) {
		return trailerMapper.getTotalSearchTrailer(paging);
	}

	@Override
	public List<TrailerVO> getTrailer(PagingVO paging) {
		return trailerMapper.getTrailer(paging);
	}

	@Override
	public List<TrailerVO> getSearchTrailer(PagingVO paging) {
		return trailerMapper.getSearchTrailer(paging);
	}

	@Override
	public TrailerVO getTrailerByIdx(String idx) {
		return trailerMapper.getTrailerByIdx(idx);
	}

	@Override
	public int updateTrailer(String idx) {
		return trailerMapper.updateTrailer(idx);
	}

	@Override
	public int deleteTrailer(String idx) {
		return trailerMapper.deleteTrailer(idx);
	}

}
