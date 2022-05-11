package egovframework.let.crud.web;
import java.util.List;
import java.util.Map;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.let.cop.bbs.service.BoardMaster;
import egovframework.let.cop.bbs.service.BoardMasterVO;
import egovframework.let.cop.bbs.service.EgovBBSAttributeManageService;
import egovframework.let.crud.service.CrudService;
import egovframework.let.crud.service.CrudVO;
import egovframework.let.temp.service.TempService;
import egovframework.let.temp.service.TempVO;
import egovframework.let.temp2.service.Temp2Service;
import egovframework.let.temp2.service.Temp2VO;
import egovframework.let.utl.fcc.service.EgovStringUtil;

import egovframework.rte.fdl.cmmn.exception.EgovBizException;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;
import org.springmodules.validation.commons.DefaultBeanValidator;

@Controller
public class CrudController {
	
	@Resource(name = "crudService")
	private CrudService crudService;
	// 객체명과 변수명에 앞자리에 각각 대소문자를 다르게 해서 차이점을 둔다. 같으면 호출시 헷갈리기 때문.
	
	//CRUD 가져오기
	@RequestMapping(value= "/crud/select.do")
	public String select(@ModelAttribute("searchVO") CrudVO searchVO,
				HttpServletRequest request, ModelMap model) throws Exception{
		
		CrudVO result = crudService.selectCrud(searchVO);
		model.addAttribute("result", result);
		return "crud/CrudSelect";
	}	
	
	//CRUD 목록 가져오기
	@RequestMapping(value = "/crud/selectList.do")
	public String selectList(@ModelAttribute("searchVO") CrudVO searchVO, HttpServletRequest request, ModelMap model) throws Exception{
		//throws Exception 에러는 던져낸다.
		
		//페이징
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		int totCnt = crudService.selectCrudListCnt(searchVO);
		
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		
		//CRUD 목록
		List<EgovMap> resultList = crudService.selectCrudList(searchVO);
		model.addAttribute("resultList", resultList);
		
		return "crud/CrudSelectList";
	}
	
	//CRUD 등록/수정
	@RequestMapping(value = "/crud/crudRegist.do")
	public String tempRegist(@ModelAttribute("searchVO") CrudVO crudVO, HttpServletRequest request, ModelMap model) throws Exception{
		
		CrudVO result = new CrudVO();
		if(!EgovStringUtil.isEmpty(crudVO.getCrudId())) {
			result = crudService.selectCrud(crudVO);
		}
		// 목적: 등록/수정 jsp페이지를 나누기 위해. 의미: crudId가 있으면 수정, 없으면 등록. 
		model.addAttribute("result", result);
		
		model.addAttribute("searchVO", crudVO);
		
		return "crud/CrudRegist";
	}
	
	//CRUD 등록하기
	@RequestMapping(value = "/crud/insert.do")
	public String insert(@ModelAttribute("searchVO") CrudVO searchVO, HttpServletRequest request, ModelMap model) throws Exception{
		
		crudService.insertCrud(searchVO);
		return "forward:/crud/selectList.do";
	}
	
	//CRUD 수정하기
	@RequestMapping(value = "/crud/update.do")
	public String update(@ModelAttribute("searchVO") CrudVO searchVO, HttpServletRequest request, ModelMap model) throws Exception{
		
		crudService.updateCrud(searchVO);
		return "forward:/crud/selectList.do";
	}
	
	//CRUD 삭제하기
	@RequestMapping(value = "/crud/delete.do")
	public String delete(@ModelAttribute("searchVO") CrudVO searchVO, HttpServletRequest request, ModelMap model) throws Exception{
		crudService.deleteCrud(searchVO);
		return "forward:/crud/selectList.do";
	}
		
}
