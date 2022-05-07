package com.lz.dao;

import com.lz.entity.Teacher;
import com.lz.utils.PageInfo;
import com.lz.utils.PropertiesUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TeacherDao {
	// 增加教师
	public void add(Teacher t) throws SQLException{
		QueryRunner queryRunner = new QueryRunner(PropertiesUtils.getDataSource());
		String sql = "insert into teacher(t_id,t_pwd,t_name,t_isadmin) values(?,?,?,?)";
		Object[] params = {t.getT_id(),t.getT_pwd(), t.getT_name(),t.getT_isadmin()};
		queryRunner.update(sql, params);
		
	}
	// 删除教师
	public void delete(String id) throws SQLException {
		QueryRunner queryRunner = new QueryRunner(PropertiesUtils.getDataSource());
		String sql = "delete from teacher where t_id = ?";
		//System.out.print("Teacherdao:"+id);
		queryRunner.update(sql, id);
	}
	// 更新教师信息
	public void update(Teacher t) throws SQLException {//根据t_id, 更新密码之外的信息
		QueryRunner queryRunner = new QueryRunner(PropertiesUtils.getDataSource());
		String sql = "update teacher set t_name = ?,t_isadmin = ? where t_id = ?";
		Object[] params = {t.getT_name(),t.getT_isadmin(),t.getT_id()};
		queryRunner.update(sql, params);
	}
	// 重置教师密码
	public void resetPwd(Teacher t) throws SQLException { //根据t_id,更新密码
		QueryRunner queryRunner = new QueryRunner(PropertiesUtils.getDataSource());
		String sql = "update teacher set t_pwd = ? where t_id = ?";
		Object[] params = {t.getT_pwd(), t.getT_id()};
		//System.out.println("42:"+t.getT_pwd()+"  "+t.getT_id());
		queryRunner.update(sql, params);
	}
	
	// 根据教师id查找教师信息
	public Teacher findById(String id) throws SQLException {
		QueryRunner queryRunner = new QueryRunner(PropertiesUtils.getDataSource());
		String sql = "select * from teacher where t_id = ?";
		Teacher teacher = queryRunner.query(sql,new BeanHandler<>(Teacher.class),id);
		return teacher;
	}
	//判断教师是否登录
	public Teacher login(String t_id, String t_pwd) throws SQLException {
		QueryRunner queryRunner = new QueryRunner(PropertiesUtils.getDataSource());
		String sql = "select * from teacher where t_id = ? and t_pwd = ?";
		Teacher teacher = queryRunner.query(sql,new BeanHandler<>(Teacher.class),t_id,t_pwd);
		return teacher;
	}
	// 查找所有教师信息
	public PageInfo<Teacher> list(Teacher teacher, PageInfo<Teacher> pageInfo) throws SQLException {

		QueryRunner queryRunner = new QueryRunner(PropertiesUtils.getDataSource());
		String _sql = "";
		List<Object> _list = new ArrayList<Object>();
		if(teacher != null && teacher.getT_id() != "" && teacher.getT_id()!=null) {
			_sql += " and t_id like ?";
			_list.add("%"+teacher.getT_id()+"%");
		}
		if(teacher != null && teacher.getT_name()!="" && teacher.getT_name()!=null) {
			_sql += " and t_name like ?";
			_list.add("%"+teacher.getT_name()+"%");
		}
		if(teacher != null && teacher.getT_isadmin()!=null) {
			_sql += " and t_isadmin = ?";
			_list.add(teacher.getT_isadmin());
		}
		//_list转数组
		Object[] arr = new Object[_list.size()];
		for (int i=0;i<_list.size();i++) {
			arr[i] = _list.get(i);
		}
		String sql = "select * from teacher where 1=1 "+_sql+" limit "+(pageInfo.getPageNo()-1)*pageInfo.getPageSize()+" , "+pageInfo.getPageSize();
		List<Teacher> list = queryRunner.query(sql, new BeanListHandler<>(Teacher.class),arr);
		pageInfo.setList(list);
		pageInfo.setTotalCount(this.count(teacher)); 
		
		return pageInfo;
	}
	//管理员查询，返回老师个数
	public Long count(Teacher teacher) throws SQLException {
		QueryRunner queryRunner = new QueryRunner(PropertiesUtils.getDataSource());
		String _sql = "";
		List<Object> _list = new ArrayList<Object>();
		if(teacher != null && teacher.getT_id() != "" && teacher.getT_id()!=null) {
			_sql += " and t_id like ?";
			_list.add("%"+teacher.getT_id()+"%");
		}
		if(teacher != null && teacher.getT_name()!="" && teacher.getT_name()!=null) {
			_sql += " and t_name like ?";
			_list.add("%"+teacher.getT_name()+"%");
		}
		if(teacher != null && teacher.getT_isadmin()!=null) {
			_sql += " and t_isadmin = ?";
			_list.add(teacher.getT_isadmin());
		}
		//_list转数组
		Object[] arr = new Object[_list.size()];
		for (int i=0;i<_list.size();i++) {
			arr[i] = _list.get(i);
		}
		String sql = "select count(*) from teacher where 1=1 "+_sql;
		System.out.println("TeacherDao   "+sql+teacher.getT_id());
		Long count = (Long)queryRunner.query(sql, new ScalarHandler(),arr);
		//System.out.println("总条数："+count);
		return count;
	}

	

}




















