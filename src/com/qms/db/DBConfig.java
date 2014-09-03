package com.qms.db;

import com.alibaba.druid.util.JdbcConstants;
import com.alibaba.druid.wall.WallFilter;
import com.jfinal.config.*;
import com.jfinal.plugin.activerecord.ActiveRecordPlugin;
import com.jfinal.plugin.activerecord.CaseInsensitiveContainerFactory;
import com.jfinal.plugin.activerecord.dialect.OracleDialect;
import com.jfinal.plugin.druid.DruidPlugin;
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
		me.add("/", CommonController.class);
		me.add("/query", QueryController.class);
	}

	/**
	 * 配置插件
	 */
	public void configPlugin(Plugins me) {
		DruidPlugin dp = new DruidPlugin(getProperty("db.url"), getProperty("db.username"), getProperty("db.password"));
		dp.setDriverClass(getProperty("db.driver.class"));
		dp.setValidationQuery("SELECT 1 FROM DUAL");
		WallFilter wall = new WallFilter();
		wall.setDbType(JdbcConstants.ORACLE);
		dp.addFilter(wall);
		me.add(dp);

		ActiveRecordPlugin arp = new ActiveRecordPlugin(dp);
		me.add(arp);
		arp.setDialect(new OracleDialect());
		arp.setContainerFactory(new CaseInsensitiveContainerFactory());
		arp.addMapping("query_def", "QUERY_ID", Query.class);
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
