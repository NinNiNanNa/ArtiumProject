package com.edu.springboot.member;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IAdminService {

	//회원 목록
	public List<MemberDTO> select();
	//회원 검색
	public List<MemberDTO> search(MemberDTO memberDTO);
	//회원 삭제
	public void delete(MemberDTO memberDTO);
	//관리자 가입
	public int admininsert(AdminDTO adminDTO);
	//관리자 목록
	public List<AdminDTO> adminselect();
	//관리자 검색
	public List<MemberDTO> adminsearch(AdminDTO adminDTO);
	//관리자 삭제
	public void admindelete(AdminDTO adminDTO);
}
