package egovframework.let.crud.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.FileVO;
import egovframework.let.cop.bbs.service.Board;
import egovframework.let.cop.bbs.service.BoardVO;
import egovframework.let.cop.bbs.service.EgovBBSManageService;
import egovframework.let.crud.service.CrudService;
import egovframework.let.crud.service.CrudVO;
import egovframework.let.temp2.service.Temp2Service;
import egovframework.let.temp2.service.Temp2VO;
import egovframework.let.utl.fcc.service.EgovDateUtil;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service("crudService")
public class CrudServiceImpl extends EgovAbstractServiceImpl implements CrudService {
	
	@Resource(name = "crudMapper")
	private CrudMapper crudMapper;
	
	@Resource(name = "egovCrudIdGnrService")
	private EgovIdGnrService idgenService;
	//context-idgen에 있는 이름을 @resource의 이름에 들어감. (리소스를 통해 context-idgen을 찾아갈 수 있도록)
	
	@Override
	public CrudVO selectTemp(CrudVO vo) throws Exception {
		return crudMapper.selectTemp(vo);
	}
	
	//임시데이터 목록 가져오기
	public List<EgovMap> selectTempList(CrudVO vo) throws Exception {
		
		return crudMapper.selectTempList(vo);
	}
	
	//임시데이터 등록하기 - string으로 id체크. 
	//getNextStringId()-캐시를 받아옴. idgenService.getNextStringId()-id를 가져옴.
	//impl에 idgen을 넣는 이유-중간에 네트워크가 끊기는 순간(로직이복잡할떄) 오류-> 다 rollback이 됨.반면, controller는 오류나면 데이터입력되다가 중간에 데이터가 빵꾸가 남.
	//impl-> 대기하고 있다가 중간에 다시 rollback할 수 있음.
	public String insertTemp(CrudVO vo) throws Exception {
		String id = idgenService.getNextStringId();
		vo.setCrudId(id);
		crudMapper.insertTemp(vo);
		
		return id;
	}
	
	//임시데이터 수정하기
	public void updateTemp(CrudVO vo) throws Exception{
		crudMapper.updateTemp(vo);
	}
	
	//임시데이터 삭제하기
	public void deleteTemp(CrudVO vo) throws Exception{
		crudMapper.deleteTemp(vo);
	}
	
	//임시데이터 목록 수
	public int selectTempListCnt(CrudVO vo) throws Exception {
		return crudMapper.selectTempListCnt(vo);
	}
	
	
	
	/*
	@Override
	public TempVO selectTemp(TempVO vo) throws Exception {
		return tempDAO.selectTemp(vo);
	}
	*/
}

