package com.qms.db.aliases;

import com.jfinal.plugin.activerecord.Model;

import java.math.BigDecimal;
import java.util.List;

/**
 * Created by chenmm on 9/11/2014.
 */
public class Aliases extends Model<Aliases> {

	public static final Aliases dao = new Aliases();

	public List<Aliases> getAliases(BigDecimal queryId) {
		return this.find("select * from ALIASES where QUERY_ID = ? order by ALIASES_SEQ asc", queryId);
	}

	public BigDecimal getAliasesId(){
		return this.getBigDecimal("ALIASES_ID");
	}

	public int getAliasesSeq(){
		return this.getInt("ALIASES_SEQ");
	}

	public String getAliasesName(){
		return this.getStr("ALIASES_NAME");
	}

	public String getAliasesCol(){
		return this.getStr("ALIASES_COL");
	}

}
