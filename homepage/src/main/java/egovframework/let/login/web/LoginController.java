package egovframework.let.login.web;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.scribejava.core.model.OAuth2AccessToken;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.let.api.naver.service.NaverLoginService;
import egovframework.let.join.service.JoinService;
import egovframework.let.join.service.JoinVO;
import egovframework.let.uat.uia.service.EgovLoginService;



@Controller
public class LoginController {
	
	@Resource(name = "loginService")
	private EgovLoginService loginService;
	
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;
	
	@Resource(name = "naverLoginService")
	private NaverLoginService naverLoginService;
	
	@Resource(name = "joinService")
	private JoinService joinService;
	
	//로그인
	@RequestMapping(value = "/login/actionLogin.do")
	public String actionLogin(@ModelAttribute("loginVO") LoginVO loginVO, HttpServletRequest request, ModelMap model) throws Exception {
		
		LoginVO resultVO = loginService.actionLogin(loginVO); //아이디와 비번을 체크해서 로그인 정보(->상세정보)를 가져옴.
		if(resultVO != null && resultVO.getId() != null && !resultVO.getId().equals("")) {  // 상세정보가 있으면
			request.getSession().setAttribute("LoginVO", resultVO); 	// 세션에 담아서 사용
			return "forward:/index.do";
		} else {	//없으면(아이디와 비번 틀림)
			model.addAttribute("loginMessage", egovMessageSource.getMessage("fail.common.login")); 	
			//메시지 뿌리기. 실무-메시지를 코드로 작성. -message-common세 파일에 있는 내용 불러오기(왜?- 1. 해외에서 접속. 영어권접속-영어로 메시지 나옴. 접속한 클라이언트의  지역을 찾아서 각나라별로 해당 언어로 보여주기
			// 2. 단어 선택의 통일화.(공통작업) 어떤 행위에 대한 성공의 메시지 등 -> 이 코드를 쓰라는 규격화  
			return "forward:/index.do"; 
			//forward는 model에 attribute한 정보가 다 담겨서 감. 속도도 더 빠름 (실무에서 많이 사용)
			//redirect는 model에 attribute한 정보가 안담기기 때문에 파라미터를 따로 적어서 보내줘야 함. 
		}
	}
	
	//로그아웃
	@RequestMapping(value = "/login/actionLogout.do")
	public String actionLogout(HttpServletRequest request, ModelMap model) throws Exception {
		
		//RequestContextHolder.getRequestAttributes().removeAttribute("LoginVO", RequestAttributes.SCOPE_SESSION);
		//-> 위에 로그인정보를 세션에 저장한 request.getSession().setAttribute("LoginVO", resultVO); 를 없앤다. -로그인에 대한 정보만 없앤다. 
		
		request.getSession().invalidate();  //사용자가 여태까지 했던 행위에 대한 모든 세션을 삭제. 
		
		return "forward:/index.do"; 
	}
	
	//네이버 로그인 콜백
	@RequestMapping(value = "/login/naverLogin.do")
	public String naverLogin(@ModelAttribute("loginVO") LoginVO loginVO, @RequestParam String code, @RequestParam String state, HttpSession session, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		//@RequestParam 파라미터 값을 받아오기 위해.  파라미터 값이 없으면 바로 에러메시지. 
		
		String domain = request.getServerName();
		OAuth2AccessToken oauthToken;
		oauthToken = naverLoginService.getAccessToken(session, code, state, domain);
		
		//로그인 사용자 정보를 읽어온다. 
		String apiResult = naverLoginService.getUserProfile(oauthToken);
		
		JSONParser parser = new JSONParser();
		Object obj = parser.parse(apiResult);	//스트링으로 받아온 값을 json으로 변환
		JSONObject jsonObj = (JSONObject) obj;		//org.json.simple.JSONObject -> json-simple 라이브러리 사용
		JSONObject result = (JSONObject) jsonObj.get("response");
		
		loginVO.setId("NAVER-" + result.get("id").toString());
		loginVO.setPassword("");
		loginVO.setUserSe("USR");
		
		LoginVO resultVO = loginService.actionLogin(loginVO);
		//로그인 값이 없으면 회원가입처리 //네이버 -> 로그인했을때 바로 회원가입까지
		
		if (resultVO != null && resultVO.getId() != null & !("").equals(resultVO.getId())){
			request.getSession().setAttribute("LoginVO", resultVO);
			return "forward:/index.do";
		} else {
			//일반가입을 제외하고는 ID값은 SNS명 + ID값
			JoinVO joinVO = new JoinVO();
			joinVO.setEmplyrId(loginVO.getId());
			joinVO.setUserNm(result.get("name").toString());
			joinVO.setPassword("");
			joinVO.setPasswordHint("SNS가입자");
			joinVO.setPasswordCnsr("SNS가입자"); 
			
			joinService.insertJoin(joinVO);
			model.addAttribute("loginMessage", "회원가입이 완료되었습니다.");
			
			return "forward:/index.do";
		}
	}
	
	
	//개인프로젝트 추가 로그인화면
	//로그인 폼
//	@RequestMapping(value = "/login/loginForm.do")
//	public String loginForm(String loginMessage, HttpServletRequest request, ModelMap model) throws Exception {
//		String address = request.getHeader("Referer");
//		model.addAttribute("address", address); 
//		System.out.println(loginMessage);
//		return "main/Login";
//	}
	
}
