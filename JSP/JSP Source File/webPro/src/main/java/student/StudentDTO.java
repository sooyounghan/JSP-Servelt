package student;

import java.util.*;

/*
 * 1. DAO(Date Access Object)  
 *   - DB에 접근하기 위한 객체 (**)
 *   - 직접 DB에 접근하여 Data를 삽입, 삭제, 조회 등 조작할 수 있는 기능(즉, Query를 수행)을 수행하는 클래스
 *   
 * 2. DTO(Data Transfer Object) - Class의 Field
 *   - 계층 간(Controller, View, Business Layer)[쉽게 생각하면, DB-DB 내 데이터 이동] 데이터 교환을 위한 클래스 (**)
 *   - DTO는 로직을 가지지 않는 데이터 객체
 *   - getter, setter[두 메서드는 값을 얻거나 설정] 메소드만 가진 클래스를 의미
 *   - VO와는 다르게 가변의 성격을 가지며, 데이터 전송을 위해 존재 (Instance 개념) (**)
 *   
 * 3. VO (Value Object)
 *   - Read-Only 속성을 가진 값 Object (**)
 *   - 단순히 값 타입을 표현하기 위하여 불변 클래스(Read-Only)를 만들어 사용
 *   - getter 기능만 사용
 *   - 리터럴(Literal) 개념4
 *   - 필요에 따라 Object 클래스의 hashCode(), equals()를 오버라이딩
 */

public class StudentDTO {
	// Field : [Access Modifier][Modifier] DataType Field_Name[=Initial value];
	private String sno; // 학번
	private String sname; // 학생 이름
	private Date enrollmentDate; // 입학일
 	
	// Constructor : [Access Modifier] Class_name(argument_list) { }
	public StudentDTO() {
		this(null, null, null);
	}
	
	public StudentDTO(String sno, String sname, Date enrollmentDate) {
		this.sno = sno;
		this.sname = sname;
		this.enrollmentDate = enrollmentDate;
	}
	
	// Method : [Access Modifier][Modifier] ReturnType Method_name(argument_list) { }
	public String getSname() { // getter만 가지고 있으면 VO
		return this.sname;
	}
	
	public String getSno() { // getter만 가지고 있으면 VO
		return this.sno;
	}
	
	public Date getEnrollmentDate() { // getter만 가지고 있으면 VO
		return this.enrollmentDate;
	}
	
	public void setSname(String sname) { // getter와 setter를 가지고 있으면 DTO
		this.sname = sname;
	}
	
	public void setSno(String sno) { // getter와 setter를 가지고 있으면 DTO
		this.sno = sno;
	}
	
	public void setEnrollmentDate(Date enrollmentDate) { // getter와 setter를 가지고 있으면 DTO
		this.enrollmentDate = enrollmentDate;
	}
	
	@Override
	public String toString() {
		return "[" + this.sno + ", " + this.sname + ", " + this.enrollmentDate + "]";
	}
}
