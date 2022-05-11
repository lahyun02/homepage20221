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
	// 어노테이션에 명칭을 줄때 항상 소문자로 시작함.
	
	@Resource(name = "crudMapper")
	private CrudMapper crudMapper;
	
	@Resource(name = "egovCrudIdGnrService")
	private EgovIdGnrService idgenService;
	//context-idgen에 있는 이름을 @resource의 이름에 들어감. (리소스를 통해 context-idgen을 찾아갈 수 있도록)
	
	//CRUD 가져오기
	@Override
	public CrudVO selectCrud(CrudVO vo) throws Exception {
		/*
		CrudVO result = crudMapper.selectCrud(vo);
		return result;
		*/
		//데이터의 가공 없이 db에서 값만 가져오므로 별도의 로직 없이 리턴으로 값만 db에서 가져옴.
		return crudMapper.selectCrud(vo);
	}
	
	//CRUD 목록 가져오기
	public List<EgovMap> selectCrudList(CrudVO vo) throws Exception {
		
		return crudMapper.selectCrudList(vo);
	}
	
	//CRUD 등록하기 - string으로 id체크. 
	//getNextStringId()-캐시를 받아옴. idgenService.getNextStringId()-id를 가져옴.
	//impl에 idgen을 넣는 이유-중간에 네트워크가 끊기는 순간(로직이복잡할떄) 오류-> 다 rollback이 됨.반면, controller는 오류나면 데이터입력되다가 중간에 데이터가 빵꾸가 남.
	//impl-> 대기하고 있다가 중간에 다시 rollback할 수 있음.
	public String insertCrud(CrudVO vo) throws Exception {
		String id = idgenService.getNextStringId();
		vo.setCrudId(id);
		crudMapper.insertCrud(vo);
		
		return id;
	}
	
	// 지금 현 상황에선 수정, 삭제에 리턴값이 없어도 됨. 쇼핑몰같은 경우 숫자를 반환함. 예- A업체, B업체에 주문 후 취소했을 경우.
	//CRUD 수정하기
	public void updateCrud(CrudVO vo) throws Exception{
		crudMapper.updateCrud(vo);
	}
	
	//CRUD 삭제하기
	public void deleteCrud(CrudVO vo) throws Exception{
		crudMapper.deleteCrud(vo);
	}
	
	//CRUD 목록 수
	public int selectCrudListCnt(CrudVO vo) throws Exception {
		return crudMapper.selectCrudListCnt(vo);
	}
	
	
	
	/*
	@Override
	public TempVO selectTemp(TempVO vo) throws Exception {
		return tempDAO.selectTemp(vo);
	}
	*/
}

