package com.swx.util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtil {
	
	public static String dateTime2String(Date date){
		return new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(date);
	}
	
	public static String date2String(Date date){
		return new SimpleDateFormat("yyyy-MM-dd").format(date);
	}
	
	public static void main(String[] args) {
		System.out.println(System.nanoTime());
	}
	
}
