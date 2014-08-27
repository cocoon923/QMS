package dbOperation;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.sql.CallableStatement;

import java.util.*;

import java.net.URL;
import java.io.*;

import org.omg.CORBA.portable.InputStream;

import dbOperation.*;


public class Stat_Dev {
	/**
     * 根据时间段，统计部门完成工作：需求(返回总需求数)
     */
	public String StatDemandSum (String sStartTime,String sEndTime,String sStatOpId,String sStatGroupId)
	{ 	
		String sSql="";
		String Count="";
		sSql=" select count(*) as COUNT from (select distinct( h.demand_id) "
			+" from qcs.demand_request h,qcs.assignment i,qcs.op_define_group j,qcs.product_version k "
			+" where h.demand_id in (select demandid from (select fun_isCommitDemand(demandid) as value,demandid "
			+" from (select distinct(dependid) as demandid from qcs.assignment "
			+" where task_id in (select task_id from (select distinct(a.task_id) as task_id,min(a.memo_time) as memo_time  "
			+" from qcs.assignment_memo a,qcs.op_define_group b where a.memo_type = 2 and a.from_id=b.member_id  ";
		if(!sStatOpId.equals("") && !sStatOpId.equals(null))
		{
			sSql+=" and b.op_id=" + sStatOpId;
		}
		if(!sStatGroupId.equals("") && !sStatGroupId.equals(null))
		{
			sSql+=" and b.group_id in (" +sStatGroupId+ ")";
		}
		sSql += " group by task_id )  where  1=1  ";
		if(!sStartTime.equals("") && !sStartTime.equals(null))
		{
			sSql+=" and to_char(memo_time,'YYYYMMDDhh24miss')>='"+sStartTime+"'";
		}
		if(!sEndTime.equals("") && !sEndTime.equals(null))
		{
			sSql+=" and to_char(memo_time,'YYYYMMDDhh24miss')<='"+sEndTime+"'";
		}
		sSql += " ))) where value=1) and  h.demand_id=i.dependid and i.accepter_id = j.member_id "
			+"and h.open_version = k.version_id ";
		if(!sStatOpId.equals("") && !sStatOpId.equals(null))
		{
			sSql+=" and j.op_id=" + sStatOpId;
		}
		if(!sStatGroupId.equals("") && !sStatGroupId.equals(null))
		{
			sSql+=" and j.group_id in (" +sStatGroupId+ ")";
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
	public Vector StatDemandGroupSum (String sStartTime,String sEndTime,String sStatOpId,String sStatGroupId)
	{ 	
		String sSql="";
		sSql=" select group_name,group_id,count(*) as count from (select distinct( h.demand_id),h.demand_title,j.group_name,k.version,j.group_id"
			+" from qcs.demand_request h,qcs.assignment i,qcs.op_define_group j,qcs.product_version k "
			+" where h.demand_id in (select demandid from (select fun_isCommitDemand(demandid) as value,demandid "
			+" from (select distinct(dependid) as demandid from qcs.assignment "
			+" where task_id in (select task_id from (select distinct(a.task_id) as task_id,min(a.memo_time) as memo_time  "
			+" from qcs.assignment_memo a,qcs.op_define_group b where a.memo_type = 2 and a.from_id=b.member_id  ";
		if(!sStatOpId.equals("") && !sStatOpId.equals(null))
		{
			sSql+=" and b.op_id=" + sStatOpId;
		}
		if(!sStatGroupId.equals("") && !sStatGroupId.equals(null))
		{
			sSql+=" and b.group_id in (" +sStatGroupId+ ")";
		}
		sSql += " group by task_id )  where  1=1  ";
		if(!sStartTime.equals("") && !sStartTime.equals(null))
		{
			sSql+=" and to_char(memo_time,'YYYYMMDDhh24miss')>='"+sStartTime+"'";
		}
		if(!sEndTime.equals("") && !sEndTime.equals(null))
		{
			sSql+=" and to_char(memo_time,'YYYYMMDDhh24miss')<='"+sEndTime+"'";
		}
		sSql += " ))) where value=1) and  h.demand_id=i.dependid and i.accepter_id = j.member_id "
			+"and h.open_version = k.version_id ";
		if(!sStatOpId.equals("") && !sStatOpId.equals(null))
		{
			sSql+=" and j.op_id=" + sStatOpId;
		}
		if(!sStatGroupId.equals("") && !sStatGroupId.equals(null))
		{
			sSql+=" and j.group_id in (" +sStatGroupId+ ")";
		}
		sSql += ") group by group_name,group_id order by group_name";
		//System.out.print("\n 返回查询结果的sql：" +sSql + "\n");
		Vector ver = new Vector();
		DBConnection lib = new DBConnection();
		ver=lib.selectVector(sSql);
		return ver;
    }
	
	
	/**
     * 根据时间段，统计部门完成工作：需求（按照组显示需求明细）
     */
	public Vector StatDemandDetail (String sStartTime,String sEndTime,String sStatOpId,String sStatGroupId,String sGroupId)
	{ 	
		String sSql="";
		sSql=" select distinct( h.demand_id),h.demand_title,j.group_name,k.version"
			+" from qcs.demand_request h,qcs.assignment i,qcs.op_define_group j,qcs.product_version k "
			+" where h.demand_id in (select demandid from (select fun_isCommitDemand(demandid) as value,demandid "
			+" from (select distinct(dependid) as demandid from qcs.assignment "
			+" where task_id in (select task_id from (select distinct(a.task_id) as task_id,min(a.memo_time) as memo_time  "
			+" from qcs.assignment_memo a,qcs.op_define_group b where a.memo_type = 2 and a.from_id=b.member_id  ";
		if(!sStatOpId.equals("") && !sStatOpId.equals(null))
		{
			sSql+=" and b.op_id=" + sStatOpId;
		}
		if(!sStatGroupId.equals("") && !sStatGroupId.equals(null))
		{
			sSql+=" and b.group_id in (" +sStatGroupId+ ")";
		}
		sSql += " group by task_id )  where  1=1  ";
		if(!sStartTime.equals("") && !sStartTime.equals(null))
		{
			sSql+=" and to_char(memo_time,'YYYYMMDDhh24miss')>='"+sStartTime+"'";
		}
		if(!sEndTime.equals("") && !sEndTime.equals(null))
		{
			sSql+=" and to_char(memo_time,'YYYYMMDDhh24miss')<='"+sEndTime+"'";
		}
		sSql += " ))) where value=1) and  h.demand_id=i.dependid and i.accepter_id = j.member_id "
			+"and h.open_version = k.version_id ";
		if(!sStatOpId.equals("") && !sStatOpId.equals(null))
		{
			sSql+=" and j.op_id=" + sStatOpId;
		}
		if(!sStatGroupId.equals("") && !sStatGroupId.equals(null))
		{
			sSql+=" and j.group_id in (" +sStatGroupId+ ")";
		}
		if(!sGroupId.equals("") && !sGroupId.equals(null))
		{
			sSql+=" and j.group_id = "+sGroupId;
		}
		sSql += " order by version ";
		//System.out.print("\n 返回查询结果的sql：" +sSql + "\n");
		Vector ver = new Vector();
		DBConnection lib = new DBConnection();
		ver=lib.selectVector(sSql);
		return ver;
    }
	
	/**
     * 根据时间段，统计部门完成工作：任务单（按照分组显示完成数量）
     */
	public Vector StatAssignmentGroupSum (String sStartTime,String sEndTime,String sStatOpId,String sStatGroupId)
	{ 	
		String sSql="";
		sSql=" select group_name,group_id,count(*) as count "
			+" from ( select a.task_id, max(a.memo_time), c.op_name,b.group_name,c.op_id,b.group_id  "
			+" from qcs.assignment_memo a, qcs.op_define_group b, qcs.op_login c "
			+" where a.memo_type = 2 and a.from_id = b.member_id   and a.from_id = c.op_id ";
		if(!sStatOpId.equals("") && !sStatOpId.equals(null))
		{
			sSql+=" and b.op_id=" + sStatOpId;
		}
		if(!sStatGroupId.equals("") && !sStatGroupId.equals(null))
		{
			sSql+=" and b.group_id in (" +sStatGroupId+ ")";
		}		
		if(!sStartTime.equals("") && !sStartTime.equals(null))
		{
			sSql+=" and to_char(a.memo_time,'YYYYMMDDhh24miss')>='"+sStartTime+"'";
		}
		if(!sEndTime.equals("") && !sEndTime.equals(null))
		{
			sSql+=" and to_char(a.memo_time,'YYYYMMDDhh24miss')<='"+sEndTime+"'";
		}
		sSql += " group by a.task_id, c.op_name ,b.group_name,c.op_id,b.group_id ) group by group_name,group_id ";
		sSql += " order by group_name";
		//System.out.print("\n 返回查询结果的sql：" +sSql + "\n");
		Vector ver = new Vector();
		DBConnection lib = new DBConnection();
		ver=lib.selectVector(sSql);
		return ver;
    }
	
	
	/**
     * 根据时间段，统计部门完成工作：任务单（按照组显示需求数量）
     */
	public Vector StatAssignmentOpSum (String sStartTime,String sEndTime,String sStatOpId,String sStatGroupId,String sGroupId)
	{ 	
		String sSql="";
		sSql=" select op_name,op_id,count(*) as count "
			+" from ( select a.task_id,d.title , max(a.memo_time), c.op_name,b.group_name,c.op_id,d.task_desc "
			+" from qcs.assignment_memo a, qcs.op_define_group b, qcs.op_login c,qcs.assignment d "
			+" where a.memo_type = 2   and a.from_id = b.member_id   and a.from_id = c.op_id  "
			+" and a.task_id = d.task_id  ";
		if(!sStatOpId.equals("") && !sStatOpId.equals(null))
		{
			sSql+=" and b.op_id=" + sStatOpId;
		}
		if(!sStatGroupId.equals("") && !sStatGroupId.equals(null))
		{
			sSql+=" and b.group_id in (" +sStatGroupId+ ")";
		}	
		if(!sGroupId.equals("") && !sGroupId.equals(null))
		{
			sSql+=" and b.group_id = " +sGroupId ;
		}	
		if(!sStartTime.equals("") && !sStartTime.equals(null))
		{
			sSql+=" and to_char(a.memo_time,'YYYYMMDDhh24miss')>='"+sStartTime+"'";
		}
		if(!sEndTime.equals("") && !sEndTime.equals(null))
		{
			sSql+=" and to_char(a.memo_time,'YYYYMMDDhh24miss')<='"+sEndTime+"'";
		}
		sSql += "  group by a.task_id, c.op_name ,b.group_name,d.title,d.task_desc,c.op_id order by c.op_name ) group by op_name,op_id";
		sSql += " order by op_name";
		//System.out.print("\n 返回查询结果的sql：" +sSql + "\n");
		Vector ver = new Vector();
		DBConnection lib = new DBConnection();
		ver=lib.selectVector(sSql);
		return ver;
    }
	
	/**
     * 根据时间段，统计部门完成工作：任务单（按照组内人员显示明细）
     */
	public Vector StatAssignmentDetail (String sStartTime,String sEndTime,String sStatOpId,String sStatGroupId,String sGroupId)
	{ 	
		String sSql="";
		sSql="  select a.task_id,d.title , max(a.memo_time) as memo_time, c.op_name,b.group_name,c.op_id,d.task_desc  "
			+" from qcs.assignment_memo a, qcs.op_define_group b, qcs.op_login c,qcs.assignment d "
			+" where a.memo_type = 2   and a.from_id = b.member_id   and a.from_id = c.op_id  "
			+" and a.task_id = d.task_id ";
		if(!sStatOpId.equals("") && !sStatOpId.equals(null))
		{
			sSql+=" and b.op_id=" + sStatOpId;
		}
		if(!sStatGroupId.equals("") && !sStatGroupId.equals(null))
		{
			sSql+=" and b.group_id in (" +sStatGroupId+ ")";
		}	
		if(!sGroupId.equals("") && !sGroupId.equals(null))
		{
			sSql+=" and b.group_id = " +sGroupId ;
		}	
		if(!sStartTime.equals("") && !sStartTime.equals(null))
		{
			sSql+=" and to_char(a.memo_time,'YYYYMMDDhh24miss')>='"+sStartTime+"'";
		}
		if(!sEndTime.equals("") && !sEndTime.equals(null))
		{
			sSql+=" and to_char(a.memo_time,'YYYYMMDDhh24miss')<='"+sEndTime+"'";
		}
		sSql += " group by a.task_id, c.op_name ,b.group_name,d.title,d.task_desc,c.op_id order by c.op_name ";
		//System.out.print("\n 返回查询结果的sql：" +sSql + "\n");
		Vector ver = new Vector();
		DBConnection lib = new DBConnection();
		ver=lib.selectVector(sSql);
		return ver;
    }
	
	
	/**
     * 根据时间段，统计部门完成工作：bug单（按照分组显示完成数量），统计开发提交的bug数据，一个bug单多次回复不重复统计
     */
	public Vector StatSlipsGroupSum (String sStartTime,String sEndTime,String sStatOpId,String sStatGroupId)
	{ 	
		String sSql="";
		sSql=" select group_name,group_id,count(*) as count "
			+" from (select distinct(a.slip_id), d.title,c.op_name, c.op_id, b.group_name,b.group_id  "
			+" from qcs.slips_memo a, qcs.op_define_group b, qcs.op_login c,qcs.slips d "
			+" where a.memo_type = 2  and a.from_id = b.member_id   and b.member_id = c.op_id  "
			+" and a.slip_id = d.slip_id ";
		if(!sStatOpId.equals("") && !sStatOpId.equals(null))
		{
			sSql+=" and b.op_id=" + sStatOpId;
		}
		if(!sStatGroupId.equals("") && !sStatGroupId.equals(null))
		{
			sSql+=" and b.group_id in (" +sStatGroupId+ ")";
		}		
		if(!sStartTime.equals("") && !sStartTime.equals(null))
		{
			sSql+=" and to_char(a.memo_time,'YYYYMMDDhh24miss')>='"+sStartTime+"'";
		}
		if(!sEndTime.equals("") && !sEndTime.equals(null))
		{
			sSql+=" and to_char(a.memo_time,'YYYYMMDDhh24miss')<='"+sEndTime+"'";
		}
		sSql += " ) group by group_name,group_id order by group_name ";
		//System.out.print("\n 返回查询结果的sql：" +sSql + "\n");
		Vector ver = new Vector();
		DBConnection lib = new DBConnection();
		ver=lib.selectVector(sSql);
		return ver;
    }
	
	
	/**
     * 根据时间段，统计部门完成工作：bug单（按照组内人员统计数量）
     */
	public Vector StatSlipsOpSum (String sStartTime,String sEndTime,String sStatOpId,String sStatGroupId,String sGroupId)
	{ 	
		String sSql="";
		sSql=" select op_id,op_name,count(*) as count"
			+" from (select distinct(a.slip_id), d.title,c.op_name, c.op_id, b.group_name  "
			+" from qcs.slips_memo a, qcs.op_define_group b, qcs.op_login c,qcs.slips d "
			+" where a.memo_type = 2  and a.from_id = b.member_id   and b.member_id = c.op_id  "
			+" and a.slip_id = d.slip_id ";
		if(!sStatOpId.equals("") && !sStatOpId.equals(null))
		{
			sSql+=" and b.op_id=" + sStatOpId;
		}
		if(!sStatGroupId.equals("") && !sStatGroupId.equals(null))
		{
			sSql+=" and b.group_id in (" +sStatGroupId+ ")";
		}	
		if(!sGroupId.equals("") && !sGroupId.equals(null))
		{
			sSql+=" and b.group_id = " +sGroupId ;
		}	
		if(!sStartTime.equals("") && !sStartTime.equals(null))
		{
			sSql+=" and to_char(a.memo_time,'YYYYMMDDhh24miss')>='"+sStartTime+"'";
		}
		if(!sEndTime.equals("") && !sEndTime.equals(null))
		{
			sSql+=" and to_char(a.memo_time,'YYYYMMDDhh24miss')<='"+sEndTime+"'";
		}
		sSql += "  ) group by op_id,op_name order by op_name ";
		//System.out.print("\n 返回查询结果的sql：" +sSql + "\n");
		Vector ver = new Vector();
		DBConnection lib = new DBConnection();
		ver=lib.selectVector(sSql);
		return ver;
    }
	
	/**
     * 根据时间段，统计部门完成工作：bug单（按照组内人员显示明细,含bug往返次数）
     */
	public Vector StatSlipsDetail (String sStartTime,String sEndTime,String sStatOpId,String sStatGroupId,String sGroupId)
	{ 	
		String sSql="";
		sSql=" select distinct (a.slip_id) as slip_id,d.title,c.op_name,c.op_id,b.group_name,	"
			+" (select count(*) from qcs.slips_memo where slip_id = a.slip_id and memo_type = 1) as num  "
			+" from qcs.slips_memo a, qcs.op_define_group b, qcs.op_login c, qcs.slips d "
			+" where a.memo_type = 2 and a.from_id = b.member_id   and b.member_id = c.op_id   "
			+" and a.slip_id = d.slip_id ";
		if(!sStatOpId.equals("") && !sStatOpId.equals(null))
		{
			sSql+=" and b.op_id=" + sStatOpId;
		}
		if(!sStatGroupId.equals("") && !sStatGroupId.equals(null))
		{
			sSql+=" and b.group_id in (" +sStatGroupId+ ")";
		}	
		if(!sGroupId.equals("") && !sGroupId.equals(null))
		{
			sSql+=" and b.group_id = " +sGroupId ;
		}	
		if(!sStartTime.equals("") && !sStartTime.equals(null))
		{
			sSql+=" and to_char(a.memo_time,'YYYYMMDDhh24miss')>='"+sStartTime+"'";
		}
		if(!sEndTime.equals("") && !sEndTime.equals(null))
		{
			sSql+=" and to_char(a.memo_time,'YYYYMMDDhh24miss')<='"+sEndTime+"'";
		}
		sSql += " order by op_name  ";
		//System.out.print("\n 返回查询结果的sql：" +sSql + "\n");
		Vector ver = new Vector();
		DBConnection lib = new DBConnection();
		ver=lib.selectVector(sSql);
		return ver;
    }
	
	
	/**
     * 根据时间段，统计部门完成工作：回退单（按照分组显示完成数量）
     */
	public Vector StatRevertGroupSum (String sStartTime,String sEndTime,String sStatOpId,String sStatGroupId)
	{ 	
		String sSql="";
		sSql=" select group_name,group_id,count(*) as count "
			+" from (select distinct(a.request_id),d.rep_title,a.from_id,c.op_name,b.group_name,b.group_id  "
			+" from qcs.revert_request_memo a,qcs.op_define_group b, qcs.op_login c,qcs.revert_request d "
			+" where a.memo_type = 4  and a.from_id = b.member_id   and a.from_id = c.op_id  and a.request_id = d.request_id ";
		if(!sStatOpId.equals("") && !sStatOpId.equals(null))
		{
			sSql+=" and b.op_id=" + sStatOpId;
		}
		if(!sStatGroupId.equals("") && !sStatGroupId.equals(null))
		{
			sSql+=" and b.group_id in (" +sStatGroupId+ ")";
		}	
		if(!sStartTime.equals("") && !sStartTime.equals(null))
		{
			sSql+=" and to_char(a.memo_time,'YYYYMMDDhh24miss')>='"+sStartTime+"'";
		}
		if(!sEndTime.equals("") && !sEndTime.equals(null))
		{
			sSql+=" and to_char(a.memo_time,'YYYYMMDDhh24miss')<='"+sEndTime+"'";
		}
		sSql += " ) group by group_name,group_id order by group_name  ";
		//System.out.print("\n 返回查询结果的sql：" +sSql + "\n");
		Vector ver = new Vector();
		DBConnection lib = new DBConnection();
		ver=lib.selectVector(sSql);
		return ver;
    }
	
	
	/**
     * 根据时间段，统计部门完成工作：回退单（按照组内人员统计数量）
     */
	public Vector StatRevertOpSum (String sStartTime,String sEndTime,String sStatOpId,String sStatGroupId,String sGroupId)
	{ 	
		String sSql="";
		sSql=" select op_id,op_name,count(*) as count "
			+" from (select distinct(a.request_id),d.rep_title,a.from_id,c.op_name,b.group_name,c.op_id  "
			+" from qcs.revert_request_memo a,qcs.op_define_group b, qcs.op_login c,qcs.revert_request d "
			+" where a.memo_type = 4 and a.from_id = b.member_id   and a.from_id = c.op_id "
			+" and a.request_id = d.request_id ";
		if(!sStatOpId.equals("") && !sStatOpId.equals(null))
		{
			sSql+=" and b.op_id=" + sStatOpId;
		}
		if(!sStatGroupId.equals("") && !sStatGroupId.equals(null))
		{
			sSql+=" and b.group_id in (" +sStatGroupId+ ")";
		}	
		if(!sGroupId.equals("") && !sGroupId.equals(null))
		{
			sSql+=" and b.group_id = " +sGroupId ;
		}	
		if(!sStartTime.equals("") && !sStartTime.equals(null))
		{
			sSql+=" and to_char(a.memo_time,'YYYYMMDDhh24miss')>='"+sStartTime+"'";
		}
		if(!sEndTime.equals("") && !sEndTime.equals(null))
		{
			sSql+=" and to_char(a.memo_time,'YYYYMMDDhh24miss')<='"+sEndTime+"'";
		}
		sSql += " ) group by op_id,op_name order by op_name ";
		//System.out.print("\n 返回查询结果的sql：" +sSql + "\n");
		Vector ver = new Vector();
		DBConnection lib = new DBConnection();
		ver=lib.selectVector(sSql);
		return ver;
    }
	
	/**
     * 根据时间段，统计部门完成工作：回退单（按照组内人员显示明细）
     */
	public Vector StatRevertDetail (String sStartTime,String sEndTime,String sStatOpId,String sStatGroupId,String sGroupId)
	{ 	
		String sSql="";
		sSql=" select distinct(a.request_id) as request_id,d.rep_title,a.from_id,c.op_name,b.group_name  "
			+" from qcs.revert_request_memo a,qcs.op_define_group b, qcs.op_login c,qcs.revert_request d "
			+" where a.memo_type = 4 and a.from_id = b.member_id   and a.from_id = c.op_id  and a.request_id = d.request_id ";
		if(!sStatOpId.equals("") && !sStatOpId.equals(null))
		{
			sSql+=" and b.op_id=" + sStatOpId;
		}
		if(!sStatGroupId.equals("") && !sStatGroupId.equals(null))
		{
			sSql+=" and b.group_id in (" +sStatGroupId+ ")";
		}	
		if(!sGroupId.equals("") && !sGroupId.equals(null))
		{
			sSql+=" and b.group_id = " +sGroupId ;
		}	
		if(!sStartTime.equals("") && !sStartTime.equals(null))
		{
			sSql+=" and to_char(a.memo_time,'YYYYMMDDhh24miss')>='"+sStartTime+"'";
		}
		if(!sEndTime.equals("") && !sEndTime.equals(null))
		{
			sSql+=" and to_char(a.memo_time,'YYYYMMDDhh24miss')<='"+sEndTime+"'";
		}
		sSql += " order by op_name ";
		//System.out.print("\n 返回查询结果的sql：" +sSql + "\n");
		Vector ver = new Vector();
		DBConnection lib = new DBConnection();
		ver=lib.selectVector(sSql);
		return ver;
    }

	
}