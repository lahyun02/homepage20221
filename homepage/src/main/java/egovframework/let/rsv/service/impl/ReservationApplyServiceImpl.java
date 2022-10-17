package egovframework.let.rsv.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.cmm.service.FileVO;
import egovframework.let.rsv.service.ReservationApplyService;
import egovframework.let.rsv.service.ReservationApplyVO;
import egovframework.let.rsv.service.ReservationService;
import egovframework.let.rsv.service.ReservationVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service("reservationApplyService")
public class ReservationApplyServiceImpl extends EgovAbstractServiceImpl implements ReservationApplyService {
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@Resource(name = "reservationApplyMapper")
	private ReservationApplyMapper reservationApplyMapper;
	
	@Resource(name = "egovReqIdGnrService")
	private EgovIdGnrService idgenService;
	
	@Resource(name = "reservationService")
	private ReservationService reservationService;
	
	@Resource(name = "egovReqTempIdGnrService")
	private EgovIdGnrService idgenTempService;

	//예약가능여부 확인
	public ReservationApplyVO rsvCheck(ReservationApplyVO vo) throws Exception {
		// 이 로직이 중간에 트랜잭션이 완료되지 않으면 롤백하기 위해 서비스 임플에 작성 (한 로직 안에 포함이 돼야 할 때)
		//신청 인원 체크
		ReservationVO reservationVO = new ReservationVO();
		reservationVO.setResveId(vo.getResveId());
		ReservationVO result = reservationService.selectReservation(reservationVO);  //신청인원과 승인완료된 인원의 수 비교
		if(result.getMaxAplyCnt() <= result.getApplyFCnt()) {
			vo.setErrorCode("ERROR-R1");
			vo.setMessage("마감되었습니다.");
		}else if(reservationApplyMapper.duplicateApplyCheck(vo) > 0) {	// 신청 중복 체크(이미 신청한 적 있는지 검사)
			vo.setErrorCode("ERROR-R2");
			vo.setMessage("이미 해당 프로그램 예약이 되어져 있습니다."); 
		}
		
		return vo;
	}

	//예약자 상세정보
	public ReservationApplyVO selectReservationApply(ReservationApplyVO vo) throws Exception {
		return reservationApplyMapper.selectReservationApply(vo); 
	}

	//예약자 등록하기
	public ReservationApplyVO insertReservationApply(ReservationApplyVO vo) throws Exception {
		//신청 인원 체크
		ReservationVO reservationVO = new ReservationVO();
		reservationVO.setResveId(vo.getResveId()); 
		//신청가능한 상태인지 확인
		ReservationVO result = reservationService.selectReservation(reservationVO);
		if(result.getMaxAplyCnt() <= result.getApplyFCnt()) {
			vo.setErrorCode("ERROR-R1");
			vo.setMessage("마감되었습니다. "); 
		}else {
			//기존 신청여부
			if(reservationApplyMapper.duplicateApplyCheck(vo) > 0) {
				vo.setErrorCode("ERROR-R2");
				vo.setMessage("이미 해당 프로그램 예약이 되어져 있습니다.");
			}else {
				String id = idgenService.getNextStringId();
				vo.setReqstId(id);
				reservationApplyMapper.insertReservationApply(vo);
			}
		}
		
		return vo;
	}
	
	//예약자 목록 가져오기
	@Override
	public List<EgovMap> selectReservationApplyList(ReservationApplyVO vo) throws Exception {
		return reservationApplyMapper.selectReservationApplyList(vo);
	}
	
	//예약자 목록 수
	@Override
	public int selectReservationApplyListCnt(ReservationApplyVO vo) throws Exception {
		return reservationApplyMapper.selectReservationApplyListCnt(vo);
	}

	//예약자 수정하기
	@Override
	public void updateReservationApply(ReservationApplyVO vo) throws Exception {
		reservationApplyMapper.updateReservationApply(vo);
	}
	
	//예약자 삭제하기
	@Override
	public void deleteReservationApply(ReservationApplyVO vo) throws Exception {
		reservationApplyMapper.deleteReservationApply(vo);
	}
	
	//예약자 승인처리
	@Override
	public void updateReservationConfirm(ReservationApplyVO vo) throws Exception {
		reservationApplyMapper.updateReservationConfirm(vo);
	}
	
	//예약자 엑셀 업로드 -- 10/19 예정 
	@Override
	public Map<String, Object> excelUpload(FileVO file, ReservationApplyVO vo) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	

	
	
	

}
