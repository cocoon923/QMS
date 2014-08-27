//用于查询界面下拉框中显示的数据，或枚举数据

package dbOperation;

import java.util.Vector;


public class QueryBaseData {
    /**
     * 根据分组、人员id查询人员及分组，入参为空默认查询组内所有有效人员
     * @param sgroupId
     * @param sopId
     */
	public Vector queryOpInfo (String sgroupId, String sopId)
	{ 
	   /*	String ssql = "select a.op_id,a.op_login, a.op_name,b.group_id,c.group_name,b.flag,a.op_mail "
				 + "from qms.op_login a, qms.group_op_info b, qms.group_def c "
				 + "where a.group_id in (1,2) and a.op_stat=1 and a.op_id=b.op_id and b.group_id=c.group_id(+)";*/
		// modify by huyf
		String ssql = "select a.op_id as OP_ID,a.op_login as OP_LOGIN, a.op_name as OP_NAME,a.op_mail as OP_MAIL from qms.op_login a";
		if (sgroupId != "")
		{
			ssql += "and b.group_id=" + sgroupId;
		}
		if (sopId != "")
		{
			ssql += " and a.op_id = " + sopId;
		}
		
		ssql+=" order by a.op_mail,a.op_id ";
		 //System.out.print("\n" +ssql + "\n");
		 Vector ver = new Vector();
		 DBConnection lib = new DBConnection();
		 ver=lib.selectVector(ssql);
		 return ver;
    }

    /**
     * added by liyf 20100329
     * 根据分组、人员id查询人员及分组，入参为空默认查询组内所有有效人员(For 新建计划)
     * @param sgroupId
     * @param sopId
     */
	public Vector queryOpInfoForNewPlan (String sgroupId, String sopId)
	{ 
		String ssql = "select a.op_id,a.op_login, a.op_name,b.group_id,c.group_name,b.flag,a.op_mail "
				 + "from qms.op_login a, (select * from qms.group_op_info union select * from qms.group_op_info_ext) b, qms.group_def c "
				 + "where a.group_id in (1,2) and a.op_stat=1 and a.op_id=b.op_id and b.group_id=c.group_id(+)";
		if (sgroupId != "")
		{
			ssql += "and b.group_id=" + sgroupId;
		}
		if (sopId != "")
		{
			ssql += " and a.op_id = " + sopId;
		}
		
		ssql+=" order by a.op_mail,a.op_id ";
		 //System.out.print("\n" +ssql + "\n");
		 Vector ver = new Vector();
		 DBConnection lib = new DBConnection();
		 ver=lib.selectVector(ssql);
		 return ver;
    }
	
	/**
     * 根据需求id/故障id，查询功能点对应的产品
     * @param stype: 1,需求id；2,故障id,不能为空
     * @param svalue
     */
	public Vector queryProduct(String stype, String svalue) 
	{ 	
		String ssql="";
		if(stype=="1")
		{
			ssql="select a.product_id,b.product_name "
					+ "from qms.demand_request a,qms.product b "
					+ "where a.product_id=b.product_id and a.demand_id=" + svalue ;
		}
		else 
		{
			if(stype=="2")
			{
				ssql="select a.product_id,b.product_name "
					+ "from qms.project_request a,qms.product b "
					+ " where a.product_id=b.product_id and a.request_id=" + svalue ;
			}
			else
			{
				System.out.print("未知类型，不处理！");
			}
		}
		 //System.out.print("\n" +ssql + "\n");
		 Vector ver = new Vector();
		 DBConnection lib = new DBConnection();
		 ver=lib.selectVector(ssql);	 
//		 System.out.print(ssql);
		 return ver;
    }

    /**
     * 根据产品id，查询产品下的子系统
     * @param sproductId
     */
	public Vector querySubSystem (String sproductId) 
	{ 	
		String ssql="select subsys_id,substr(subsys_name_cn,instr(subsys_name_cn,'(')+1,instr(subsys_name_cn,')')-instr(subsys_name_cn,'(')-1)" 
				   + "||' -- '||subsys_name_cn as SUBSYS_NAME_CN from qms.subsys_def "
				   + "where prj_id="+ sproductId +" order by subsys_name_cn";
		 //System.out.print("\n" +ssql + "\n");
		 Vector ver = new Vector();
		 DBConnection lib = new DBConnection();
		 ver=lib.selectVector(ssql);	 
		 return ver;
    }

    /**
     * 根据子系统id，查询产品下的子系统下模块
     * @param sproductId   产品id，qms.product表中定义
     * @param ssubSystemId 子系统id，qms.subsys_def表中定义
     * @param smoduleId 模块id
     */
	public Vector queryModule (String sproductId,String ssubSystemId,String smoduleId) 
	{ 	
		String ssql="select product_id,subsys_id,module_id,substr(module_name,instr(module_name,'(')+1,instr(module_name,')')-instr(module_name,'(')-1)"
				   + "||' -- '||module_name as MODULE_NAME from qms.PRODUCT_DETAIL "
				   + " where 1=1";
		if(sproductId!="")
			ssql += " and product_id=" + sproductId;
		if(ssubSystemId!="")
			ssql += " and subsys_id = " + ssubSystemId;
		if(smoduleId!="")
			ssql = " select module_id,module_name as MODULE_NAME from qms.PRODUCT_DETAIL "
				 + " where 1=1 and module_id = " + smoduleId ;
		ssql += " order by module_name";
		 //System.out.print("\n" +ssql + "\n");
		 Vector ver = new Vector();
		 DBConnection lib = new DBConnection();
		 ver=lib.selectVector(ssql);	 
//		 System.out.print("\n" +ssql + "\n");
		 return ver;
    }
	
    /**
     * 根据产品id，返回产品下所有的子系统、模块
     * @param sproductId   产品id，qms.product表中定义
     */
	public Vector querySubSystemModule (String sproductId) 
	{ 	
		String ssql="select  b.subsys_id as SUBSYS_ID,substr(b.subsys_name_cn,instr(b.subsys_name_cn,'(')+1,instr(b.subsys_name_cn,')')-instr(b.subsys_name_cn,'(')-1) ||' -- '||b.subsys_name_cn as SUBSYS_NAME_CN"
                   +",a.module_id as MODULE_ID,substr( a.module_name,instr( a.module_name,'(')+1,instr( a.module_name,')')-instr( a.module_name,'(')-1)||' -- '|| a.module_name as MODULE_NAME "
                   +" from qms.PRODUCT_DETAIL a,qms.subsys_def b where 1=1 "
                   +" and  a.product_id="+sproductId+"  and a.subsys_id=b.subsys_id and a.product_id=b.prj_id order by module_name"; 
		Vector ver = new Vector();
		DBConnection lib = new DBConnection();
		//System.out.print(ssql);
		ver=lib.selectVector(ssql);	
		return ver;
    }

    /**
     * 根据表名、字段名，查询qms.sys_base_type表中的枚举数据
     * @param stablename 表名
     * @param scolname 字段名
     */
	public Vector querySysBaseType (String stablename,String scolname) 
	{ 	
		String ssql="select code_value,cname from qms.sys_base_type "
				   + " where table_name='" + stablename + "' " 
				   + "and col_name='" + scolname + "' order by code_value";
		 //System.out.print("\n" +ssql + "\n");
		 Vector ver = new Vector();
		 DBConnection lib = new DBConnection();
		 ver=lib.selectVector(ssql);	 
		 return ver;
    }
	

    /**
     * 根据需求id、故障id 按照固定规则生成case编号
     * @param stype 类型，1：需求；2：故障
     * @param svalue id号
     */
	public Vector getnewCaseId (String stype,String svalue) 
	{ 	
		String ssql="";
		String ssql1="";
		if(stype=="1")
		{
			//ssql="select b.product_name||'-'||d.product_vs_name||'-R"+ svalue +"'||'-'||" 
			//	+ " (select lpad(to_char(decode(caseid,null,0,caseid)+1),5,'0')"
			//	+ " from (select max(to_number(substr(case_id,length(case_id)-4,length(case_id)))) caseid " 
			//	+ " from qms.case_rec where demand_id = "+ svalue +" and case_source = 1))  as NEWCASEID"
			//	+ " from qms.demand_request a,qms.product b,qms.product_project c,qms.product_version d "
			//	+ " where a.product_id=b.product_id and a.demand_id="+ svalue +" and a.product_id=c.product_id "
			//	+ " and c.project_id = (select area_id "
			//	+ " from qms.project where proj_code=(select project_code from qms.demand_request where demand_id="+ svalue +")) "
			//	+ " and c.product_version_id=d.product_version_id";
			//sql语句优化
			ssql="select b.product_name||'-'||d.product_vs_name||'-R"+ svalue +"'||'-'||" 
				+ " (select lpad(to_char(decode(caseid,null,0,caseid)+1),5,'0')"
				+ " from (select max(to_number(substr(case_id,length(case_id)-4,length(case_id)))) caseid " 
				+ " from qms.case_rec where demand_id = "+ svalue +" and case_source = 1))  as NEWCASEID"
				+ " from qms.demand_request a,qms.product b,qms.product_project c,qms.product_version d,qms.project e "
				+ " where a.product_id=b.product_id and a.demand_id="+ svalue +" and a.product_id=c.product_id "
				+ " and c.project_id = e.area_id and e.proj_code = a.project_code and a.project_code = c.project_code"
				+ " and c.product_version_id=d.product_version_id";
			//增加从qms.product_project的兼容性：如果完全匹配查询不到数据，就不匹配地区，使用第一条数据作为版本信息  modify by liyf 20091029 start
			ssql1="select b.product_name||'-'||d.product_vs_name||'-R"+ svalue +"'||'-'||" 
				+ " (select lpad(to_char(decode(caseid,null,0,caseid)+1),5,'0')"
				+ " from (select max(to_number(substr(case_id,length(case_id)-4,length(case_id)))) caseid " 
				+ " from qms.case_rec where demand_id = "+ svalue +" and case_source = 1))  as NEWCASEID"
				+ " from qms.demand_request a,qms.product b,qms.product_project c,qms.product_version d,qms.project e "
				+ " where a.product_id=b.product_id and a.demand_id="+ svalue +" and a.product_id=c.product_id "
				+ " and e.proj_code = a.project_code and a.project_code = c.project_code"
				+ " and c.product_version_id=d.product_version_id";
			//modify by liyf 20091029 end
			
		}
		else if(stype=="2")
		{
			//ssql="select b.product_name||'-'||d.product_vs_name||'-F"+ svalue +"'||'-'||"
			//	+ " (select lpad(to_char(decode(caseid,null,0,caseid)+1),5,'0') "
			//	+ " from (select max(to_number(substr(case_id,length(case_id)-4,length(case_id)))) caseid "
			//	+ " from qms.case_rec where demand_id = "+ svalue +" and case_source = 2))  as NEWCASEID"
			//	+ " from qms.project_request a,qms.product b,qms.product_project c,qms.product_version d "
			//	+ " where a.product_id=b.product_id and a.request_id="+ svalue +" and a.product_id=c.product_id "
			//	+ " and c.project_id = (select area_id"
			//	+ " from qms.project where proj_code=(select proj_code from qms.project_request where request_id="+ svalue +")) "
			//	+ " and c.product_version_id=d.product_version_id";
			//sql语句优化
			ssql="select b.product_name||'-'||d.product_vs_name||'-F"+ svalue +"'||'-'||"
				+ " (select lpad(to_char(decode(caseid,null,0,caseid)+1),5,'0') "
				+ " from (select max(to_number(substr(case_id,length(case_id)-4,length(case_id)))) caseid "
				+ " from qms.case_rec where demand_id = "+ svalue +" and case_source = 2))  as NEWCASEID"
				+ " from qms.project_request a,qms.product b,qms.product_project c,qms.product_version d,qms.project e "
				+ " where a.product_id=b.product_id and a.request_id="+ svalue +" and a.product_id=c.product_id "
				+ " and c.project_id = e.area_id and e.proj_code = a.proj_code and a.proj_code= c.project_code "
				+ " and c.product_version_id=d.product_version_id";
			//增加从qms.product_project的兼容性：如果完全匹配查询不到数据，就不匹配地区，使用第一条数据作为版本信息  modify by liyf 20091029 start
			ssql1="select b.product_name||'-'||d.product_vs_name||'-F"+ svalue +"'||'-'||"
				+ " (select lpad(to_char(decode(caseid,null,0,caseid)+1),5,'0') "
				+ " from (select max(to_number(substr(case_id,length(case_id)-4,length(case_id)))) caseid "
				+ " from qms.case_rec where demand_id = "+ svalue +" and case_source = 2))  as NEWCASEID"
				+ " from qms.project_request a,qms.product b,qms.product_project c,qms.product_version d,qms.project e "
				+ " where a.product_id=b.product_id and a.request_id="+ svalue +" and a.product_id=c.product_id "
				+ " and e.proj_code = a.proj_code and a.proj_code= c.project_code "
				+ " and c.product_version_id=d.product_version_id";
			//modify by liyf 20091029 end
		}
		else
		{
			System.out.print("入参类型不正确，请确认！");	
		}
		 //System.out.print("\n" +ssql + "\n"); 
		 Vector ver = new Vector();
		 DBConnection lib = new DBConnection();
		 ver=lib.selectVector(ssql);
		 //增加从qms.product_project的兼容性：如果完全匹配查询不到数据，就不匹配地区，使用第一条数据作为版本信息  modify by liyf 20091029 start
		 
		 //modify by liyf 20091029 end
		 return ver;
    }

	
	
    /**
     * 根据需求id、故障id 返回id号加名称
     * @param stype 类型，1：需求；2：故障
     * @param svalue id号
     */
	public Vector getfuncName (String stype,String svalue) 
	{ 	
		String ssql="";
		if(stype=="1")
		{
			ssql="select  '[R'||demand_id||']--'||demand_title as FUNCNAME from qms.demand_request where demand_id=" + svalue;
			
		}
		else if(stype=="2")
		{
			ssql="select  '[F'||request_id||']--'||rep_title as FUNCNAME from qms.project_request where request_id=" + svalue;
		}
		else
		{
			System.out.print("入参类型不正确，请确认！");	
		}
		 //System.out.print("\n" +ssql + "\n");
		 Vector ver = new Vector();
		 DBConnection lib = new DBConnection();
		 ver=lib.selectVector(ssql);	 
		 return ver;
    }

	
    /**
     * 根据需求id、故障id 返回版本信息
     * @param stype 类型，1：需求；2：故障
     * @param svalue id号
     */
	public Vector getVerInfo (String stype,String svalue) 
	{ 	
		String ssql="";
		if(stype=="1")
		{
			//ssql=" select d.product_version_id as PRODUCT_VERSION_ID,d.product_version_name as PRODUCT_VERSION_NAME,d.product_vs_name as PRODUCT_VS_NAME"
			//	+ " from qms.demand_request a,qms.product b,qms.product_project c,qms.product_version d "
			//	+ " where a.product_id=b.product_id and a.demand_id="+svalue+" and a.product_id=c.product_id "
			//	+ " and c.project_id = (select area_id "
			//	+ " from qms.project where proj_code=(select project_code from qms.demand_request "
			//	+ " where demand_id="+svalue+")) and c.product_version_id=d.product_version_id";
			//sql语句优化
			ssql=" select d.product_version_id as PRODUCT_VERSION_ID,d.product_version_name as PRODUCT_VERSION_NAME,d.product_vs_name as PRODUCT_VS_NAME"
				+ " from qms.demand_request a,qms.product b,qms.product_project c,qms.product_version d,qms.project e "
				+ " where a.product_id=b.product_id and a.demand_id="+svalue+" and a.product_id=c.product_id "
				+ " and c.project_id = e.area_id and e.proj_code = a.project_code and a.project_code = c.project_code"
				+ " and c.product_version_id=d.product_version_id";
		}
		else if(stype=="2")
		{
			//ssql= " select d.product_version_id as PRODUCT_VERSION_ID,d.product_version_name as PRODUCT_VERSION_NAME,d.product_vs_name as PRODUCT_VS_NAME"
			//	+ " from qms.project_request a,qms.product b,qms.product_project c,qms.product_version d "
			//	+ " where a.product_id=b.product_id and a.request_id="+svalue+" and a.product_id=c.product_id "
			//	+ " and c.project_id = (select area_id "
			//	+ " from qms.project where proj_code=(select proj_code from qms.project_request "
			//	+ " where request_id="+svalue+"))  and c.product_version_id=d.product_version_id";
			//sql语句优化
			ssql= " select d.product_version_id as PRODUCT_VERSION_ID,d.product_version_name as PRODUCT_VERSION_NAME,d.product_vs_name as PRODUCT_VS_NAME"
				+ " from qms.project_request a,qms.product b,qms.product_project c,qms.product_version d,qms.project e "
				+ " where a.product_id=b.product_id and a.request_id="+svalue+" and a.product_id=c.product_id "
				+ " and c.project_id = e.area_id and e.proj_code = a.proj_code  and a.proj_code= c.project_code"
				+ " and c.product_version_id=d.product_version_id";
			
		}
		else
		{
			System.out.print("入参类型不正确，请确认！");	
		}
		 //System.out.print("\n" +ssql + "\n");
		 Vector ver = new Vector();
		 DBConnection lib = new DBConnection();
		 ver=lib.selectVector(ssql);	 	 
		 return ver;
    }

	
    /**
     * 根据操作员id，查询是否存在qms.group_op_info表中
     * @param sopid 操作员编号
     */
	public int queryOpGroupCount (String sopid) 
	{ 	
		String ssql="select * from qms.group_op_info where op_id="+sopid +"union select * from qms.group_op_info_ext where op_id="+sopid;
		 //System.out.print("\n" +ssql + "\n");
		 Vector ver = new Vector();
		 DBConnection lib = new DBConnection();
		 ver=lib.selectVector(ssql);
		 if (ver.size()>0)
		 {
			 return 1;  //有记录存在
		 }
		 else return 2; //无记录存在
    }

/* 调试用函数 */
/*	public static void main(String args[])
	{
	   Vector ver = new Vector();
	   ver=getnewCaseId("1","21737");
	   System.out.print("\n----BEGIN-----\n");
	   System.out.print("ver.size()="+ver.size()+"\n");
	   if(ver.size()>0)
	   	{for (int i = 0; i < ver.size(); i++) {
		    HashMap hash = (HashMap) ver.get(i);
		    String snewCaseId = (String) hash.get("NEWCASEID");
		    System.out.println("sId=" + snewCaseId);
		    System.out.print("--------");
		  }
	   	}
	   else System.out.print("ver.size()="+ver.size()+"，不显示！");

	  }  

*/	
}