package com.example.controller;

import java.io.IOException;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.example.model.RecordDAO;
import com.example.model.RecordDTO;

public class RecordController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static final int LISTCOUNT = 5; 

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String RequestURI = request.getRequestURI();
		String contextPath = request.getContextPath();
		String command = RequestURI.substring(contextPath.length());
		
		response.setContentType("text/html; charset=utf-8");
		request.setCharacterEncoding("utf-8");
	
		if (command.equals("/RecordGridAction.to")) {//홈에서 게시판 목록 가져오기
			requestRecordList(request);
			RequestDispatcher rd = request.getRequestDispatcher("./record/grid.jsp");
			rd.forward(request, response);
		} 
		else if (command.equals("/RecordWriteForm.to")) { // 글 등록 페이지 출력하기
				requestLoginName(request);
				RequestDispatcher rd = request.getRequestDispatcher("./record/writeForm.jsp");
				rd.forward(request, response);				
		} else if (command.equals("/RecordWriteAction.to")) {// 새로운 글 등록하기
				requestRecordWrite(request);
				RequestDispatcher rd = request.getRequestDispatcher("/RecordGridAction.to");
				rd.forward(request, response);						
		} else if (command.equals("/RecordViewAction.to")) {//선택된 글 상세 페이지 가져오기
				requestRecordView(request);
				RequestDispatcher rd = request.getRequestDispatcher("/RecordView.to");
				rd.forward(request, response);						
		} else if (command.equals("/RecordView.to")) { //글 상세 페이지 출력하기
				RequestDispatcher rd = request.getRequestDispatcher("./record/view.jsp");
				rd.forward(request, response);	
		}		
		 else if (command.equals("/RecordUpdateAction.to")) { //선택된 글의 조회수 증가하기
			    requestRecordUpdate(request);
		    	RequestDispatcher rd = request.getRequestDispatcher("/RecordGridAction.to");
			    rd.forward(request, response);
		} else if (command.equals("/RecordDeleteAction.to")) { //선택된 글 삭제하기
				requestRecordDelete(request);
				RequestDispatcher rd = request.getRequestDispatcher("/RecordGridAction.to");
				rd.forward(request, response);				
		}
		 else if (command.equals("/TotalRecord.to")) { //총 공부시간
			 	requestTotalStudyTime(request);
				RequestDispatcher rd = request.getRequestDispatcher("./record/total.jsp");
				rd.forward(request, response);				
		} 
	}
	//등록된 글 목록 가져오기	
	public void requestRecordList(HttpServletRequest request){
			
		RecordDAO dao = RecordDAO.getInstance();
		List<RecordDTO> recordlist = new ArrayList<RecordDTO>();
		
	  	int pageNum=1;
		int limit=LISTCOUNT;
		
		if(request.getParameter("pageNum")!=null)
			pageNum=Integer.parseInt(request.getParameter("pageNum"));
				
		String items = request.getParameter("items");
		String text = request.getParameter("text");
		
		int total_record=dao.getListCount(items, text);
		recordlist = dao.getRecordList(pageNum,limit, items, text); 
		
		int total_page;
		
		if (total_record % limit == 0){     
	     	total_page =total_record/limit;
	     	Math.floor(total_page);  
		}
		else{
		   total_page =total_record/limit;
		   Math.floor(total_page); 
		   total_page =  total_page + 1; 
		}		
   
   		request.setAttribute("pageNum", pageNum);		  
   		request.setAttribute("total_page", total_page);   
		request.setAttribute("total_record",total_record); 
		request.setAttribute("recordlist", recordlist);								
	}
	
	//인증된 사용자명 가져오기
	public void requestLoginName(HttpServletRequest request){
					
		String id = request.getParameter("id");
		
		RecordDAO  dao = RecordDAO.getInstance();
		
		String name = dao.getLoginNameById(id);		
		
		request.setAttribute("name", name);									
	}
	
	// 새로운 글 등록하기
	public void requestRecordWrite(HttpServletRequest request) {
		
	    RecordDAO dao = RecordDAO.getInstance();       
	    RecordDTO record = new RecordDTO();
	    
	    record.setId(request.getParameter("id"));
	    record.setName(request.getParameter("name"));
	    record.setCategory(request.getParameter("category"));
	    LocalTime studyTime = LocalTime.parse(request.getParameter("study_time_hour") + ":" + request.getParameter("study_time_minute"), DateTimeFormatter.ofPattern("HH:mm"));
	    record.setStudy_time(studyTime);
	               
	    System.out.println(request.getParameter("name"));
	    System.out.println(request.getParameter("category"));
	    System.out.println(studyTime);
	            
	    java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy/MM/dd");
	    String regist_day = formatter.format(new java.util.Date()); 
	    record.setRegist_day(regist_day);    
	                
	    dao.insertRecord(record);                               
	}

	
	//선택된 글 상세 페이지 가져오기
	public void requestRecordView(HttpServletRequest request){
					
		RecordDAO dao = RecordDAO.getInstance();
		int num = Integer.parseInt(request.getParameter("num"));
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));	
		RecordDTO record = dao.getRecordByNum(num, pageNum);		
		request.setAttribute("num", num);		 
   		request.setAttribute("page", pageNum); 
   		request.setAttribute("record", record); 
	}

	//선택된 글 내용 수정하기
	public void requestRecordUpdate(HttpServletRequest request) {
	    int num = Integer.parseInt(request.getParameter("num"));
	    int pageNum = Integer.parseInt(request.getParameter("pageNum"));	
	    
	    RecordDAO dao = RecordDAO.getInstance();		
	    RecordDTO record = new RecordDTO();		
	    
	    record.setNum(num);
	    record.setId(request.getParameter("id"));
	    record.setName(request.getParameter("name"));
	    record.setCategory(request.getParameter("category"));
	    LocalTime studyTime = LocalTime.parse(request.getParameter("study_time_hour") + ":" + request.getParameter("study_time_minute"), DateTimeFormatter.ofPattern("HH:mm"));
	    record.setStudy_time(studyTime);
	    java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy/MM/dd");
	    String regist_day = formatter.format(new java.util.Date()); 
	    
	    record.setRegist_day(regist_day);	
	    dao.updateRecord(record);								
	}

	//선택된 글 삭제하기
	public void requestRecordDelete(HttpServletRequest request){
					
		int num = Integer.parseInt(request.getParameter("num"));
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));	
		
		RecordDAO dao = RecordDAO.getInstance();
		dao.deleteRecord(num);							
	}
	
	// 해당 사용자의 id로 총 공부시간 가져오기 
	public void requestTotalStudyTime(HttpServletRequest request) {
	    RecordDAO dao = RecordDAO.getInstance();
	    RecordDTO record = new RecordDTO();
	    
	    int totalStudyTime = dao.getTotalStudyTime();
	   
	    record.setId(request.getParameter("id"));

	    request.setAttribute("total_study_time", totalStudyTime);
	    request.setAttribute("record", record); 
	   
	}

}
