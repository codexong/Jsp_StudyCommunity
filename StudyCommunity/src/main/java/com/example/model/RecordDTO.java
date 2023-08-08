package com.example.model;

import java.time.LocalTime;

public class RecordDTO {
	
	private int num;
	private String id;
	private String name;
	private String category;
	private LocalTime study_time;
	private String regist_day;
	
	public RecordDTO(){
		super();
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getRegist_day() {
		return regist_day;
	}

	public void setRegist_day(String regist_day) {
		this.regist_day = regist_day;
	}
	
	public LocalTime getStudy_time() {
		return study_time;
	}

	public int getStudy_time_hour() {
	    return this.study_time.getHour();
	}

	public int getStudy_time_minute() {
	    return this.study_time.getMinute();
	}
	
	public void setStudy_time(LocalTime study_time) {
	    this.study_time = study_time;
	}

	public void setStudy_time_hour(int hour) {
	    if (this.study_time == null) {
	        this.study_time = LocalTime.of(hour, 0);
	    } else {
	        this.study_time = this.study_time.withHour(hour);
	    }
	}

	public void setStudy_time_minute(int minute) {
	    if (this.study_time == null) {
	        this.study_time = LocalTime.of(0, minute);
	    } else {
	        this.study_time = this.study_time.withMinute(minute);
	    }
	}
}	
