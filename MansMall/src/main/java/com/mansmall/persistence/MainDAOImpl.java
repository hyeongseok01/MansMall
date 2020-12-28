package com.mansmall.persistence;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.mansmall.domain.ProductVO;
import com.mansmall.util.Criteria;
@Repository
public class MainDAOImpl implements MainDAO {

	
	@Inject
	private SqlSession session;
	public final static String NS ="com.mansmall.mappers.mainMapper";
	
	@Override
	public List<ProductVO> mainList(Criteria cri) throws Exception {	
		return session.selectList(NS+".mainList", cri);
	}

	@Override
	public int mainCount() throws Exception {	
		return session.selectOne(NS+".mainCount");
	}

}
