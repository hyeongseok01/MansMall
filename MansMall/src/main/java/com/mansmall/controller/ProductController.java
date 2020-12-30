package com.mansmall.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mansmall.domain.CategoryVO;
import com.mansmall.domain.ProductVO;
import com.mansmall.domain.ReviewVO;
import com.mansmall.service.ProductService;
import com.mansmall.service.ReviewService;
import com.mansmall.util.Criteria;
import com.mansmall.util.FileUtils;
import com.mansmall.util.PageMaker;
import com.mansmall.util.SearchCriteria;

@Controller
@RequestMapping("/product/*")
public class ProductController {

	@Autowired
	ProductService service;
	
	@Inject
	ReviewService review;
	
	// 웹 프로젝트 영역 외부에 파일을 저장할 때 사용할 경로
	@Resource(name="uploadPath")
	private String uploadPath; // servlet-context.xml에 설정
			
	private static final Logger logger = LoggerFactory.getLogger(ProductController.class);
	
	// 1차 카테고리에 따른 2차 카테고리 출력
	//@PathVariable("cg_code")
	// 	: path로 들어온 1차카테고리
	@ResponseBody
	@RequestMapping(value="subCGList/{cg_code}",method = RequestMethod.GET)
	public ResponseEntity<List<CategoryVO>>subCGListGET(@PathVariable("cg_code") String cg_code){
		
		logger.info("subCGListGET() execute.....");
		
		ResponseEntity<List<CategoryVO>> entity = null;
		try {
			logger.info("==="+service.subCGList(cg_code));
			entity = new ResponseEntity<List<CategoryVO>> (service.subCGList(cg_code),HttpStatus.OK);
		}catch(Exception e) {
			entity = new ResponseEntity<List<CategoryVO>>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	//파일 출력(여기서는 저장된 이미지를 가져와 반환)
	@ResponseBody
	@GetMapping("displayFile")
	public ResponseEntity<byte[]> displayFile(String fileName) throws Exception {
		return FileUtils.getFile(uploadPath, fileName);
	}
	
	
	/* 카테고리에 해당하는 상품 리스트 출력 */
	@GetMapping("list")
	public void list(@ModelAttribute("cri")Criteria cri,
					 @ModelAttribute("cg_code") String cg_code,
					 Model model) throws Exception {
		
		logger.info("list 실행");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cg_code", cg_code);
		map.put("rowStart", cri.getRowStart());
		map.put("rowEnd", cri.getRowEnd());
			
		List<ProductVO> list = service.productListCG(map);
		model.addAttribute("productList", list);
		model.addAttribute("cg_name", service.getCGName(cg_code));

		
		// PageMaker 생성
		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		int count = service.productCount(cg_code);
		pm.setTotalCount(count);
		
		model.addAttribute("pm", pm);
	}
	
	
	
	/*상품 상세정보 페이지 읽기   */
	@RequestMapping(value = "read", method = RequestMethod.GET)
	public void productReadGET(@ModelAttribute("cri") Criteria cri,
								@RequestParam("pdt_num") int pdt_num, Model model) throws Exception {
		
		logger.info("상세정보(productReadGET) 페이지 실행중");
		
		// 선택한 상품 정보의 이미지를 썸네일에서 원본으로 변경
		ProductVO vo = service.readProduct(pdt_num);
		vo.setPdt_img(FileUtils.thumbToOriginName(vo.getPdt_img()));
		
		//logger.info("=====dateFormat: " + DateFormatUtils.kstToDate(vo.getPdt_date_sub()).toString());
		logger.info("상품 상세: "+ vo.toString());
		model.addAttribute("vo", vo);
		
		//PageMaker 생성- 상품목록으로 돌아가기 클릭 시 이동하기 위해서
		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		
		model.addAttribute("pm", pm);
		
		// 해당 상품에 달린 상품 후기 개수를 함께 보냄
		model.addAttribute("totalReview", review.countReview(vo.getPdt_num()));
	}
	

	/* 검색조건에 해당하는 상품 리스트 출력 */
	@RequestMapping(value="listSearch", method =RequestMethod.GET)
	public void listSearch(@ModelAttribute("scri") SearchCriteria scri,
							Model model) throws Exception{
		logger.info("리스트검색 실행중");
		logger.info("SearchCriteria"+ scri.toString());
	
		List<ProductVO> list = service.productListSearch(scri);
		model.addAttribute("productList", list);
		
		//PageMaker 생성
		PageMaker pm = new PageMaker();
		pm.setCri(scri);
		int count =  service.productSearchCount(scri.getKeyword());
		pm.setTotalCount(count);
		
		model.addAttribute("pm", pm);

	}
}   
