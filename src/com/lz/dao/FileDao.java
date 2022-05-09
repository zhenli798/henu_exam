package com.lz.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;

import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import com.lz.entity.myFile;
import com.lz.utils.PageInfo;
import com.lz.utils.PropertiesUtils;

public class FileDao {
	public void add(myFile f) throws SQLException{
		QueryRunner queryRunner = new QueryRunner(PropertiesUtils.getDataSource());
		String sql = "insert into file(s_id,f_name,f_path,f_time) values(?,?,?,?)";
		Object[] params = {f.getS_id(),f.getF_name(),f.getF_path(),f.getF_time()};
		queryRunner.update(sql, params);
	}
	public void delete(Integer id) throws SQLException {
		QueryRunner queryRunner = new QueryRunner(PropertiesUtils.getDataSource());
		String sql = "delete from file where f_id = ?";
		queryRunner.update(sql, id);
	}
	// 学生查询，返回文件列表
			public PageInfo<myFile> listFile(String s_id,String f_name,PageInfo<myFile> pageInfo) throws SQLException {
				QueryRunner queryRunner = new QueryRunner(PropertiesUtils.getDataSource());
				String sql;
				if(f_name==null||f_name.equals("")) {
					 sql = "select * from file where s_id=" +s_id+ " limit  "+(pageInfo.getPageNo()-1)*pageInfo.getPageSize()+" , "+pageInfo.getPageSize();
				}else {
					sql = "select * from file where s_id=" +s_id+" and f_name like '%"+f_name+ "%' limit  "+(pageInfo.getPageNo()-1)*pageInfo.getPageSize()+" , "+pageInfo.getPageSize();
				}
				System.out.println("listFile:"+sql);
				List<myFile> list = queryRunner.query(sql, new BeanListHandler<>(myFile.class));
				pageInfo.setList(list);
				pageInfo.setTotalCount(this.count(s_id,f_name)); 
				return pageInfo;
			}
		//学生查询，返回文件数量
			public Long count(String s_id, String f_name) throws SQLException {
				QueryRunner queryRunner = new QueryRunner(PropertiesUtils.getDataSource());
				String sql;
				if(f_name==null||f_name.equals("")) {
					 sql = "select count(*) from file where s_id="+s_id;
				}else {
					sql = "select count(*) from file where s_id="+s_id+" and f_name like '%"+f_name+ "%'";
				}
				
				Long count = (Long)queryRunner.query(sql, new ScalarHandler());
				System.out.println("总条数："+count);
				return count;
			}
	
}




















