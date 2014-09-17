package com.qms.db.chart;

import com.jfinal.plugin.activerecord.Model;

import java.math.BigDecimal;
import java.util.List;

/**
 * Created by chenmm on 9/16/2014.
 */
public class ChartCfg extends Model<ChartCfg> {

	public static final String PIE_CFG = "PIE_CFG";
	public static final String BAR_CFG = "BAR_CFG";

	public static final ChartCfg dao = new ChartCfg();

	public List<ChartCfg> getChartCfg(String cfgKey) {
		return this.find("select * from chart_cfg where cfg_key = ?", cfgKey);
	}

	public BigDecimal getCfgId() {
		return this.getBigDecimal("CFG_ID");
	}

	public String getCfgName() {
		return this.getStr("CFG_NAME");
	}

	public String getCfgKey() {
		return this.getStr("CFG_KEY");
	}

	public String getCfgValue() {
		return this.getStr("CFG_VALUE");
	}

}
