package com.qms.db.chart;

import com.jfinal.plugin.activerecord.Model;

import java.util.List;

/**
 * Created by chenmm on 9/11/2014.
 */
public class Chart extends Model<Chart> {

	public static final Chart dao = new Chart();

	public List<Chart> findByQueryId(int queryId) {
		return this.find("select * from chart where query_id = ?", queryId);
	}
}
