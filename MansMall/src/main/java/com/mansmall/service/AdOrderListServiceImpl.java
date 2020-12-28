package com.mansmall.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.mansmall.domain.OrderVO;
import com.mansmall.persistence.AdOrderListDAO;
import com.mansmall.util.Criteria;
@Service
public class AdOrderListServiceImpl implements AdOrderListService {
		
	@Inject
	private AdOrderListDAO dao;
	
	@Override
	public List<OrderVO> adOrderList(Criteria cri) throws Exception {
		return dao.adOrderList(cri);
	}

	@Override
	public int adOrderListCount(String odr_code) throws Exception {
		return dao.adOrderListCount(odr_code);
	}

	@Override
	public void deliveryModify(Map map) throws Exception {
		dao.deliveryModify(map);
	}

}
