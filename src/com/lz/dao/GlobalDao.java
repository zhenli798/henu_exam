package com.lz.dao;

import com.lz.entity.Global;
import com.lz.utils.PropertiesUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;

import java.sql.SQLException;

public class GlobalDao {
	//更新全局变量的信息
	public void update(Global g)  {
		QueryRunner queryRunner = new QueryRunner(PropertiesUtils.getDataSource());
		String sql = "update global set task_interval=?,record_number=?,max_advance_time=?,min_file_size=?,max_file_size=?,teacher_can_clean=? where g_id=1";
		Object[] params = {g.getTask_interval(),g.getRecord_number(),g.getMax_advance_time(),g.getMin_file_size(),g.getMax_file_size(),g.getTeacher_can_clean()};
		System.out.println("global18："+g.getTask_interval()+"  "+g.getRecord_number()+"  "+g.getMax_advance_time()+"  "+g.getMin_file_size()+"  "+g.getMax_file_size()+"  "+g.getTeacher_can_clean());
		try {
			queryRunner.update(sql, params);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	//查询全局变量的信息
	public Global getGlobal() throws SQLException {
		QueryRunner queryRunner = new QueryRunner(PropertiesUtils.getDataSource());
		String sql = "select * from global where g_id = 1";
		Global global = queryRunner.query(sql,new BeanHandler<>(Global.class));
		return global;
	}
}




















