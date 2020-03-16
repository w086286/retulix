package com.tis.channel.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.tis.channel.mapper.ChannelMapper;
import com.tis.common.model.PagingVO;
import com.tis.retulix.domain.MemberVO;
import com.tis.retulix.domain.Stat_ViewVO;

import lombok.extern.log4j.Log4j;

@Log4j
@Service(value="channelService")
public class ChannelServiceImpl implements ChannelService {
	
	@Inject
	private ChannelMapper channelMapper;

	/**chStat*/
	@Override
	public Stat_ViewVO showUserStat(String email) {
		return this.channelMapper.showUserStat(email);
	}
	
	@Override
	public Stat_ViewVO showStatMax(String email) {
		return this.channelMapper.showStatMax(email);
	}
	
	@Override
	public int getTotalPage(PagingVO paging) {
		return this.channelMapper.getTotalPage(paging);
	}
	
	@Override
	public List<Stat_ViewVO> showUserReview(String email) {
		return this.channelMapper.showUserReview(email);
	}
	
	/**chInfo*/
	@Override
	public MemberVO showUserInfo(String email) {
		return this.channelMapper.showUserInfo(email);
	}

	@Override
	public int updateUserInfo(MemberVO vo) {
		return this.channelMapper.updateUserInfo(vo);
	}

	@Override
	public int deleteUserInfo(String email) {
		return this.channelMapper.deleteUserInfo(email);
	}
	
	@Override
	public int updateUserIcon(String email, String userIcon) {
		return this.channelMapper.updateUserIcon(email, userIcon);
	}
}
