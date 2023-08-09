package com.example.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import java.time.LocalTime;
import java.time.format.DateTimeFormatter;


import com.example.database.DBConnection;

public class RecordDAO {

	private static RecordDAO instance;
	
	private RecordDAO() {
		
	}

	public static RecordDAO getInstance() {
		if (instance == null)
			instance = new RecordDAO();
		return instance;
	}	
	//record 테이블의 레코드 개수
	public int getListCount(String items, String text) {
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;

	    int x = 0;

	    String sql;

	    if (items == null && text == null)
	        sql = "select count(*) from record";
	    else
	        sql = "SELECT count(*) FROM record where " + items + " like '%" + text + "%'";

	    try {
	        conn = DBConnection.getConnection();
	        pstmt = conn.prepareStatement(sql);

	        rs = pstmt.executeQuery();

	        if (rs.next())
	            x = rs.getInt(1);

	    } catch (Exception ex) {
	        System.out.println("getListCount() 에러: " + ex);
	    } finally {
	        try {
	            if (rs != null)
	                rs.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        try {
	            if (pstmt != null)
	                pstmt.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        try {
	            if (conn != null)
	                conn.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	    return x;
	}

	//record 테이블의 레코드 가져오기
	public ArrayList<RecordDTO> getRecordList(int page, int limit, String items, String text) {

	    int total_record = getListCount(items, text);
	    int start = (page - 1) * limit;
	    int index = start + 1;

	    String sql = null;

	    if (items == null && text == null)
	        sql = "select * from record ORDER BY num DESC";
	    else
	        sql = "SELECT * FROM record WHERE " + items + " like '%" + text + "%' ORDER BY num DESC ";

	    ArrayList<RecordDTO> list = new ArrayList<>();

	    try (Connection conn = DBConnection.getConnection();
		         PreparedStatement pstmt = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
		         ResultSet rs = pstmt.executeQuery()) {

		        while (rs.absolute(index)) {
	            RecordDTO record = new RecordDTO();
	            
	            record.setNum(rs.getInt("num"));
	            record.setId(rs.getString("id"));
	            record.setName(rs.getString("name"));
	            record.setCategory(rs.getString("category"));
	            String studyTimeStr = rs.getString("study_time");
	            LocalTime studyTime = LocalTime.parse(studyTimeStr, DateTimeFormatter.ofPattern("HH:mm"));
	            record.setStudy_time(studyTime);
	            record.setRegist_day(rs.getString("regist_day"));
	           
	            list.add(record);
	            if (index < (start + limit) && index <= total_record) {
	                index++;
	            } else {
	                break;
	            }
	        }
	    } catch (Exception ex) {
	        System.out.println("getBoardList() 에러 : " + ex);
	    }
	    return list;
	}

	//member 테이블에서 인증된 id의 사용자명 가져오기
	public String getLoginNameById(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;	

		String name=null;
		String sql = "select * from member where id = ? ";

		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) 
				name = rs.getString("name");	
			
			return name;
		} catch (Exception ex) {
			System.out.println("getBoardByNum() 에러 : " + ex);
		} finally {
			try {				
				if (rs != null) 
					rs.close();							
				if (pstmt != null) 
					pstmt.close();				
				if (conn != null) 
					conn.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}		
		}
		return null;
	}

	//record 테이블에 새로운 글 삽입히가
	public void insertRecord(RecordDTO record)  {
	    Connection conn = null;
	    PreparedStatement pstmt = null;

	    try {
	        conn = DBConnection.getConnection();

	        String sql = "INSERT INTO record VALUES (record_seq.nextval, ?, ?, ?, ?, ?)";

	        pstmt = conn.prepareStatement(sql);

	        int index = 1;
	        pstmt.setString(index++, record.getId());
	        pstmt.setString(index++, record.getName());
	        pstmt.setString(index++, record.getCategory());
	        String studyTime = record.getStudy_time().format(DateTimeFormatter.ofPattern("HH:mm"));
	        pstmt.setString(index++, studyTime);
	        pstmt.setString(index++, record.getRegist_day());
	       

	        pstmt.executeUpdate();
	        
	    } catch (Exception ex) {
	        System.out.println("insertRecord() 에러 : " + ex);
	    } finally {
	        try {
	            if (pstmt != null) {
	                pstmt.close();
	            }
	        } catch (Exception ex) {
	            throw new RuntimeException(ex.getMessage());
	        }
	        try {
	            if (conn != null) {
	                conn.close();
	            }
	        } catch (Exception ex) {
	            throw new RuntimeException(ex.getMessage());
	        }
	    }
	}
	//선택된 글 상세 내용 가져오기
	public RecordDTO getRecordByNum(int num, int page) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		RecordDTO record = null;

		String sql = "select * from record where num = ? ";

		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				record = new RecordDTO();
				record.setNum(rs.getInt("num"));
				record.setId(rs.getString("id"));
				record.setName(rs.getString("name"));
				record.setCategory(rs.getString("category"));
				String studyTimeStr = rs.getString("study_time");
	            LocalTime studyTime = LocalTime.parse(studyTimeStr, DateTimeFormatter.ofPattern("HH:mm"));
	            record.setStudy_time(studyTime);
				record.setRegist_day(rs.getString("regist_day"));		

			}
			
			conn.close();
			
		} catch (Exception ex) {
			System.out.println("getRecordByNum() 에러 : " + ex);
		} 
		return record;
	}
	//선택된 글 내용 수정하기
	public void updateRecord(RecordDTO record) {
	    Connection conn = null;
	    PreparedStatement pstmt = null;

	    try {
	        String sql = "UPDATE record SET name=?, category=?, study_time=? WHERE num=?";

	        conn = DBConnection.getConnection();
	        pstmt = conn.prepareStatement(sql);

	        pstmt.setString(1, record.getName());
	        pstmt.setString(2, record.getCategory());
	        LocalTime study_time = LocalTime.of(record.getStudy_time_hour(), record.getStudy_time_minute());
	        pstmt.setObject(3, study_time);
	        pstmt.setInt(4, record.getNum());

	        pstmt.executeUpdate();
	        
	    } catch (Exception ex) {
	        System.out.println("updateRecord() 에러 : " + ex);
	    } finally {
	        try {
	            if (pstmt != null)
	                pstmt.close();
	            if (conn != null)
	                conn.close();
	        } catch (SQLException ex) {
	            throw new RuntimeException(ex.getMessage());
	        }
	    }
	}

	//선택된 글 삭제하기
	public void deleteRecord(int num) {
		Connection conn = null;
		PreparedStatement pstmt = null;		

		String sql = "delete from record where num=?";	
		try {
		    conn = DBConnection.getConnection();
		    pstmt = conn.prepareStatement(sql);
		    pstmt.setInt(1, num);
		    pstmt.executeUpdate();
		    
		} catch (Exception ex) {
		    System.out.println("deleteRecord() 에러 : " + ex);
		} finally {
		    try {
		        if (pstmt != null) {
		            pstmt.close();
		        }
		    } catch (SQLException ex) {
		        ex.printStackTrace();
		    }
		    try {
		        if (conn != null) {
		            conn.close();
		        }
		    } catch (SQLException ex) {
		        ex.printStackTrace();
		    }
		}
	}
	
	//토탈 공부시간 조회하기
	public int getTotalStudyTimeForUser(String id) {
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	   
	    int total = 0;

	    try {
	        conn = DBConnection.getConnection();

	        String sql = "SELECT study_time FROM record WHERE id = ?";

	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, id);

	        rs = pstmt.executeQuery();

	        while (rs.next()) {
	            String studyTimeStr = rs.getString("study_time");
	            LocalTime studyTime = LocalTime.parse(studyTimeStr, DateTimeFormatter.ofPattern("HH:mm"));
	            total += studyTime.getHour() * 60 + studyTime.getMinute(); // 분 단위로 합산
	        }
	        
	    } catch (Exception ex) {
	        System.out.println("getTotalStudyTimeForUser() 에러 : " + ex);
	    } finally {
	        try {
	            if (rs != null) {
	                rs.close();
	            }
	            if (pstmt != null) {
	                pstmt.close();
	            }
	            if (conn != null) {
	                conn.close();
	            }
	        } catch (SQLException ex) {
	            System.out.println("getTotalStudyTimeForUser() 에러 : " + ex);
	        }
	    }
	    return total;
	}
}
