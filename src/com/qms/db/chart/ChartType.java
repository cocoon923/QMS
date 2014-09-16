package com.qms.db.chart;

/**
 * Created by chenmm on 9/11/2014.
 */
public enum ChartType {

	TABLE(0), PIE(1);

	private int value;

	private ChartType(int value) {
		this.value = value;
	}

	public int value() {
		return this.value;
	}

	public static ChartType type(int value) {
		switch (value) {
			case 0:
				return TABLE;
			case 1:
				return PIE;
		}
		return null;
	}

}
