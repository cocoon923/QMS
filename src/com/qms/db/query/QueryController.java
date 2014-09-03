package com.qms.db.query;

import com.jfinal.core.Controller;

/**
 * Created by chenmm on 9/1/2014.
 */
public class QueryController extends Controller {

	public void index() {
		this.renderJson("data", Query.dao.findAll());
	}

}
