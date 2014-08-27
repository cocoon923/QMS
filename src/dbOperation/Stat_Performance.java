package dbOperation;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.sql.CallableStatement;

import java.util.*;

import java.net.URL;
import java.sql.Blob;
import java.io.*;

import org.omg.CORBA.portable.InputStream;

import dbOperation.*;


public class Stat_Performance {
    /**
     * 根据分组类型，返回所有分组名称 及分组下成员
     * stype=1 返回分组信息
     * stype=2 返回分组及分组下成员信息
     */
	public Vector getGroupOpByType (String stype,String sgrouptype)
	{ 
		String ssql="";
		if(stype.equals("1"))
		{	
			ssql="select * from aicms.stat_group_def where 1=1";
			if(!sgrouptype.equals(""))
			{
				ssql+= " and group_type in (" + sgrouptype +")";
			}
			
			ssql+= "order by stat_group_id";
		}
		else if (stype.equals("2"))
		{
			ssql="select * from aicms.stat_group_def a,aicms.stat_group_op b where  1=1 and a.stat_group_id=b.stat_group_id";
			if(!sgrouptype.equals(""))
			{
				ssql += "  and a.group_type in ("+sgrouptype+")";
			}
			ssql +=" order by b.stat_group_id,b.op_name ";
		}
		
		//System.out.print("\n 查询统计分组sql：" +ssql + "\n");
		Vector ver = new Vector();
		DBConnection lib = new DBConnection();
		ver=lib.selectVector(ssql);
		return ver;
    }
	
	/**
	 * 根据分组id，返回该组下成员
	 */
	public Vector getOpByGroup(String sgroupid)
	{
		String ssql=" select * from aicms.stat_group_op where 1=1";
		if(!sgroupid.equals(""))
		{
			ssql += " and stat_group_id in ("+sgroupid+")";
		}
		ssql += " oorder by stat_group_id,op_name";
		Vector ver = new Vector();
		DBConnection lib = new DBConnection();
		ver=lib.selectVector(ssql);
		return ver;
	}
	
	/**
	 * 根据组类型或组id，返回相关产品id及产品名称
	 */
	public Vector getGroupProductByGroup(String sgrouptype,String sgroupid)
	{
		String ssql=" select distinct (a.product_id) as product_id, b.product_name as product_name "
				   +" from aicms.stat_group_product_map a,qcs.product b,aicms.stat_group_def c "
				   +" where a.product_id = b.product_id and a.group_id = c.stat_group_id";
		if(!sgrouptype.equals(""))
		{
			ssql += " and c.group_type in ("+sgrouptype+")";
		}
		if(!sgroupid.equals(""))
		{
			ssql += " and c.stat_group_id in ("+sgroupid+")";
		}
		ssql += " order by product_id";
		Vector ver = new Vector();
		DBConnection lib = new DBConnection();
		ver=lib.selectVector(ssql);
		return ver;
	}
	
	
	/**
	 * 根据组类别、时间段，返回需求协调中SCCB/PM处理的需求个数、总时间、以及平均时间
	 * sproducts -- 必填，需统计的产品id，用英文逗号分割，例如：2,3,92,93
	 * sgrouptype -- 必填，需统计人员归属组类别，用英文逗号分割，例如：1,2,3
	 * */
	public Vector getDemandSCCBTime(String sproducts,String sgrouptype,String sgroupid,String sstarttime,String sendtime)
	{
		String ssql=" select op,op_name,groupid,groupname,count(*) count ,sum(time) totaltime,trim(to_char(sum(time)/count(*),990.99)) time from "
				   +" (select distinct(b.from_id) op,d.op_name,a.demand_id,a.min,a.max,a.time,c.stat_group_id groupid,c.stat_group_name groupname from "
				   +" (select demand_id, min, max, trim(to_char(max - min, 99999990.99)) time from "
				   +" (select demand_id,min(mintime) min,decode(max(maxtime),null,min(mintime),max(maxtime)) max from "
				   +" (select demand_id,min(time) mintime,null maxtime from (select demand_id,memo_time time from "
				   +" qcs.demand_memo where memo_id=1 and demand_id in (select demand_id from qcs.demand_request where product_id in ("+sproducts+"))"
				   +" union "
				   +" select demand_id,rep_time time from qcs.demand_request where demand_id in "
				   +" (select demand_id from qcs.demand_request where product_id in ("+sproducts+"))) group by demand_id "
				   +" union "
				   +" select demand_id,null mintime,max(memo_time) mintime from "
				   +" (select demand_id,memo_time  from qcs.demand_memo where memo_type in (1, 2, 3, 4, 5, 6, 7, 14, 15, 16, 17, 18, 19, 21, 24, 27, 29, 31, 33, 35, 36, 37) "
				   +" and demand_id in (select demand_id from qcs.demand_request where product_id in ("+sproducts+"))) group by demand_id) "
				   +" group by demand_id)) a,qcs.demand_memo b ,aicms.stat_group_def c,aicms.stat_group_op d "
				   +" where a.demand_id=b.demand_id and c.stat_group_id=d.stat_group_id and b.from_id=d.op_id and a.time>0 ";
		if(!sgrouptype.equals(""))
		{
			ssql += " and c.group_type in ("+sgrouptype+") ";
		}
		if(!sgroupid.equals(""))
		{
			ssql += " and c.stat_group_id in ("+sgroupid+")";
		}
		if(!sstarttime.equals(""))
		{
			ssql += " and to_char(a.max, 'YYYYMMDDHH24MISS') >= '"+sstarttime+"' ";
		}
		if(!sendtime.equals(""))
		{
			ssql += " and to_char(a.max, 'YYYYMMDDHH24MISS') <= '"+sendtime+"' ";
		}
		ssql += " ) group by op,op_name,groupid,groupname order by groupid,op";
		Vector ver = new Vector();
		DBConnection lib = new DBConnection();
		ver=lib.selectVector(ssql);
		return ver;
	}
	
	/**
	 * 根据组类别、时间段，返回需求协调中SCCB/PM处理的需求测试完成的平均时间
	 * sproducts -- 必填，需统计的产品id，用英文逗号分割，例如：2,3,92,93
	 * sgrouptype -- 必填，需统计人员归属组类别，用英文逗号分割，例如：1,2,3
	 * */
	public Vector getDemandSCCBDemandTime(String sproducts,String sgrouptype,String sgroupid,String sstarttime,String sendtime)
	{
		String ssql=" select op,op_name,groupid,groupname,count(*) count ,sum(time) totaltime,trim(to_char(sum(time)/count(*),990.99)) time  from "
				   +" (select distinct(b.from_id) op,d.op_name,a.demand_id,a.min,a.max,a.time,c.stat_group_id groupid,c.stat_group_name groupname from "
				   +" (select demand_id,min,max,trim(to_char(max - min, 99999990.99)) time from "
				   +" (select demand_id,min(starttime) min,max(endtime) max from (select demand_id,min(time) starttime,null endtime from "
				   +" (select demand_id,memo_time time from qcs.demand_memo where memo_id=1 "
				   +" and demand_id in (select demand_id from qcs.demand_request where product_id in ("+sproducts+")) "
				   +" union "
				   +" select demand_id,rep_time time from qcs.demand_request "
				   +" where demand_id in (select demand_id from qcs.demand_request where product_id in ("+sproducts+"))) group by demand_id "
				   +" union "
				   +" select demand_id,null,qa_time endtime from qcs.demand_request where product_id in ("+sproducts+") "
				   +" and status in (11,12,13,20,21) and qa_time is not null) group by demand_id) where max >= min) a,"
				   +" qcs.demand_memo b ,aicms.stat_group_def c,aicms.stat_group_op d  where a.demand_id=b.demand_id "
				   +" and c.stat_group_id=d.stat_group_id and b.from_id=d.op_id ";
		if(!sgrouptype.equals(""))
		{
			ssql += " and c.group_type in ("+sgrouptype+") ";
		}
		if(!sgroupid.equals(""))
		{
			ssql += " and c.stat_group_id in ("+sgroupid+")";
		}
		if(!sstarttime.equals(""))
		{
			ssql += " and to_char(a.max, 'YYYYMMDDHH24MISS') >= '"+sstarttime+"' ";
		}
		if(!sendtime.equals(""))
		{
			ssql += " and to_char(a.max, 'YYYYMMDDHH24MISS') <= '"+sendtime+"' ";
		}
		ssql += " )group by op,op_name,groupid,groupname order by groupid,op";
		Vector ver = new Vector();
		DBConnection lib = new DBConnection();
		ver=lib.selectVector(ssql);
		return ver;
	}
	
	
	/**
	 * 根据组类别、时间段，返回开发参与需求的完成时间的平均值
	 * sproducts -- 必填，需统计的产品id，用英文逗号分割，例如：2,3,92,93
	 * sgrouptype -- 必填，需统计人员归属组类别，用英文逗号分割，例如：1,2,3
	 * */
	public Vector getDemandDevDemandTime(String sproducts,String sgrouptype,String sgroupid,String sstarttime,String sendtime)
	{
		String ssql=" select op,op_name,groupid,groupname,count(*) count ,sum(time) totaltime,trim(to_char(sum(time)/count(*),990.99)) time  from "
				   +" (select distinct(e.from_id) op,d.op_name,a.demand_id,a.min,a.max,a.time,c.stat_group_id groupid,c.stat_group_name groupname from "
				   +" (select demand_id,min,max,trim(to_char(max - min, 99999990.99)) time from "
				   +" (select demand_id,min(starttime) min,max(endtime) max from (select demand_id,min(time) starttime,null endtime from "
				   +" (select demand_id,memo_time time from qcs.demand_memo where memo_id=1 and "
				   +" demand_id in (select demand_id from qcs.demand_request where product_id in ("+sproducts+")) "
				   +" union "
				   +" select demand_id,rep_time time from qcs.demand_request where "
				   +" demand_id in (select demand_id from qcs.demand_request where product_id in ("+sproducts+"))) group by demand_id "
				   +" union "
				   +" select demand_id,null,qa_time endtime from qcs.demand_request where product_id in ("+sproducts+") "
				   +" and status in (11,12,13,20,21) and qa_time is not null) group by demand_id) where max >= min) a,"
				   +" qcs.assignment b ,qcs.assignment_memo e,aicms.stat_group_def c,aicms.stat_group_op d "
				   +" where a.demand_id=b.dependid and c.stat_group_id=d.stat_group_id and e.from_id=d.op_id "
				   +" and b.task_id=e.task_id and e.memo_type not in (1,10,11)";
		if(!sgrouptype.equals(""))
		{
			ssql += " and c.group_type in ("+sgrouptype+") ";
		}
		if(!sgroupid.equals(""))
		{
			ssql += " and c.stat_group_id in ("+sgroupid+")";
		}
		if(!sstarttime.equals(""))
		{
			ssql += " and to_char(a.max, 'YYYYMMDDHH24MISS') >= '"+sstarttime+"' ";
		}
		if(!sendtime.equals(""))
		{
			ssql += " and to_char(a.max, 'YYYYMMDDHH24MISS') <= '"+sendtime+"' ";
		}
		ssql += " )group by op,op_name,groupid,groupname order by groupid,op";
		//System.out.print("\n 返回查询结果的sql：" +ssql + "\n");
		Vector ver = new Vector();
		DBConnection lib = new DBConnection();
		ver=lib.selectVector(ssql);
		return ver;
	}
	
	
	/**
	 * 根据组类别、时间段，返回开发完成的任务单的总数，总时间及平均时间
	 * sproducts -- 必填，需统计的产品id，用英文逗号分割，例如：2,3,92,93
	 * sgrouptype -- 必填，需统计人员归属组类别，用英文逗号分割，例如：1,2,3
	 * */
	public Vector getDevAssignmentTime(String sproducts,String sgrouptype,String sgroupid,String sstarttime,String sendtime)
	{
		String ssql=" select opname op_name,opid op,groupid,groupname,count(*) count,sum(time) totaltime,trim(to_char(sum(time)/count(*),990.99)) time from "
			       +" (select distinct(d.op_id) opid,a.dependid demand_id,a.task_id taskid,c.stat_group_id groupid,c.stat_group_name groupname,a.opentime starttime,a.qa_time endtime,a.time time,d.op_name opname from "
			       +" (select task_id,dependid,opentime,qa_time,trim(to_char(qa_time-opentime,9999990.99)) time from "
			       +" (select task_id, dependid, opentime, qa_time  from qcs.assignment where "
			       +" dependid in (select demand_id from qcs.demand_request where product_id in ("+sproducts+"))   and status_id = 4)) a,"
			       +" qcs.assignment_memo b,aicms.stat_group_def c,aicms.stat_group_op d where "
			       +" a.task_id = b.task_id and c.stat_group_id = d.stat_group_id and d.op_id = b.from_id and b.memo_type not in (1,10,11) ";
		if(!sgrouptype.equals(""))
		{
			ssql += " and c.group_type in ("+sgrouptype+") ";
		}
		if(!sgroupid.equals(""))
		{
			ssql += " and c.stat_group_id in ("+sgroupid+")";
		}
		if(!sstarttime.equals(""))
		{
			ssql += " and to_char(a.qa_time, 'YYYYMMDDHH24MISS') >= '"+sstarttime+"' ";
		}
		if(!sendtime.equals(""))
		{
			ssql += " and to_char(a.qa_time, 'YYYYMMDDHH24MISS') <= '"+sendtime+"' ";
		}
		ssql += " ) group by opname,opid,groupid,groupname order by groupid,opid";
		//System.out.print("\n 返回查询结果的sql：" +ssql + "\n");
		Vector ver = new Vector();
		DBConnection lib = new DBConnection();
		ver=lib.selectVector(ssql);
		return ver;
	}
	
	/**
	 * 根据组类别、时间段，返回bug产生的个数、总时间、以及平均时间
	 * sgroupid -- 需统计的小组id，用英文逗号分割，例如：1,2,3
	 * sgrouptype -- 必填，需统计人员归属组类别，用英文逗号分割，例如：1,2,3
	 * */
	public Vector getBugTime(String sgrouptype,String sgroupid,String sstarttime,String sendtime)
	{
		String ssql=" select d.op_id op,d.op_name opname,c.stat_group_id groupid,c.stat_group_name groupname,sum(time) totaltime ,count(*) count,trim(to_char(sum(time)/count(*),990.99)) time from "
				   +" (select distinct(from_id) op,slip_id from qcs.slips_memo ) a,"
				   +" (select slip_id,opentime,closetime,decode(to_char(closetime,'YYYYMMDD'),'18991130',opentime,closetime),trim(to_char(decode(to_char(closetime,'YYYYMMDD'),'18991130',opentime,closetime)-opentime, 99999990.99)) time from qcs.slips where status_id in (2,7,8,10)) b,"
				   +" aicms.stat_group_def c,aicms.stat_group_op d where a.slip_id = b.slip_id and a.op=d.op_id and c.stat_group_id = d.stat_group_id ";
		if(!sgrouptype.equals(""))
		{
			ssql += " and c.group_type in ("+sgrouptype+") ";
		}
		if(!sgroupid.equals(""))
		{
			ssql += " and c.stat_group_id in ("+sgroupid+")";
		}
		if(!sstarttime.equals(""))
		{
			ssql += " and to_char(b.closetime, 'YYYYMMDDHH24MISS') >= '"+sstarttime+"' ";
		}
		if(!sendtime.equals(""))
		{
			ssql += " and to_char(b.closetime, 'YYYYMMDDHH24MISS') <= '"+sendtime+"' ";
		}
		ssql += " group by d.op_id,d.op_name,c.stat_group_id,c.stat_group_name order by groupid,op";
		//System.out.print("\n 返回查询结果的sql：" +ssql + "\n");
		Vector ver = new Vector();
		DBConnection lib = new DBConnection();
		ver=lib.selectVector(ssql);
		return ver;
	}
	
	
	/**
	 * 根据组类别、时间段，返回bug产生的个数、总时间、以及平均时间
	 * sgroupid -- 需统计的小组id，用英文逗号分割，例如：1,2,3
	 * sgrouptype -- 必填，需统计人员归属组类别，用英文逗号分割，例如：1,2,3
	 * */
	public Vector getAssignmentBugCount(String sgrouptype,String sgroupid,String sstarttime,String sendtime)
	{
		String ssql=" select op_id op,op_name opname,groupid,groupname,count(*) assignment,sum(bugcount) sum,trim(to_char(sum(bugcount)*100/count(*),990.00))||'%' per "
				   +" from (select a.task_id,c.op_id,c.op_name,b.stat_group_id groupid,b.stat_group_name groupname,a.bugcount from "
				   +" (select task_id,max(op) opid,decode(max(bug),null,0,max(bug)) bugcount from "
				   +" (select distinct(from_id) op,task_id,null bug from qcs.assignment_memo where memo_type not in (1,10,11)group by from_id,task_id "
				   +" union "
				   +" select null op,task_id,count(*) bug  from qcs.assignment_slip group by task_id) group by task_id) a,"
				   +" aicms.stat_group_def b,aicms.stat_group_op c ,qcs.assignment d,qcs.demand_request e "
				   +" where a.opid=c.op_id  and b.stat_group_id = c.stat_group_id and d.task_id=a.task_id and d.dependid=e.demand_id and d.status_id=4 ";
		if(!sgrouptype.equals(""))
		{
			ssql += " and b.group_type in ("+sgrouptype+") ";
		}
		if(!sgroupid.equals(""))
		{
			ssql += " and b.stat_group_id in ("+sgroupid+")";
		}
		if(!sstarttime.equals(""))
		{
			ssql += " and to_char(d.qa_time, 'YYYYMMDDHH24MISS') >= '"+sstarttime+"' ";
		}
		if(!sendtime.equals(""))
		{
			ssql += " and to_char(d.qa_time, 'YYYYMMDDHH24MISS') <= '"+sendtime+"' ";
		}
		ssql += " ) group by op_id,op_name,groupid,groupname order by groupid,op";
		//System.out.print("\n 返回查询结果的sql：" +ssql + "\n");
		Vector ver = new Vector();
		DBConnection lib = new DBConnection();
		ver=lib.selectVector(ssql);
		return ver;
	}
	
	/**
	 * 根据组类别、时间段，返回bug产生的个数、总时间、以及平均时间
	 * sproducts -- 必填，需统计的产品id，用英文逗号分割，例如：2,3,92,93
	 * */
	public Vector getProjectRequestCount(String sproducts,String sstarttime,String sendtime)
	{
		String ssql="";
		String ssql1="select product_id,count(*) fault,null demand from qcs.project_request where 1=1";
		String ssql2="select product_id,null fault,count(*) demand from qcs.demand_request where 1=1";
		if(!sproducts.equals(""))
		{
			ssql1 += " and product_id in ("+sproducts+")";
			ssql2 += " and product_id in ("+sproducts+")";
		}
		if(!sstarttime.equals(""))
		{
			ssql1 += " and to_char(rep_time, 'YYYYMMDDHH24MISS') >= '"+sstarttime+"' ";
			ssql2 += " and to_char(rm_time, 'YYYYMMDDHH24MISS') >= '"+sstarttime+"' ";
		}
		if(!sendtime.equals(""))
		{
			ssql1 += " and to_char(rep_time, 'YYYYMMDDHH24MISS') <= '"+sendtime+"' ";
			ssql2 += " and to_char(rm_time, 'YYYYMMDDHH24MISS') <= '"+sendtime+"' ";
		}
		ssql1 += " group by product_id";
		ssql2 += " group by product_id";
		ssql =" select a.product_id productid,b.product_name productname,decode(max(a.fault),null,0,max(a.fault)) faultcount,decode(max(a.demand),null,0,max(a.demand)) demandcount,"
			 +" trim(to_char(decode(max(a.fault),null,0,max(a.fault))*100/decode(max(a.demand),null,1,max(a.demand)),99990.99))||'%' per from ("+ssql1+" union " +ssql2+ ") a,"
			 +" qcs.product b where a.product_id=b.product_id group by a.product_id,b.product_name order by a.product_id";
		//System.out.print("\n 返回查询结果的sql：" +ssql + "\n");
		Vector ver = new Vector();
		DBConnection lib = new DBConnection();
		ver=lib.selectVector(ssql);
		return ver;
	}
	
	
	/**
	 * 根据组类别、时间段，返回有效、无效评审个数
	 * sproducts -- 必填，需统计的产品id，用英文逗号分割，例如：2,3,92,93
	 * */
	public Vector getAuditCount(String sproducts,String sgrouptype,String sgroupid,String sstarttime,String sendtime)
	{
		String ssql="";
		String ssql1=" select a.op_id,c.op_name,b.stat_group_id,b.stat_group_name ,count(*) totalcountOK,null totalcountFail from "
					+" qcs.audits a,aicms.stat_group_def b,aicms.stat_group_op c where "
					+" a.audit_id in (select audit_id from (select audit_id,count(*) count from qcs.audits_problems "
					+" where status=2 group by audit_id) where count>=3)and b.stat_group_id = c.stat_group_id and a.op_id=c.op_id";
		String ssql2=" select a.op_id,c.op_name,b.stat_group_id,b.stat_group_name ,null totalcountOK,count(*) totalcountFail from "
					+" qcs.audits a,aicms.stat_group_def b,aicms.stat_group_op c where "
					+" a.audit_id in (select audit_id from (select audit_id,count(*) count from qcs.audits_problems "
					+" where status=2 group by audit_id) where count<3) and b.stat_group_id = c.stat_group_id and a.op_id=c.op_id";
		if(!sproducts.equals(""))
		{
			ssql1 += " and a.audit_product in ("+sproducts+")";
			ssql2 += " and a.audit_product in ("+sproducts+")";
		}
		if(!sgrouptype.equals(""))
		{
			ssql1 += " and b.group_type in ("+sgrouptype+") ";
			ssql2 += " and b.group_type in ("+sgrouptype+") ";
		}
		if(!sgroupid.equals(""))
		{
			ssql1 += " and b.stat_group_id in ("+sgroupid+")";
			ssql2 += " and b.stat_group_id in ("+sgroupid+")";
		}
		if(!sstarttime.equals(""))
		{
			ssql1 += " and to_char(a.audit_date, 'YYYYMMDDHH24MISS') >= '"+sstarttime+"' ";
			ssql2 += " and to_char(a.audit_date, 'YYYYMMDDHH24MISS') >= '"+sstarttime+"' ";
		}
		if(!sendtime.equals(""))
		{
			ssql1 += " and to_char(a.audit_date, 'YYYYMMDDHH24MISS') <= '"+sendtime+"' ";
			ssql2 += " and to_char(a.audit_date, 'YYYYMMDDHH24MISS') <= '"+sendtime+"' ";
		}
		ssql1 += " group by a.audit_type,a.op_id,c.op_name,b.stat_group_id,b.stat_group_name";
		ssql2 += " group by a.audit_type,a.op_id,c.op_name,b.stat_group_id,b.stat_group_name";
		ssql =" select op_id op,op_name opname,stat_group_id groupid,stat_group_name groupname,decode(max(totalcountOK),null,0,max(totalcountOK)) ok,"
			 +" decode(max(totalcountFail),null,0,max(totalcountFail)) fail,((decode(max(totalcountOK), null, 0, max(totalcountOK)) + decode(max(totalcountFail), null, 0, max(totalcountFail)))) sumcount"
			 +" from ("+ssql1+" union "+ssql2+") "
			 +" group by op_id,op_name,stat_group_id,stat_group_name";
		//System.out.print("\n 返回查询结果的sql：" +ssql + "\n");
		Vector ver = new Vector();
		DBConnection lib = new DBConnection();
		ver=lib.selectVector(ssql);
		return ver;
	}
/*--------------------------------------------------------------------------------------------------------*/	
	
/* 调试用函数 */
//public static void main(String args[])
//{
//	   Vector ver = new Vector();
//	   String s="";
	   //s=getCaseProcessID("238");
	   //deleteCaseProcessInfo("239","2");
//	   PrcaddPlanTaskInfo("1","","5","20090101","20090102","1");
//	   System.out.print("\n----BEGIN-----\n");
//	   System.out.print("ver.size()="+ver.size()+"\n");
//	   System.out.print("s="+s);
//	   if(ver.size()>0)
//	   	{for (int i = 0; i < ver.size(); i++) {
//		    HashMap CaseInfohash = (HashMap) ver.get(i);
//			String sCASEID = (String) CaseInfohash.get("CASE_ID");
//			String sCASENAME = (String) CaseInfohash.get("CASE_NAME");
//			String sCASEDESC = (String) CaseInfohash.get("CASE_DESC");
//			String sEXPRESULT = (String) CaseInfohash.get("EXP_RESULT");
//			String sCLIINFOID = (String) CaseInfohash.get("CLI_INFO_ID");
//			String sSVRINFOID = (String) CaseInfohash.get("SVR_INFO_ID");
//			//sCASEENV = (String) CaseInfohash.get("CASE_ENV");
//			String sCASEDATAPREPARE = (String) CaseInfohash.get("CASE_DATA_PREPARE");
//			String sSUBSYSID = (String) CaseInfohash.get("SUB_SYS_ID");
//			String sMODULEID = (String) CaseInfohash.get("MODULE_ID");
//			String sOPID = (String) CaseInfohash.get("OP_ID");
//			System.out.print(sCASEID + "\n----\n"+ sCASENAME + "----\n" + sCASEDESC + "----\n" + sEXPRESULT + "----\n" + sCLIINFOID + "----\n" + sSVRINFOID + "----\n" + "" + "----\n" + sCASEDATAPREPARE + "----\n" + sSUBSYSID + "----\n" + sMODULEID + "----\n" + sOPID + "----\n");
//		  }
//	   	}
//	   else System.out.print("ver.size()="+ver.size()+"，不显示！");

//	  }  
	
 	
}