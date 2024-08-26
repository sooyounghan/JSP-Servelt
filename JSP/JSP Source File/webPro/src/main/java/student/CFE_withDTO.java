package student;

import java.util.*;

/*
 * StudnetDTO를 List, Set, Map에 넣고 출력
 */
public class CFE_withDTO {
	public static void main(String[] args) {
		System.out.println("====List에 StudentDTO 객체 추가====");
		
		List<StudentDTO> list_dto = new ArrayList<StudentDTO>(); // 객체 StudentDTO를 담는 ArrayList
		
		list_dto.add(new StudentDTO("123456", "ABC", new Date())); // 객체 생성과 동시에 ArrayList에 삽입
		list_dto.add(new StudentDTO("345678", "BCD", new Date()));
		list_dto.add(new StudentDTO("900554", "CDF", new Date()));

		for(int i = 0; i < list_dto.size(); i++) {
			System.out.println(list_dto.get(i).toString()); // toString() Override을 통해 ArrayList 요소 출력
		}
		
		System.out.println("====Set에 StudentDTO 객체 추가====");
		
		Set<StudentDTO> set_dto = new HashSet<StudentDTO>();
		
		StudentDTO student1 = new StudentDTO(); // 기본 생성자를 통한 StudentDTO 객체 생성
		student1.setSno("123456");
		student1.setSname("ABC");
		student1.setEnrollmentDate(new Date()); // Setter를 통한 초기화
		
		StudentDTO student2 = new StudentDTO(); // 기본 생성자를 통한 StudentDTO 객체 생성
		student2.setSno("345678");
		student2.setSname("BCD");
		student2.setEnrollmentDate(new Date()); // Setter를 통한 초기화
		
		StudentDTO student3 = new StudentDTO(); // 기본 생성자를 통한 StudentDTO 객체 생성
		student3.setSno("900554");
		student3.setSname("CDF");
		student3.setEnrollmentDate(new Date()); // Setter를 통한 초기화
		
		set_dto.add(student1); // student1 객체 삽입
		set_dto.add(student2);
		set_dto.add(student3);

		for(StudentDTO student : set_dto) { // 향상된 for문을 통한 set 요소 추출
			System.out.println(student.toString());
		}
		System.out.println();
		
		Iterator<StudentDTO> iterator = set_dto.iterator();
		while(iterator.hasNext()) {
			System.out.println(iterator.next().toString());		
		}

		System.out.println("====Map에 StudentDTO 객체 추가====");
		
		Map<String, StudentDTO> map_dto = new HashMap<String, StudentDTO>(); // Key는 학생의 학번
		
		map_dto.put(student1.getSno(), student1);
		map_dto.put(student2.getSno(), student2);
		map_dto.put(student3.getSno(), student3);
		
		Set<Map.Entry<String, StudentDTO>> entrySet = map_dto.entrySet();
		Iterator<Map.Entry<String, StudentDTO>> iter = entrySet.iterator();
		
		while(iter.hasNext()) {
			Map.Entry<String, StudentDTO> entry = iter.next();
			System.out.println(entry.getValue().toString());
		}
	}
}
