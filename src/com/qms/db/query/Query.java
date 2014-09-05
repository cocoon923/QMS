package com.qms.db.query;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;

import java.util.List;

/**
 * Created by chenmm on 9/1/2014.
 */
public class Query extends Model<Query> {

	public static final Query dao = new Query();

	public List findAll() {
		return this.find("select * from query_def");
	}

	public boolean delete(String queryId) {
		return this.deleteById(queryId);
	}

	public void add(String queryName, String querySQL) {
		Query query = new Query().set("QUERY_ID", "QUERY_SEQ.Nextval").set("QUERY_NAME", queryName).set("QUERY_SQL", querySQL).set("QUERY_VALID", 1);
		query.save();
	}

	public boolean validate(String querySQL) {
		try {
			Db.find(querySQL);
		} catch (Exception e) {
			return false;
		}
		return true;
	}

}
