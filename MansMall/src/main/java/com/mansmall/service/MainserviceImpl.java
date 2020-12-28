package com.mansmall.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mansmall.domain.ProductVO;
import com.mansmall.persistence.MainDAO;
import com.mansmall.util.Criteria;
@Service
public class MainserviceImpl implements MainService {

	@Autowired
	private MainDAO dao;
	
	@Override
	public List<ProductVO> mainList(Criteria cri) throws Exception {
		return dao.mainList(cri);
	}

	@Override
	public int mainCount() throws Exception {
		return dao.mainCount();
	}

}
