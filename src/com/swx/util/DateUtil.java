package com.swx.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;

public class DateUtil {
	
	public static String dateTime2String(Date date){
		return new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(date);
	}
	
	public static String date2String(Date date){
		return new SimpleDateFormat("yyyy-MM-dd").format(date);
	}

	public static String computeDate(String days){
		int cycle = Integer.parseInt(days);
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(new Date());
		calendar.add(calendar.DAY_OF_MONTH,-cycle);
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		return df.format(calendar.getTime());
	}

	public static String computeAfterDate(String days){
		int cycle = Integer.parseInt(days);
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(new Date());
		calendar.add(calendar.DAY_OF_MONTH,cycle);
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		return df.format(calendar.getTime());
	}

}
