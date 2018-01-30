package com.viafirma.examples.util;


public class BenchMarkTimeUtils {

	public static long startDate;
	public static long endDate;
	
	
	public static long getBenchMarkSeconds() {
		System.out.println(startDate);
		System.out.println(endDate);
		return (endDate-startDate)/1000;
	}
	
}
