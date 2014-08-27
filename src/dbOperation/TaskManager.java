package dbOperation;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

public class TaskManager {
	/**
	 * modify by huyf 根据QMS.task_seq返回可用计划序号
	 */
	public String getNewTaskSeq() {

		String ssql = "select QMS.task_seq.nextval as TASK_SEQ from dual";
		// System.out.print("\n" + "	" + ssql + "	" + "\n");
		DBConnection lib = new DBConnection();
		ResultSet rs = lib.executeQuery(ssql);
		String staskseq = "";
		try {
			rs.next();
			staskseq = rs.getString("TASK_SEQ");
			rs.close();
		} catch (SQLException ex) {
			System.err.println("aq.executeQuery:" + ex.getMessage());
		}
		return staskseq;
	}

	/**
	 * 根据任务任务序号，返回任务相关信息
	 */
	public Vector querytaskinfo(String staskid) {
		String ssql = "";
		ssql = " select  a.TASK_ID as TASK_ID,a.TASK_DESC as TASK_DESC,a.CLOSER_ID as CLOSER_ID,a.ACCEPTER_ID as ACCEPTER_ID,a.DEV_TIME as DEV_TIME,a.TEST_TIME AS TEST_TIME from ASSIGNMENT a";
		if (!staskid.equals("")) {
			ssql += " where  a.task_id=" + staskid;
		}
		ssql += " order by a.task_id";
		// System.out.print("\n" + "	" + ssql + "	" + "\n");
		Vector ver = new Vector();
		DBConnection lib = new DBConnection();
		ver = lib.selectVector(ssql);
		return ver;
	}

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

	/**
	 * modify by huyf
	 * 增加任务表，同时需要增加任务流程数据（insert表：task_def,task_process）
	 */
	public void addTaskInfo(String sTaskId, String sDemandTitle, String sopId,
			String sDeveloper, String sStatusId, String sDemandID,
			String sTaskDesc, String sDevFinishTime, String sTestFinishTime,String sTester) {
		if (!sTaskDesc.equals("")) {
			sTaskDesc = sTaskDesc.replaceAll("'", "''");
		}
		if (sDevFinishTime==null ){

			sDevFinishTime = "";
		}
		if (sTestFinishTime==null) {

			sTestFinishTime = "";
		}
		String ssql = "";
		ssql = "INSERT INTO QMS.ASSIGNMENT(TASK_ID,TITLE,OPENER_ID,CLOSER_ID,ACCEPTER_ID,OPENTIME,CLOSETIME,STATUS_ID,PRIORITY,TYPE_ID,DEMAND_ID,TASK_DESC,FINISH_TIME,WORKTIME_QA ,WORKTIME_DEV,DEV_TIME,QA_TIME,TEST_TIME,QA_ASSIGN_TIME,QA_MAGR ,UTIL_TEST,NG_STATUS,OLD_TASK_ID)"
				+ "VALUES ("
				+ sTaskId
				+ ",'"
				+ sDemandTitle
				+ "','"
				+ sopId
				+ "','"
				+ sTester
				+ "','"
				+ sDeveloper
				+ "', sysdate ,NULL,"
				+ sStatusId
				+ ", NULL, NULL,"
				+ sDemandID
				+ ",'"
				+ sTaskDesc
				+ "', NULL,NULL,NULL,TO_DATE('"
				+ sDevFinishTime
				+ "', 'yyyy-mm-dd hh24:mi:ss'), NULL, TO_DATE('"
				+ sTestFinishTime
				+ "','yyyy-mm-dd hh24:mi:ss'), NULL, NULL, NULL, NULL, NULL)";
		//System.out.print("创建任务单SQL:" + ssql);
		DBConnection lib = new DBConnection();
		lib.executeUpdate(ssql);
	}

	/**
	 * 根据入参查询满足条件的需求编号及相关属性
	 * 
	 * @param stype
	 *            标识查询需求或故障，1：查需求；2：查故障
	 */
	public Vector querydemandinfo(String stype, String srepstarttime,
			String srependtime, String sdevstarttime, String sdevendtime,
			String sproductid, String sdemandstauts, String sgroupid,
			String sopid, String sdemandid, String sdefproductid,
			String defstatus, String splanid) {
		String ssql = "";
		if (stype.equals("1")) {
			ssql = "select distinct a.demand_id as DEMAND_ID, c.proj_name as PROJ_NAME,a.demand_title as DEMAND_TITLE,d.product_name as PRODUCT_NAME,"
					+ "a.status as STATUS,nvl(to_char(a.rep_time, 'yyyy-mm-dd'), '-') as REP_TIME,nvl(to_char(a.dev_time, 'yyyy-mm-dd'), '-') as DEV_TIME,"
					+ "b.sta_name as STA_NAME"
					+ " from DEMAND_REQUEST a, DEMAND_STATUS b, PROJECT c,product d,assignment e "
					+ " where a.status = b.sta_id and a.project_code = c.proj_code and a.product_id = d.product_id and a.demand_id=e.dependid"
					+ " and a.product_id in ("
					+ sdefproductid
					+ ") and a.status in (" + defstatus + ")";
			if (!srepstarttime.equals("") && !srepstarttime.equals(null)) {
				ssql += " and to_char(a.rep_time,'YYYYMMDDhh24miss')>='"
						+ srepstarttime + "'";
			}
			if (!srependtime.equals("") && !srependtime.equals(null)) {
				ssql += " and to_char(a.rep_time,'YYYYMMDDhh24miss')<='"
						+ srependtime + "'";
			}
			if (!sdevstarttime.equals("") && !sdevstarttime.equals(null)) {
				ssql += " and to_char(a.dev_time,'YYYYMMDDhh24miss')>='"
						+ sdevstarttime + "'";
			}
			if (!sdevendtime.equals("") && !sdevendtime.equals(null)) {
				ssql += " and to_char(a.dev_time,'YYYYMMDDhh24miss')<='"
						+ sdevendtime + "'";
			}
			if (!sproductid.equals("") && !sproductid.equals(null)) {
				ssql += " and a.product_id in (" + sproductid + ")";
			}
			if (!sdemandstauts.equals("") && !sdemandstauts.equals(null)) {
				ssql += " and a.status in (" + sdemandstauts + ")";
			}
			if (!sgroupid.equals("") && !sgroupid.equals(null)) {
				ssql += " and e.closer_id in (select op_id from group_op_info where group_id in ("
						+ sgroupid + "))";
			}
			if (!sopid.equals("") && !sopid.equals(null)) {
				ssql += " and e.closer_id in (" + sopid + ")";
			}
			if (!sdemandid.equals("") && !sdemandid.equals(null)) {
				ssql += " and a.demand_id in (" + sdemandid + ")";
			}
			if (splanid != null && !splanid.equals("")) {
				ssql += "and a.demand_id not in (select task_value from plan_task where plan_id="
						+ splanid + " and task_type=" + stype + ")";
			}
		} else if (stype.equals("2")) {
			ssql = "select distinct a.request_id as DEMAND_ID,b.proj_name as PROJ_NAME,a.rep_title as DEMAND_TITLE,"
					+ "d.product_name as PRODUCT_NAME,a.rep_status as STATUS,nvl(to_char(a.rep_time, 'yyyy-mm-dd'), '-') as REP_TIME,"
					+ "nvl(to_char(a.dev_one_time, 'yyyy-mm-dd'), '-') as DEV_TIME,c.name as STA_NAME,a.rep_dev as DEV_ID,"
					+ "a.rep_qa as TESTER_ID "
					+ " from project_request a,project b,proj_status c,product d  "
					+ " where a.proj_code = b.proj_code and a.rep_status = c.id and a.product_id = d.product_id"
					+ " and a.product_id in ("
					+ sdefproductid
					+ ") and a.rep_status in (" + defstatus + ")";
			if (!srepstarttime.equals("") && !srepstarttime.equals(null)) {
				ssql += " and to_char(a.rep_time,'YYYYMMDDhh24miss')>='"
						+ srepstarttime + "'";
			}
			if (!srependtime.equals("") && !srependtime.equals(null)) {
				ssql += " and to_char(a.rep_time,'YYYYMMDDhh24miss')<='"
						+ srependtime + "'";
			}
			if (!sdevstarttime.equals("") && !sdevstarttime.equals(null)) {
				ssql += " and to_char(a.dev_one_time,'YYYYMMDDhh24miss')>='"
						+ sdevstarttime + "'";
			}
			if (!sdevendtime.equals("") && !sdevendtime.equals(null)) {
				ssql += " and to_char(a.dev_one_time,'YYYYMMDDhh24miss')<='"
						+ sdevendtime + "'";
			}
			if (!sproductid.equals("") && !sproductid.equals(null)) {
				ssql += " and a.product_id in (" + sproductid + ")";
			}
			if (!sdemandstauts.equals("") && !sdemandstauts.equals(null)) {
				ssql += " and a.rep_status in (" + sdemandstauts + ")";
			}
			if (!sgroupid.equals("") && !sgroupid.equals(null)) {
				ssql += " and a.rep_qa in (select op_id from group_op_info where group_id in ("
						+ sgroupid + "))";
			}
			if (!sopid.equals("") && !sopid.equals(null)) {
				ssql += " and a.rep_qa in (" + sopid + ")";
			}
			if (!sdemandid.equals("") && !sdemandid.equals(null)) {
				ssql += " and a.request_id in (" + sdemandid + ")";
			}
			if (splanid != null && !splanid.equals("")) {
				ssql += "and a.request_id not in (select task_value from plan_task where plan_id="
						+ splanid + " and task_type=" + stype + ")";
			}
		}

		else {
			System.out.print("输入类型未知，请检查！");
		}
		ssql += " order by demand_id asc";
		// System.out.print("\n 查询需求、故障信息sql为：" +ssql + "\n");
		Vector ver = new Vector();
		DBConnection lib = new DBConnection();
		ver = lib.selectVector(ssql);
		return ver;
	}

	/**
	 * 根据计划实时查询qcs中状态
	 * 
	 * @param splanid
	 *            计划编号
	 */
	public Vector trackdemandinfo(String splanid) {
		String ssql = "";
		// select后选出测试人员名称、提交测试时间/QA_leader分配时间
		// ssql="select distinct 'R'||a.demand_id as DEMAND_ID, c.proj_name as PROJ_NAME,a.demand_title as DEMAND_TITLE,"
		// +"d.product_name as PRODUCT_NAME,a.status as STATUS,nvl(to_char(a.rep_time, 'yyyy-mm-dd'), '-') as REP_TIME,"
		// +"nvl(to_char(a.dev_time, 'yyyy-mm-dd'), '-') as DEV_TIME,b.sta_name as STA_NAME,g.group_name as GROUP_NAME "
		// +"from DEMAND_REQUEST a,DEMAND_STATUS b, PROJECT c,product d,assignment e,group_op_info f,group_def g "
		// +"where a.status = b.sta_id and a.project_code = c.proj_code and a.product_id = d.product_id and a.demand_id=e.dependid and e.closer_id=f.op_id(+) and f.group_id=g.group_id(+)"
		// +" and a.demand_id in (select task_value from plan_task where plan_id="+splanid+" and task_type=1)"
		// +" union all "
		// +"select distinct 'F'||a.request_id as DEMAND_ID,b.proj_name as PROJ_NAME,a.rep_title as DEMAND_TITLE,"
		// +"d.product_name as PRODUCT_NAME,a.rep_status as STATUS,nvl(to_char(a.rep_time, 'yyyy-mm-dd'), '-') as REP_TIME,"
		// +"nvl(to_char(a.dev_one_time, 'yyyy-mm-dd'), '-') as DEV_TIME,c.name as STA_NAME,g.group_name as GROUP_NAME   "
		// +"from project_request a,project b,proj_status c,product d ,group_op_info f,group_def g  "
		// +" where a.proj_code = b.proj_code and a.rep_status = c.id and a.product_id = d.product_id and a.rep_qa=f.op_id(+) and f.group_id=g.group_id(+) "
		// +"and a.request_id in (select task_value from plan_task where plan_id="+splanid+" and task_type=2)";

		ssql = "select distinct 'R'||a.demand_id as DEMAND_ID, c.proj_name as PROJ_NAME,a.demand_title as DEMAND_TITLE,"
				+ "d.product_name as PRODUCT_NAME,a.status as STATUS,nvl(to_char(a.rep_time, 'yyyy-mm-dd'), '-') as REP_TIME,"
				+ "nvl(to_char(a.dev_time, 'yyyy-mm-dd'), '-') as DEV_TIME,b.sta_name as STA_NAME,g.group_name as GROUP_NAME, "
				+ "h.op_name as TESTER_NAME,(select nvl(to_char(max(dev_time), 'yyyy-mm-dd'), '-') from assignment where dependid=a.demand_id) as COMMIT_TIME "
				+ " from DEMAND_REQUEST a,DEMAND_STATUS b, PROJECT c,product d,assignment e,group_op_info f,group_def g,op_login h "
				+ " where a.status = b.sta_id and a.project_code = c.proj_code and a.product_id = d.product_id and a.demand_id=e.dependid and e.closer_id=h.op_id and h.op_id = f.op_id(+) and f.group_id=g.group_id(+)"
				+ " and a.demand_id in (select task_value from plan_task where plan_id="
				+ splanid
				+ " and task_type=1)"
				+ " union all "
				+ "select distinct 'F'||a.request_id as DEMAND_ID,b.proj_name as PROJ_NAME,a.rep_title as DEMAND_TITLE,"
				+ "d.product_name as PRODUCT_NAME,a.rep_status as STATUS,nvl(to_char(a.rep_time, 'yyyy-mm-dd'), '-') as REP_TIME,"
				+ "nvl(to_char(a.dev_one_time, 'yyyy-mm-dd'), '-') as DEV_TIME,c.name as STA_NAME,g.group_name as GROUP_NAME,   "
				+ " h.op_name as TESTER_NAME,nvl(to_char(a.QA_CONFIRMTIME, 'yyyy-mm-dd'), '-')  as COMMIT_TIME "
				+ " from project_request a,project b,proj_status c,product d ,group_op_info f,group_def g,op_login h  "
				+ " where a.proj_code = b.proj_code and a.rep_status = c.id and a.product_id = d.product_id and a.rep_qa=h.op_id and h.op_id = f.op_id(+) and f.group_id=g.group_id(+) "
				+ "and a.request_id in (select task_value from plan_task where plan_id="
				+ splanid + " and task_type=2)";

		ssql += " order by group_name,tester_name,product_name,demand_id";
		// System.out.print("\n 跟踪需求、故障信息sql为：" +ssql + "\n");
		Vector ver = new Vector();
		DBConnection lib = new DBConnection();
		ver = lib.selectVector(ssql);
		return ver;
	}

	/**
	 * 根据需求、故障id，查询出对应的qa的id、名称、归属组；dev的id、名称
	 * 
	 * @param stype
	 *            标识查询需求或故障，1：需求；2：故障
	 * @param svalue
	 *            需求、故障id。不能为空
	 */
	public Vector querydemandopinfo(String stype, String svalue) {
		String ssql = "";
		if (stype.equals("1")) {
			ssql = "select f.op_name as DEV_NAME,"
					+ "b.accepter_id as DEV_ID,g.op_name as TESTER_NAME, "
					+ "b.closer_id as TESTER_ID,c.group_name as NAME,c.group_id as ID,"
					+ "'['||c.group_id||'] '||c.group_name as GROUP_NAME "
					+ " from demand_request a,assignment b,group_def c,group_op_info d,op_login f,op_login g"
					+ " where a.demand_id="
					+ svalue
					+ " and a.demand_id=b.dependid and b.closer_id=d.op_id "
					+ " and c.group_id=d.group_id and f.op_id=b.accepter_id and g.op_id=b.closer_id";
		} else if (stype.equals("2")) {
			ssql = "select f.op_name as DEV_NAME ,"
					+ "a.rep_dev as DEV_ID,g.op_name as TESTER_NAME,"
					+ "a.rep_qa as TESTER_ID, c.group_name as NAME,c.group_id as ID, "
					+ "'['||c.group_id||'] '||c.group_name as GROUP_NAME "
					+ " from project_request a,project b,group_def c,group_op_info d ,op_login f,op_login g"
					+ " where a.request_id="
					+ svalue
					+ "　and a.proj_code=b.proj_code and a.rep_qa=d.op_id "
					+ "and c.group_id=d.group_id and f.op_id=a.rep_dev and g.op_id=a.rep_qa";
		} else {
			System.out.print("未知查询类型，请检查！");
		}

		// System.out.print("\n 查询需求、故障测试人员为：" +ssql + "\n");
		Vector ver = new Vector();
		DBConnection lib = new DBConnection();
		ver = lib.selectVector(ssql);
		return ver;

	}

	/**
	 * 新增计划任务明细信息（insert plan_task表）
	 * 
	 * @param splanid
	 *            计划编号，不能为空
	 * @param stasktype
	 *            计划任务类型，1：需求；2：故障，不能为空
	 * @param staskvalue
	 *            计划任务类型id值。根据stasktype确定，staskvalue=1,此处填需求编号；staskvalue=2，
	 *            此处填故障编号
	 */
	public boolean PrcaddPlanTaskInfo(String type, String demandid,
			String planid, String planstarttime, String planendtime,
			String tasktype, String sislog, String sModifyOp, String sRemark) {
		if (sRemark != null) {
			sRemark = sRemark.replaceAll("'", "''");
		}
		DBConnection lib = new DBConnection();

		lib.executeProcess("{call OPERTASKINFO('" + type + "','"
				+ demandid + "','" + planid + "','" + planstarttime + "','"
				+ planendtime + "','" + tasktype + "','" + sislog + "','"
				+ sModifyOp + "','" + sRemark + "') }");
		return true;
	}

	/**
	 * 查询计划任务信息
	 */
	public Vector queryplantaskinfo(String splanid, String stasktype,
			String staskvalue, String splanstarttime, String splanendtime,
			String srealstarttime, String srealendtime, String staskexecutor,
			String sexecutorgroup, String sstatus, String stype, String staskdev) {
		String ssql = "select PLAN_ID, TASK_TYPE, TASK_VALUE, "
				+ " decode(task_type,1,'R'||task_value,2,'F'||task_value,task_value) as ID,TASK_NAME,"
				+ " nvl(to_char(PLAN_START_TIME, 'YYYY-MM-DD'),'-') as PLAN_START_TIME,"
				+ " nvl(to_char(PLAN_END_TIME, 'YYYY-MM-DD'),'-') as PLAN_END_TIME,"
				+ " nvl(to_char(REAL_START_TIME, 'YYYY-MM-DD'),'-') as REAL_START_TIME, "
				+ " nvl(to_char(REAL_END_TIME, 'YYYY-MM-DD'),'-') as REAL_END_TIME, TASK_EXECUTOR,EXECUTOR_GROUP,"
				+ " STATUS,decode(status,0,'未结束',1,'按时完成',2,'延期完成','未定义状态') as STATUS_NAME,"
				+ " TYPE,decode(type,0,'计划内','1','计划外','未定义类型') as TYPE_NAME,TASK_DEV  "
				+ " from plan_task where 1=1";
		if (splanid != null && !splanid.equals("")) {
			ssql += " and plan_id=" + splanid;
		}
		if (stasktype != null && !stasktype.equals("")) {
			ssql += " and task_type =" + stasktype;
		}
		if (staskvalue != null && !staskvalue.equals("")) {
			ssql += " and task_value =" + staskvalue;
		}
		if (splanstarttime != null && !splanstarttime.equals("")) {
			ssql += " and to_char(plan_start_time,'YYYYMMDDHH24MISS')>='"
					+ splanstarttime + "'";
		}
		if (splanendtime != null && !splanendtime.equals("")) {
			ssql += " and to_char(plan_end_time,'YYYYMMDDHH24MISS')<='"
					+ splanendtime + "'";
		}
		if (srealstarttime != null && !srealstarttime.equals("")) {
			ssql += " and to_char(real_start_time,'YYYYMMDDHH24MISS')>='"
					+ srealstarttime + "'";
		}
		if (srealendtime != null && !srealendtime.equals("")) {
			ssql += " and to_char(real_end_time,'YYYYMMDDHH24MISS')<='"
					+ srealendtime + "'";
		}
		if (staskexecutor != null && !staskexecutor.equals("")) {
			ssql += " and planner like '%" + staskexecutor + "%'";
		}
		if (sexecutorgroup != null && !sexecutorgroup.equals("")) {
			ssql += " and executor_group like '%" + sexecutorgroup + "%'";
		}
		if (sstatus != null && !sstatus.equals("")) {
			ssql += " and status=" + sstatus;
		}
		if (stype != null && !stype.equals("")) {
			ssql += " and type=" + stype;
		}
		if (staskdev != null && !staskdev.equals("")) {
			ssql += " and task_dev like '%" + staskdev + "%'";
		}

		// ssql += " order by plan_id,task_type,task_value";
		ssql += " order by plan_id,executor_group,task_executor,task_type,task_value";

		// System.out.print("\n" + "	" + ssql + "	" + "\n");
		Vector ver = new Vector();
		DBConnection lib = new DBConnection();
		ver = lib.selectVector(ssql);
		return ver;
	}

	/**
	 * 查询计划任务中的任务是否重复出现
	 */
	public Vector queryplantaskinfoagain(String splanid) {
		String ssql = " select task_type,task_value,decode(task_type,'1','R'||task_value,'2','F'||task_value,task_value) as demand_id from "
				+ "(select a.task_type as task_type, a.task_value as task_value,count(*) as count "
				+ " from plan_task a,plan_task b "
				+ " where  a.task_type=b.task_type and a.task_value=b.task_value and b.plan_id="
				+ splanid
				+ " group by a.task_type,a.task_value order by count desc) a where a.count>1";

		// System.out.print("\n" + "	" + ssql + "	" + "\n");
		Vector ver = new Vector();
		DBConnection lib = new DBConnection();
		ver = lib.selectVector(ssql);
		return ver;
	}

	/**
	 * 删除计划任务(delete表：plan_task)
	 */
	public void deleteplantask(String splanid, String stasktype,
			String staskvalue) {
		String ssql = "delete plan_task where plan_id=" + splanid
				+ " and task_type=" + stasktype + " and task_value="
				+ staskvalue;

		// System.out.print("\n" + "	" + ssql + "	" + "\n");
		DBConnection lib = new DBConnection();
		lib.executeUpdate(ssql);
	}

	/**
	 * 关闭计划
	 */
	public boolean colseplan(String splanid) {
		DBConnection lib = new DBConnection();
		lib.executeProcess("{call CLOSEPLAN('" + splanid + "') }");
		return true;
	}

	/**
	 * 增加计划维护记录日志(insert表：plan_task_modify_log)
	 * 
	 * @param sModifyType
	 *            ：1：增加计划任务；2：删除计划任务
	 */
	public void addplantasklog(String splanid, String stasktype,
			String staskvalue, String sModify_op, String sModifyType,
			String sRemark) {
		if (sRemark != null) {
			sRemark = sRemark.replaceAll("'", "''");
		}
		String ssql = "insert into plan_task_modify_log(plan_id,task_type,task_value,modify_op,modify_type,modify_date,remark)"
				+ " values("
				+ splanid
				+ ","
				+ stasktype
				+ ","
				+ staskvalue
				+ ","
				+ sModify_op
				+ ","
				+ sModifyType
				+ ",sysdate,'"
				+ sRemark
				+ "')";

		// System.out.print("\n" + "	" + ssql + "	" + "\n");
		DBConnection lib = new DBConnection();
		lib.executeUpdate(ssql);
	}

	/**
	 * 查询计划维护记录日志(查询表：plan_task_modify_log)
	 */
	public void queryplantasklog(String splanid, String stasktype,
			String staskvalue, String sModify_op, String sModifyType,
			String sStartDate, String sEndDate) {
		String ssql = " select a.plan_id,a.task_type,a.task_value,a.modify_op,a.modify_type,a.modify_date,a.remark,b.op_name "
				+ " from plan_task_modify_log a,op_login b where 1=1 and a.modify_op=b.op_id";

		if (splanid != null) {
			ssql += " and a.plan_id" + splanid;
		}
		if (stasktype != null) {
			ssql += " and a.task_type" + stasktype;
		}
		if (staskvalue != null) {
			ssql += " and a.task_value" + staskvalue;
		}
		if (sModify_op != null) {
			ssql += " and a.modify_op" + sModify_op;
		}
		if (sModifyType != null) {
			ssql += " and a.modify_type" + sModifyType;
		}
		if (sStartDate != null) {
			ssql += " and to_char(a.modify_date, 'yyyymmddhh24miss') >="
					+ sStartDate;
		}
		if (sEndDate != null) {
			ssql += " and to_char(a.modify_date, 'yyyymmddhh24miss') <="
					+ sEndDate;
		}
		ssql += " order by a.modify_date desc";
		// System.out.print("\n" + "	" + ssql + "	" + "\n");
		DBConnection lib = new DBConnection();
		lib.executeUpdate(ssql);
	}

}