package com.example.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.example.database.DBConnection;

public class BoardDAO {

	private static BoardDAO instance;
	
	private BoardDAO() {
		
	}

	public static BoardDAO getInstance() {
		if (instance == null)
			instance = new BoardDAO();
		return instance;
	}	
	//board 테이블의 레코드 개수
	public int getListCount(String items, String text) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int x = 0;

		String sql;
		
		if (items == null && text == null)
			sql = "select  count(*) from board";
		else
			sql = "SELECT   count(*) FROM board where " + items + " like '%" + text + "%'";
		
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
	//board 테이블의 레코드 가져오기
	public ArrayList<BoardDTO> getBoardList(int page, int limit, String items, String text) {
	    int total_record = getListCount(items, text);
	    int start = (page - 1) * limit;
	    int index = start + 1;

	    String sql = null;
	    if (items == null && text == null) {
	        sql = "SELECT * FROM board ORDER BY num DESC";
	    } else {
	        sql = "SELECT * FROM board WHERE " + items + " LIKE '%" + text + "%' ORDER BY num DESC";
	    }

	    ArrayList<BoardDTO> list = new ArrayList<>();

	    try (Connection conn = DBConnection.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
	         ResultSet rs = pstmt.executeQuery()) {

	        while (rs.absolute(index)) {
	            BoardDTO board = new BoardDTO();
	            board.setNum(rs.getInt("num"));
	            board.setId(rs.getString("id"));
	            board.setName(rs.getString("name"));
	            board.setCategory(rs.getString("category"));
	            board.setSubject(rs.getString("subject"));
	            board.setContent(rs.getString("content"));
	            board.setRegist_day(rs.getString("regist_day"));
	            board.setHit(rs.getInt("hit"));
	            list.add(board);

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

	//board 테이블에 새로운 글 삽입히가
	public void insertBoard(BoardDTO board)  {

		
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DBConnection.getConnection();		

			String sql = "insert into board values(num_seq.nextval, ?, ?, ?, ?, ?, ?, ?)";
		
			pstmt = conn.prepareStatement(sql);
			
			int index = 1;
			pstmt.setString(index++, board.getId());
			pstmt.setString(index++, board.getName());
			pstmt.setString(index++, board.getSubject());
			pstmt.setString(index++, board.getContent());
			pstmt.setString(index++, board.getRegist_day());
			pstmt.setInt(index++, board.getHit());
			pstmt.setString(index++, board.getCategory());

			pstmt.executeUpdate();
		} catch (Exception ex) {
			System.out.println("insertBoard() 에러 : " + ex);
		} finally {
			try {									
				if (pstmt != null) 
					pstmt.close();				
				if (conn != null) 
					conn.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}		
		}		
	} 
	//선택된 글의 조회수 증가하기
	public void updateHit(int num) {

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = DBConnection.getConnection();

			String sql = "select hit from board where num = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			int hit = 0;

			if (rs.next())
				hit = rs.getInt("hit") + 1;
		

			sql = "update board set hit=? where num=?";
			pstmt = conn.prepareStatement(sql);		
			pstmt.setInt(1, hit);
			pstmt.setInt(2, num);
			
			pstmt.executeUpdate();
			
			conn.close();
			
		} catch (Exception ex) {
			System.out.println("updateHit() 에러 : " + ex);
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
	}
	//선택된 글 상세 내용 가져오기
	public BoardDTO getBoardByNum(int num, int page) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		BoardDTO board = null;

		updateHit(num);
		String sql = "select * from board where num = ? ";

		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				board = new BoardDTO();
				board.setNum(rs.getInt("num"));
				board.setId(rs.getString("id"));
				board.setName(rs.getString("name"));
				board.setCategory(rs.getString("category"));
				board.setSubject(rs.getString("subject"));
				board.setContent(rs.getString("content"));
				board.setRegist_day(rs.getString("regist_day"));
				board.setHit(rs.getInt("hit"));
			}
			
			conn.close();
			
			return board;
			
			
			
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
	//선택된 글 내용 수정하기
	public void updateBoard(BoardDTO board) {

		Connection conn = null;
		PreparedStatement pstmt = null;
	
		try {
			String sql = "update board set name=?, category=?, subject=?, content=? where num=?";

			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, board.getName());
			pstmt.setString(2, board.getSubject());
			pstmt.setString(3, board.getCategory());
			pstmt.setString(4, board.getContent());
			pstmt.setInt(5, board.getNum());

			pstmt.executeUpdate();			

		} catch (Exception ex) {
		    System.out.println("updateBoard() 에러 : " + ex);
		} finally {
		    try {
		        if (pstmt != null) {
		            pstmt.close();
		        }
		    } catch (SQLException ex) {
		        System.out.println("PreparedStatement close() 에러 : " + ex);
		    }

		    try {
		        if (conn != null) {
		            conn.close();
		        }
		    } catch (SQLException ex) {
		        System.out.println("Connection close() 에러 : " + ex);
		    }
	} 
}		
	//선택된 글 삭제하기
	public void deleteBoard(int num) {
	    String sql = "delete from board where num=?";
	    
	    try (Connection conn = DBConnection.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {
	        
	        pstmt.setInt(1, num);
	        pstmt.executeUpdate();

	    } catch (Exception ex) {
	        System.out.println("deleteBoard() 에러 : " + ex);
	    }
	}
}
