package RentCar;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class RentCarDAO {
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	public void getConnection() {
		try {
			Context initcnx = new InitialContext();
			Context envcnx = (Context)initcnx.lookup("java:comp/env");
			DataSource ds = (DataSource)envcnx.lookup("jdbc/pool");
			
			conn = ds.getConnection();
		} catch(NamingException e) {
			e.printStackTrace();
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	/*
	 * 상위 3개의 Car List 추출
	 */
	public List<CarList> getSelectCar() {
		List<CarList> carList = new ArrayList<CarList>();
		
		try {
			getConnection();
			
			String sql = "SELECT * FROM RENTCAR ORDER BY NO DESC";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();

			int count = 0; // 상위 3개 상품 출력을 위해 설정
			while(rs.next()) {	
				CarList car = new CarList();
				
				car.setNo(rs.getInt(1));
				car.setName(rs.getString(2));
				car.setCategory(rs.getInt(3));
				car.setPrice(rs.getInt(4));
				car.setUsepeople(rs.getInt(5));
				car.setCompany(rs.getString(6));
				car.setImg(rs.getString(7));
				car.setInfo(rs.getString(8));
				
				carList.add(car);
				
				count++;
				if(count >= 3) break;
			}
			
			conn.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return carList;
	}
	
	/*
	 * Category별 CarList 추출
	 */
	public List<CarList> getCategoryCar(int category) {
		List<CarList> carList = new ArrayList<CarList>();
		
			try {
				getConnection();
				
				String sql = "SELECT * FROM RENTCAR WHERE CATEGORY = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, category);
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					CarList car = new CarList();
					
					car.setNo(rs.getInt(1));
					car.setName(rs.getString(2));
					car.setCategory(rs.getInt(3));
					car.setPrice(rs.getInt(4));
					car.setUsepeople(rs.getInt(5));
					car.setCompany(rs.getString(6));
					car.setImg(rs.getString(7));
					car.setInfo(rs.getString(8));
					
					carList.add(car);
				}
				
				conn.close();
			} catch(SQLException e) {
				e.printStackTrace();
			}
		return carList;
	}
	
	/*
	 * 모든 CarList 추출
	 */
	public List<CarList> getAllListCar() {
		List<CarList> carList = new ArrayList<CarList>();
		
			try {
				getConnection();
				
				String sql = "SELECT * FROM RENTCAR";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					CarList car = new CarList();
					
					car.setNo(rs.getInt(1));
					car.setName(rs.getString(2));
					car.setCategory(rs.getInt(3));
					car.setPrice(rs.getInt(4));
					car.setUsepeople(rs.getInt(5));
					car.setCompany(rs.getString(6));
					car.setImg(rs.getString(7));
					car.setInfo(rs.getString(8));
					
					carList.add(car);
				}
				
				conn.close();
			} catch(SQLException e) {
				e.printStackTrace();
			}
		return carList;
	}
	
	/*
	 * 하나의 Car 정보 추출
	 */
	public CarList getOneCarList(int no) {
		CarList car = new CarList();
		
		try {
			getConnection();
			
			String sql = "SELECT * FROM RENTCAR WHERE NO = ?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, no);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				car.setNo(rs.getInt(1));
				car.setName(rs.getString(2));
				car.setCategory(rs.getInt(3));
				car.setPrice(rs.getInt(4));
				car.setUsepeople(rs.getInt(5));
				car.setCompany(rs.getString(6));
				car.setImg(rs.getString(7));
				car.setInfo(rs.getString(8));
			}
			
			conn.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return car;
	}
	
	/*
	 * 로그인 처리를 위한 회원 ID와 PassWord를 추출
	 */
	public int getMember(String id, String password) {
		int result = 0;
		
		try {
			getConnection();
			
			// 일치하면 1, 불일치하면 0 
			String sql = "SELECT COUNT(*) FROM MEMBER WHERE ID = ? AND PASS1 = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, password);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt(1);
			}
			
			conn.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	/*
	 * 예약 정보를 삽입
	 */
	public void setReserveCar(CarReserve car_reserve) {
		try {
			getConnection();
			
			String sql = "INSERT INTO CAR_RESERVE VALUES(RESERVE_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, car_reserve.getNo());
			pstmt.setString(2, car_reserve.getId());
			pstmt.setInt(3, car_reserve.getCar_num());
			pstmt.setInt(4, car_reserve.getDuration_day());
			pstmt.setString(5, car_reserve.getReserve_day());
			pstmt.setInt(6, car_reserve.getInsurance());
			pstmt.setInt(7, car_reserve.getUse_wifi());
			pstmt.setInt(8, car_reserve.getNavigation());
			pstmt.setInt(9, car_reserve.getBaby_sheet());
			
			pstmt.executeUpdate();
			
			conn.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	/*
	 * 예약 정보를 모든 추출
	 */
	public List<CarView> getAllReserve(String id) {
		List<CarView> reserveList = new ArrayList<CarView>();
		
		try {
			getConnection();
			
			String sql = "SELECT * FROM RENTCAR R INNER JOIN CAR_RESERVE C ON (R.NO = C.NO)"
						 + "WHERE C.ID = ? AND SYSDATE < TO_DATE(C.RESERVE_DAY, 'YYYY-MM-DD')";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				CarView reserve_car = new CarView();
				
				reserve_car.setName(rs.getString(2));
				reserve_car.setPrice(rs.getInt(4));
				reserve_car.setImg(rs.getString(7));
				reserve_car.setCar_num(rs.getInt(12));
				reserve_car.setDuration_day(rs.getInt(13));
				reserve_car.setReserve_day(rs.getString(14));
				reserve_car.setInsurance(rs.getInt(15));
				reserve_car.setUse_wifi(rs.getInt(16));
				reserve_car.setNavigation(rs.getInt(17));
				reserve_car.setBaby_sheet(rs.getInt(18));
				
				reserveList.add(reserve_car);
			}
			
			conn.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		
		return reserveList;
	}
	
	/*
	 * id와 reserve_day에 대해 해당 예약 정보 제거
	 */
	public void reserveCarRemove(String id, String reserve_day) {
		try {
			getConnection();
			
			String sql = "DELETE FROM CAR_RESERVE WHERE ID = ? AND RESERVE_DAY = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, reserve_day);
			
			pstmt.executeQuery();
			
			conn.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
}
