package com.qms.db;

import com.jfinal.core.Controller;

/**
 * Created by chenmm on 9/2/2014.
 */
public class CommonController extends Controller {

	public void index() {
		this.renderJsp("login.jsp");
	}

}
