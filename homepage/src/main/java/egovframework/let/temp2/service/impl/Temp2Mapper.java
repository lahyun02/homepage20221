package egovframework.let.temp2.service.impl;
import java.util.Iterator;
import java.util.List;

import egovframework.let.temp2.service.Temp2VO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

import org.springframework.stereotype.Repository;

@Mapper("temp2Mapper")
public interface Temp2Mapper {
	
	//임시데이터 가져오기 - 동일한 메소드가 있지 않아야 됨.
	Temp2VO selectTemp(Temp2VO vo) throws Exception;
	
	//임시데이터 목록 가져오기
	List<EgovMap> selectTempList(Temp2VO vo) throws Exception;
	
	//임시데이터 등록-등록, 수정, 삭제 같은 경우 DB에서 받아오는 결과값이 없어서 void로 함.
	void insertTemp(Temp2VO vo) throws Exception;
	
	//임시데이터 수정하기
	void updateTemp(Temp2VO vo) throws Exception;
	
	//임시데이터 삭제하기
	void deleteTemp(Temp2VO vo) throws Exception;
	
	//임시데이터 목록 수
	int selectTempListCnt(Temp2VO vo) throws Exception;
	
}
