package com.qms.db.chart;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.qms.db.aliases.Aliases;
import com.qms.db.query.Query;

import java.util.Iterator;
import java.util.List;

/**
 * Created by chenmm on 9/11/2014.
 */
public class ChartController extends Controller {

	public void tableData() {
		Query query = Query.dao.findById(getPara("QUERY_ID"));
		List<Record> records = Db.find(query.getQuerySql());
		JSONObject data = new JSONObject();
		data.put("data", records);
		this.renderJson(data);
	}

	public void pieData() {
		Query query = Query.dao.findById(getPara("QUERY_ID"));
		List<Record> records = Db.find(query.getQuerySql());
		JSONObject pieCfg = JSON.parseObject(ChartCfg.dao.getChartCfg(ChartCfg.PIE_CFG).get(0).getCfgValue());

		JSONArray returnData = new JSONArray();

		for (Chart chart : Chart.dao.findByQueryIdChartType(query.getQueryId(), ChartType.PIE)) {
			JSONObject queryOption = JSON.parseObject(chart.getChartOption());

			JSONObject title = new JSONObject();
			title.put("text", query.getQueryName());
			pieCfg.put("title", title);

			JSONArray series = new JSONArray();
			JSONObject series0 = new JSONObject();
			series0.put("type", "pie");
			series0.put("name", queryOption.getString("seriesname"));

			String nameCol = queryOption.getString("namecol");
			String yCol = queryOption.getString("ycol");
			JSONArray data = new JSONArray();
			for (Record record : records) {
				JSONObject item = new JSONObject();
				item.put("name", record.get(nameCol));
				item.put("y", record.get(yCol));
				data.add(item);
			}
			series0.put("data", data);
			series.add(series0);
			pieCfg.put("series", series);

			returnData.add(pieCfg);
		}

		this.renderJson("records", returnData);
	}

	public void barData() {
		Query query = Query.dao.findById(getPara("QUERY_ID"));
		List<Record> records = Db.find(query.getQuerySql());
		JSONObject barCfg = JSON.parseObject(ChartCfg.dao.getChartCfg(ChartCfg.BAR_CFG).get(0).getCfgValue());

		JSONArray returnData = new JSONArray();

		for (Chart chart : Chart.dao.findByQueryIdChartType(query.getQueryId(), ChartType.BAR)) {
			JSONObject queryOption = JSON.parseObject(chart.getChartOption());

			JSONObject title = new JSONObject();
			title.put("text", query.getQueryName());
			barCfg.put("title", title);

			JSONArray categories = new JSONArray();
			JSONObject xAxis = new JSONObject();

			JSONArray series = new JSONArray();
			String nameCol = queryOption.getString("namecol");
			JSONArray dataCols = JSON.parseArray(queryOption.getString("dataCol"));
			for (Record record : records) {
				JSONObject seriesItem = new JSONObject();
				seriesItem.put("name", record.get(nameCol));

				JSONArray dataArray = new JSONArray();
				for (Iterator it = dataCols.iterator(); it.hasNext(); ) {
					String dataCol = (String) it.next();
					dataArray.add(record.get(dataCol));
				}
				seriesItem.put("data", dataArray);
				series.add(seriesItem);
			}
			for (Iterator it = dataCols.iterator(); it.hasNext(); ) {
				String dataCol = (String) it.next();
				categories.add(Aliases.dao.getAliasesByCol(query.getQueryId(), dataCol).getAliasesName());
			}
			xAxis.put("categories", categories);
			barCfg.put("xAxis", xAxis);
			barCfg.put("series", series);

			returnData.add(barCfg);
		}

		this.renderJson("records", returnData);
	}

}
