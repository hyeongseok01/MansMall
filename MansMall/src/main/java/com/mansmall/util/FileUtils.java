
package com.mansmall.util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.apache.commons.io.IOUtils;
import org.imgscalr.Scalr;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.util.FileCopyUtils;

/*
 * 웹 프로젝트 외부 영역에 존재하는 파일작업을  하기 위한 유틸
 */
public class FileUtils {
	 //String...은 가변사이즈 매개변수 (가변인자★) 배열!
	private static void makeDir(String uploadPath, String... paths) {
		
		//디렉토리가 존재하면 새로 만들지 않고skip//인덱스는 0부터 시작하기때문에 -1
		if(new File(paths[paths.length-1]).exists()) {
			return;
		}
		
		//매개변수로 들어온 경로의 모든 폴더 생성
		for(String path: paths) {
			File dirPath = new File(uploadPath + path);
			//해당 폴더가 존재하지 않으면
			if(!dirPath.exists()) {
				dirPath.mkdir();// 폴더생성  (mkdir 디렉토리 만드는 명령어)
				} 
			}
		}

	/* 완료
	 * 날짜 폴더 경로 설정 메소드
	 * 
	 * @Params
	 * uploadPath : 기본 파일 업로드 경로
	 * 
	 * @return 
	 * String : 생성된 날짜 폴더 경로(ex.\\2020\\03\\03)
	 * 
	 */
	private static String calcPath(String uploadPath) {
		Calendar cal = Calendar.getInstance();
		// DecimalFormat 객체는 10진수의 포맷 변경시 사용
        // 한자리수 월, 날짜일 경우 01 02 03...으로 표현하기 위함 
        // format은 포맷에 맞는 문자열을 리턴
        // Calendar객체에서 1월은 0으로 출력하기때문에
        // 현재 월을 알고 싶다면 Calendar.MONTH + 1 을 해줘야한다.
		// 년/월/일 형태의 날짜 경로 
		
		// 년 (ex. \\2020)
		String yearPath = File.separator + cal.get(Calendar.YEAR);
		// 년 + 월 (ex. \\2020\\03)
		String monthPath = yearPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.MONTH)+1);
		// 년 + 월 + 일 (ex. \\2020\\03\\13)
		String datePath = monthPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.DATE));
		
		System.out.println("=====calcPath result: " + datePath);
		
		// 경로 별 모든 폴더 생성
		makeDir(uploadPath, yearPath, monthPath, datePath);
		
		return datePath;
	}	
	
	/*완료
	 * 파일 업로드
	 * 
	 * @Params
	 * String uploadPath: 기본 파일 업로드 경로
	 * String originName: 원본 파일명
	 * byte[] fileData:   파일 데이터
	 * 
	 * @return
	 * String uploadedFileName : 날짜 경로 + 파일 이름 (ex.\\2020\\03\\13\\uuid+fileName)
	 * 
	 */
	public static String uploadFile(String uploadPath,String originName, byte[] fileData) throws Exception{
		
		System.out.println("uploadFile() 실행중");
		
		//파일명 설정 -> uuid_파일명
		UUID uuid = UUID.randomUUID();// 파일명 중복방지 목적
		//원본이름에 uuid값을 추가하여 저장할 이름 설정.
		String saveName = uuid.toString()+ "_"+ originName;
		//파일 경로 설정 : 한 폴더에 너무 많은 폴더 생성을 방지하기 위해서 날짜별로 분류
		//기존 경로\날짜 폴더
		String savePath = calcPath(uploadPath); //ex. \\2020\\03\\13
		//설정한 정보로 빈 파일 생성
		//기존경로\날짜경로에 비어있는 파일 생성. 
		File target = new File(uploadPath + savePath, saveName);
		//만든 파일에 데이터 씀.
		//파일 데이터를 target에 복사.
		FileCopyUtils.copy(fileData, target);
		
		// 확장자 명만 가져옴
		String formatName = originName.substring(originName.lastIndexOf(".") +1);
		//업로드 되는 파일 이름을 저장할 변수
		String uploadFileName = null;
		
		// 이미지 파일인지 일반 파일인지 확인
		// 이미지 파일이면, 썸네일 생성  (이미지파일 확장자가 아니라면 null이 리턴됨)
		if(MediaUtils.getMediaType(formatName) != null) {
			uploadFileName = makeThumbNail(uploadPath, savePath, saveName);
			
		} else {
		// 일반 파일이면, 아이콘 생성
			uploadFileName = makeIcon(uploadPath, savePath, saveName);
		}
		
		return uploadFileName;
	}
	
	
	
	/*공부완료
	 * 이미지 파일의 썸네일 생성 메소드
	 * 
	 * @Params
	 * String uploadPath : 기본 파일 업로드 경로
	 * String path		 : 년/월/일에 해당하는 특정 경로  
	 * String fileName 	 : UUID_originName 
	 * @return           : 섬네일의 전체 경로
	 * 
	 */
	private static String makeThumbNail(String uploadPath, String path, String fileName) throws Exception {
	    //이미지 파일처럼 메모리가 많이 필요한 경우 메모리 자원을 확보 못 할 수 있다. 미리 이미지를 처리해두는 BufferedImage 사용(임포트 필요)
		
		BufferedImage sourceImg = ImageIO.read(new File(uploadPath + path, fileName)); //BufferedImage 안의 파일을 읽기 위해 ImageIO 임포트 후 사용
		// 크기를 조정하여 이미지 데이터저장.
		BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 140); // sourceImg 원본이미지
																												// 이미지 가로/세로 비율 유지 																												// 이미지 높이를 120px로 맞춤.
		// 썸네일 생성 준비 
		
		String thumbNailName = uploadPath + path + File.separator + "s_" + fileName; // 원본 파일 앞에 s_를 붙이는 형식으로 섬네일 파일 이름 설정.  
		File newFile = new File(thumbNailName);										 //섬네일 파일 생성. 
		String formatName = fileName.substring(fileName.lastIndexOf(".") + 1); 		 
		// 형식 = 파일 이름에서 .을 찾아 그 뒤의 인덱스부터 읽어들임                           
	    // ex : test.exe 이면 . 뒤의 exe를 추출, 즉 파일 확장자 추출 과정.
		
		// 썸네일 생성
		ImageIO.write(destImg, formatName.toUpperCase(), newFile);
		
		// 생성한 썸네일 경로의 subString을 반환
		System.out.println("=====makeThumbNail() thumbNail: " + thumbNailName); 
		return thumbNailName.substring(uploadPath.length()).replace(File.separatorChar, '/');
		// 섬네일이 존재하는 윈도우 전체 경로에서 윈도우의 파일 구분자인 \ 를 브라우저에서
	    // 제대로 인식하지 못하기 때문에 U에서 사용하는 / 로 치환한 다음 반환. 
	}
	
	/*
	 * 일반 파일의 아이콘 생성 메소드
	 * 
	 * @Params
	 * String uploadPath : 기본 파일 업로드 경로
	 * String path		 : 날짜 경로
	 * String fileName 	 : UUID_originName 
	 * 
	 * @return
	 * String : 날짜 경로 +s_ +fileName 
	 * 	ex)\\2020\\03\\13\\uuid+s_+fileName
	 * 
	 */
	private static String makeIcon(String uploadPath, String path, String fileName) throws Exception{
		String iconName = uploadPath + path + File.separator + fileName;
		
		return iconName.substring(uploadPath.length()).replace(File.separatorChar, '/');
	}

	
	/*
	 * 파일 가져옴
	 * 웹 프로젝트 외부 영역의 파일을 가져와
	 * ResponseEntity로 반환
	 * 
	 * @Params
	 * String uploadPath : 외부 폴더 업로드 경로
	 * String fileName : 가져올 파일 명
	 * 
	 * @return
	 * ResponseEntity<byte[]> : 가져온 파일 정보와 Http상태코드를 반환 
	 * 
	 * 리턴값: 썸네일 이미지를 사용하도록 확인.
	 */
	public static ResponseEntity<byte[]> getFile(String uploadPath, String fileName) throws Exception {
		//입력스트림 객체: 자원(파일)을 대상으로 스트림(매개체)을 통하여 읽기기능(Input Stream)으로부터 사용하여 데이터를 읽어오는 객체
		InputStream in = null; //최상위 추상클래스. 작업방향 : 입력이었기 때문에. 다루는 데이타의 단위 : byte //fileInputStream도 가능.(자식클래스)
		ResponseEntity<byte[]> entity = null;
		
		//파일이 존재하지 않을 경우에는 예외가 발생하여, 예외처리 구문을 함.
		try {
			// 파일의 확장자로 파일 종류 확인
			String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
			//파일명이 이미지의 종류인지 체크.
			MediaType type = MediaUtils.getMediaType(formatName);
			
			// 파일 헤더 설정
			HttpHeaders headers = new HttpHeaders();
			headers.setContentType(type);
			
			// 파일 가져옴
			in = new FileInputStream(uploadPath + fileName);

			// entity 생성  // IOUtils 이 클래스는 스트림 수준에서 복사 또는 읽기, 쓰기 기능을 제공한다.
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.OK);
			
		} catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
			
		} finally {
			in.close();
		}
		
		return entity;
	}
	
	/*
	 * 이미지 파일 삭제
	 * 
	 * @Params 
	 * String uploadPath : 파일 경로
	 * String fileName : 삭제할 파일
	 * 
	 */
	public static void deleteFile(String uploadPath, String fileName) {
		
		//  날짜경로+ UUID_fileName
		String front = fileName.substring(0, 12); 	// 날짜 경로 /2020/03/20/
		String end = fileName.substring(14); 		// UUID_fileName
		String origin = front + end;
		// 원본 파일 지우기
		new File(uploadPath+origin.replace('/', File.separatorChar)).delete(); // File.separatorChar:/로 파일경로 분리하기 
		// 썸네일 파일 지우기
		new File(uploadPath+fileName.replace('/', File.separatorChar)).delete(); 	
	}
	
	
	/* 공부완료
	 * 썸네일 파일명 -> 원래 파일명
	 * ex) /2020/03/20/s_UUID파일명 -> /2020/03/20/UUID파일명
	 */
	public static String thumbToOriginName(String thumbnailName) {
		String front = thumbnailName.substring(0, 12); 	// 날짜 경로, substring(0부터 12 전까지 출력)
		String end = thumbnailName.substring(14); 		// UUID_fileName, 14부터 끝까지 출력
		
		return front+end;
		
	}
	
	
	
	
}
