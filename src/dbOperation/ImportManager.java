package dbOperation;

import java.util.Vector;

public class ImportManager {

	/**
	 * 校验创建任务单限制 add by huyf
	 * 
	 * @return
	 */
	public boolean isAllowAddTaskInfo(String sDeveloper, String sDemandID) {
		if (sDeveloper == null) {
			sDeveloper = "";
		}
		if (sDemandID == null) {
			sDemandID = "";
		}
		String sql = "select a.TASK_ID as TASK_ID  from QMS.ASSIGNMENT a  where a.ACCEPTER_ID="
				+ sDeveloper + " and DEMAND_ID=" + sDemandID;
		Vector ver = new Vector();
		DBConnection lib = new DBConnection();
		ver = lib.selectVector(sql);
		if (ver.size() > 0)
			return false;
		else
			return true;
	}

}
