package com.mansmall.persistence;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.mail.Session;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.mansmall.domain.OrderVO;
import com.mansmall.util.Criteria;
@Repository
public class AdOrderListDAOImpl implements AdOrderListDAO {
	
	@Inject
	private SqlSession session;
	public final static String NS="com.mansmall.mappers.adOrderMapper";
	
	@Override
	public List<OrderVO> adOrderList(Criteria cri) throws Exception {
		return session.selectList(NS+".adOrderList", cri);
	}

	@Override
	public int adOrderListCount(String odr_code) throws Exception {
		return session.selectOne(NS+".adOrderListCount", odr_code);
	}

	@Override
	public void deliveryModify(Map map) throws Exception {
		session.update(NS+".deliveryModify", map);
	}

}
