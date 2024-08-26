package RentCar;

/*
 * RentCar에 대한 데이터에 대한 클래스
 */
public class CarList {
	private int no; // 자동차 식별자 
	private String name; // 자동차 이름
	private int category; // 자동차 분류
	private int price; // 렌터카 가격
	private int usepeople; // 차량 탑승 가능 인원
	private String company; // 자동차 회사
	private String img; // 렌터카 이미지
	private String info; // 렌터카 정보
	
	public int getNo() {
		return no;
	}
	
	public void setNo(int no) {
		this.no = no;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public int getCategory() {
		return category;
	}
	
	public void setCategory(int category) {
		this.category = category;
	}
	
	public int getPrice() {
		return price;
	}
	
	public void setPrice(int price) {
		this.price = price;
	}
	
	public int getUsepeople() {
		return usepeople;
	}
	
	public void setUsepeople(int usepeople) {
		this.usepeople = usepeople;
	}
	
	public String getCompany() {
		return company;
	}
	
	public void setCompany(String company) {
		this.company = company;
	}
	
	public String getImg() {
		return img;
	}
	
	public void setImg(String img) {
		this.img = img;
	}
	
	public String getInfo() {
		return info;
	}
	
	public void setInfo(String info) {
		this.info = info;
	}
}
