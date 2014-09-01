package common;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map.Entry;
import java.util.Vector;

import dbOperation.DBConnection;

/**
 * add by huyf
 * 
 * @author huyf
 * 
 */
public class DataImport {

	public String importData(InputStream in, String importType, String openID)
			throws Exception {
		String errorMsg = null;
		List errorList = new ArrayList();
		try {
			ExcelByPOI excle = new ExcelByPOI(in);
			List excleRecordList = excle.excelToMapList(0);
			String orginSQL = (String) queryCfgImport(importType).get(
					"IMPROT_SQL");
			Vector ver = queryCfgImportMapping(importType);
			HashMap dbMap = new HashMap();
			if (ver.size() > 0) {
				for (int i = 0; i < ver.size(); i++) {
					HashMap map = (HashMap) ver.get(i);
					String excleColNo = (String) map.get("EXCLE_COL_NO");
					String dbColName = (String) map.get("DB_COL_NAME");
					dbMap.put(excleColNo, dbColName);
				}
			}
			if (excleRecordList.size() > 0) {
				for (int i = 0; i < excleRecordList.size(); i++) {
					HashMap excleMap = (HashMap) excleRecordList.get(i);
					transfer(ver, excleMap);
					HashMap map = generateData(excleMap, dbMap);
					String runableSql = geanerateSQL(orginSQL, map);
					if (runableSql.indexOf("{OPEN_ID}") > 0) {
						runableSql = runableSql.replace("{OPEN_ID}", openID);
					}
					if (runableSql.indexOf("{PROJECT_CODE}") > 0) {
						runableSql = runableSql.replace("{PROJECT_CODE}", "1");
					}
					DBConnection lib = new DBConnection();
					boolean isImported = lib.executeUpdate(runableSql);
					if (!isImported) {
						errorList.add(i + 1);
					}
				}
			}
		} catch (Exception e) {
			errorMsg = "import data failed";
		}
		System.out.print("導入完畢");
		if (errorList.size() > 0) {
			errorMsg ="The"+errorList.toString() + "row data import failed,please check data!";
		}
		return errorMsg;
	}

	public void upLoadFile(InputStream in, File f) throws Exception {
		FileOutputStream o = new FileOutputStream(f);
		byte b[] = new byte[1024];
		int n;
		while ((n = in.read(b)) != -1) {
			o.write(b, 0, n);
		}
		o.close();
		in.close();
		System.out.print("File upload success!");
	}

	/**
	 * 生成sql
	 * 
	 * @param originSQL
	 * @param replaceData
	 * @return
	 */
	public String geanerateSQL(String originSQL, HashMap replaceData) {
		String sql = originSQL;
		Iterator it = replaceData.entrySet().iterator();
		while (it.hasNext()) {
			Entry entry = (Entry) it.next();
			String dbColName = (String) entry.getKey();
			String dbColValue = (String) entry.getValue();
			if (dbColName == null) {
				dbColName = "";
			}
			if (dbColValue == null) {
				dbColValue = "";
			}
			String key = "{" + dbColName + "}";
			String value = "'" + dbColValue + "'";
			if (sql.indexOf(key) > 0) {
				String replaced = sql.replaceAll(key, value);
				sql = replaced;
			}
		}
		return sql;
	}

	/**
	 * 生成DB_COL_NAME---EXCLE_COL_VALUE映射
	 * 
	 * @param excleMap
	 * @param dbMap
	 * @return
	 */
	public HashMap generateData(HashMap excleMap, HashMap dbMap) {
		HashMap map = new HashMap();
		for (int i = 1; i <= excleMap.size(); i++) {
			for (int j = 1; j <= dbMap.size(); j++) {
				if (i == j) {
					String index = String.valueOf(i);
					String key = (String) dbMap.get(index);
					String value = (String) excleMap.get(index);
					map.put(key, value);
					continue;
				}
			}
		}
		return map;
	}

	/**
	 * 查询CFG_IMPORT获取配置信息
	 * 
	 * @param importName
	 * @return
	 */
	public HashMap queryCfgImport(String importName) {
		HashMap dataMap = new HashMap();
		Vector ver = queryCfgImportList(importName);
		if (ver.size() > 0) {
			dataMap = (HashMap) ver.get(0);
		}
		return dataMap;
	}

	public Vector queryCfgImportList(String importType) {
		String sql = "select a.IMPORT_ID as IMPORT_ID,a.IMPORT_NAME as IMPORT_NAME,a.IMPORT_TYPE as IMPORT_TYPE,a.IMPROT_SQL as IMPROT_SQL from QMS.CFG_IMPORT a ";
		if (importType != null) {
			sql = sql + " WHERE IMPORT_TYPE='" + importType + "'";
		}
		DBConnection lib = new DBConnection();
		Vector ver = lib.selectVector(sql);
		return ver;
	}

	/**
	 * 生成Excle_COL_NO---DB_COL_NAME映射关系
	 * 
	 * @param importType
	 * @return
	 */
	public Vector queryCfgImportMapping(String importType) {
		String sql = "select a.IMPORT_TYPE as IMPORT_TYPE, a.DB_COL_NAME as DB_COL_NAME,a.EXCLE_COL_NAME as EXCLE_COL_NAME,a.EXCLE_COL_NO as EXCLE_COL_NO,a.SRC_TABLE_COL as SRC_TABLE_COL,a.PARAM_COL as PARAM_COL  from QMS.CFG_IMPORT_MAPPING a";
		if (importType != null) {
			sql = sql + " WHERE IMPORT_TYPE='" + importType + "'";
		}
		System.out.println(sql);
		DBConnection lib = new DBConnection();
		Vector ver = lib.selectVector(sql);

		return ver;
	}

	/**
	 * 转换映射配置
	 * 
	 * @param ver
	 * @param excleMap
	 */
	public void transfer(Vector ver, HashMap excleMap) {
		for (int j = 0; j < ver.size(); j++) {
			HashMap dataMap = (HashMap) ver.get(j);
			String src_table_col = (String) dataMap.get("SRC_TABLE_COL");
			if (src_table_col != null) {
				String transferValue = null;
				String src_table = "";
				String table_col = "";
				if (src_table_col.indexOf(".") > 0) {
					src_table = src_table_col.split("\\.")[0];
					table_col = src_table_col.split("\\.")[1];
				}
				String param_name = (String) dataMap.get("PARAM_COL");
				String index = (String) dataMap.get("EXCLE_COL_NO");
				String Param_value = (String) excleMap.get(index);
				// String valueCol = (String) dataMap.get("DB_COL_NAME");
				DBConnection lib = new DBConnection();
				if (param_name != null && table_col != null
						&& src_table_col != null) {
					String sql = "select " + table_col + " from " + src_table
							+ " where " + param_name + "='" + Param_value + "'";
					System.out.println("转换映射配置sql: " + sql);
					Vector ve = lib.selectVector(sql);
					if (ve.size() > 0) {
						HashMap mapping = (HashMap) ve.get(0);
						transferValue = (String) mapping.get(table_col);
					}
				}
				excleMap.put(index, transferValue);
			}
		}
	}
}