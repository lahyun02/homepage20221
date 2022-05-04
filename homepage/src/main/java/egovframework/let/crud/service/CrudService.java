package egovframework.let.crud.service;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface CrudService {
	//임시데이터 가져오기
	public CrudVO selectTemp(CrudVO vo) throws Exception;
	
	//임시데이터 목록 가져오기
	public List<EgovMap> selectTempList(CrudVO vo) throws Exception;
	
	//임시데이터 등록하기
	public String insertTemp(CrudVO vo) throws Exception;
	
	//임시데이터 수정하기
	public void updateTemp(CrudVO vo) throws Exception;
	
	//임시데이터 삭제하기
	public void deleteTemp(CrudVO vo) throws Exception;
	
	//임시데이터 목록 수
	public int selectTempListCnt(CrudVO vo) throws Exception;
	
}