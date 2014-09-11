package com.qms.db.chart;

import com.alibaba.fastjson.JSONObject;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.qms.db.aliases.Aliases;
import com.qms.db.query.Query;

import java.util.List;

/**
 * Created by chenmm on 9/11/2014.
 */
public class ChartController extends Controller {

	public void test() {
		this.renderJson("data", Aliases.dao.getAliases(16));
	}

	public void tableData() {
		Query query = Query.dao.findById(getPara("QUERY_ID"));
		List<Record> records = Db.find(query.getStr("QUERY_SQL"));
		JSONObject data = new JSONObject();
		data.put("data", records);
		this.renderJson(data);
	}

}
