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


public class Stat {
    /**
     * 返回所有统计项目（查询stat_def表）
     */
	public Vector getStatDef (String sstatid)
	{ 
		String ssql="select * from stat_def where 1=1";
		if(!sstatid.equals(""))
		{
			ssql+= " and stat_id=" + sstatid;
		}
		
		ssql+= "order by stat_id";
		
		//System.out.print("\n 查询统计项目的sql：" +ssql + "\n");
		Vector ver = new Vector();
		DBConnection lib = new DBConnection();
		ver=lib.selectVector(ssql);
		return ver;
    }

	/**
     * 返回所有统计项和查询条件（查询stat_field表）
     */
	public Vector getStatfield (String sstatid,String stype)
	{ 
		String ssql="select * from stat_field where 1=1";
		if(sstatid!=null)
		{
			ssql += " and stat_id="+sstatid;
		}
		if(stype!=null)
		{
			ssql += " and type="+ stype;
		}
		
		ssql += " order by display_seq,display_type";
		
		//System.out.print("\n 查询统计字段的sql：" +ssql + "\n");
		Vector ver = new Vector();
		DBConnection lib = new DBConnection();
		ver=lib.selectVector(ssql);
		return ver;
    }
	
	
	/**
     * 根据界面传入的sql语句，返回查询结果
     */
	public Vector returnResult (String sSql)
	{ 	
		//System.out.print("\n 返回查询结果的sql：" +sSql + "\n");
		Vector ver = new Vector();
		DBConnection lib = new DBConnection();
		ver=lib.selectVector(sSql);
		return ver;
    }
	
	/**
     * 根据界面传入的sql语句，返回查询结果
     */
	public void InertLog (String sStatid,String sStatsql,String sOpId)
	{ 	
		String sSql="";
		if(!sStatsql.equals(""))
		{
			sStatsql=sStatsql.replaceAll("'", "''");
		}
		sSql="insert into stat_log values("+sStatid+",'"+sStatsql+"',"+sOpId+",sysdate)";
		//System.out.print("\n 返回查询结果的sql：" +sSql + "\n");
		DBConnection lib = new DBConnection();
		lib.executeUpdate(sSql);
    }

	
	
	/**
	 * 根据入参查询满足条件的需求编号及相关属性
	 * @param stype 标识查询需求或故障，1：查需求；
	 */
	public Vector statdemand(String stype,String srepstarttime,String srependtime,String sproductid,String sstauts,String sgroupid,String sopid,String sdemandid,String sdefproductid)
	{
		String ssql="";
		if(stype.equals("1"))
		{
			ssql="select distinct a.demand_id as DEMAND_ID, c.project_name as PROJ_NAME,a.demand_title as DEMAND_TITLE,d.product_name as PRODUCT_NAME,"
				+"a.status as STATUS,nvl(to_char(a.rep_time, 'yyyy-mm-dd'), '-') as REP_TIME,nvl(to_char(a.dev_time, 'yyyy-mm-dd'), '-') as DEV_TIME,"
				+"b.sta_name as STA_NAME"
			    +" from DEMAND_REQUEST a, DEMAND_STATUS b, PROJECT c,product d,assignment e "
			    +" where a.status = b.sta_id and a.project_code = c.proj_code and a.product_id = d.product_id and a.demand_id=e.demand_id"
			    +" and a.product_id in ("+sdefproductid+")";
			if(!srepstarttime.equals("") && !srepstarttime.equals(null))
			{
				ssql+=" and to_char(a.rep_time,'YYYYMMDDhh24miss')>='"+srepstarttime+"'";
			}
			if(!srependtime.equals("") && !srependtime.equals(null))
			{
				ssql+=" and to_char(a.rep_time,'YYYYMMDDhh24miss')<='"+srependtime+"'";
			}
			if(!sproductid.equals("") && !sproductid.equals(null))
			{
				ssql+=" and a.product_id in ("+sproductid+")";
			}
			if(!sstauts.equals("") && !sstauts.equals(null))
			{
				ssql+=" and a.status in ("+sstauts+")";
			}
			if(!sgroupid.equals("") && !sgroupid.equals(null))
			{
				ssql+=" and e.closer_id in (select op_id from group_op_info where group_id in ("+sgroupid+"))";
			}
			if(!sopid.equals("") && !sopid.equals(null))
			{
				ssql+=" and e.closer_id in ("+sopid+")";
			}
			if(!sdemandid.equals("") && !sdemandid.equals(null))
			{
				ssql+=" and a.demand_id in ("+sdemandid+")";
			}
		}
		else
		{
			System.out.print("输入类型未知，请检查！");
		}	
		ssql+=" order by demand_id asc";
		//System.out.print("\n 返回查询结果的sql：" +ssql + "\n");
		Vector ver = new Vector();
		DBConnection lib = new DBConnection();
		ver=lib.selectVector(ssql);
		return ver;
	}
	
	
	public void StatInfo(String stype,String sValue,String sStatus)
	{
		int iFlag=0;
		String sSql="";
		String unfinish_status="";
		String finish_status="";
		sStatus=","+sStatus+",";
		String sSql1="";
		String sSql2="";
		if(stype.equals("1")) //统计类型为需求
		{
			unfinish_status=",1,2,3,4,";
			finish_status=",5,20,";
			if(unfinish_status.indexOf(sStatus)>0) 
			{
				iFlag=0; //需求未完成
			}
			if(finish_status.indexOf(sStatus)>0) 
			{
				iFlag=1; //需求已完成
			}
			sSql ="select * from demand_stat_result_finish where demand_id="+sValue; //判断需求完成后是否已生成统计信息
			Vector ver = new Vector();
			DBConnection lib = new DBConnection();
			ver=lib.selectVector(sSql);
			if(ver.size()<1 )//需求完成后未生成统计信息，需要删除原临时统计信息再生成。
			{
				sSql1="delete demand_stat_result_unfinish where demand_id="+sValue;
				sSql2="delete demand_stat_tmp where demand_task_id in (select task_id from assignment where demand_id="+sValue+")";
				
				lib.executeUpdate(sSql1);
				lib.executeUpdate(sSql2);
				lib.executeProcess("{call DemandStat('"+stype+"','"+sValue+"',"+iFlag+") }");
			}
		}
	}
	
	
	/**
     * 根据需求编号，返回统计汇总信息(小数据量可用，数据量大，当填入sValues值时会报错)
     */
	public Vector QueryStatInfo (String sValues)
	{ 	
		String sSql="";
		sSql=" select sum(devtime) as DEVTIME,sum(qatime) as QATIME,"
			+" round(sum(devtime) * 100 / (sum(devtime) + sum(qatime)), 2) || '%' as dev_time_per,"
			+" round(sum(qatime) * 100 / (sum(devtime) + sum(qatime)), 2) || '%' as qa_time_per from "
			+" (select round(sum(a.dev_time), 2) as devtime,round(sum(a.test_time), 2) as qatime "
			+" from demand_stat_result_unfinish a where a.demand_id in ("+sValues+") "
			+" union"
			+" select round(sum(a.dev_time), 2) as devtime,round(sum(a.test_time), 2) as qatime "
			+" from demand_stat_result_finish a where a.demand_id in ("+sValues+"))";
		//System.out.print("\n 返回查询结果的sql：" +sSql + "\n");
		Vector ver = new Vector();
		DBConnection lib = new DBConnection();
		ver=lib.selectVector(sSql);
		return ver;
    }	
	
	
	/**
     * 根据需求编号，返回统计汇总信息明细(小数据量可用，数据量大，当填入sValues值时会报错)
     */
	public Vector QueryStatDetailInfo (String sValues)
	{ 	
		String sSql="";
		sSql=" select a.demand_id,b.demand_title,round(sum(a.dev_time),2) as devtime,round(sum(a.test_time),2) as qatime,"
			+" round(sum(a.dev_time)*100 / (sum(a.dev_time) + sum(a.test_time)),2)||'%' as devtimeper,"
			+" round(sum(a.test_time)*100 / (sum(a.dev_time) + sum(a.test_time)),2)||'%'as qatimeper "
			+" from demand_stat_result_unfinish a, demand_request b "
			+" where a.demand_id in ("+sValues+") and a.demand_id = b.demand_id "
			+" group by a.demand_id, b.demand_title "
			+" union "
			+" select a.demand_id,b.demand_title,round(sum(a.dev_time),2) as devtime,round(sum(a.test_time),2) as qatime,"
			+" round(sum(a.dev_time)*100 / (sum(a.dev_time) + sum(a.test_time)),2)||'%' as devtimeper,"
			+" round(sum(a.test_time)*100 / (sum(a.dev_time) + sum(a.test_time)),2)||'%'as qatimeper "
			+" from demand_stat_result_finish a, demand_request b "
			+" where a.demand_id in ("+sValues+") and a.demand_id = b.demand_id  "
			+" group by a.demand_id, b.demand_title";
		sSql += " order by demand_id";
		//System.out.print("\n 返回查询结果的sql：" +sSql + "\n");
		Vector ver = new Vector();
		DBConnection lib = new DBConnection();
		ver=lib.selectVector(sSql);
		return ver;
    }
	
	
	
	/**
     * 根据界面上的查询条件，返回统计汇总信息
     */
	public Vector QueryStatInfoAll (String stype,String srepstarttime,String srependtime,String sproductid,String sstauts,String sgroupid,String sopid,String sdemandid,String sdefproductid,String StatType)
	{ 	
		String sSql="";
		String sSql_str="";
		
		sSql_str="select distinct a.demand_id"
			    +" from DEMAND_REQUEST a, DEMAND_STATUS b, PROJECT c,product d,assignment e "
		        +" where a.status = b.sta_id and a.project_code = c.proj_code and a.product_id = d.product_id and a.demand_id=e.demand_id"
		        +" and a.product_id in ("+sdefproductid+")";
		if(!srepstarttime.equals("") && !srepstarttime.equals(null))
		{
			sSql_str+=" and to_char(a.rep_time,'YYYYMMDDhh24miss')>='"+srepstarttime+"'";
		}
		if(!srependtime.equals("") && !srependtime.equals(null))
		{
			sSql_str+=" and to_char(a.rep_time,'YYYYMMDDhh24miss')<='"+srependtime+"'";
		}
		if(!sproductid.equals("") && !sproductid.equals(null))
		{
			sSql_str+=" and a.product_id in ("+sproductid+")";
		}
		if(!sstauts.equals("") && !sstauts.equals(null))
		{
			sSql_str+=" and a.status in ("+sstauts+")";
		}
		if(!sgroupid.equals("") && !sgroupid.equals(null))
		{
			sSql_str+=" and e.closer_id in (select op_id from group_op_info where group_id in ("+sgroupid+"))";
		}
		if(!sopid.equals("") && !sopid.equals(null))
		{
			sSql_str+=" and e.closer_id in ("+sopid+")";
		}
		if(!sdemandid.equals("") && !sdemandid.equals(null))
		{
			sSql_str+=" and a.demand_id in ("+sdemandid+")";
		}
		
		/* 统计总时间，不取总数，分别取开发时间最大值；测试时间最大值 modify by liyf 20091020
		 */
		if(StatType.equals("1"))
		{
		sSql=" select sum(devtime) as DEVTIME,sum(qatime) as QATIME,"
			+" round(sum(devtime) * 100 / (sum(devtime) + sum(qatime)), 2) || '%' as dev_time_per,"
			+" round(sum(qatime) * 100 / (sum(devtime) + sum(qatime)), 2) || '%' as qa_time_per from "
			+" (select round(sum(a.dev_time), 2) as devtime,round(sum(a.test_time), 2) as qatime "
			+" from demand_stat_result_unfinish a where a.demand_id in ("+sSql_str+") "
			+" union"
			+" select round(sum(a.dev_time), 2) as devtime,round(sum(a.test_time), 2) as qatime "
			+" from demand_stat_result_finish a where a.demand_id in ("+sSql_str+"))";
		}
		else
		{
		sSql=" select sum(devtime) as DEVTIME,sum(qatime) as QATIME,"
			+" round(sum(devtime) * 100 / (sum(devtime) + sum(qatime)), 2) || '%' as dev_time_per,"
			+" round(sum(qatime) * 100 / (sum(devtime) + sum(qatime)), 2) || '%' as qa_time_per from "
			+" (select a.demand_id,round(max(a.dev_time), 2) as devtime,round(max(a.test_time), 2) as qatime "
			+" from demand_stat_result_unfinish a where a.demand_id in ("+sSql_str+")  group by a.demand_id"
			+" union"
			+" select a.demand_id,round(max(a.dev_time), 2) as devtime,round(max(a.test_time), 2) as qatime "
			+" from demand_stat_result_finish a where a.demand_id in ("+sSql_str+") group by a.demand_id)";
		}  
		//System.out.print("\n 返回查询结果的sql：" +sSql + "\n");
		Vector ver = new Vector();
		DBConnection lib = new DBConnection();
		ver=lib.selectVector(sSql);
		return ver;
    }	
	
	
	/**
     * 根据界面上的查询条件，返回统计汇总信息明细
     */
	public Vector QueryStatDetailInfoAll (String stype,String srepstarttime,String srependtime,String sproductid,String sstauts,String sgroupid,String sopid,String sdemandid,String sdefproductid,String StatType)
	{ 	
		String sSql="";
		String sSql_str="";
		
		sSql_str="select distinct a.demand_id"
			    +" from DEMAND_REQUEST a, DEMAND_STATUS b, PROJECT c,product d,assignment e "
		        +" where a.status = b.sta_id and a.project_code = c.proj_code and a.product_id = d.product_id and a.demand_id=e.demand_id"
		        +" and a.product_id in ("+sdefproductid+")";
		if(!srepstarttime.equals("") && !srepstarttime.equals(null))
		{
			sSql_str+=" and to_char(a.rep_time,'YYYYMMDDhh24miss')>='"+srepstarttime+"'";
		}
		if(!srependtime.equals("") && !srependtime.equals(null))
		{
			sSql_str+=" and to_char(a.rep_time,'YYYYMMDDhh24miss')<='"+srependtime+"'";
		}
		if(!sproductid.equals("") && !sproductid.equals(null))
		{
			sSql_str+=" and a.product_id in ("+sproductid+")";
		}
		if(!sstauts.equals("") && !sstauts.equals(null))
		{
			sSql_str+=" and a.status in ("+sstauts+")";
		}
		if(!sgroupid.equals("") && !sgroupid.equals(null))
		{
			sSql_str+=" and e.closer_id in (select op_id from group_op_info where group_id in ("+sgroupid+"))";
		}
		if(!sopid.equals("") && !sopid.equals(null))
		{
			sSql_str+=" and e.closer_id in ("+sopid+")";
		}
		if(!sdemandid.equals("") && !sdemandid.equals(null))
		{
			sSql_str+=" and a.demand_id in ("+sdemandid+")";
		}
		
		/*统计总时间，不取总数，分别取开发时间最大值；测试时间最大值 modify by liyf 20091020
		 增加StatType值进行判断，当StatType=1，统计总数；当StatType为空或其他值，分别按照开发时间，测试时间的最大值进行统计
		 */
		if(StatType.equals("1")) 
		{	
		sSql=" select a.demand_id,b.demand_title,to_char(b.qa_time,'YYYY-MM-DD') as closetime,round(sum(a.dev_time),2) as devtime,round(sum(a.test_time),2) as qatime,"
			+" round(sum(a.dev_time)*100 / (sum(a.dev_time) + sum(a.test_time)),2)||'%' as devtimeper,"
			+" round(sum(a.test_time)*100 / (sum(a.dev_time) + sum(a.test_time)),2)||'%'as qatimeper "
			+" from demand_stat_result_unfinish a, demand_request b "
			+" where a.demand_id in ("+sSql_str+") and a.demand_id = b.demand_id "
			+" group by a.demand_id, b.demand_title,b.qa_time "
			+" union "
			+" select a.demand_id,b.demand_title,to_char(b.qa_time,'YYYY-MM-DD') as closetime,round(sum(a.dev_time),2) as devtime,round(sum(a.test_time),2) as qatime,"
			+" round(sum(a.dev_time)*100 / (sum(a.dev_time) + sum(a.test_time)),2)||'%' as devtimeper,"
			+" round(sum(a.test_time)*100 / (sum(a.dev_time) + sum(a.test_time)),2)||'%'as qatimeper "
			+" from demand_stat_result_finish a, demand_request b "
			+" where a.demand_id in ("+sSql_str+") and a.demand_id = b.demand_id  "
			+" group by a.demand_id, b.demand_title,b.qa_time";
		}
		else
		{
			sSql=" select a.demand_id,b.demand_title,to_char(b.qa_time,'YYYY-MM-DD') as closetime,round(max(a.dev_time),2) as devtime,round(max(a.test_time),2) as qatime,"
			+" round(max(a.dev_time)*100 / (max(a.dev_time) + max(a.test_time)),2)||'%' as devtimeper,"
			+" round(max(a.test_time)*100 / (max(a.dev_time) + max(a.test_time)),2)||'%'as qatimeper "
			+" from demand_stat_result_unfinish a, demand_request b "
			+" where a.demand_id in ("+sSql_str+") and a.demand_id = b.demand_id "
			+" group by a.demand_id, b.demand_title,b.qa_time "
			+" union "
			+" select a.demand_id,b.demand_title,to_char(b.qa_time,'YYYY-MM-DD') as closetime,round(max(a.dev_time),2) as devtime,round(max(a.test_time),2) as qatime,"
			+" round(max(a.dev_time)*100 / (max(a.dev_time) + max(a.test_time)),2)||'%' as devtimeper,"
			+" round(max(a.test_time)*100 / (max(a.dev_time) + max(a.test_time)),2)||'%'as qatimeper "
			+" from demand_stat_result_finish a, demand_request b "
			+" where a.demand_id in ("+sSql_str+") and a.demand_id = b.demand_id  "
			+" group by a.demand_id, b.demand_title,b.qa_time";
		}
		sSql += " order by demand_id";
		//System.out.print("\n 返回查询结果的sql：" +sSql + "\n");
		Vector ver = new Vector();
		DBConnection lib = new DBConnection();
		ver=lib.selectVector(sSql);
		return ver;
    }
	
	
	/**
     * 根据时间段，统计部门完成工作：需求(返回总需求数)
     */
	public String StatDemandSum (String sStartTime,String sEndTime,String sGroupType)
	{ 	
		String sSql="";
		String Count="";
		sSql="select count(*) as COUNT from "
			+"( select distinct(demand_id) from demand_request a, assignment b,group_op_info d,group_def e  "
			+" where a.demand_id=b.demand_id and a.status in (11,12,13) and b.closer_id = d.op_id and d.group_id=e.group_id";
		if(!sStartTime.equals("") && !sStartTime.equals(null))
		{
			sSql+=" and to_char(a.qa_time,'YYYYMMDDhh24miss')>='"+sStartTime+"'";
		}
		if(!sEndTime.equals("") && !sEndTime.equals(null))
		{
			sSql+=" and to_char(a.qa_time,'YYYYMMDDhh24miss')<='"+sEndTime+"'";
		}
		if(!sGroupType.equals("") && !sGroupType.equals(null))
		{
			sSql+=" and e.group_type in ("+ sGroupType +") ";
		}
		sSql += ")";
		//System.out.print("\n 返回查询结果的sql：" +sSql + "\n");
		Vector ver = new Vector();
		DBConnection lib = new DBConnection();
		ver=lib.selectVector(sSql);
		if(ver.size()>0)
		{
			HashMap hash=(HashMap) ver.get(0);
			Count = (String) hash.get("COUNT");
			return Count;
		}
		else
		{
			return "0";
		}
    }

	
	/**
     * 根据时间段，统计部门完成工作：需求（按照分组显示完成数量）
     */
	public Vector StatDemandGroupSum (String sStartTime,String sEndTime,String sGroupType)
	{ 	
		String sSql="";
		String Count="";
		/* 显示所有组的完成数量，包括完成数为0。  modify by liyf 20091104     start
		sSql="select group_name,group_id,count(*) as count from "
			+"(select distinct(demand_id),e.group_name as group_name ,e.group_id as group_id "
			+" from demand_request a,assignment b,group_op_info d,group_def e "
			+" where a.demand_id=b.demand_id and a.status in (11,12,13) and b.closer_id = d.op_id and d.group_id=e.group_id";
		if(!sStartTime.equals("") && !sStartTime.equals(null))
		{
			sSql+=" and to_char(a.qa_time,'YYYYMMDDhh24miss')>='"+sStartTime+"'";
		}
		if(!sEndTime.equals("") && !sEndTime.equals(null))
		{
			sSql+=" and to_char(a.qa_time,'YYYYMMDDhh24miss')<='"+sEndTime+"'";
		}
		sSql += ") group by group_name,group_id order by group_name ";
		*/
		sSql="select Y.group_name as group_name,Y.group_id as group_id,decode(sum(X.num),'',0,sum(X.num))as count from "
			+"(select distinct(demand_id),e.group_name as group_name ,e.group_id as group_id,1 as num "
			+" from demand_request a,assignment b,group_op_info d,group_def e "
			+" where a.demand_id=b.demand_id and a.status in (11,12,13) and b.closer_id = d.op_id and d.group_id=e.group_id";
		if(!sStartTime.equals("") && !sStartTime.equals(null))
		{
			sSql+=" and to_char(a.qa_time,'YYYYMMDDhh24miss')>='"+sStartTime+"'";
		}
		if(!sEndTime.equals("") && !sEndTime.equals(null))
		{
			sSql+=" and to_char(a.qa_time,'YYYYMMDDhh24miss')<='"+sEndTime+"'";
		}
		sSql += ") X, group_def Y where X.group_id(+) = Y.group_id ";
		if(!sGroupType.equals("") && !sGroupType.equals(null))
		{
			sSql+=" and Y.group_type in ("+ sGroupType +")";
		}
		sSql += " group by Y.group_name,Y.group_id order by Y.group_name ";
		
		//显示所有组的完成数量，包括完成数为0。  modify by liyf 20091104     end
		
		//System.out.print("\n 返回查询结果的sql：" +sSql + "\n");
		Vector ver = new Vector();
		DBConnection lib = new DBConnection();
		ver=lib.selectVector(sSql);
		return ver;
    }
	
	
	/**
     * 根据时间段，统计部门完成工作：需求（按照人员显示完成数量）
     */
	public Vector StatDemandOpSum (String sStartTime,String sEndTime,String sGroupId)
	{ 	
		String sSql="";
		String Count="";
		/* 显示组内所有人员的完成数量，包括完成数为0。  modify by liyf 20091110     start
		sSql="select op_id,op_name,group_name,group_id,count(*) as count from "
			+"(select distinct(demand_id),e.group_name as group_name,e.group_id as group_id,f.op_id as op_id,f.op_name as op_name "
			+" from demand_request a,assignment b,group_op_info d,group_def e,op_login f "
			+" where a.demand_id=b.demand_id  and d.op_id=f.op_id and a.status in (11,12,13)  and b.closer_id = d.op_id  "
			+"and d.group_id=e.group_id";
		if(!sStartTime.equals("") && !sStartTime.equals(null))
		{
			sSql+=" and to_char(a.qa_time,'YYYYMMDDhh24miss')>='"+sStartTime+"'";
		}
		if(!sEndTime.equals("") && !sEndTime.equals(null))
		{
			sSql+=" and to_char(a.qa_time,'YYYYMMDDhh24miss')<='"+sEndTime+"'";
		}
		if(!sGroupId.equals("") && !sGroupId.equals(null))
		{
			sSql+=" and d.group_id="+ sGroupId;
		}
		sSql += ") group by op_id, op_name,group_name,group_id order by op_name desc ";
		
		*/
		
		sSql=" select Y.op_id as op_id,O.op_name as op_name,Z.group_id as group_id,Z.group_name as group_name,decode(X.count,'',0,X.count) as count "
			+" from (select op_id, group_id, sum(num) as count from (select distinct (demand_id), d.group_id as group_id, d.op_id as op_id, 1 as num "
			+" from demand_request a, assignment b, group_op_info d "
			+" where a.demand_id = b.demand_id and a.status in (11, 12, 13) and b.closer_id = d.op_id";
		if(!sStartTime.equals("") && !sStartTime.equals(null))
		{
			sSql+=" and to_char(a.qa_time,'YYYYMMDDhh24miss')>='"+sStartTime+"'";
		}
		if(!sEndTime.equals("") && !sEndTime.equals(null))
		{
			sSql+=" and to_char(a.qa_time,'YYYYMMDDhh24miss')<='"+sEndTime+"'";
		}
		if(!sGroupId.equals("") && !sGroupId.equals(null))
		{
			sSql+=" and d.group_id="+ sGroupId;
		}
		sSql += ") group by op_id, group_id) X right join group_op_info Y on X.op_id = Y.op_id, group_def Z, op_login O where 1=1 ";		
		if(!sGroupId.equals("") && !sGroupId.equals(null))
		{
			sSql+=" and Y.group_id="+ sGroupId;
		}
		sSql +=" and Y.op_id = O.op_id and Y.group_id = Z.group_id and O.op_stat=1 order by op_name desc";
		
		//modify by liyf 20091110     end
		
		//System.out.print("\n 返回查询结果的sql：" +sSql + "\n");
		Vector ver = new Vector();
		DBConnection lib = new DBConnection();
		ver=lib.selectVector(sSql);
		return ver;
    }
	
	/**
     * 根据时间段，统计部门完成工作：需求（按照个人显示完成情况）
     */
	public Vector StatDemandDetail (String sStartTime,String sEndTime,String sGroupId)
	{ 	
		String sSql="";
		String Count="";
		sSql="select distinct(a.demand_id) as demand_id,a.demand_title as demand_title,f.version,h.name,to_char(a.qa_time,'yyyy-mm-dd') as qa_time,e.op_name as op_name"
			+" from demand_request a,assignment b,group_op_info d,op_login e,product_version f,project g,province h "
			+" where a.demand_id=b.demand_id  and a.status in (11,12,13) and b.closer_id = d.op_id "
			+" and d.op_id=e.op_id and a.open_version = f.version_id and a.project_code = g.proj_code  and g.area_id = h.id";
		if(!sStartTime.equals("") && !sStartTime.equals(null))
		{
			sSql+=" and to_char(a.qa_time,'YYYYMMDDhh24miss')>='"+sStartTime+"'";
		}
		if(!sEndTime.equals("") && !sEndTime.equals(null))
		{
			sSql+=" and to_char(a.qa_time,'YYYYMMDDhh24miss')<='"+sEndTime+"'";
		}
		if(!sGroupId.equals("") && !sGroupId.equals(null))
		{
			sSql+=" and d.group_id="+ sGroupId;
		}
		sSql+=" order by op_name desc";
		//System.out.print("\n 返回查询结果的sql：" +sSql + "\n");
		Vector ver = new Vector();
		DBConnection lib = new DBConnection();
		ver=lib.selectVector(sSql);
		return ver;
    }
	
	
	/**
     * 根据时间段，统计部门完成工作：BUG(按照小组统计产生bug数)
     */
	public Vector StatSlips (String sStartTime,String sEndTime,String sGroupType)
	{ 	
		String sSql="";
		/*显示所有组完成的bug数量，包括完成数为0。  modify by liyf 20091110     start
		sSql=" select c.group_name,c.group_id,count(*) as count "
			+" from slips a, group_op_info b,group_def c "
			+" where a.opener_id = b.op_id and b.group_id=c.group_id ";
		if(!sStartTime.equals("") && !sStartTime.equals(null))
		{
			sSql+=" and to_char(a.opentime,'YYYYMMDDhh24miss')>='"+sStartTime+"'";
		}
		if(!sEndTime.equals("") && !sEndTime.equals(null))
		{
			sSql+=" and to_char(a.opentime,'YYYYMMDDhh24miss')<='"+sEndTime+"'";
		}
		sSql += " group by c.group_name,c.group_id order by c.group_name";
		
		*/
		
		sSql=" select Y.group_id as group_id,Y.group_name as group_name,decode(X.count,'',0,X.count) as count "
			+" from ( select c.group_name, c.group_id, count(*) as count from slips a, group_op_info b, group_def c "
			+" where a.opener_id = b.op_id and b.group_id = c.group_id";
		if(!sStartTime.equals("") && !sStartTime.equals(null))
		{
			sSql+=" and to_char(a.opentime,'YYYYMMDDhh24miss')>='"+sStartTime+"'";
		}
		if(!sEndTime.equals("") && !sEndTime.equals(null))
		{
			sSql+=" and to_char(a.opentime,'YYYYMMDDhh24miss')<='"+sEndTime+"'";
		}
		sSql += " group by c.group_name, c.group_id ) X right join group_def Y on X.group_id=Y.group_id where 1=1 ";
		if(!sGroupType.equals("") && !sGroupType.equals(null))
		{
			sSql+=" and Y.group_type in ("+ sGroupType +")";
		}			
			
		sSql +=" order by Y.group_name";		
		//modify by liyf 20091110  end 
		
		//System.out.print("\n 返回查询结果的sql：" +sSql + "\n");
		Vector ver = new Vector();
		DBConnection lib = new DBConnection();
		ver=lib.selectVector(sSql);
		return ver;
    }
	
	
	/**
     * 根据时间段，统计部门完成工作：BUG(按照小组人员统计产生bug数)
     */
	public Vector StatSlipsOpSum (String sStartTime,String sEndTime,String sGroupId)
	{ 	
		String sSql="";
		/*显示所有组完成的bug数量，包括完成数为0。  modify by liyf 20091110     start
		sSql="select b.op_id,d.op_name,c.group_name,c.group_id,count(*) as count"
			+" from slips a,group_op_info b, group_def c,op_login d "
			+" where a.opener_id = b.op_id and b.group_id=c.group_id and b.op_id= d.op_id ";
		if(!sStartTime.equals("") && !sStartTime.equals(null))
		{
			sSql+=" and to_char(a.opentime,'YYYYMMDDhh24miss')>='"+sStartTime+"'";
		}
		if(!sEndTime.equals("") && !sEndTime.equals(null))
		{
			sSql+=" and to_char(a.opentime,'YYYYMMDDhh24miss')<='"+sEndTime+"'";
		}
		if(!sGroupId.equals("") && !sGroupId.equals(null))
		{
			sSql+=" and b.group_id="+ sGroupId;
		}
		sSql += " group by b.op_id,d.op_name,c.group_name,c.group_id order by d.op_name desc";
		
		*/
		sSql=" select Y.op_id as op_id, Z.op_name as op_name, Y.group_id as group_id, O.group_name as group_name, decode(X.count, '', 0, X.count) as count "
			+" from (select b.op_id, b.group_id, count(*) as count from slips a, group_op_info b where a.opener_id = b.op_id ";
		if(!sStartTime.equals("") && !sStartTime.equals(null))
		{
			sSql+=" and to_char(a.opentime,'YYYYMMDDhh24miss')>='"+sStartTime+"'";
		}
		if(!sEndTime.equals("") && !sEndTime.equals(null))
		{
			sSql+=" and to_char(a.opentime,'YYYYMMDDhh24miss')<='"+sEndTime+"'";
		}
		if(!sGroupId.equals("") && !sGroupId.equals(null))
		{
			sSql+=" and b.group_id="+ sGroupId;
		}
		sSql += " group by b.op_id, b.group_id) X  right join group_op_info Y on X.op_id = Y.op_id, op_login Z, group_def O "
			  +" where 1=1 ";		
		if(!sGroupId.equals("") && !sGroupId.equals(null))
		{
			sSql+=" and Y.group_id="+ sGroupId;
		}		
		sSql +=" and Y.op_id = Z.op_id and O.group_id = Y.group_id and Z.op_stat=1 order by Z.op_name";
		//modify by liyf 20091110    end 
		
		//System.out.print("\n 返回查询结果的sql：" +sSql + "\n");
		Vector ver = new Vector();
		DBConnection lib = new DBConnection();
		ver=lib.selectVector(sSql);
		return ver;
    }
	
	/**
     * 根据时间段，统计部门完成工作：BUG(按组划分，显示明细)
     */
	public Vector StatSlipsDetail (String sStartTime,String sEndTime,String sGroupId)
	{ 	
		String sSql="";
		sSql=" select a.slip_id,a.title,a.opener_id,c.op_name,to_char(a.opentime,'yyyy-mm-dd') as opentime "
			+" from slips a, group_op_info b,op_login c "
			+" where a.opener_id = b.op_id and b.op_id=c.op_id";
		if(!sStartTime.equals("") && !sStartTime.equals(null))
		{
			sSql+=" and to_char(a.opentime,'YYYYMMDDhh24miss')>='"+sStartTime+"'";
		}
		if(!sEndTime.equals("") && !sEndTime.equals(null))
		{
			sSql+=" and to_char(a.opentime,'YYYYMMDDhh24miss')<='"+sEndTime+"'";
		}
		if(!sGroupId.equals("") && !sGroupId.equals(null))
		{
			sSql+=" and b.group_id="+ sGroupId;
		}
		sSql += " order by c.op_name,a.opentime";
		//System.out.print("\n 返回查询结果的sql：" +sSql + "\n");
		Vector ver = new Vector();
		DBConnection lib = new DBConnection();
		ver=lib.selectVector(sSql);
		return ver;
    }
	
	
	/**
     * 根据时间段，统计部门完成工作：故障(统计总数)
     */
	public String StatProjectRequestSum (String sStartTime,String sEndTime,String sGroupType)
	{ 	
		String sSql="";
		String Count="";
		sSql="select count(*) as COUNT "
			+" from (select distinct(a.slip_id)  from project_request_memo a, group_op_info b, group_def c,project_request d"
			+" where a.from_id = b.op_id and a.slip_id=d.request_id and b.group_id = c.group_id and a.memo_type in (5, 11)";
		if(!sStartTime.equals("") && !sStartTime.equals(null))
		{
			sSql+=" and to_char(a.memo_time,'YYYYMMDDhh24miss')>='"+sStartTime+"'";
		}
		if(!sEndTime.equals("") && !sEndTime.equals(null))
		{
			sSql+=" and to_char(a.memo_time,'YYYYMMDDhh24miss')<='"+sEndTime+"'";
		}
		if(!sGroupType.equals("") && !sGroupType.equals(null))
		{
			sSql+=" and c.group_type in ("+ sGroupType +") ";
		}
		sSql += ")";
		
		//System.out.print("\n 返回查询结果的sql：" +sSql + "\n");
		Vector ver = new Vector();
		DBConnection lib = new DBConnection();
		ver=lib.selectVector(sSql);
		if(ver.size()>0)
		{
			HashMap hash=(HashMap) ver.get(0);
			Count = (String) hash.get("COUNT");
			return Count;
		}
		else
		{
			return "0";
		}
    }
	
	
	/**
     * 根据时间段，统计部门完成工作：故障(按照组统计完成总数)
     */
	public Vector StatProjectRequestGroupSum (String sStartTime,String sEndTime,String sGroupType)
	{ 	
		String sSql="";
		String Count="";
		/*显示所有组完成的故障数量，包括完成数为0。  modify by liyf 20091110     start
		sSql=" select c.group_name,c.group_id,count(*) as count "
			+" from project_request_memo a, group_op_info b, group_def c,project_request d "
			+" where a.from_id = b.op_id and a.slip_id=d.request_id and b.group_id = c.group_id and a.memo_type in (5, 11)";
		if(!sStartTime.equals("") && !sStartTime.equals(null))
		{
			sSql+=" and to_char(a.memo_time,'YYYYMMDDhh24miss')>='"+sStartTime+"'";
		}
		if(!sEndTime.equals("") && !sEndTime.equals(null))
		{
			sSql+=" and to_char(a.memo_time,'YYYYMMDDhh24miss')<='"+sEndTime+"'";
		}
		sSql += " group by c.group_name,c.group_id order by c.group_name";
		*/
		sSql=" select Y.group_id as group_id,Y.group_name as group_name,decode(X.count,'',0,X.count) as count "
			+" from ( select b.group_id, count(*) as count from project_request_memo a, group_op_info  b, project_request d "
			+" where a.from_id = b.op_id and a.slip_id = d.request_id and a.memo_type in (5, 11)";
		if(!sStartTime.equals("") && !sStartTime.equals(null))
		{
			sSql+=" and to_char(a.memo_time,'YYYYMMDDhh24miss')>='"+sStartTime+"'";
		}
		if(!sEndTime.equals("") && !sEndTime.equals(null))
		{
			sSql+=" and to_char(a.memo_time,'YYYYMMDDhh24miss')<='"+sEndTime+"'";
		}
		sSql += " group by b.group_id ) X right join group_def Y on X.group_id = Y.group_id  where 1=1 ";
		if(!sGroupType.equals("") && !sGroupType.equals(null))
		{
			sSql+=" and Y.group_type in ("+ sGroupType+")";
		}
		sSql += " order by Y.group_name";		
		
		//modify by liyf 20091110    end 
		
		//System.out.print("\n 返回查询结果的sql：" +sSql + "\n");
		Vector ver = new Vector();
		DBConnection lib = new DBConnection();
		ver=lib.selectVector(sSql);
		return ver;
    }
	
	
	/**
     * 根据时间段，统计部门完成工作：故障(按照组内人员统计完成总数)
     */
	public Vector StatProjectRequestOpSum (String sStartTime,String sEndTime,String sGroupId)
	{ 	
		String sSql="";
		String Count="";
		/*显示所有组完成的故障数量，包括完成数为0。  modify by liyf 20091110     start
		sSql=" select b.op_id,e.op_name,c.group_name,c.group_id,count(*) as count "
			+" from project_request_memo a, group_op_info b, group_def c,project_request d,op_login e "
			+" where a.from_id = b.op_id  and a.slip_id=d.request_id and b.group_id = c.group_id "
			+" and b.op_id = e.op_id and a.memo_type in (5, 11)";
		if(!sStartTime.equals("") && !sStartTime.equals(null))
		{
			sSql+=" and to_char(a.memo_time,'YYYYMMDDhh24miss')>='"+sStartTime+"'";
		}
		if(!sEndTime.equals("") && !sEndTime.equals(null))
		{
			sSql+=" and to_char(a.memo_time,'YYYYMMDDhh24miss')<='"+sEndTime+"'";
		}
		if(!sGroupId.equals("") && !sGroupId.equals(null))
		{
			sSql+=" and b.group_id="+ sGroupId;
		}
		sSql += " group by b.op_id,e.op_name,c.group_name,c.group_id order by e.op_name desc";
		*/
		sSql=" select Y.op_id as op_id , Z.op_name as op_name, Y.group_id as group_id ,O.group_name as group_name , decode(X.count,'',0,X.count) as count "
			+" from(  select b.op_id, b.group_id, count(*) as count from project_request_memo a, group_op_info b, project_request d"
			+" where a.from_id = b.op_id and a.slip_id = d.request_id and a.memo_type in (5, 11)";
		if(!sStartTime.equals("") && !sStartTime.equals(null))
		{
			sSql+=" and to_char(a.memo_time,'YYYYMMDDhh24miss')>='"+sStartTime+"'";
		}
		if(!sEndTime.equals("") && !sEndTime.equals(null))
		{
			sSql+=" and to_char(a.memo_time,'YYYYMMDDhh24miss')<='"+sEndTime+"'";
		}
		if(!sGroupId.equals("") && !sGroupId.equals(null))
		{
			sSql+=" and b.group_id="+ sGroupId;
		}
		sSql += " group by b.op_id, b.group_id)X right join group_op_info Y on X.op_id=Y.op_id, op_login Z ,group_def O "
			 + " where 1=1 ";
		
		if(!sGroupId.equals("") && !sGroupId.equals(null))
		{
			sSql+=" and Y.group_id="+ sGroupId;
		}
		
		sSql += "and Y.group_id=O.group_id and Z.op_stat=1 and Y.op_id=Z.op_id order by Z.op_name desc";
		//modify by liyf 20091110    end 
		
		//System.out.print("\n 返回查询结果的sql：" +sSql + "\n");
		Vector ver = new Vector();
		DBConnection lib = new DBConnection();
		ver=lib.selectVector(sSql);
		return ver;
    }
	
	
	/**
     * 根据时间段，统计部门完成工作：故障(按组查询明细信息)
     */
	public Vector StatProjectRequestDetail (String sStartTime,String sEndTime,String sGroupId)
	{ 	
		String sSql="";
		String Count="";
		sSql=" select distinct(d.request_id) as request_id,d.rep_title,to_char(a.memo_time,'yyyy-mm-dd') as memo_time,c.op_name,e.type_name "
			+" from project_request_memo a, group_op_info b, op_login c,project_request d,project_request_memo_type e  "
			+" where a.from_id = b.op_id  and a.slip_id=d.request_id and b.op_id =c.op_id and a.memo_type=e.type_id and a.memo_type in (5, 11)";
		if(!sStartTime.equals("") && !sStartTime.equals(null))
		{
			sSql+=" and to_char(a.memo_time,'YYYYMMDDhh24miss')>='"+sStartTime+"'";
		}
		if(!sEndTime.equals("") && !sEndTime.equals(null))
		{
			sSql+=" and to_char(a.memo_time,'YYYYMMDDhh24miss')<='"+sEndTime+"'";
		}
		if(!sGroupId.equals("") && !sGroupId.equals(null))
		{
			sSql+=" and b.group_id="+ sGroupId;
		}
		sSql += " order by c.op_name,memo_time";
		
		//System.out.print("\n 返回查询结果的sql：" +sSql + "\n");
		Vector ver = new Vector();
		DBConnection lib = new DBConnection();
		ver=lib.selectVector(sSql);
		return ver;
    }
	
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