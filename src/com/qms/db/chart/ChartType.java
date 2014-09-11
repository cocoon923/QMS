package com.qms.db.chart;

/**
 * Created by chenmm on 9/11/2014.
 */
public enum ChartType {

	TABLE(0);

	private int value;

	private ChartType(int value) {
		this.value = value;
	}

	public int getValue() {
		return this.value;
	}
}
