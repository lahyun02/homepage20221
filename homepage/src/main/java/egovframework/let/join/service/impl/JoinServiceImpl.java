package egovframework.let.join.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.let.join.service.JoinService;
import egovframework.let.join.service.JoinVO;
import egovframework.let.utl.sim.service.EgovFileScrty;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

@Service(value="joinService")
public class JoinServiceImpl extends EgovAbstractServiceImpl implements JoinService{

		@Resource(name="joinMapper")
		private JoinMapper joinMapper;

		@Resource(name="joinIdGnrService")
		private EgovIdGnrService idgenService;

		
		//회원등록
		@Override
		public String insertJoin(JoinVO vo) throws Exception {
			String esntlId = idgenService.getNextStringId();
			vo.setEsntlId(esntlId);
			
			//입력한 비밀번호를 암호화한다.
			String enpassword = EgovFileScrty.encryptPassword(vo.getPassword(),vo.getEmplyrId());
			//encryptPassword 메소드를 살펴보면 SHA-256 방식으로 암호화한다. 이때 이 SHA-256은 단방향이라 반대로 복호화가 불가능하다.
			vo.setPassword(enpassword);
			
			joinMapper.insertJoin(vo);
			return esntlId;
			
		}

		//아이디 중복 체크
		@Override
		public int duplicateCheck(JoinVO vo) throws Exception {
			return joinMapper.duplicateCheck(vo);
		}
		
}
