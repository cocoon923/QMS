package com.qms.db.aliases;

import com.jfinal.plugin.activerecord.Model;

import java.util.List;

/**
 * Created by chenmm on 9/11/2014.
 */
public class Aliases extends Model<Aliases> {

	public static final Aliases dao = new Aliases();

	public List<Aliases> getAliases(int queryId) {
		return this.find("select * from ALIASES where QUERY_ID = ? order by ALIASES_SEQ asc", queryId);
	}

}
