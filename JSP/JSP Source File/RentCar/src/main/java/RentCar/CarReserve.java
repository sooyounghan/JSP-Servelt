package RentCar;


/*
 * 차량에 대한 예약 정보 클래스
 */
public class CarReserve {
	private int reserve_no; // 예약번호
	private int no; // 차 식별자
	private String id; // 예약 회원 ID
	private int car_num; // 차 수량
	private int duration_day; // 대여 기간
	private String reserve_day; // 대여일
	private int insurance; // 보험료
	private int use_wifi; // Wi-fi 이용
	private int navigation; // Navigation 이용
	private int baby_sheet; // BabySheet 이용
	
	public int getReserve_no() {
		return reserve_no;
	}

	public void setReserve_no(int reserve_no) {
		this.reserve_no = reserve_no;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	
	public int getNo() {
		return no;
	}
	
	public void setNo(int no) {
		this.no = no;
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