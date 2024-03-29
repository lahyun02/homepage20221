package egovframework.let.temp2.web;
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
public class Temp2Controller {
	
	@Resource(name = "temp2Service")
	private Temp2Service temp2Service;
	
	//임시데이터 가져오기
	@RequestMapping(value= "/temp2/select.do")
	public String select(@ModelAttribute("searchVO") Temp2VO searchVO,
				HttpServletRequest request, ModelMap model) throws Exception{
		
		Temp2VO result = temp2Service.selectTemp(searchVO);
		model.addAttribute("result", result);
		return "temp2/TempSelect";
	}	
	
	//임시데이터 목록 가져오기
	@RequestMapping(value = "/temp2/selectList.do")
	public String selectList(@ModelAttribute("searchVO") Temp2VO searchVO, HttpServletRequest request, ModelMap model) throws Exception{
		
		//페이징
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		int totCnt = temp2Service.selectTempListCnt(searchVO);
		
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		
		//임시데이터목록
		List<EgovMap> resultList = temp2Service.selectTempList(searchVO);
		model.addAttribute("resultList", resultList);
		
				
		return "temp2/TempSelectList";
	}
	
	//임시데이터 등록/수정
	@RequestMapping(value = "/temp2/tempRegist.do")
	public String tempRegist(@ModelAttribute("searchVO") Temp2VO tempVO, HttpServletRequest request, ModelMap model) throws Exception{
		
		Temp2VO result = new Temp2VO();
		if(!EgovStringUtil.isEmpty(tempVO.getTempId())) {
			result = temp2Service.selectTemp(tempVO);
		}
		model.addAttribute("result", result);
		
		return "temp2/TempRegist";
	}
	
	//임시데이터 등록하기
	@RequestMapping(value = "/temp2/insert.do")
	public String insert(@ModelAttribute("searchVO") Temp2VO searchVO, HttpServletRequest request, ModelMap model) throws Exception{
		
		temp2Service.insertTemp(searchVO);
		return "forward:/temp2/selectList.do";
	}
	
	//임시데이터 수정하기
	@RequestMapping(value = "/temp2/update.do")
	public String update(@ModelAttribute("searchVO") Temp2VO searchVO, HttpServletRequest request, ModelMap model) throws Exception{
		
		temp2Service.updateTemp(searchVO);
		return "forward:/temp2/selectList.do";
	}
	
	//임시데이터 삭제하기
	@RequestMapping(value = "/temp2/delete.do")
	public String delete(@ModelAttribute("searchVO") Temp2VO searchVO, HttpServletRequest request, ModelMap model) throws Exception{
		temp2Service.deleteTemp(searchVO);
		return "forward:/temp2/selectList.do";
	}
		
}
