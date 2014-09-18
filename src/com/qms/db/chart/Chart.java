package com.qms.db.chart;

import com.jfinal.plugin.activerecord.Model;

import java.math.BigDecimal;
import java.util.List;

/**
 * Created by chenmm on 9/11/2014.
 */
public class Chart extends Model<Chart> {

	public static final Chart dao = new Chart();

	public List<Chart> findByQueryId(BigDecimal queryId) {
		return this.find("select * from chart where query_id = ? order by chart_type", queryId);
	}

	public List<Chart> findByQueryIdChartType(BigDecimal queryId, ChartType chartType) {
		return this.find("select * from chart where query_id = ? and chart_type = ?", new Object[]{queryId, chartType.value()});
	}

	public BigDecimal getChartId() {
		return this.getBigDecimal("CHART_ID");
	}

	public ChartType getChartType() {
		return ChartType.type(this.getInt("CHART_TYPE"));
	}

	public String getChartOption() {
		return this.getStr("CHART_OPTION");
	}
}
