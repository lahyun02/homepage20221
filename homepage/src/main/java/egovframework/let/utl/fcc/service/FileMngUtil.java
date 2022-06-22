package egovframework.let.utl.fcc.service;

import java.io.File;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import egovframework.com.cmm.service.FileVO;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;

@Component("fileMngUtil")
public class FileMngUtil {
	
	public static final int BUFF_SIZE = 2048;
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@Resource(name = "egovFileIdGnrService")
	private EgovIdGnrService idgenService;
	
	// 첨부파일에 대한 목록 정보를 취득한다.
	public List<FileVO> parseFileInf(Map<String, MultipartFile> files, String KeyStr, int fileKeyParam, String atchFileId, String storePath) throws Exception {
		
		// KeyStr : 파일저장할 때 앞에 이름 디폴트로 설정하는 것.
		// atchFileId: 첨부파일 id 
		// storePath: 저장경로
		
		int fileKey = fileKeyParam;
		// fileKeyParam: 디폴트 값 0
		
		//파일저장경로
		String storePathString = "";
		//첨부파일ID
		String atchFileIdString = "";
		
		//파일 저장경로 여부
		if("".equals(storePath) || storePath == null) {
			storePathString = propertyService.getString("Globals.fileStorePath");  // 파일이 디폴트로 저장되는 경로 
		} else {
			storePathString = propertyService.getString(storePath);
		}
		
		//첨부파일ID 생성 및 업데이트 여부
		if("".equals(atchFileId) || atchFileId == null) {
			atchFileIdString = idgenService.getNextStringId();
		} else {
			atchFileIdString = atchFileId;
		}
		// 1~3번 파일을 첨부한 후, 수정할때 4,5번을 추가해서 넣을때 atchFileId가 필요 
		
		//폴더경로 설정
		File saveFolder = new File(storePathString);  //java.io 파일 임포트
		if(!saveFolder.exists() || saveFolder.isFile()) {	// 폴더가 존재하지 않으면 
			saveFolder.mkdirs();  // 폴더 만들기
		}
		
		//파일변수  iterator, entry = java.util
		Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
		MultipartFile file;
		String filePath = "";
		List<FileVO> result = new ArrayList<FileVO>();
		FileVO fvo;
		
		while(itr.hasNext()) {
			Entry<String, MultipartFile> entry = itr.next();
			
			file = entry.getValue();
			String orginFileName = file.getOriginalFilename();	//원본파일명
			
			//----------------------------------
			// 위 파일명이 없는 경우 처리 
			// (첨부가 되지 않은 input file type)
			//----------------------------------
			if("".equals(orginFileName)) {
				continue;
			}
			////--------------------------------
			
			//파일확장자 체크 - 한 게시판에 한글이나 피피티만 첨부가능하게 해달라는 요청 등에 사용 
			int index = orginFileName.lastIndexOf(".");	  // 마지막에 있는 .을 찾는다(확장자찾기)
			String fileExt = orginFileName.substring(index + 1);  // 확장자 가져오기 
			
			//저장파일명 - 운영체제상 덮어쓰기(리눅스)나 1,2,3 복사본(윈도우)이 생기기때문에 개발자가 파일저장할때 이름을 바꿔줘야함.
			// (참고로 db- 원본파일명 : 사용자에게 원본파일명을 던져주기 위해 , 저장파일명: 개발자가 저장하기 위해 )
			String newName = KeyStr + EgovStringUtil.getTimeStamp() + fileKey;
			
			//파일사이즈 - 우리가 몇 용량을 차지하고 있는지 확인 위해
			long size = file.getSize();
			
			//파일저장 - 웹 루트(톰캣이 컴파일되는, webapp) 안에 저장
			if(!"".equals(orginFileName)) {
				filePath = storePathString + File.separator + newName;  // File.separator: 폴더 구분해주는 추가적인 값. 안그럼 storePathString 폴더와 동일선상 경로에 저장됨
				file.transferTo(new File(filePath)); 
			}
			fvo = new FileVO();
			fvo.setFileExtsn(fileExt);
			fvo.setFileStreCours(storePathString);
			fvo.setFileMg(Long.toString(size));
			fvo.setOrignlFileNm(orginFileName);
			fvo.setStreFileNm(newName);
			fvo.setAtchFileId(atchFileIdString);
			fvo.setFileSn(String.valueOf(fileKey)); 
			
			result.add(fvo);
			
			fileKey++;
		}
		
		return result;
	}
	
}
