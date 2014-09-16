package com.qms.db.query;

import com.alibaba.fastjson.JSONObject;
import com.jfinal.core.Controller;
import com.qms.db.aliases.Aliases;
import com.qms.db.chart.Chart;

import java.math.BigDecimal;
import java.util.List;

/**
 * Created by chenmm on 9/1/2014.
 */
public class QueryController extends Controller {

	public void index() {
		this.renderJson("data", Query.dao.findAll());
	}

	public void delete() {
		boolean result = Query.dao.delete(getPara());
		this.renderJson(result);
	}

	public void add() {
		boolean success = false;
		try {
			String queryName = getPara("QUERY_NAME");
			String querySql = getPara("QUERY_SQL");
			Query.dao.add(queryName, querySql);
			success = true;
		} finally {
			this.renderJson(success);
		}
	}

	public void validate() {
		String querySql = getPara("value");
		JSONObject result = new JSONObject();
		try {
			if (Query.dao.validate(querySql)) {
				result.put("value", querySql);
				result.put("valid", 1);
			} else {
				result.put("value", querySql);
				result.put("message", "查询SQL无效");
				result.put("valid", 0);
			}
		} catch (Exception e) {
			result.put("value", querySql);
			result.put("message", "查询SQL无效");
			result.put("valid", 0);
		} finally {
			this.renderJson(result.toJSONString());
		}
	}

	public void detail() {
		BigDecimal queryId = new BigDecimal(getPara("QUERY_ID"));
		this.setAttr("queryId", queryId);
		this.setAttr("charts", Chart.dao.findByQueryId(queryId));
		List<Aliases> aliases = Aliases.dao.getAliases(queryId);
		if (aliases != null && aliases.size() > 0) {
			this.setAttr("aliases", aliases);
		}

		this.render("Query.Detail.html");
	}

}
