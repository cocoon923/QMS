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


public class PlanManager {
    /**
     * 根据qms.plan_seq返回可用计划序号
     */
	public String getNewPlanSeq ()
	{ 

		//String ssql = "select qms.plan_seq.nextval as PLAN_SEQ from dual";
		 String ssql="select nvl(max(plan_id)+1,1)as PLAN_SEQ from qms.plan";
		 //System.out.print("\n" + "	" + ssql + "	" + "\n");
		 DBConnection lib = new DBConnection();
		 ResultSet rs=lib.executeQuery(ssql);
		 String splanseq="";
	     try
	     {
	       rs.next();
	       splanseq = rs.getString("PLAN_SEQ");  
	       rs.close();
	     }
	     catch(SQLException ex)
	     {
	    	System.err.println("aq.executeQuery:"+ex.getMessage());
		 }
		 return splanseq;
    }

    /**
     * 根据计划表中各字段条件，返回计划基本信息
     */
	public Vector queryplaninfo (String splanid,String splanname,String sstarttime,String sendtime,String splanner,String screatetimestart,String screatetimeend,String sflag,String stype,String sDate)
	{ 
		String ssql = "select PLAN_ID,PLAN_NAME,nvl(to_char(start_time, 'yyyy-mm-dd'), '-') as START_TIME, "
			        +" nvl(to_char(end_time, 'yyyy-mm-dd'), '-') as END_TIME, PLANNER,"
			        +"(select op_name from qms.op_login where op_id=planner) as PLANNER_NAME, "
			        +" nvl(to_char(create_time, 'yyyy-mm-dd'), '-') as CREATE_TIME,flag,"
			        +"(select '['||code_value||'] '||cname from qms.sys_base_type where table_name='PLAN'and col_name='FLAG' and code_value=flag) as FLAG_NAME,type "
			        +" from qms.plan where 1=1";
		if(splanid!=null && !splanid.equals(""))
		{
			ssql += " and plan_id in ("+splanid+")";
		}
		if(splanname!=null && !splanname.equals(""))
		{
			ssql += " and plan_name like '%"+splanname+"%'";
		}
		if(sstarttime!=null && !sstarttime.equals(""))
		{
			ssql += " and to_char(start_time,'YYYYMMDDHH24MISS')>='"+sstarttime+"'";
		}
		if(sendtime!=null && !sendtime.equals(""))
		{
			ssql += " and to_char(end_time,'YYYYMMDDHH24MISS')<='"+sendtime+"'";
		}
		if(splanner!=null && !splanner.equals(""))
		{
			ssql += " and planner="+splanner;
		}
		if(screatetimestart!=null && !screatetimestart.equals(""))
		{
			ssql += " and to_char(create_time,'YYYYMMDDHH24MISS')>='"+screatetimestart+"'";
		}
		if(screatetimeend!=null && !screatetimeend.equals(""))
		{
			ssql += " and to_char(create_time,'YYYYMMDDHH24MISS')<='"+screatetimeend+"'";
		}
		if(sflag!=null && !sflag.equals(""))
		{
			ssql += " and flag="+sflag;
		}
		if(stype!=null && !stype.equals(""))
		{
			ssql += " and type="+stype;
		}
		if(sDate!=null && !sDate.equals(""))
		{
			ssql += "and "+ sDate +" between to_char(start_time,'YYYYMMDD') and to_char(end_time,'YYYYMMDD')";
		}

		ssql += " order by plan_id";

		 //System.out.print("\n" + "	" + ssql + "	" + "\n");
		 Vector ver = new Vector();
		 DBConnection lib = new DBConnection();
		 ver=lib.selectVector(ssql);
		 return ver;
    }

	/**
	 * 根据入参更新plan基本信息（insert/update qms.plan表）
	 * @param sopertype 操作类型 1：新增；2：修改
	 * @param splanid  计划编号，不能为空
	 */
	public void operplaninfo (String sopertype,String splanid,String splanname,String sstarttime,String sendtime,String splanner,String screatetime,String sflag,String stype)
	{
		String ssql="";
		if(sopertype==null || sopertype.equals("") || splanid==null || splanid.equals(""))
		{
			System.out.print("入参不正确，请检查!");
		}
		else
		{
			if(sopertype.equals("1")==true) //新增
			{
				ssql="insert into qms.plan (plan_id,plan_name,start_time,end_time,planner,create_time,flag,type) "
					+"values("+splanid+",'"+splanname+"',to_date('"+sstarttime+"','YYYYMMDDHH24MISS'),to_date('"+sendtime+"','YYYYMMDDHH24MISS'),'"+splanner+"',sysdate,"+sflag+",0)";
			}
			//if(sopertype.equals("2")==true) //修改
			else
			{
				ssql="update qms.plan set plan_name='"+splanname+"',start_time=to_date('"+sstarttime+"','YYYYMMDDHH24MISS'),end_time=to_date('"+sendtime+"','YYYYMMDDHH24MISS'),planner="+splanner+",flag="+sflag
				    +" where plan_id="+splanid;
			}
			//System.out.print("\n" + "	" + ssql + "	" + "\n");
			
			DBConnection lib = new DBConnection();
			lib.executeUpdate(ssql);
			//System.out.print("操作成功!");
		}
	}

	
	/**
	 * 根据入参查询满足条件的需求编号及相关属性
	 * @param stype 标识查询需求或故障，1：查需求；2：查故障
	 */
	public Vector querydemandinfo(String stype,String srepstarttime,String srependtime,String sdevstarttime,String sdevendtime,String sproductid,String sdemandstauts,String sgroupid,String sopid,String sdemandid,String sdefproductid,String defstatus,String splanid)
	{
		/* 
		 * 增加查询非crm部门人员任务单测试人员和开发人员名称的显示
		 * 修改：qms.group_op_info c 为 ( select * from qms.group_op_info X  union all  select * from qms.group_op_info_ext Y) c
		 */	
		String ssql="";
		int itype=Integer.parseInt(stype);
		
		switch(itype)
		{
			case 1://需求
				ssql=" select distinct a.demand_id as DEMAND_ID, c.project_name as PROJ_NAME,a.demand_title as DEMAND_TITLE,d.product_name as PRODUCT_NAME,"
					+" a.status as STATUS,nvl(to_char(a.rep_time, 'yyyy-mm-dd'), '-') as REP_TIME,nvl(to_char(a.dev_time, 'yyyy-mm-dd'), '-') as DEV_TIME,"
					+" b.sta_name as STA_NAME"
				    +" from qms.DEMAND_REQUEST a, qms.DEMAND_STATUS b, qms.PROJECT c,qms.product d,qms.assignment e "
				    +" where a.status = b.sta_id and a.project_code = c.proj_code and a.product_id = d.product_id and a.demand_id=e.demand_id"
				    +" and a.product_id in ("+sdefproductid+") and a.status in ("+defstatus+")";
				if(!srepstarttime.equals("") && !srepstarttime.equals(null))
				{
					ssql+=" and to_char(a.rep_time,'YYYYMMDDhh24miss')>='"+srepstarttime+"'";
				}
				if(!srependtime.equals("") && !srependtime.equals(null))
				{
					ssql+=" and to_char(a.rep_time,'YYYYMMDDhh24miss')<='"+srependtime+"'";
				}
				if(!sdevstarttime.equals("") && !sdevstarttime.equals(null))
				{
					ssql+=" and to_char(a.dev_time,'YYYYMMDDhh24miss')>='"+sdevstarttime+"'";
				}
				if(!sdevendtime.equals("") && !sdevendtime.equals(null))
				{
					ssql+=" and to_char(a.dev_time,'YYYYMMDDhh24miss')<='"+sdevendtime+"'";
				}
				if(!sproductid.equals("") && !sproductid.equals(null))
				{
					ssql+=" and a.product_id in ("+sproductid+")";
				}
				if(!sdemandstauts.equals("") && !sdemandstauts.equals(null))
				{
					ssql+=" and a.status in ("+sdemandstauts+")";
				}
				if(!sgroupid.equals("") && !sgroupid.equals(null))
				{
					ssql+=" and e.closer_id in (select op_id from (select * from qms.group_op_info X  union all  select * from qms.group_op_info_ext Y) where group_id in ("+sgroupid+"))";
				}
				if(!sopid.equals("") && !sopid.equals(null))
				{
					ssql+=" and e.closer_id in ("+sopid+")";
				}
				if(!sdemandid.equals("") && !sdemandid.equals(null))
				{
					ssql+=" and a.demand_id in ("+sdemandid+")";
				}
				if(splanid !=null && !splanid.equals(""))
				{
					ssql+="and a.demand_id not in (select task_value from qms.plan_task where plan_id="+splanid+" and task_type="+stype+")";
				}
				break;
			case 2://故障
				ssql=" select distinct a.request_id as DEMAND_ID,b.proj_name as PROJ_NAME,a.rep_title as DEMAND_TITLE,"
					+" d.product_name as PRODUCT_NAME,a.rep_status as STATUS,nvl(to_char(a.rep_time, 'yyyy-mm-dd'), '-') as REP_TIME,"
					+" nvl(to_char(a.dev_one_time, 'yyyy-mm-dd'), '-') as DEV_TIME,c.name as STA_NAME,a.rep_dev as DEV_ID,"
					+" a.rep_qa as TESTER_ID "
					+" from qms.project_request a,qms.project b,qms.proj_status c,qms.product d  "
					+" where a.proj_code = b.proj_code and a.rep_status = c.id and a.product_id = d.product_id"
					+" and a.product_id in ("+sdefproductid+") and a.rep_status in ("+defstatus+")";
				if(!srepstarttime.equals("") && !srepstarttime.equals(null))
				{
					ssql+=" and to_char(a.rep_time,'YYYYMMDDhh24miss')>='"+srepstarttime+"'";
				}
				if(!srependtime.equals("") && !srependtime.equals(null))
				{
					ssql+=" and to_char(a.rep_time,'YYYYMMDDhh24miss')<='"+srependtime+"'";
				}
				if(!sdevstarttime.equals("") && !sdevstarttime.equals(null))
				{
					ssql+=" and to_char(a.dev_one_time,'YYYYMMDDhh24miss')>='"+sdevstarttime+"'";
				}
				if(!sdevendtime.equals("") && !sdevendtime.equals(null))
				{
					ssql+=" and to_char(a.dev_one_time,'YYYYMMDDhh24miss')<='"+sdevendtime+"'";
				}
				if(!sproductid.equals("") && !sproductid.equals(null))
				{
					ssql+=" and a.product_id in ("+sproductid+")";
				}
				if(!sdemandstauts.equals("") && !sdemandstauts.equals(null))
				{
					ssql+=" and a.rep_status in ("+sdemandstauts+")";
				}
				if(!sgroupid.equals("") && !sgroupid.equals(null))
				{
					ssql+=" and a.rep_qa in (select op_id from (select * from qms.group_op_info X  union all  select * from qms.group_op_info_ext Y) where group_id in ("+sgroupid+"))";
				}
				if(!sopid.equals("") && !sopid.equals(null))
				{
					ssql+=" and a.rep_qa in ("+sopid+")";
				}
				if(!sdemandid.equals("") && !sdemandid.equals(null))
				{
					ssql+=" and a.request_id in ("+sdemandid+")";
				}
				if(splanid !=null && !splanid.equals(""))
				{
					ssql+="and a.request_id not in (select task_value from qms.plan_task where plan_id="+splanid+" and task_type="+stype+")";
				}
				break;
			case 3://功能点任务单
				ssql=" select distinct a.task_id  as DEMAND_ID,'研发功能点' as PROJ_NAME,a.title as DEMAND_TITLE,"
					+" d.product_name as PRODUCT_NAME,a.status_id as STATUS,nvl(to_char(a.opentime, 'yyyy-mm-dd'), '-') as REP_TIME,"
					+" nvl(to_char(a.dev_time, 'yyyy-mm-dd'), '-') as DEV_TIME,c.name as STA_NAME,a.accepter_id as DEV_ID,"
					+" a.closer_id as TESTER_ID "
					+" from qms.assignment a,qms.assignment_status c,qms.product d,qms.feature_list e  "
					+" where a.task_id = e.task_id and a.status_id = c.id and d.product_id = e.product_id and e.status_update!=5 and a.demand_id is null"
					+" and e.product_id in ("+sdefproductid+") and a.status_id in ("+defstatus+")";
				if(!srepstarttime.equals("") && !srepstarttime.equals(null))
				{
					ssql+=" and to_char(a.opentime,'YYYYMMDDhh24miss')>='"+srepstarttime+"'";
				}
				if(!srependtime.equals("") && !srependtime.equals(null))
				{
					ssql+=" and to_char(a.opentime,'YYYYMMDDhh24miss')<='"+srependtime+"'";
				}
				if(!sdevstarttime.equals("") && !sdevstarttime.equals(null))
				{
					ssql+=" and to_char(a.dev_time,'YYYYMMDDhh24miss')>='"+sdevstarttime+"'";
				}
				if(!sdevendtime.equals("") && !sdevendtime.equals(null))
				{
					ssql+=" and to_char(a.dev_time,'YYYYMMDDhh24miss')<='"+sdevendtime+"'";
				}
				if(!sproductid.equals("") && !sproductid.equals(null))
				{
					ssql+=" and e.product_id in ("+sproductid+")";
				}
				if(!sdemandstauts.equals("") && !sdemandstauts.equals(null))
				{
					ssql+=" and a.status_id in ("+sdemandstauts+")";
				}
				if(!sgroupid.equals("") && !sgroupid.equals(null))
				{
					ssql+=" and a.closer_id in (select op_id from (select * from qms.group_op_info X  union all  select * from qms.group_op_info_ext Y) where group_id in ("+sgroupid+"))";
				}
				if(!sopid.equals("") && !sopid.equals(null))
				{
					ssql+=" and a.closer_id in ("+sopid+")";
				}
				if(!sdemandid.equals("") && !sdemandid.equals(null))
				{
					ssql+=" and a.task_id in ("+sdemandid+")";
				}
				if(splanid !=null && !splanid.equals(""))
				{
					ssql+="and a.task_id not in (select task_value from qms.plan_task where plan_id="+splanid+" and task_type="+stype+")";
				}
				break;
			default:
				System.out.print("输入类型未知，请检查！");
				break;
		}
			
		ssql+=" order by demand_id asc";
		/* modify by liyf 20100324 end*/
		//System.out.print("\n 查询需求、故障信息sql为：" +ssql + "\n");
		Vector ver = new Vector();
		DBConnection lib = new DBConnection();
		ver=lib.selectVector(ssql);
		return ver;
	}


	/**
	 * 根据计划实时查询qcs中状态
	 * @param splanid 计划编号
	 */
	public Vector trackdemandinfo(String splanid)
	{
		String ssql="";
		//select后选出测试人员名称、提交测试时间/QA_leader分配时间
		//ssql="select distinct 'R'||a.demand_id as DEMAND_ID, c.proj_name as PROJ_NAME,a.demand_title as DEMAND_TITLE,"
			//+"d.product_name as PRODUCT_NAME,a.status as STATUS,nvl(to_char(a.rep_time, 'yyyy-mm-dd'), '-') as REP_TIME,"
			//+"nvl(to_char(a.dev_time, 'yyyy-mm-dd'), '-') as DEV_TIME,b.sta_name as STA_NAME,g.group_name as GROUP_NAME "
			//+"from qms.DEMAND_REQUEST a,qms.DEMAND_STATUS b, qms.PROJECT c,qms.product d,qms.assignment e,qms.group_op_info f,qms.group_def g "
			//+"where a.status = b.sta_id and a.project_code = c.proj_code and a.product_id = d.product_id and a.demand_id=e.demand_id and e.closer_id=f.op_id(+) and f.group_id=g.group_id(+)"
			//+" and a.demand_id in (select task_value from qms.plan_task where plan_id="+splanid+" and task_type=1)"
			//+" union all "
			//+"select distinct 'F'||a.request_id as DEMAND_ID,b.proj_name as PROJ_NAME,a.rep_title as DEMAND_TITLE,"
			//+"d.product_name as PRODUCT_NAME,a.rep_status as STATUS,nvl(to_char(a.rep_time, 'yyyy-mm-dd'), '-') as REP_TIME,"
			//+"nvl(to_char(a.dev_one_time, 'yyyy-mm-dd'), '-') as DEV_TIME,c.name as STA_NAME,g.group_name as GROUP_NAME   "
			//+"from qms.project_request a,qms.project b,qms.proj_status c,qms.product d ,qms.group_op_info f,qms.group_def g  "
			//+" where a.proj_code = b.proj_code and a.rep_status = c.id and a.product_id = d.product_id and a.rep_qa=f.op_id(+) and f.group_id=g.group_id(+) "
			//+"and a.request_id in (select task_value from qms.plan_task where plan_id="+splanid+" and task_type=2)";

    	/* modify by liyf 20100324 start
		 * 增加查询非crm部门人员任务单测试人员和开发人员名称的显示
		 * 修改：qms.group_op_info c 为 ( select * from qms.group_op_info X  union all  select * from qms.group_op_info_ext Y) c
		 */	
		
/*		ssql=" select distinct 'R'||a.demand_id as DEMAND_ID, c.project_name as PROJ_NAME,a.demand_title as DEMAND_TITLE,"
				+" d.product_name as PRODUCT_NAME,a.status as STATUS,nvl(to_char(a.rep_time, 'yyyy-mm-dd'), '-') as REP_TIME,"
				+" nvl(to_char(a.dev_time, 'yyyy-mm-dd'), '-') as DEV_TIME,b.sta_name as STA_NAME,g.group_name as GROUP_NAME, "
				+" h.op_name as TESTER_NAME,(select nvl(to_char(max(dev_time), 'yyyy-mm-dd'), '-') from qms.assignment where demand_id=a.demand_id) as COMMIT_TIME "
				+" from qms.DEMAND_REQUEST a,qms.DEMAND_STATUS b, qms.PROJECT c,qms.product d,qms.assignment e,(select * from qms.group_op_info X  union all  select * from qms.group_op_info_ext Y) f,qms.group_def g,qms.op_login h "
				+" where a.status = b.sta_id and a.project_code = c.proj_code and a.product_id = d.product_id and a.demand_id=e.demand_id and e.closer_id=h.op_id and h.op_id = f.op_id(+) and f.group_id=g.group_id(+)"
				+" and a.demand_id in (select task_value from qms.plan_task where plan_id="+splanid+" and task_type=1)"
				+" union all "
				+" select distinct 'F'||a.request_id as DEMAND_ID,b.project_name as PROJ_NAME,a.rep_title as DEMAND_TITLE,"
				+" d.product_name as PRODUCT_NAME,a.rep_status as STATUS,nvl(to_char(a.rep_time, 'yyyy-mm-dd'), '-') as REP_TIME,"
				+" nvl(to_char(a.dev_one_time, 'yyyy-mm-dd'), '-') as DEV_TIME,c.name as STA_NAME,g.group_name as GROUP_NAME,   "
				+" h.op_name as TESTER_NAME,nvl(to_char(a.QA_CONFIRMTIME, 'yyyy-mm-dd'), '-')  as COMMIT_TIME "
				+" from qms.project_request a,qms.project b,qms.proj_status c,qms.product d ,(select * from qms.group_op_info X  union all  select * from qms.group_op_info_ext Y) f,qms.group_def g,qms.op_login h  "
				+" where a.proj_code = b.proj_code and a.rep_status = c.id and a.product_id = d.product_id and a.rep_qa=h.op_id and h.op_id = f.op_id(+) and f.group_id=g.group_id(+) "
				+" and a.request_id in (select task_value from qms.plan_task where plan_id="+splanid+" and task_type=2)"
				+" union all"
				+" select distinct 'T'||e.task_id as DEMAND_ID, '研发功能点' as PROJ_NAME,e.title as DEMAND_TITLE,"
				+" d.product_name as PRODUCT_NAME,e.status_id as STATUS,nvl(to_char(e.opentime, 'yyyy-mm-dd'), '-') as REP_TIME,"
				+" nvl(to_char(e.dev_time, 'yyyy-mm-dd'), '-') as DEV_TIME,b.name as STA_NAME,g.group_name as GROUP_NAME, "
				+" h.op_name as TESTER_NAME,(select nvl(to_char(max(dev_time), 'yyyy-mm-dd'), '-') from qms.assignment where task_id=a.task_id) as COMMIT_TIME "
				+" from qms.feature_list a,qms.assignment_status b,qms.product d,qms.assignment e,(select * from qms.group_op_info X  union all  select * from qms.group_op_info_ext Y) f,qms.group_def g,qms.op_login h "
				+" where e.status_id = b.id and a.task_id = e.task_id and a.product_id = d.product_id and e.closer_id=h.op_id and h.op_id = f.op_id(+) and f.group_id=g.group_id(+)"
				+" and e.task_id in (select task_value from qms.plan_task where plan_id="+splanid+" and task_type=3)";

			ssql+=" order by group_name,tester_name,product_name,demand_id";*/
		
		ssql="select 'T' || a.task_id as TASK_ID, d.demand_src_id as DEMAND_SRC_ID, a.title as TITLE, a.task_desc as TASK_DESC,"
		+" st.name as TASK_STATUS, d.demand_id as DEMAND_ID,"
	    +" (select project_name from qms.PROJECT where proj_code = d.project_code) as PROJ_NAME," 
	    +" (select module_name from qms.product_detail where module_id = d.module_id) as MODULE_NAME,"
	    +" (select op_name from qms.op_login where op_id = a.closer_id) as TESTER_NAME,"
	    +" (select op_name from qms.op_login where op_id = a.accepter_id) as DEV_NAME,"
	    +" nvl(to_char(a.dev_time, 'yyyy-mm-dd'), '-') as COMMIT_TIME"
	    +" from qms.assignment a, qms.DEMAND_REQUEST d, qms.assignment_status st"
	    +" where a.demand_id = d.demand_id and a.status_id = st.id"
	    +" and a.demand_id in (select task_value from qms.plan_task where plan_id = 1)";
		
		ssql+=" order by TASK_ID";
		
		System.out.print("\n 跟踪需求信息sql为：" +ssql + "\n");
		Vector ver = new Vector();
		DBConnection lib = new DBConnection();
		ver=lib.selectVector(ssql);
		return ver;
	}
	
	
	 /**
     * 根据需求、故障id、功能点任务单，查询出对应的qa的id、名称、归属组；dev的id、名称
     * @param stype 标识查询需求或故障，1：需求；2：故障；3：功能点任务单
     * @param svalue 需求、故障id、功能点任务单。不能为空
     */
	public Vector querydemandopinfo (String stype,String svalue)
	{ 	
		String ssql="";
		int itype=Integer.parseInt(stype);
		switch(itype)
		{
			case 1:
				/* modify by liyf 20100324 start
				 * 增加查询非crm部门人员任务单测试人员和开发人员名称的显示
				 * 修改：qms.group_op_info d 为 ( select * from qms.group_op_info X  union all  select * from qms.group_op_info_ext Y) d
				 */
				ssql=" select f.op_name as DEV_NAME,"
					+" b.accepter_id as DEV_ID,g.op_name as TESTER_NAME, "
					+" b.closer_id as TESTER_ID,c.group_name as NAME,c.group_id as ID,"
					+"'['||c.group_id||'] '||c.group_name as GROUP_NAME "
					+" from qms.demand_request a,qms.assignment b,qms.group_def c,(select * from qms.group_op_info X  union all  select * from qms.group_op_info_ext Y) d,qms.op_login f,qms.op_login g"
					+" where a.demand_id="+ svalue +" and a.demand_id=b.demand_id and b.closer_id=d.op_id "
					+" and c.group_id=d.group_id and f.op_id=b.accepter_id and g.op_id=b.closer_id";
				break;
			case 2:
				ssql=" select f.op_name as DEV_NAME ,"
					+" a.rep_dev as DEV_ID,g.op_name as TESTER_NAME,"
					+" a.rep_qa as TESTER_ID, c.group_name as NAME,c.group_id as ID, "
					+" '['||c.group_id||'] '||c.group_name as GROUP_NAME "
					+" from qms.project_request a,qms.project b,qms.group_def c,(select * from qms.group_op_info X  union all  select * from qms.group_op_info_ext Y) d ,qms.op_login f,qms.op_login g"
					+" where a.request_id="+ svalue +"　and a.proj_code=b.proj_code and a.rep_qa=d.op_id "
					+" and c.group_id=d.group_id and f.op_id=a.rep_dev and g.op_id=a.rep_qa";
				/* modify by liyf 20100324 end */
				break;
			case 3:
				ssql=" select f.op_name as DEV_NAME,"
					+" b.accepter_id as DEV_ID,g.op_name as TESTER_NAME, "
					+" b.closer_id as TESTER_ID,c.group_name as NAME,c.group_id as ID,"
					+" '['||c.group_id||'] '||c.group_name as GROUP_NAME "
					+" from qms.assignment b,qms.group_def c,(select * from qms.group_op_info X  union all  select * from qms.group_op_info_ext Y) d,qms.op_login f,qms.op_login g"
					+" where b.task_id="+ svalue +"  and b.closer_id=d.op_id "
					+" and c.group_id=d.group_id and f.op_id=b.accepter_id and g.op_id=b.closer_id";
				break;
			default:
				System.out.print("未知查询类型，请检查！");
				break;
		
		}

			//System.out.print("\n 查询需求、故障测试人员为：" +ssql + "\n");
			Vector ver = new Vector();
			DBConnection lib = new DBConnection();
			ver=lib.selectVector(ssql);
			return ver;
		 
    }


	
    /**
     * 新增计划任务明细信息（insert qms.plan_task表）
     * @param splanid  计划编号，不能为空
     * @param stasktype 计划任务类型，1：需求；2：故障，不能为空
     * @param staskvalue 计划任务类型id值。根据stasktype确定，staskvalue=1,此处填需求编号；staskvalue=2，此处填故障编号
     */
//	public void addPlanTaskInfo(String splanid,String stasktype,String staskvalue,String staskname,String splanstarttime,String splanendtime,String srealstarttime,String srealendtime,String staskexecutor,String sexecutorgroup,String sstatus,String stype,String staskdev)
//	{
//		if(staskname.length()>0)
//			staskname=staskname.replaceAll("'", "''");
		
//		String ssql="insert into qms.plan_task(PLAN_ID,TASK_TYPE,TASK_VALUE,TASK_NAME,PLAN_START_TIME,PLAN_END_TIME,REAL_START_TIME,REAL_END_TIME,TASK_EXECUTOR,EXECUTOR_GROUP,STATUS,TYPE,TASK_DEV) "
//				  +"values("+splanid+","+stasktype+","+staskvalue+",'"+staskname+"',to_date('"+splanstarttime+"','YYYY-MM-DD'),to_date('"+splanendtime+"','YYYY-MM-DD'),to_date('"+srealstarttime+"','YYYY-MM-DD'),to_date('"+srealendtime+"','YYYY-MM-DD'),'"+staskexecutor+"','"+sexecutorgroup+"',"+sstatus+","+stype+",'"+staskdev+"')";
		
//		System.out.print("插入sql="+ssql);
//		DBConnection lib = new DBConnection();
//		lib.executeUpdate(ssql);
//		System.out.print("插入成功");
	
//	}
	public boolean PrcaddPlanTaskInfo(String type,String demandid,String planid,String planstarttime,String planendtime,String tasktype,String sislog,String sModifyOp,String sRemark)
	{ 
		if(sRemark!=null)
		{
			sRemark=sRemark.replaceAll("'", "''");
		}
		DBConnection lib = new DBConnection();
		//System.out.print("\n type="+type);
		//System.out.print("\n demandid="+demandid);
		//System.out.print("\n planid="+planid);
		//System.out.print("\n planstarttime="+planstarttime);
		//System.out.print("\n planendtime="+planendtime);
		//System.out.print("\n tasktype="+tasktype);
		//System.out.print("\n sislog="+sislog);
		//System.out.print("\n sModifyOp="+sModifyOp);
		//System.out.print("\n sRemark="+sRemark);

		lib.executeProcess("{call qms.OPERTASKINFO('"+type+"','"+demandid+"','"+planid+"','"+planstarttime+"','"+planendtime+"','"+tasktype+"','"+sislog+"','"+sModifyOp+"','"+sRemark+"') }");
		return true;
	} 

		

	
    /**
     * 查询计划任务信息
     */
	public Vector queryplantaskinfo (String splanid,String stasktype,String staskvalue,String splanstarttime,String splanendtime,String srealstarttime,String srealendtime,String staskexecutor,String sexecutorgroup,String sstatus,String stype,String staskdev)
	{ 
		String ssql = "select PLAN_ID, TASK_TYPE, TASK_VALUE, "
					+" decode(task_type,1,'R'||task_value,2,'F'||task_value,3,'T'||task_value,task_value) as ID,TASK_NAME,"
					+" nvl(to_char(PLAN_START_TIME, 'YYYY-MM-DD'),'-') as PLAN_START_TIME,"
					+" nvl(to_char(PLAN_END_TIME, 'YYYY-MM-DD'),'-') as PLAN_END_TIME,"
					+" nvl(to_char(REAL_START_TIME, 'YYYY-MM-DD'),'-') as REAL_START_TIME, "
					+" nvl(to_char(REAL_END_TIME, 'YYYY-MM-DD'),'-') as REAL_END_TIME, TASK_EXECUTOR,EXECUTOR_GROUP,"
					+" STATUS,decode(status,0,'未结束',1,'按时完成',2,'延期完成','未定义状态') as STATUS_NAME,"
					+" TYPE,decode(type,0,'计划内','1','计划外','未定义类型') as TYPE_NAME,TASK_DEV  "
					+" from qms.plan_task where 1=1";
		if(splanid!=null && !splanid.equals(""))
		{
			ssql += " and plan_id="+splanid;
		}
		if(stasktype!=null && !stasktype.equals(""))
		{
			ssql += " and task_type ="+stasktype;
		}
		if(staskvalue!=null && !staskvalue.equals(""))
		{
			ssql += " and task_value ="+ staskvalue;
		}
		if(splanstarttime!=null && !splanstarttime.equals(""))
		{
			ssql += " and to_char(plan_start_time,'YYYYMMDDHH24MISS')>='"+splanstarttime+"'";
		}
		if(splanendtime!=null && !splanendtime.equals(""))
		{
			ssql += " and to_char(plan_end_time,'YYYYMMDDHH24MISS')<='"+splanendtime+"'";
		}
		if(srealstarttime!=null && !srealstarttime.equals(""))
		{
			ssql += " and to_char(real_start_time,'YYYYMMDDHH24MISS')>='"+srealstarttime+"'";
		}
		if(srealendtime!=null && !srealendtime.equals(""))
		{
			ssql += " and to_char(real_end_time,'YYYYMMDDHH24MISS')<='"+srealendtime+"'";
		}
		if(staskexecutor!=null && !staskexecutor.equals(""))
		{
			ssql += " and planner like '%"+staskexecutor+"%'";
		}
		if(sexecutorgroup!=null && !sexecutorgroup.equals(""))
		{
			ssql += " and executor_group like '%"+sexecutorgroup+"%'";
		}
		if(sstatus!=null && !sstatus.equals(""))
		{
			ssql += " and status="+sstatus;
		}
		if(stype!=null && !stype.equals(""))
		{
			ssql += " and type="+stype;
		}
		if(staskdev!=null && !staskdev.equals(""))
		{
			ssql += " and task_dev like '%"+staskdev+"%'";
		}

		//ssql += " order by plan_id,task_type,task_value";
		ssql +=" order by plan_id,executor_group,task_executor,task_type,task_value";

		 //System.out.print("\n" + "	" + ssql + "	" + "\n");
		 Vector ver = new Vector();
		 DBConnection lib = new DBConnection();
		 ver=lib.selectVector(ssql);
		 return ver;
    }
    /**
     * 查询计划任务中的任务是否重复出现
     */
	public Vector queryplantaskinfoagain (String splanid)
	{ 
		String ssql =" select task_type,task_value,decode(task_type,'1','R'||task_value,'2','F'||task_value,'3','T'||task_value,task_value) as demand_id from "
			        +"(select a.task_type as task_type, a.task_value as task_value,count(*) as count "
			        +" from qms.plan_task a,qms.plan_task b "
			        +" where  a.task_type=b.task_type and a.task_value=b.task_value and b.plan_id="+splanid
			        +" group by a.task_type,a.task_value order by count desc) a where a.count>1";

		 //System.out.print("\n" + "	" + ssql + "	" + "\n");
		 Vector ver = new Vector();
		 DBConnection lib = new DBConnection();
		 ver=lib.selectVector(ssql);
		 return ver;
    }

	
	
	
	
    /**
     *删除计划任务(delete表：qms.plan_task)
     */
	public void deleteplantask (String splanid,String stasktype,String staskvalue)
	{ 
		String ssql = "delete qms.plan_task where plan_id="+splanid+" and task_type="+stasktype+" and task_value="+staskvalue;

		 //System.out.print("\n" + "	" + ssql + "	" + "\n");
		 DBConnection lib = new DBConnection();
		 lib.executeUpdate(ssql);
    }

	
	
	/**
	 * 关闭计划
	 */
	public boolean colseplan(String splanid)
	{
		DBConnection lib = new DBConnection();
		lib.executeProcess("{call qms.CLOSEPLAN('"+splanid+"') }");
		return true;
	}
	

    /**
     *增加计划维护记录日志(insert表：qms.plan_task_modify_log)
     *@param sModifyType：1：增加计划任务；2：删除计划任务
     */
	public void addplantasklog (String splanid,String stasktype,String staskvalue,String sModify_op,String sModifyType,String sRemark)
	{ 
		if(sRemark!=null)
		{
			sRemark=sRemark.replaceAll("'", "''");
		}
		String ssql = "insert into qms.plan_task_modify_log(plan_id,task_type,task_value,modify_op,modify_type,modify_date,remark)"
					+ " values("+splanid+","+stasktype+","+staskvalue+","+sModify_op+","+sModifyType+",sysdate,'"+sRemark+"')";

		 //System.out.print("\n" + "	" + ssql + "	" + "\n");
		 DBConnection lib = new DBConnection();
		 lib.executeUpdate(ssql);
    }
	
	
    /**
     *查询计划维护记录日志(查询表：qms.plan_task_modify_log)
     */
	public void queryplantasklog (String splanid,String stasktype,String staskvalue,String sModify_op,String sModifyType,String sStartDate,String sEndDate)
	{ 
		String ssql = " select a.plan_id,a.task_type,a.task_value,a.modify_op,a.modify_type,a.modify_date,a.remark,b.op_name "
					+ " from qms.plan_task_modify_log a,qms.op_login b where 1=1 and a.modify_op=b.op_id";

		if(splanid!=null)
		{
			ssql += " and a.plan_id"+ splanid;
		}
		if(stasktype!=null)
		{
			ssql += " and a.task_type"+ stasktype;
		}
		if(staskvalue!=null)
		{
			ssql += " and a.task_value"+ staskvalue;
		}
		if(sModify_op!=null)
		{
			ssql += " and a.modify_op"+ sModify_op;
		}
		if(sModifyType!=null)
		{
			ssql += " and a.modify_type"+ sModifyType;
		}
		if(sStartDate!=null)
		{
			ssql += " and to_char(a.modify_date, 'yyyymmddhh24miss') >="+ sStartDate;
		}
		if(sEndDate!=null)
		{
			ssql += " and to_char(a.modify_date, 'yyyymmddhh24miss') <="+ sEndDate;
		}
		ssql += " order by a.modify_date desc" ;
		//System.out.print("\n" + "	" + ssql + "	" + "\n");
		DBConnection lib = new DBConnection();
		lib.executeUpdate(ssql);
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