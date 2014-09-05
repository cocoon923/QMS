package com.qms.db.query;

import com.alibaba.fastjson.JSONObject;
import com.jfinal.core.Controller;

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

	}

	public void validate() {
		String querySql = getPara("value");
		JSONObject result = new JSONObject();
		if (Query.dao.validate(querySql)) {
			result.put("value", querySql);
			result.put("valid", 1);
		} else {
			result.put("value", querySql);
			result.put("message", "查询SQL无效");
			result.put("valid", 0);
		}
		this.renderJson(result.toJSONString());
	}

}
