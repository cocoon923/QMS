package com.qms.db.query;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;

import java.math.BigDecimal;
import java.util.List;

/**
 * Created by chenmm on 9/1/2014.
 */
public class Query extends Model<Query> {

	public static final Query dao = new Query();

	public List<Query> findAll() {
		return this.find("select * from query_def");
	}

	public boolean delete(String queryId) {
		return this.deleteById(queryId);
	}

	public void add(String queryName, String querySQL) {
		Query query = new Query().set("QUERY_ID", "QMS_SEQ.nextval").set("QUERY_NAME", queryName).set("QUERY_SQL", querySQL).set("QUERY_VALID", 1);
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

	public BigDecimal getQueryId() {
		return this.getBigDecimal("QUERY_ID");
	}

	public String getQueryName() {
		return this.getStr("QUERY_NAME");
	}

	public String getQuerySql() {
		return this.getStr("QUERY_SQL");
	}

	public int getQueryValid() {
		return this.getInt("QUERY_VALID");
	}

}
