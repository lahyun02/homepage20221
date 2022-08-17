package egovframework.let.join.service.impl;

import egovframework.let.join.service.JoinVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper(value="joinMapper")
public interface JoinMapper {

	//회원등록
	void insertJoin(JoinVO vo) throws Exception;
	//아이디 중복 체크
	int duplicateCheck(JoinVO vo) throws Exception;

}
