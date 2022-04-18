package com.lz.dao;

import com.lz.entity.Student;
import com.lz.utils.PageInfo;
import com.lz.utils.PropertiesUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class StudentDao {
	//手动添加学生
	public void add(Student s) throws SQLException{
		QueryRunner queryRunner = new QueryRunner(PropertiesUtils.getDataSource());
		String sql = "insert into student(e_id,s_id,s_name,s_class) values(?,?,?,?)";
		Object[] params = {s.getE_id(),s.getS_id(),s.getS_name(),s.getS_class()};
		queryRunner.update(sql, params);
		
	}
	//根据学生id删除学生
	public void delete(Integer s_i) throws SQLException {
		QueryRunner queryRunner = new QueryRunner(PropertiesUtils.getDataSource());
		String sql = "delete from student where s_i = ?";
		queryRunner.update(sql, s_i);
	}
	//更新学生信息
	public void update(Student s) throws SQLException {
		QueryRunner queryRunner = new QueryRunner(PropertiesUtils.getDataSource());
		String sql = "update student set s_id=?,s_name=?,s_class=?where s_i=?";
		Object[] params = {s.getS_id(),s.getS_name(),s.getS_class(),s.getS_i()};
		queryRunner.update(sql, params);
	}
	//修改学生成绩
	public void editScore(Integer s_i, Integer s_score, String s_comment) throws SQLException {
		QueryRunner queryRunner = new QueryRunner(PropertiesUtils.getDataSource());
		String sql = "update student set s_score=?,s_comment=? where s_i=?";
		Object[] params = {s_score,s_comment,s_i};
		queryRunner.update(sql,params);
	}
	//查询学生所有信息
	public PageInfo<Student> listStudent(Student student, PageInfo<Student> pageInfo) throws SQLException {
		QueryRunner queryRunner = new QueryRunner(PropertiesUtils.getDataSource());
		String _sql = "";
//		System.out.println("s_id:"+student.getS_id());
//		System.out.println("s_name:"+student.getS_name());
//		System.out.println("s_class:"+student.getS_class());
//		System.out.println("e_id:"+student.getE_id());
		List<Object> _list = new ArrayList<Object>();
		if(student != null && student.getS_id() != "" && student.getS_id()!=null) {
			_sql += " and s_id like ?";
			_list.add("%"+student.getS_id()+"%");
		}
		if(student != null && student.getS_name()!="" && student.getS_name()!=null) {
			_sql += " and s_name like ?";
			_list.add("%"+student.getS_name()+"%");
		}
		if(student != null && student.getS_class()!="" && student.getS_class()!=null) {
			_sql += " and s_class = ?";
			_list.add(student.getS_class());
		}
		//_list转数组
		Object[] arr = new Object[_list.size()];
		for (int i=0;i<_list.size();i++) {
			arr[i] = _list.get(i);
		}
		String sql = "select * from student where e_id="+student.getE_id()+_sql+" limit "+(pageInfo.getPageNo()-1)*pageInfo.getPageSize()+" , "+pageInfo.getPageSize();
		System.out.println("S,Dao,studentlist:"+sql);
		List<Student> list = queryRunner.query(sql, new BeanListHandler<>(Student.class),arr);
		System.out.println("studentlist:"+list);
		pageInfo.setList(list);
		pageInfo.setTotalCount(this.count(student)); 
		
		return pageInfo;
	}
//返回一场考生里面学生的个数
	public Long count(Student student) throws SQLException {
		QueryRunner queryRunner = new QueryRunner(PropertiesUtils.getDataSource());
		String _sql = "";
//		System.out.println("s_id:"+student.getS_id());
//		System.out.println("s_name:"+student.getS_name());
//		System.out.println("s_class:"+student.getS_class());
//		System.out.println("e_id:"+student.getE_id());
		List<Object> _list = new ArrayList<Object>();
		if(student != null && student.getS_id() != "" && student.getS_id()!=null) {
			_sql += " and s_id like ?";
			_list.add("%"+student.getS_id()+"%");
		}
		if(student != null && student.getS_name()!="" && student.getS_name()!=null) {
			_sql += " and s_name like ?";
			_list.add("%"+student.getS_name()+"%");
		}
		if(student != null && student.getS_class()!="" && student.getS_class()!=null) {
			_sql += " and s_class = ?";
			_list.add(student.getS_class());
		}
		//_list转数组
		Object[] arr = new Object[_list.size()];
		for (int i=0;i<_list.size();i++) {
			arr[i] = _list.get(i);
		}
		String sql = "select count(*) from student where e_id="+student.getE_id()+_sql;
		System.out.println("S,D,Studentcount:"+sql);
		Long count = (Long)queryRunner.query(sql, new ScalarHandler());
		System.out.println("总条数："+count);
		return count;
	}
	

	//学生登录判断
	public Student login(String s_id, String s_pwd) throws SQLException {
		QueryRunner queryRunner = new QueryRunner(PropertiesUtils.getDataSource());
		String sql = "select * from student where s_id = ? and s_name = ?";
		Student student = queryRunner.query(sql,new BeanHandler<>(Student.class),s_id, s_pwd);
		return student;
	}
	//学生上传答案后修改数据库
	public void upfile(Student s) throws SQLException {
		QueryRunner queryRunner = new QueryRunner(PropertiesUtils.getDataSource());
		String sql = "update student set s_fname=?, s_fpath=? where s_i = ?";
		Object[] params = {s.getS_fname(),s.getS_fpath(),s.getS_i()};
		queryRunner.update(sql, params);
	}
	
}




















