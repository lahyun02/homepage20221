package egovframework.let.rsv.service.impl;

import java.util.List;

import egovframework.let.rsv.service.ReservationApplyVO;
import egovframework.let.rsv.service.ReservationVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("reservationApplyMapper")
public interface ReservationApplyMapper {
	
	//기존 신청여부
	int duplicateApplyCheck(ReservationApplyVO vo) throws Exception;
	
	//예약자 상세정보
	ReservationApplyVO selectReservationApply(ReservationApplyVO vo) throws Exception;
	
	//예약자 등록하기
	void insertReservationApply(ReservationApplyVO vo) throws Exception;
	
	//예약자 목록 가져오기
	List<EgovMap> selectReservationApplyList(ReservationApplyVO vo) throws Exception;
		
	//예약자 목록 수 
	int selectReservationApplyListCnt(ReservationApplyVO vo) throws Exception;
	
//	//예약가능여부 확인
//	void rsvCheck(ReservationApplyVO vo) throws Exception;
	
}
