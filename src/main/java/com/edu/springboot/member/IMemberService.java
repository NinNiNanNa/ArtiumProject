package com.edu.springboot.member;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IMemberService {
	
	//회원목록
	public List<MemberDTO> select();
	//회원가입
	public int insert(MemberDTO memberDTO);
	//아이디 중복 확인
	public int idCheck(MemberDTO memberDTO);
	//회원조회
	public MemberDTO selectOne(MemberDTO memberDTO);
	//회원정보 수정
	public int update(MemberDTO memberDTO);
	//회원삭제
	public void delete(MemberDTO memberDTO);
	//로그인
	public int loginCheck(MemberDTO memberDTO);
}
