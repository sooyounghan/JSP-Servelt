package RentCar;

/*
 * 차량 예약에 대한 정보를 담을 Class
 */
public class CarView {
	private String name; // 차 이름
	private int price; // 대여 가격
	private String img; // 차 이미지
	private int car_num; // 차 수량
	private int duration_day; // 대여 기간
	private String reserve_day; // 대여일
	private int insurance; // 보험료
	private int use_wifi; // Wi-fi 이용
	private int navigation; // Navigation 이용
	private int baby_sheet; // BabySheet 이용
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public int getPrice() {
		return price;
	}
	
	public void setPrice(int price) {
		this.price = price;
	}
	
	public String getImg() {
		return img;
	}
	
	public void setImg(String img) {
		this.img = img;
	}
	
	public int getCar_num() {
		return car_num;
	}
	
	public void setCar_num(int car_num) {
		this.car_num = car_num;
	}
	
	public int getDuration_day() {
		return duration_day;
	}
	
	public void setDuration_day(int duration_day) {
		this.duration_day = duration_day;
	}
	
	public String getReserve_day() {
		return reserve_day;
	}
	
	public void setReserve_day(String reserve_day) {
		this.reserve_day = reserve_day;
	}
	
	public int getInsurance() {
		return insurance;
	}
	
	public void setInsurance(int insurance) {
		this.insurance = insurance;
	}
	
	public int getUse_wifi() {
		return use_wifi;
	}
	
	public void setUse_wifi(int use_wifi) {
		this.use_wifi = use_wifi;
	}
	
	public int getNavigation() {
		return navigation;
	}
	
	public void setNavigation(int navigation) {
		this.navigation = navigation;
	}
	
	public int getBaby_sheet() {
		return baby_sheet;
	}
	
	public void setBaby_sheet(int baby_sheet) {
		this.baby_sheet = baby_sheet;
	}
}
