package com.qms.db;

import com.jfinal.config.*;
import com.jfinal.plugin.activerecord.ActiveRecordPlugin;
import com.jfinal.plugin.activerecord.dialect.OracleDialect;
import com.jfinal.plugin.c3p0.C3p0Plugin;
import com.qms.db.query.Query;
import com.qms.db.query.QueryController;

/**
 * API引导式配置
 */
public class DBConfig extends JFinalConfig {

	/**
	 * 配置常量
	 */
	public void configConstant(Constants me) {
		// 加载少量必要配置，随后可用getProperty(...)获取值
		loadPropertyFile("config.properties");
		me.setDevMode(getPropertyToBoolean("devMode", false));
	}

	/**
	 * 配置路由
	 */
	public void configRoute(Routes me) {
		me.add("/query", QueryController.class);
	}

	/**
	 * 配置插件
	 */
	public void configPlugin(Plugins me) {
		// 配置C3p0数据库连接池插件
		C3p0Plugin dsOracle = new C3p0Plugin(getProperty("db.url"), getProperty("db.username"), getProperty("db.password").trim(), getProperty("db.driverclasss"));
		me.add(dsOracle);
		ActiveRecordPlugin arOracle = new ActiveRecordPlugin(dsOracle);
		me.add(arOracle);
		arOracle.setDialect(new OracleDialect());
		arOracle.addMapping("query", Query.class);
	}

	/**
	 * 配置全局拦截器
	 */
	public void configInterceptor(Interceptors me) {

	}

	/**
	 * 配置处理器
	 */
	public void configHandler(Handlers me) {

	}

}
