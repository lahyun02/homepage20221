package egovframework.com.cmm.web;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Map;

import egovframework.com.cmm.SessionVO;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.FileVO;
import egovframework.let.utl.fcc.service.EgovNumberUtil;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import net.coobird.thumbnailator.Thumbnails;

import javax.annotation.Resource;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


/**
 * @Class Name : EgovImageProcessController.java
 * @Description :
 * @Modification Information
 *
 *    수정일       수정자         수정내용
 *    -------        -------     -------------------
 *    2009. 4. 2.     이삼섭
 *    2011.08.31.     JJY        경량환경 템플릿 커스터마이징버전 생성
 *
 * @author 공통 서비스 개발팀 이삼섭
 * @since 2009. 4. 2.
 * @version
 * @see
 *
 */
@Controller
public class EgovImageProcessController extends HttpServlet {

    /**
	 *  serialVersion UID
	 */
	private static final long serialVersionUID = -6339945210971171173L;

	@Resource(name = "EgovFileMngService")
    private EgovFileMngService fileService;
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
    private static final Logger LOGGER = LoggerFactory.getLogger(EgovImageProcessController.class);

    /**
     * 첨부된 이미지에 대한 미리보기 기능을 제공한다.
     *
     * @param atchFileId
     * @param fileSn
     * @param sessionVO
     * @param model
     * @param response
     * @throws Exception
     */
    @SuppressWarnings("resource")
	@RequestMapping("/cmm/fms/getImage.do")
    public void getImageInf(SessionVO sessionVO, ModelMap model, @RequestParam Map<String, Object> commandMap, HttpServletResponse response) throws Exception {

		//@RequestParam("atchFileId") String atchFileId,
		//@RequestParam("fileSn") String fileSn,
		String atchFileId = (String)commandMap.get("atchFileId");
		String fileSn = (String)commandMap.get("fileSn");

		FileVO vo = new FileVO();

		vo.setAtchFileId(atchFileId);
		vo.setFileSn(fileSn);

		FileVO fvo = fileService.selectFileInf(vo);

		//String fileLoaction = fvo.getFileStreCours() + fvo.getStreFileNm();

		File file = new File(fvo.getFileStreCours(), fvo.getStreFileNm());
		FileInputStream fis = null; new FileInputStream(file);

		BufferedInputStream in = null;
		ByteArrayOutputStream bStream = null;
		try{
			fis = new FileInputStream(file);
			in = new BufferedInputStream(fis);
			bStream = new ByteArrayOutputStream();
			int imgByte;
			while ((imgByte = in.read()) != -1) {
			    bStream.write(imgByte);
			}

			String type = "";

			if (fvo.getFileExtsn() != null && !"".equals(fvo.getFileExtsn())) {
			    if ("jpg".equals(fvo.getFileExtsn().toLowerCase())) {
				type = "image/jpeg";
			    } else {
				type = "image/" + fvo.getFileExtsn().toLowerCase();
			    }
			    type = "image/" + fvo.getFileExtsn().toLowerCase();

			} else {
				LOGGER.debug("Image fileType is null.");
			}

			response.setHeader("Content-Type", type);
			response.setContentLength(bStream.size());

			bStream.writeTo(response.getOutputStream());

			response.getOutputStream().flush();
			response.getOutputStream().close();


		}catch(Exception e){
			LOGGER.debug("{}", e);
		}finally{
			if (bStream != null) {
				try {
					bStream.close();
				} catch (Exception est) {
					LOGGER.debug("IGNORED: {}", est.getMessage());
				}
			}
			if (in != null) {
				try {
					in.close();
				} catch (Exception ei) {
					LOGGER.debug("IGNORED: {}", ei.getMessage());
				}
			}
			if (fis != null) {
				try {
					fis.close();
				} catch (Exception efis) {
					LOGGER.debug("IGNORED: {}", efis.getMessage());
				}
			}
		}
    }
    
    
    //썸네일 가져오기
    // 한 페이지당 리스트에서 게시판 하나마다 한번씩 호출됨
    @RequestMapping("/cmm/fms/getThumbImage.do")
    public void getThumbImage(ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {

    	String fileStorePath = EgovStringUtil.isEmpty(request.getParameter("fileStorePath")) ? "board.fileStorePath" : request.getParameter("fileStorePath");
    	
    	String atchFileNm = request.getParameter("atchFileNm");
    	String thumbYn = request.getParameter("thumbYn");
    	String fileExt = ""; //확장자
    	int index = atchFileNm.lastIndexOf(".");
    	if(index != -1) {  //점이 있을때 (확장자있을떄) 확장자와 이름을 분리
    		fileExt = atchFileNm.substring(index + 1);	  //확장자
    		atchFileNm = atchFileNm.substring(0, index);  // 확장자를 뺀 나머지 이름
    	}  
    	
    	String resFilePath = propertiesService.getString(fileStorePath);
    	File file = null;
    	if("Y".equals(thumbYn)) {
    		String strWidth = request.getParameter("width") == null ? propertiesService.getString("photoThumbWidth") : request.getParameter("width");
    		String strHeight = request.getParameter("height") == null ? propertiesService.getString("photoThumbHeight") : request.getParameter("height");
    		int width = (EgovNumberUtil.getNumberValidCheck(strWidth)) ? EgovStringUtil.zeroConvert(strWidth) : propertiesService.getInt("photoThumbWidth");
    		int height = (EgovNumberUtil.getNumberValidCheck(strHeight)) ? EgovStringUtil.zeroConvert(strHeight) : propertiesService.getInt("photoThumbHeight");
    		
    		file = new File(resFilePath, atchFileNm + "_THUMB." + fileExt);
    		if(!file.exists()) {
    			File orgFile = new File(resFilePath, atchFileNm);  
    			if(orgFile.exists()) {
    				Thumbnails.of(orgFile).size(width, height).toFile(file); //썸네일 생성
    			} else {
    				LOGGER.info("File Not Found : " + resFilePath + File.separator + atchFileNm); 
    			}
    		}
    	} else {
    		file = new File(resFilePath, atchFileNm); //원본파일을 그대로 보냄
    	}
    	
    	if(file.exists()) {
    		FileInputStream fis = null;
    		BufferedInputStream in = null;
    		ByteArrayOutputStream bStream = null;
    		
    		try {
    			fis = new FileInputStream(file);
    			in = new BufferedInputStream(fis);
    			bStream = new ByteArrayOutputStream();
    			
    			int imgByte;
    			while ((imgByte = in.read()) != -1) {
    				bStream.write(imgByte); 
    			} 
    			
    			String type = "";
    			if (fileExt != null && !"".equals(fileExt)) {
    				if ("jpg".equals(EgovStringUtil.lowerCase(fileExt))) {
    					type = "image/jpeg";  // jpeg라고 해야 브라우저가 이미지를 인식하고 jpg 파일을 보여준다.
    				} else {
    					type = "image/" + EgovStringUtil.lowerCase(fileExt);
    				}
    			} else {
    				LOGGER.debug("Image fileType is null."); 
    			}
    			
    			response.setHeader("Content-Type", type);  //이미지파일 타입
    			response.setContentLength(bStream.size());
    			
    			bStream.writeTo(response.getOutputStream());
    			
    			response.getOutputStream().flush();
    			
    		} catch (FileNotFoundException fnfe) {
    			LOGGER.debug("/cmm/fms/getImage.do -- stream error : " + atchFileNm); 
    		} catch (IOException ioe) {
    			LOGGER.debug("/cmm/fms/getImage.do -- stream error : " + atchFileNm);
    		} catch (Exception e) {
    			LOGGER.debug("/cmm/fms/getImage.do -- stream error : " + atchFileNm); 
    		} finally {
    			try {response.getOutputStream().close();} catch(Exception ex){} // 닫아줘야 다른 자원을 정상적으로 사용 가능.
    			if(bStream != null) {
    				try {bStream.close();}catch(IOException ex){LOGGER.info("IOException");} 
    			}
    			if(in != null) {
    				try {in.close();}catch(IOException ex){LOGGER.info("IOException");} 
    			}
    			if(fis != null) {
    				try {fis.close();}catch(IOException ex){LOGGER.info("IOException");} 
    			}
    		}
    	}
    	
    }
    
}
