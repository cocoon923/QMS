package dbOperation;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.*;
import java.sql.*;

import java.net.URL;
import java.sql.Blob;
import java.io.*;

import org.omg.CORBA.portable.InputStream;

import dbOperation.*;


public class CaseQuery
{
	
	/**
     * 根据产品id，查询产品信息
     * @param svalue 产品id字符串，例如：svalue=2,3,92,93
     */
    public Vector queryProductInfo(String svalue) 
	{ 	
		String ssql="select PRODUCT_ID,PRODUCT_NAME,'['||PRODUCT_ID||']'||PRODUCT_NAME as NAME "
			       +" from product where product_id in "+ svalue ;
		//System.out.print("\n" +ssql + "\n");
		 Vector ver = new Vector();
		 DBConnection lib = new DBConnection();
		 ver=lib.selectVector(ssql);
		 return ver;
    }
    
    
    public Vector queryCaseInfo(String sstartTime,String sendTime,String sproductId,String ssubSysid,String smoduleId,String sgroupid,String sopId,String stype,String svalue) 
	{ 	

    	/* modify by liyf 20100324 start
		 * 增加查询非crm部门人员任务单测试人员和开发人员名称的显示
		 * 修改：group_op_info c 为 ( select * from group_op_info X  union all  select * from group_op_info_ext Y) c
		 */
    		String ssql="select a.case_seq,decode(case_source,'1','R'||a.demand_id,'2','F'||a.demand_id,a.demand_id) as id,"
				      +" a.case_id,a.case_name,a.case_desc,a.exp_result,a.module_id,d.op_name,'['||b.group_id||'] '||b.group_name as group_name "
				      +" from case_rec a ,group_def b,(select * from group_op_info X  union all  select * from group_op_info_ext Y) c,op_login d "
				      +" where 1=1 and a.op_id=c.op_id and b.group_id=c.group_id and a.op_id=d.op_id";
			if(!sstartTime.equals("") && !sstartTime.equals(null))
			{
				ssql+=" and to_char(a.create_time,'YYYYMMDDhh24miss')>='"+sstartTime+"'";
			}
			if(!sendTime.equals("") && !sendTime.equals(null))
			{
				ssql+=" and to_char(a.create_time,'YYYYMMDDhh24miss')<='"+sendTime+"'";
			}
			if(!sproductId.equals("") && !sproductId.equals(null))
			{
				ssql+=" and a.sub_sys_id in (select subsys_id from subsys_def where prj_id="+sproductId+")";
			}
			if(!ssubSysid.equals("") && !ssubSysid.equals(null))
			{
				ssql+=" and a.sub_sys_id="+ssubSysid;
			}
			if(!smoduleId.equals("") && !smoduleId.equals(null))
			{
				ssql+=" and a.module_id="+smoduleId;
			}
			if(!sgroupid.equals("") && !sgroupid.equals(null))
			{
				ssql+=" and a.op_id in (select op_id from (select * from group_op_info X  union all  select * from group_op_info_ext Y) where group_id="+sgroupid+")";
			}
			if(!sopId.equals("") && !sopId.equals(null))
			{
				ssql+=" and a.op_id="+sopId;
			}
			if(!stype.equals("")&& !stype.equals(null))
			{
				if(stype.equals("1"))
				{
					ssql+=" and a.case_source in ("+stype+") and (a.demand_id in ("+svalue+") "
					     +" or a.demand_id in (select demand_main from demand_relation"
					     +" where demand_relate in("+svalue+")))";	
				}
				else
				{
					ssql+=" and a.case_source in ("+stype+") and a.demand_id in ("+svalue+")";
				}
			}
			
			ssql+=" order by id,a.case_id asc";
		 /* modify by liyf 20100324 end*/
		 //System.out.print("\n" +ssql + "\n");
		 Vector ver = new Vector();
		 DBConnection lib = new DBConnection();
		 ver=lib.selectVector(ssql);
		 return ver;

    }
    
    public Vector queryCaseInfoall(String sstartTime,String sendTime,String sproductId,String ssubSysid,String smoduleId,String sgroupid,String sopId,String stype,String svalue) 
	{ 	

    	/* modify by liyf 20100324 start
		 * 增加查询非crm部门人员任务单测试人员和开发人员名称的显示
		 * 修改：group_op_info c 为 ( select * from group_op_info X  union all  select * from group_op_info_ext Y) c
		 */	
    	String ssql="select distinct a.case_seq,decode(case_source,'1','R'||a.demand_id,'2','F'||a.demand_id,a.demand_id) as id,"
				      +" a.case_id,a.case_name,a.case_desc,a.exp_result,a.module_id,d.op_name,'['||b.group_id||'] '||b.group_name as group_name,"
				      +" a.module_id as module_id,e.module_name as module_name"
				      +" from case_rec a ,group_def b,(select * from group_op_info X  union all  select * from group_op_info_ext Y) c,op_login d  ,product_detail e"
				      +" where 1=1 and a.op_id=c.op_id and b.group_id=c.group_id and a.op_id=d.op_id and a.module_id=e.module_id ";

			if(!sstartTime.equals("") && !sstartTime.equals(null))
			{
				ssql+=" and to_char(a.create_time,'YYYYMMDDhh24miss')>='"+sstartTime+"'";
			}
			if(!sendTime.equals("") && !sendTime.equals(null))
			{
				ssql+=" and to_char(a.create_time,'YYYYMMDDhh24miss')<='"+sendTime+"'";
			}
			if(!sproductId.equals("") && !sproductId.equals(null))
			{
				ssql+=" and a.sub_sys_id in (select subsys_id from subsys_def where prj_id="+sproductId+")";
			}
			if(!ssubSysid.equals("") && !ssubSysid.equals(null))
			{
				ssql+=" and a.sub_sys_id="+ssubSysid;
			}
			if(!smoduleId.equals("") && !smoduleId.equals(null))
			{
				ssql+=" and a.module_id="+smoduleId;
			}
			if(!sgroupid.equals("") && !sgroupid.equals(null))
			{
				ssql+=" and a.op_id in (select op_id from (select * from group_op_info X  union all  select * from group_op_info_ext Y) where group_id="+sgroupid+")";
			}
			if(!sopId.equals("") && !sopId.equals(null))
			{
				ssql+=" and a.op_id="+sopId;
			}
			if(!stype.equals("")&& !stype.equals(null))
			{
				if(stype.equals("1"))
				{
					ssql+=" and a.case_source in ("+stype+") and (a.demand_id in ("+svalue+") "
					     +" or a.demand_id in (select demand_main from demand_relation"
					     +" where demand_relate in("+svalue+")))";	
				}
				else
				{
					ssql+=" and a.case_source in ("+stype+") and a.demand_id in ("+svalue+")";
				}
			}
			
			ssql+=" order by id,a.case_id asc";
	     /* modify by liyf 20100324 end*/
		 //System.out.print("\n" +ssql + "\n");
		 Vector ver = new Vector();
		 DBConnection lib = new DBConnection();
		 ver=lib.selectVector(ssql);
		 return ver;

    }

    
/* 调试用函数 */
/*    public static void main(String args[])
    	{
    	   Vector ver = new Vector();
    	   String s="";
//    	   s=getCaseProcessID("238");
    	   ver=queryCaseInfo("","","","","","","","2","");
    	   System.out.print("\n----BEGIN-----\n");
    	   System.out.print("ver.size()="+ver.size()+"\n");
    	   System.out.print("s="+s);
    	   if(ver.size()>0)
    	   {for (int i = 0; i < ver.size(); i++) {
    		    HashMap CaseInfohash = (HashMap) ver.get(i);
    		    String sID = (String) CaseInfohash.get("ID");
    			String sCASEID = (String) CaseInfohash.get("CASE_ID");
    			String sCASENAME = (String) CaseInfohash.get("CASE_NAME");
    			String sCASEDESC = (String) CaseInfohash.get("CASE_DESC");
    			String sMODULEID = (String) CaseInfohash.get("MODULE_ID");
    			String sOPNAME = (String) CaseInfohash.get("OP_NAME");
    			String sGROUPNAME = (String) CaseInfohash.get("GROUP_NAME");
    			//sCASEENV = (String) CaseInfohash.get("CASE_ENV");
//    			String sCASEDATAPREPARE = (String) CaseInfohash.get("CASE_DATA_PREPARE");
//    			String sSUBSYSID = (String) CaseInfohash.get("SUB_SYS_ID");
//    			String sMODULEID = (String) CaseInfohash.get("MODULE_ID");
//    			String sOPID = (String) CaseInfohash.get("OP_ID");
    			System.out.print(sID+"\n----\n"+sCASEID + "\n----\n"+ sCASENAME + "----\n" + sCASEDESC + "----\n" + sMODULEID + "----\n" + sOPNAME + "----\n" + sGROUPNAME + "----\n" );
    		  }
    	   	}
   	      else System.out.print("ver.size()="+ver.size()+"，不显示！");

    	  }  	
*/
}