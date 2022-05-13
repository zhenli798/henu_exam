package com.lz.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import com.lz.entity.Exam;
import com.lz.entity.Exam2;
import com.lz.entity.Notice;
import com.lz.utils.PageInfo;
import com.lz.utils.PropertiesUtils;

public class ExamDao {
	
	public void add(Exam e) throws SQLException{//刚添加时没有q_name,q_path
		QueryRunner queryRunner = new QueryRunner(PropertiesUtils.getDataSource());
		String sql = "insert into exam(t_id,e_name,e_starttime,e_stoptime,e_autostart,e_status) values(?,?,?,?,?,?)";
		Object[] params = {e.getT_id(),e.getE_name(),e.getE_starttime(),e.getE_stoptime(),e.getE_autostart(),e.getE_status()};
		queryRunner.update(sql, params);
		
	}
	//根据考试id删除考试
	public void deleteExam(Integer id) throws SQLException {
		QueryRunner queryRunner = new QueryRunner(PropertiesUtils.getDataSource());
		String sql = "delete from exam where e_id = ?";
		queryRunner.update(sql,  id);
	}
	
	//传入exam对象，完全更新，构造的时候，可以使用session里的。
	public void update(Exam e) throws SQLException {
		QueryRunner queryRunner = new QueryRunner(PropertiesUtils.getDataSource());
		String sql = "update exam set t_id = ?, e_name = ?, e_starttime = ?, e_stoptime=?, e_autostart=?,q_name=?, q_path=?, e_status = ? where e_id = ?";
		Object[] params = {e.getT_id(),e.getE_name(),e.getE_starttime(),e.getE_stoptime(),e.getE_autostart(),e.getQ_name(),e.getQ_path(),e.getE_status(),e.getE_id()};
		queryRunner.update(sql, params);
	}
	
	//老师查询，返回考试列表
		public PageInfo<Exam> listExam(String t_id,String e_name,PageInfo<Exam> pageInfo) throws SQLException {
			QueryRunner queryRunner = new QueryRunner(PropertiesUtils.getDataSource());
			String sql;
			if(e_name==null||e_name.equals("")) {
				 sql = "select * from exam where t_id=" +t_id+ " limit  "+(pageInfo.getPageNo()-1)*pageInfo.getPageSize()+" , "+pageInfo.getPageSize();
			}else {
				sql = "select * from exam where t_id=" +t_id+" and e_name like '%"+e_name+ "%' limit  "+(pageInfo.getPageNo()-1)*pageInfo.getPageSize()+" , "+pageInfo.getPageSize();
			}
			System.out.println("listExam:"+sql);
			List<Exam> list = queryRunner.query(sql, new BeanListHandler<>(Exam.class));
			pageInfo.setList(list);
			pageInfo.setTotalCount(this.count(t_id,e_name)); 
			return pageInfo;
		}
	//老师查询，返回考试数量
		public Long count(String t_id, String e_name) throws SQLException {
			QueryRunner queryRunner = new QueryRunner(PropertiesUtils.getDataSource());
			String sql;
			if(e_name==null||e_name.equals("")) {
				 sql = "select count(*) from exam where t_id="+t_id;
			}else {
				sql = "select count(*) from exam where t_id="+t_id+" and e_name like '%"+e_name+ "%'";
			}
			
			Long count = (Long)queryRunner.query(sql, new ScalarHandler());
			System.out.println("总条数："+count);
			return count;
		}
		//学生查询，返回自己的考试列表
				public PageInfo<Exam2> listMyExam(String s_id,String e_name,PageInfo<Exam2> pageInfo) throws SQLException {
					QueryRunner queryRunner = new QueryRunner(PropertiesUtils.getDataSource());
					String sql;
					if(e_name==null||e_name.equals("")) {
						 sql = "select student.e_id,s_i,e_name,e_starttime,e_stoptime,q_path,q_name,s_fname,s_fpath,s_score,s_comment from student,exam where student.e_id=exam.e_id and student.s_id=" +s_id+ " limit  "+(pageInfo.getPageNo()-1)*pageInfo.getPageSize()+" , "+pageInfo.getPageSize();
					}else {
						sql = "select student.e_id,s_i,e_name,e_starttime,e_stoptime,q_path,q_name,s_fname,s_fpath,s_score,s_comment from student,exam where student.e_id=exam.e_id and student.s_id=" +s_id+" and e_name='" +e_name+ "' limit  "+(pageInfo.getPageNo()-1)*pageInfo.getPageSize()+" , "+pageInfo.getPageSize();
					}
					List<Exam2> list = queryRunner.query(sql, new BeanListHandler<>(Exam2.class));
					pageInfo.setList(list);
					pageInfo.setTotalCount(this.countMyexam(s_id)); 
					return pageInfo;
				}
			//学生查询，返回考试数量
				public Long countMyexam(String s_id) throws SQLException {
					QueryRunner queryRunner = new QueryRunner(PropertiesUtils.getDataSource());
					String sql="select count(*) from student,exam where student.e_id=exam.e_id and student.s_id="+s_id;					
					Long count = (Long)queryRunner.query(sql, new ScalarHandler());
					System.out.println("总条数："+count);
					return count;
				}
		public Exam findById(Integer e_id) throws SQLException {
			QueryRunner queryRunner = new QueryRunner(PropertiesUtils.getDataSource());
			String sql = "select * from exam where e_id = ?";
			Exam exam = queryRunner.query(sql,new BeanHandler<>(Exam.class),e_id);
			return exam;
		}
		//某考生的某场考试
		public Exam2 findBySI(Integer s_i) throws SQLException {
			QueryRunner queryRunner = new QueryRunner(PropertiesUtils.getDataSource());
			String sql = "select student.e_id,s_i,e_name,e_starttime,e_stoptime,q_path,q_name,s_score,s_comment from student,exam where student.e_id=exam.e_id and student.s_i=" +s_i;
			Exam2 exam2 = queryRunner.query(sql,new BeanHandler<>(Exam2.class));
			return exam2;
		}
		

}




















