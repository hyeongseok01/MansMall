package com.mansmall.controller;



import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.mansmall.domain.OrderVO;
import com.mansmall.service.AdOrderListService;
import com.mansmall.service.OrderService;
import com.mansmall.util.Criteria;
import com.mansmall.util.PageMaker;

@Controller
@RequestMapping("/admin/order/*")
public class AdOrderController {
	
	@Autowired
	AdOrderListService service;
	
	@Inject
	private OrderService orderService;
	
	private static final Logger logger = LoggerFactory.getLogger(AdOrderController.class);
	
	//주문현황
	@GetMapping("orderList")
	public void adOrderList(@ModelAttribute("cri")Criteria cri,
							@ModelAttribute("odr_code") String odr_code, Model model) throws Exception{
		logger.info("adOrderList() 실행중");
		
		List<OrderVO> list = service.adOrderList(cri);
		model.addAttribute("orderList", list);
		
		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		int count = service.adOrderListCount(odr_code);
		pm.setTotalCount(count);
		model.addAttribute("pm", pm);
	}
	//배송현황 수정
	@PostMapping("modify")
	public ResponseEntity<String> deliveryModify(int odr_code, String delivery){
		
		logger.info("modify실행중");
		
		ResponseEntity<String> entity = null;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("odr_code",odr_code);
		map.put("delivery",delivery);
		
		try {
			service.deliveryModify(map);
			entity= new ResponseEntity<String>(HttpStatus.OK);
		} catch(Exception e){
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST); 
		}
		return entity;
	}
	
	//주문 상세 조회
	@RequestMapping(value = "orderRead",method = RequestMethod.GET)
	public void readOrderGET(int odr_code,Model model, HttpSession session) throws Exception{
		
		logger.info("readOrderGET 실행중");
		model.addAttribute("orderList", orderService.readOrder(odr_code));
		model.addAttribute("order", orderService.getOrder(odr_code));
		
	}

}
