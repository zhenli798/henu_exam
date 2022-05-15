package com.lz.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.MapListHandler;

import com.lz.utils.PropertiesUtils;
public class ScoreDao {

	public List<Map<String, Object>> query_range() throws SQLException {
		QueryRunner queryRunner = new QueryRunner(PropertiesUtils.getDataSource());
		String sql = "select exam.e_id, exam.e_name,ifnull(bad,0)bad,ifnull(common,0)common,ifnull(good,0)good,ifnull(best,0)best from exam "
				+ "left join( "
				+ "	select e_id,count(*) bad from student where s_score<60 group by e_id "
				+ ") A on exam.e_id = A.e_id "
				+ "left join( "
				+ "	select e_id,count(*)common from student where s_score>=60 and s_score<=70 group by e_id "
				+ ") B on exam.e_id = B.e_id "
				+ "left join( "
				+ "	select e_id,count(*)good from student where s_score>70 and s_score<=85 group by e_id "
				+ ") C on exam.e_id = C.e_id "
				+ "left join( "
				+ "	select e_id,count(*)best from student where s_score>85  group by e_id "
				+ ") D on exam.e_id = D.e_id ";
		
		List<Map<String, Object>> list = queryRunner.query(sql, new MapListHandler());
		return list;
	}
	
	
	public List<Map<String, Object>> query_jgl() throws SQLException {
		QueryRunner queryRunner = new QueryRunner(PropertiesUtils.getDataSource());
		String sql = "select A.e_id,( select e_name from exam where A.e_id=exam.e_id)e_name,jgnum,allnum,round(jgnum/allnum,2)*100 jgl from( "
				+ "select e_id,count(*)jgnum from student where s_score>60 group by e_id "
				+ ")a,( "
				+ "select e_id,count(*)allnum from student group by e_id) "
				+ "b where a.e_id = b.e_id";
		List<Map<String, Object>> list = queryRunner.query(sql, new MapListHandler());
		return list;
	}
	
	public List<Map<String, Object>> query_rangeByTid(String t_id) throws SQLException {
		QueryRunner queryRunner = new QueryRunner(PropertiesUtils.getDataSource());
		String sql = "select exam.e_id, exam.e_name,ifnull(bad,0)bad,ifnull(common,0)common,ifnull(good,0)good,ifnull(best,0)best from exam "
				+ "left join( "
				+ "	select e_id,count(*) bad from student where s_score<60 group by e_id "
				+ ") A on exam.e_id = A.e_id "
				+ "left join( "
				+ "	select e_id,count(*)common from student where s_score>=60 and s_score<=70 group by e_id "
				+ ") B on exam.e_id = B.e_id "
				+ "left join( "
				+ "	select e_id,count(*)good from student where s_score>70 and s_score<=85 group by e_id "
				+ ") C on exam.e_id = C.e_id "
				+ "left join( "
				+ "	select e_id,count(*)best from student where s_score>85  group by e_id "
				+ ") D on exam.e_id = D.e_id where t_id=?";
		
		List<Map<String, Object>> list = queryRunner.query(sql, new MapListHandler(),t_id);
		return list;
	}
	
	public List<Map<String, Object>> query_jglByTid(String t_id) throws SQLException {
		QueryRunner queryRunner = new QueryRunner(PropertiesUtils.getDataSource());
		String sql = "select * from exam,(\r\n"
				+ "select A.e_id,jgnum,allnum,round(jgnum/allnum,2)*100 jgl from(\r\n"
				+ "select e_id,count(*)jgnum from student where s_score>=60 group by e_id\r\n"
				+ ")a,(\r\n"
				+ "select e_id,count(*)allnum from student group by e_id\r\n"
				+ ")b where a.e_id = b.e_id\r\n"
				+ ")c where exam.e_id = C.e_id\r\n"
				+ "and t_id=?";
		List<Map<String, Object>> list = queryRunner.query(sql, new MapListHandler(),t_id);
		return list;
	}
	public List<Map<String, Object>> top5() throws SQLException {
		QueryRunner queryRunner = new QueryRunner(PropertiesUtils.getDataSource());
		String sql = "select s_id,s_name,sum(s_score) sumx from student group by e_id order by sumx desc limit 0,5";
		List<Map<String, Object>> list = queryRunner.query(sql, new MapListHandler());
		return list;
	}



	public List<Map<String, Object>> query_rangeByS_ID(String s_id)  throws SQLException {
		QueryRunner queryRunner = new QueryRunner(PropertiesUtils.getDataSource());
		String sql = "select e_name,s_name,s_score from student,exam where student.e_id=exam.e_id and s_id=?";
		List<Map<String, Object>> list = queryRunner.query(sql, new MapListHandler(),s_id);
		return list;
	}
	
}
