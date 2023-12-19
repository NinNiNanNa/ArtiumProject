package com.edu.springboot.member;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IMemberService {
	
	//회원 삭제
	public void delete(MemberDTO memberDTO);
	//아이디 찾기
	public String searchId(MemberDTO memberDTO);
	//비밀번호 찾기
	public String searchPw(MemberDTO memberDTO);
	//회원 가입
	public int insert(MemberDTO memberDTO);
	//아이디 중복 확인
	public int idCheck(MemberDTO memberDTO);
	//회원 조회
	public MemberDTO selectOne(MemberDTO memberDTO);
	//회원정보 수정
	public int update(MemberDTO memberDTO);
	//로그인
	public int loginCheck(MemberDTO memberDTO);
}
