package com.lz.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import com.lz.entity.Notice;
import com.lz.utils.PropertiesUtils;

public class NoticeDao {
	//根据所发消息的对象增加消息
	public void add(Notice n) throws SQLException{
		QueryRunner queryRunner = new QueryRunner(PropertiesUtils.getDataSource());
		String sql = "insert into notice(e_id,n_text,n_time) values(?,?,?)";
		
		Object[] params = {n.getE_id(),n.getN_text(),n.getN_time()};
		queryRunner.update(sql, params);
		
	}
	//根据消息id删除相应的消息
	public void delete(Integer n_id) throws SQLException {
		QueryRunner queryRunner = new QueryRunner(PropertiesUtils.getDataSource());
		String sql = "delete from notice where n_id = ?";
		queryRunner.update(sql, n_id);
	}
	
    //查询所有消息并以list返回
	public List<Notice> listNotice(Integer e_id) throws SQLException{
		QueryRunner queryRunner = new QueryRunner(PropertiesUtils.getDataSource());
		String sql = "select * from notice where e_id = "+e_id;
		List<Notice> list = queryRunner.query(sql,new BeanListHandler<>(Notice.class));
		return list;
	}
	
}




















