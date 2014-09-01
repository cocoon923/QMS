package com.qms.db.query;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;

import java.util.List;

/**
 * Created by chenmm on 9/1/2014.
 */
public class Query extends Model<Query> {

	public static final Query dao = new Query();

	public List findAll() {
		 return this.find("select * from query_def");
	}

}
