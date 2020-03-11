package com.tis.channel.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.tis.channel.mapper.ChannelMapper;
import com.tis.retulix.domain.MemberVO;

import lombok.extern.log4j.Log4j;

@Log4j
@Service(value="channelService")
public class ChannelServiceImpl implements ChannelService {
	
	@Inject
	private ChannelMapper channelMapper;

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
}
