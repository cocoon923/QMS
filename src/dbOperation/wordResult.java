package dbOperation;
import org.omg.CORBA.portable.InputStream;
import java.sql.Blob;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import dbOperation.*;

public class wordResult {
	   //获取需求或者故障下所有的编写者
	   public Vector getAuthorInfo(String sDemanId,int sCaseType)
	   {
		   System.out.print("根据需求编号或者故障编号获取对于的编写者");
          // String sSql="select  distinct(a.op_name) as OP_NAME,to_char(b.op_time,'yyyy-mm-dd') as OP_TIME,a.op_login as OP_LOGIN  from op_login a, case_rec b where a.op_id in(select distinct(b.op_id) from case_rec where demand_id="+sDemanId+" and case_source="+sCaseType+") order by op_time" ;
           String sSql="select distinct (a.op_name) as OP_NAME,a.op_login as OP_LOGIN,a.op_id as OP_ID from op_login a, case_rec b where a.op_id in (select distinct (op_id) from case_rec where demand_id ="+sDemanId+" and case_source ="+sCaseType+")";
		   Vector ver = new Vector();
		   DBConnection lib = new DBConnection();
		   ver=lib.selectVector(sSql);
		   return ver;
	   }
	   
	   //获取需求或者故障下对应编写者编写CASE的最大日期
	   public Vector getAuthorMaxDate(String sDemanId,int sCaseType,String sOpId)
	   {
		   String sSql="select max(to_char(op_time,'yyyy-mm-dd')) as OP_TIME  from case_rec where demand_id ="+sDemanId+" and case_source ="+sCaseType+" and op_id='"+sOpId+"'";
		   Vector ver = new Vector();
		   DBConnection lib = new DBConnection();
		   ver=lib.selectVector(sSql);
		   return ver;
	   }
	   
	   //获取需求或者故障的原始需求等
	   public static Vector getDemandInfo(String sDemanId,int sCaseType)
	   {
		   //备份 String sSql="select DEMAND_ID,replace(replace(ORI_DEMAND_INFO,'\n','</p><p>'),' ','&nbsp;&nbsp;') as ORI_DEMAND_INFO,replace(replace(DEMAND_SOLUTION,'\n','</p><p>'),' ','&nbsp;&nbsp;') as DEMAND_SOLUTION,replace(replace(DEMAND_CHG_INFO,'\n','</p><p>'),' ','&nbsp;&nbsp;') as DEMAND_CHG_INFO,replace(replace(REMARK1,'\n','</p><p>'),' ','&nbsp;&nbsp;') as REMARK1,replace(replace(REMARK2,'\n','</p><p>'),' ','&nbsp;&nbsp;') as REMARK2,replace(replace(REMARK3,'\n','</p><p>'),' ','&nbsp;&nbsp;') as REMARK3,replace(replace(REMARK4,'\n','</p><p>'),' ','&nbsp;&nbsp;') as REMARK4,replace(replace(REMARK5,'\n','</p><p>'),' ','&nbsp;&nbsp;') as REMARK5,replace(replace(REMARK6,'\n','</p><p>'),' ','&nbsp;&nbsp;') as REMARK6,DEMAND_TYPE from demand_property where demand_id="+sDemanId+" and demand_type="+sCaseType;
		  // String sSql="select DEMAND_ID,replace(replace(ORI_DEMAND_INFO,'\n','</span></p><p class=MsoNormal><span style=font-family: 宋体>'),' ','&nbsp;&nbsp;') as ORI_DEMAND_INFO,replace(replace(DEMAND_SOLUTION,'\n','</span></p><p class=MsoNormal><span style=font-family: 宋体>'),' ','&nbsp;&nbsp;') as DEMAND_SOLUTION,replace(replace(DEMAND_CHG_INFO,'\n','</span></p><p class=MsoNormal><span style=font-family: 宋体>'),' ','&nbsp;&nbsp;') as DEMAND_CHG_INFO,replace(replace(REMARK1,'\n','</span></p><p class=MsoNormal><span style=font-family: 宋体>'),' ','&nbsp;&nbsp;') as REMARK1,replace(replace(REMARK2,'\n','</span></p><p class=MsoNormal><span style=font-family: 宋体>'),' ','&nbsp;&nbsp;') as REMARK2,replace(replace(REMARK3,'\n','</span></p><p class=MsoNormal><span style=font-family: 宋体>'),' ','&nbsp;&nbsp;') as REMARK3,replace(replace(REMARK4,'\n','</span></p><p class=MsoNormal><span style=font-family: 宋体>'),' ','&nbsp;&nbsp;') as REMARK4,replace(replace(REMARK5,'\n','</span></p><p class=MsoNormal><span style=font-family: 宋体>'),' ','&nbsp;&nbsp;') as REMARK5,replace(replace(REMARK6,'\n','</span></p><p class=MsoNormal><span style=font-family: 宋体>'),' ','&nbsp;&nbsp;') as REMARK6,DEMAND_TYPE from demand_property where demand_id="+sDemanId+" and demand_type="+sCaseType;
		   //String sSql="select DEMAND_ID,replace(replace(ORI_DEMAND_INFO,' ','&nbsp;&nbsp;'),'\n','</span></p><p class=\"MsoNormal\"><span style=\"font-family: 宋体\">') as ORI_DEMAND_INFO,replace(replace(DEMAND_SOLUTION,' ','&nbsp;&nbsp;'),'\n','</span></p><p class=\"MsoNormal\"><span style=\"font-family: 宋体\">') as DEMAND_SOLUTION,replace(replace(DEMAND_CHG_INFO,' ','&nbsp;&nbsp;'),'\n','</span></p><p class=\"MsoNormal\"><span style=\"font-family: 宋体\">') as DEMAND_CHG_INFO,replace(replace(REMARK1,' ','&nbsp;&nbsp;'),'\n','</span></p><p class=\"MsoNormal\" style=\"line-height: 120%; margin-left: 77.95pt; margin-right: 84.0pt; margin-top: 0cm; margin-bottom: .0001pt\"><span style=\"font-size: 9.0pt; line-height: 120%; font-family: 宋体; color: black\">') as REMARK1,replace(replace(REMARK2,' ','&nbsp;&nbsp;'),'\n','</span></p><p class=\"MsoNormal\" style=\"line-height: 120%; margin-left: 77.95pt; margin-right: 84.0pt; margin-top: 0cm; margin-bottom: .0001pt\"><span style=\"font-size: 9.0pt; line-height: 120%; font-family: 宋体; color: black\">') as REMARK2,replace(replace(REMARK3,' ','&nbsp;&nbsp;'),'\n','</span></p><p class=\"MsoNormal\" style=\"line-height: 120%; margin-left: 77.95pt; margin-right: 84.0pt; margin-top: 0cm; margin-bottom: .0001pt\"><span style=\"font-size: 9.0pt; line-height: 120%; font-family: 宋体; color: black\">') as REMARK3,replace(replace(REMARK4,' ','&nbsp;&nbsp;'),'\n','</span></p><p class=\"MsoNormal\" style=\"line-height: 120%; margin-left: 77.95pt; margin-right: 84.0pt; margin-top: 0cm; margin-bottom: .0001pt\"><span style=\"font-size: 9.0pt; line-height: 120%; font-family: 宋体; color: black\">') as REMARK4,replace(replace(REMARK5,' ','&nbsp;&nbsp;'),'\n','</span></p><p class=\"MsoNormal\" style=\"line-height: 120%; margin-left: 77.95pt; margin-right: 84.0pt; margin-top: 0cm; margin-bottom: .0001pt\"><span style=\"font-size: 9.0pt; line-height: 120%; font-family: 宋体; color: black\">') as REMARK5,replace(replace(REMARK6,' ','&nbsp;&nbsp;'),'\n','</span></p><p class=\"MsoNormal\" style=\"line-height: 120%; margin-left: 77.95pt; margin-right: 84.0pt; margin-top: 0cm; margin-bottom: .0001pt\"><span style=\"font-size: 9.0pt; line-height: 120%; font-family: 宋体; color: black\">') as REMARK6,DEMAND_TYPE from demand_property where demand_id="+sDemanId+" and demand_type="+sCaseType;

		   String sSql="select * from demand_property where demand_id="+sDemanId+" and demand_type="+sCaseType;
		   
		   //System.out.print("SQL="+sSql+"\n");
		   Vector ver = new Vector(); 
		   DBConnection lib = new DBConnection();
		   ver=lib.selectVector(sSql);
		   return ver;
	   }
	   
	   
	   //获取需求或者故障下所有的模块
	   public  Vector getModuleNameInfo(String sDemanId,int sCaseType)
	   {
           String sSql="select module_name,module_id from product_detail where module_id in(select distinct(module_id) from case_rec where demand_id="+sDemanId+" and case_source="+sCaseType+") order by module_desc";
		   Vector ver = new Vector();
		   DBConnection lib = new DBConnection();
		   ver=lib.selectVector(sSql);
		   return ver;
	   } 
	   
	   //获取需求或者故障下所有的模块
	   public  Vector getModuleNameInfo1(String sDemanId,int sCaseType,String sSubSysId)
	   {
           String sSql="select module_name,module_id from product_detail where module_id in(select distinct(module_id) from case_rec where demand_id="+sDemanId+" and case_source="+sCaseType;
		   if(!sSubSysId.equals(""))
		   {
			   sSql += " and sub_sys_id in ("+sSubSysId+")";
		   }
		   
		   sSql += ") order by module_desc";
           Vector ver = new Vector();
		   DBConnection lib = new DBConnection();
		   ver=lib.selectVector(sSql);
		   return ver;
	   } 
	   
	   //获取需求或者故障下某个模块下的所有CASE
	   public Vector getModuleCaseInfo(String sDemanId,int sCaseType,String sModuleId)
	   {
           //String sSql="select * from case_rec where demand_id="+sDemanId+" and case_source="+sCaseType+" and module_id="+sModuleId+" order by case_id";
		   
		   //String sSql="select a.CASE_SEQ ,a.CASE_ID,a.DEMAND_ID,a.CASE_NAME,a.CASE_DESC,a.CASE_DATA_PREPARE,"
	       //    +"a.EXP_RESULT,a.PRO_VERSION_CODE,a.CLI_INFO_ID,c.CNAME as CLI_INFO_ID_NAME,"
	       //    +"a.SVR_INFO_ID,d.CNAME as SVR_INFO_ID_NAME,a.SUB_SYS_ID,a.MODULE_ID,a.PROGRAM_NAME,"
	       //    +"a.STATUS,e.CNAME as STATUS_NAME,a.STATUS_TIME,a.CASE_TYPE,f.CNAME as CASE_TYPE_NAME,"
	       //    +"a.CASE_SOURCE,e.CNAME as CASE_SOURCE_NAME,a.OP_ID,a.OP_TIME,a.CREATE_TIME,a.CASE_ENV,a.CASE_CONCLUSION "
	       //    +" from case_rec a,sys_base_type c,sys_base_type d,sys_base_type e,sys_base_type f,sys_base_type g "
	       //    +" where a.demand_id="+sDemanId+" and a.case_source="+sCaseType + "and a.module_id="+sModuleId
	       //    +" and c.table_name='CASE_REC' and c.col_name='CLI_INFO_ID' and a.cli_info_id=c.code_value  "
	       //    +" and d.table_name='CASE_REC' and d.col_name='SVR_INFO_ID' and a.svr_info_id=d.code_value  "
	       //    +" and e.table_name='CASE_REC' and e.col_name='STATUS' and a.status=e.code_value  "
	       //    +" and f.table_name='CASE_REC' and f.col_name='CASE_TYPE' and a.case_type=f.code_value  "
	       //    +" and g.table_name='CASE_REC' and g.col_name='CASE_SOURCE' and a.case_source=g.code_value "
	       //    +" order by a.case_seq";
		   String sSql="select a.CASE_SEQ ,a.CASE_ID,a.DEMAND_ID,a.CASE_NAME,a.CASE_DESC,a.CASE_DATA_PREPARE,"
			   		  +"a.EXP_RESULT,a.PRO_VERSION_CODE,"
			   		  +"a.CLI_INFO_ID,(select c.cname from sys_base_type c where c.table_name='CASE_REC' and c.col_name='CLI_INFO_ID' and a.cli_info_id=c.code_value ) as CLI_INFO_ID_NAME,"
			   		  +"a.SVR_INFO_ID,(select d.cname from sys_base_type d where d.table_name='CASE_REC' and d.col_name='SVR_INFO_ID' and a.svr_info_id=d.code_value ) as SVR_INFO_ID_NAME,"
			   		  +"a.SUB_SYS_ID,a.MODULE_ID,a.PROGRAM_NAME,"
			   		  +"a.STATUS,(select e.cname from sys_base_type e where e.table_name='CASE_REC' and e.col_name='STATUS' and a.status=e.code_value ) as STATUS_NAME,"
			   		  +"a.STATUS_TIME,"
			   		  +"a.CASE_TYPE,(select f.cname from sys_base_type f where f.table_name='CASE_REC' and f.col_name='CASE_TYPE' and a.case_type=f.code_value ) as CASE_TYPE_NAME,"
			   		  +"a.CASE_SOURCE,(select g.cname from sys_base_type g where g.table_name='CASE_REC' and g.col_name='CASE_SOURCE' and a.case_source=g.code_value) as CASE_SOURCE_NAME,"
			   		  +"a.OP_ID,a.OP_TIME,a.CREATE_TIME,a.CASE_ENV,a.CASE_CONCLUSION, "
			   		  +"a.module_id,(select module_desc from product_detail where module_id = a.module_id) as MODULE_NAME "
			   		  +" from case_rec a"
			   		  +" where a.demand_id="+sDemanId+" and a.case_source="+sCaseType;
		   if(!sModuleId.equals(""))
		   {
			   sSql+=" and a.module_id="+sModuleId;
		   }
		   sSql+= " order by a.case_seq";
		   
		   //System.out.print("\n"+sSql);
		   Vector ver = new Vector();
		   DBConnection lib = new DBConnection();
		   ver=lib.selectVector(sSql);
		   return ver;
	   }
	   
	   
	   //获取需求或者故障下某个模块下的所有CASE
	   public Vector getModuleCaseInfo1(String sDemanId,int sCaseType,String sModuleId,String sSubSysId)
	   {

		   String sSql="select a.CASE_SEQ ,a.CASE_ID,a.DEMAND_ID,a.CASE_NAME,a.CASE_DESC,a.CASE_DATA_PREPARE,"
			   		  +"a.EXP_RESULT,a.PRO_VERSION_CODE,"
			   		  +"a.CLI_INFO_ID,(select c.cname from sys_base_type c where c.table_name='CASE_REC' and c.col_name='CLI_INFO_ID' and a.cli_info_id=c.code_value ) as CLI_INFO_ID_NAME,"
			   		  +"a.SVR_INFO_ID,(select d.cname from sys_base_type d where d.table_name='CASE_REC' and d.col_name='SVR_INFO_ID' and a.svr_info_id=d.code_value ) as SVR_INFO_ID_NAME,"
			   		  +"a.SUB_SYS_ID,a.MODULE_ID,a.PROGRAM_NAME,"
			   		  +"a.STATUS,(select e.cname from sys_base_type e where e.table_name='CASE_REC' and e.col_name='STATUS' and a.status=e.code_value ) as STATUS_NAME,"
			   		  +"a.STATUS_TIME,"
			   		  +"a.CASE_TYPE,(select f.cname from sys_base_type f where f.table_name='CASE_REC' and f.col_name='CASE_TYPE' and a.case_type=f.code_value ) as CASE_TYPE_NAME,"
			   		  +"a.CASE_SOURCE,(select g.cname from sys_base_type g where g.table_name='CASE_REC' and g.col_name='CASE_SOURCE' and a.case_source=g.code_value) as CASE_SOURCE_NAME,"
			   		  +"a.OP_ID,a.OP_TIME,a.CREATE_TIME,a.CASE_ENV,a.CASE_CONCLUSION, "
			   		  +"a.module_id,(select module_desc from product_detail where module_id = a.module_id) as MODULE_NAME "
			   		  +" from case_rec a"
			   		  +" where a.demand_id="+sDemanId+" and a.case_source="+sCaseType;
		   if(!sModuleId.equals(""))
		   {
			   sSql+=" and a.module_id="+sModuleId;
		   }
		   if(!sSubSysId.equals(""))
		   {
			   sSql+=" and a.sub_sys_id in ("+sSubSysId+")";
		   }
		   sSql+= " order by a.case_seq";
		   
		   System.out.print("\n"+sSql);
		   Vector ver = new Vector();
		   DBConnection lib = new DBConnection();
		   ver=lib.selectVector(sSql);
		   return ver;
	   }

	   
	   //获取某个CASE的所有步骤
	   public  Vector getCaseStepInfo(String sCaseSeq)
	   {
	       String sSql="select * from case_process where case_seq="+sCaseSeq+" order by process_id";
		   Vector ver = new Vector();
		   DBConnection lib = new DBConnection();
		   ver=lib.selectVector(sSql);
		   return ver;
	   }
	   //获取文档名称
	   public Vector getWordName(String sDemanId,int sCaseType)
	   {   
		   String sSql="";
		   String sWordName="";
		   if(sCaseType==1)  //需求
		   {
		      //sSql="select   '功能测试确认文档-['||decode(b.product_id,2,'OB营帐',3,'OpenPRM',92,'AINBS',93,'AINCS',169,'综合帐务管理系统','')||']-[' || d.product_vs_name || ']-R"+sDemanId+"-' ||a.demand_title as NEWCASEID"
              //        +",to_char(sysdate,'YYYYMMDD') as NEWDATE  from demand_request a,product b,product_project c,product_version d "
              //       +"where a.demand_id="+sDemanId+" and a.product_id = b.product_id and a.product_id = c.product_id and "
              //        +"c.project_id = (select area_id "
              //        +"from project where proj_code=(select project_code from demand_request where demand_id="+sDemanId+")) " 
              //        +"and c.product_version_id=d.product_version_id and a.product_id = b.product_id";
		      //优化sql语句
		      sSql="select   '功能测试确认文档-['||(select product_name from product where product_id=b.product_id)||']-[' || d.product_vs_name || ']-R"+sDemanId+"-' ||a.demand_title as NEWCASEID"
	              +",to_char(sysdate,'YYYYMMDD') as NEWDATE  from demand_request a,product b,product_project c,product_version d,project e "
	              +"where a.demand_id="+sDemanId+" and a.product_id = b.product_id and a.product_id = c.product_id and "
	              +"c.project_id = e.area_id and e.proj_code = a.project_code and a.project_code = c.project_code " 
	              +"and c.product_version_id=d.product_version_id and a.product_id = b.product_id";
		   }
		   else   //故障
		   {
			   //sSql="select  '功能测试确认文档-['||decode(b.product_id,2,'OB营帐',3,'OpenPRM',92,'AINBS',93,'AINCS',169,'综合帐务管理系统','')||']-[' || d.product_vs_name || ']-F"+sDemanId+"-' ||a.rep_title as NEWCASEID,to_char(sysdate,'YYYYMMDD')  as NEWDATE "
               //    +" from project_request a,product b,product_project c,product_version d where a.product_id=b.product_id and a.request_id="+sDemanId+" and a.product_id=c.product_id "
               //    +" and c.project_id = (select area_id " 
               //    +" from project where proj_code=(select proj_code from project_request where request_id="+sDemanId+"))  "
               //    +" and c.product_version_id=d.product_version_id and a.product_id=b.product_id";
			   //优化sql语句
			   sSql="select  '功能测试确认文档-['||(select product_name from product where product_id=b.product_id)||']-[' || d.product_vs_name || ']-F"+sDemanId+"-' ||a.rep_title as NEWCASEID,to_char(sysdate,'YYYYMMDD')  as NEWDATE "
	               +" from project_request a,product b,product_project c,product_version d,project e where a.product_id=b.product_id and a.request_id="+sDemanId+" and a.product_id=c.product_id "
	               +" and c.project_id = e.area_id and e.proj_code = a.proj_code and a.proj_code = c.project_code"
	               +" and c.product_version_id=d.product_version_id and a.product_id=b.product_id";
		   }
		   //System.out.print("sql="+sSql);
		   Vector ver = new Vector();
		   DBConnection lib = new DBConnection();
		   ver=lib.selectVector(sSql);
		   return ver;
	   }
	   
	   //获取需求下任务单或者故障处理的QA
	   public Vector getDemandAuthorInfo(String sDemanId,int sCaseType)
	   {
		   System.out.print("获取需求下任务单或者故障处理的编写者");
		   String sSql="";
		   if(sCaseType==1)  //需求
		   {
			  sSql="select distinct (a.op_name) as OP_NAME,a.op_login as OP_LOGIN,a.op_id as OP_ID from op_login a, "
				   	+" assignment b where a.op_id in (select distinct (CLOSER_ID) from assignment where dependid ="
				   	+ sDemanId+" )";

		   }
		   else   //故障
		   {
			   sSql="select distinct (a.op_name) as OP_NAME,a.op_login as OP_LOGIN,a.op_id as OP_ID from op_login a, "
			   	   +" project_request b where a.op_id in (select distinct (REP_QA) from project_request where request_id ="
			   	   + sDemanId+" )"; 
		   }
		   //System.out.print("sSql="+sSql);
           Vector ver = new Vector();
		   DBConnection lib = new DBConnection();
		   ver=lib.selectVector(sSql);
		   return ver;
	   }
	/*
	   public static void main(String arrg[])
	   {
		  // Vector ver=getWordName("19921",1);
		   Vector ver=getWordName("12306",2);

		//   Vector ver=getDemandInfo("19925",1);
		   //Vector ver= getCaseStepInfo("238");
		    System.out.print("\n结果-----\n");
		   for (int i = ver.size()-1;i>=0 ; i--) {
			    HashMap hash = (HashMap) ver.get(0);
			    String name = (String) hash.get("NEWCASEID");
			    String pass=(String) hash.get("NEWDATE");

			    System.out.println(name+"   "+pass);
			    System.out.print("-----\n");
			  }
		   System.out.print(ver.size());
	   }
	   */
	 
	   /*public static void main(String arrg[])
	   {    
		   
		   Vector ver= getDemandInfo("20030",1);
		    System.out.print("我要的結果-----\n");
		   for (int i = 0; i < ver.size(); i++) 
		   {
			    HashMap hash = (HashMap) ver.get(i);
			    String name = (String) hash.get("SVR_INFO_ID_NAME");

			    System.out.println("name="+name+"\n   ");
			    

			  }
		   //System.out.print(ver.size());
		   
	   }
	
	   
	   /*
	   public ArrayList getAuthorInfo(String sDemanId,int sCaseType)
	   {
		   System.out.print("根据需求编号或者故障编号获取对于的编写者");
		   DBConnection lib = new DBConnection();
		   String sOpName="";
		   String sTemp="";
		   String sOpTime="";
		   int iCount=0;
		   //String sSql="select op_name from op_login where op_id in(select distinct(op_id) from case_rec where demand_id="+sDemanId+" and case_source="+sCaseType+")";
	       String sSql="select  distinct(a.op_name) as OP_NAME,to_char(b.op_time,'yyyy-mm-dd') as OP_TIME  from op_login a, case_rec b where a.op_id in(select distinct(b.op_id) from case_rec where demand_id="+sDemanId+" and case_source="+sCaseType+")";
		  
	       
	       ResultSet RS = lib.executeQuery(sSql);
	        try
	        {
	            while(RS.next())
	            {

	              sTemp= sOpName+RS.getString("OP_NAME");  
	              if(iCount>0)
	            	  sOpName=sOpName+"、"+sTemp;
	              else
	            	  sOpName=sTemp;
	              sOpTime=RS.getString("OP_TIME");
	              iCount=iCount+1;
	            }
	            RS.close();
	        }catch(SQLException ex)
	        {
			  System.err.println("aq.executeQuery:"+ex.getMessage());
		    }
		   ArrayList list = new ArrayList();
		   list.add(sOpName);
		   list.add(sOpTime);
           return list;
	   }
     */
} 
