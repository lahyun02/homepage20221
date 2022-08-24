package egovframework.let.join.web;

import java.io.PrintWriter;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.let.join.service.JoinService;
import egovframework.let.join.service.JoinVO;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import net.sf.json.JSONObject;

@Controller
public class JoinController {
	
	@Resource(name = "joinService")
	private JoinService joinService;
	
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;
	
	//회원구분
	@RequestMapping(value = "/join/memberType.do")
	public String memberType(@ModelAttribute("searchVO") JoinVO vo, HttpServletRequest request, ModelMap model) throws Exception{
		
		return "join/MemberType";
	}
	
	//회원등록 폼
	@RequestMapping(value = "/join/memberRegist.do")
	public String memberRegist(@ModelAttribute("searchVO") JoinVO vo, HttpServletRequest request, ModelMap model) throws Exception{
		
		return "join/MemberRegist";
	}
	
	//회원가입
	@RequestMapping(value = "/join/insertMember.do")
	public String insertMember(@ModelAttribute("searchVO") JoinVO vo, HttpServletRequest request, ModelMap model) throws Exception{
		if(!EgovStringUtil.isEmpty(vo.getLoginType())) {
			//일반가입을 제외하고는 ID값은 SNS명 + ID값(ex. KAKAO-123456)
			if(!("normal").equals(vo.getLoginType())) {
				vo.setEmplyrId(vo.getLoginType() + "-" + vo.getEmplyrId());
				vo.setPassword(""); //null이 아니라 빈 공간으로 간다. 암호화시켜 db에 저장하기 위해. (둘 중 하나가 null이면 암호화할 수 없음)
				vo.setPasswordHint("SNS가입자"); //필수값이기때문에 임의값 임시기입 (sns가입자는 비번힌트가 의미x떄문)
				vo.setPasswordCnsr("SNS가입자"); //필수값이기때문에 임의값 임시기입
			}
		}
		// 서버에서 한번 더 체크하는 이유 - 두명이상 동시 접속-아이디중복확인 후, 가입버튼을 눌렀을때 나머지 한명이 중복되면 에러뜨는 걸(db-unique키) 막기 위해 
		if(joinService.duplicateCheck(vo) > 0) {
			model.addAttribute("message", egovMessageSource.getMessage("fail.duplicate.member")); 
			//이미 사용중인 ID입니다.
			return "forward:/join/memberType.do";
		}else {
			joinService.insertJoin(vo);
			model.addAttribute("message", egovMessageSource.getMessage("join.request.msg")); 
			//회원신청이 정상적으로 완료되었습니다. 로그인 후 이용해 주세요. 
		}
		
		return "forward:/index.do";
	}
	
	//아이디 중복체크
	@RequestMapping(value = "/join/duplicateCheck.do")
	public void duplicateCheck(@ModelAttribute("searchVO") JoinVO vo, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception{
		String successYn = "Y";
		String message = "성공";
		
		JSONObject jo = new JSONObject(); 		//map과 비슷. json객체에 데이터를 담아서 사용함.
		response.setContentType("application/json; charset=utf-8");		//보안상 작성. 정확하게 어떤 데이터인지 알려주기 위해(디폴트:text)
		
		int duplicateCnt = joinService.duplicateCheck(vo);
		if(duplicateCnt > 0) {
			successYn = "N";
			message = egovMessageSource.getMessage("fail.duplicate.member"); //이미 사용중인 ID입니다.;
		}
		//아이디 중복이면 1, 사용가능하면 0 (마일리지, 적립금 관리할때 응용)
		
		jo.put("successYn", successYn);
		jo.put("message", message);
		
		//jsp없이 바로 화면에 작성하기 위해 Printwriter를 사용함.
		PrintWriter printwriter = response.getWriter();
		printwriter.println(jo.toString());
		printwriter.flush();
		printwriter.close();	//닫아주기
	}
}
