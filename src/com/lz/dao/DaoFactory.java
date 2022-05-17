package com.lz.dao;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

public class DaoFactory {

	//类似工厂模式+单例模式 返回各个使用实例对象
	private static DaoFactory factory = new DaoFactory();
	private Map<String, Object> map = new ConcurrentHashMap<>();
	private DaoFactory(){
		
	}
	public static DaoFactory getInstance() {
		return factory;
	}
	//返回老师及其操作的对象
	public TeacherDao getTeacherDao() {   
		TeacherDao dao = (TeacherDao) map.get("TeacherDao");
		if(dao != null) {
			return dao;
		}else {
			dao = new TeacherDao();
			map.put("TeacherDao",dao);
		}
		return dao;
	}
	//返回学生及其操作对象
	public StudentDao getStudentDao() {
		StudentDao dao = (StudentDao) map.get("StudentDao");
		if(dao != null) {
			return dao;
		}else {
			dao = new StudentDao();
			map.put("StudentDao",dao);
		}
		return dao;
	}
	//返回有关考试操作的对象
	public ExamDao getExamDao() {
		ExamDao dao = (ExamDao) map.get("ExamDao");
		if(dao != null) {
			return dao;
		}else {
			dao = new ExamDao();
			map.put("ExamDao",dao);
		}
		return dao;
	}
	//返回有关分数操作的对象
	public ScoreDao getScoreDao() {
		ScoreDao dao = (ScoreDao) map.get("ScoreDao");
		if(dao != null) {
			return dao;
		}else {
			dao = new ScoreDao();
			map.put("ScoreDao",dao);
		}
		return dao;
	}
	//返回有关文件操作的对象
	public FileDao getFileDao() {
		FileDao dao = (FileDao) map.get("FileDao");
		if(dao != null) {
			return dao;
		}else {
			dao = new FileDao();
			map.put("FileDao",dao);
		}
		return dao;
	}
	//返回有关消息操作的对象
	public NoticeDao getNoticeDao() {
		NoticeDao dao = (NoticeDao) map.get("NoticeDao");
		if(dao != null) {
			return dao;
		}else {
			dao = new NoticeDao();
			map.put("NoticeDao",dao);
		}
		return dao;
	}

	//返回有关全局变量的对象
	public GlobalDao getGlobalDao() {
		GlobalDao dao = (GlobalDao) map.get("GlobalDao");
		if(dao != null) {
			return dao;
		}else {
			dao = new GlobalDao();
			map.put("GlobalDao",dao);
		}
		return dao;
	}
	//测试用例
	public static void main(String[] args) {
		System.out.println(DaoFactory.getInstance().getExamDao());
		System.out.println(DaoFactory.getInstance().getExamDao());
	}
	
}
