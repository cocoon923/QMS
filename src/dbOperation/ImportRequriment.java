package dbOperation;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;
import java.io.*;
public class ImportRequriment {
	   public Vector getAllMailInfo(String sgroupid)
	   {
		   String sSql="select * from OP_LOGIN where group_id in ("+sgroupid+") order by op_mail desc";
		   //System.out.print("\n获取EMAIL信息"+sSql+"\n");
		   Vector ver = new Vector();
		   DBConnection lib = new DBConnection();
		   ver=lib.selectVector(sSql);
		   return ver;
	   }
	   
	   public Vector getImportRequirementInfo(String sIRM,int iIRMType)
	   {
		   String sSql="";
		   if(iIRMType==1) //获取重点需求信息
		   {
			   sSql="select '[R'||a.demand_id||']--'||a.demand_title as FUNCNAME,a.demand_id as DEMAND_ID,c.id as DEMAND_PROV_ID, c.name  as DEMAND_PROV,"
				  +" e.sta_id as STATEID,e.sta_name as STATE,a.plantime as PLAN_DEV_TIME,a.dev_one_time as REAL_DEV_TIME,"
				  +" a.pso_deploy_time as PLAN_TEST_TIME,a.qa_time as REAL_TEST_TIME,'['||a.product_id||'] '||b.product_name as PRODUCT"
                  +" from demand_request a,province c,project d,demand_status e,product b"
                  +" where a.demand_id="+sIRM+" and a.project_code=d.proj_code and d.area_id=c.id and a.status=e.sta_id and a.product_id=b.product_id";
		     System.out.print("\n获取重点需求信息sql="+sSql+"\n");
		   }
		   else    //获取重点故障信息
		   {
			   sSql="select '[F'||a.request_id||']--'||a.rep_title as FUNCNAME,a.request_id as DEMAND_ID,c.id as DEMAND_PROV_ID, c.name  as DEMAND_PROV,"
				   +" e.ID as STATEID,e.name as STATE,null as PLAN_DEV_TIME,null as REAL_DEV_TIME,null as PLAN_TEST_TIME,null as REAL_TEST_TIME,"
				   +" '['||a.product_id||'] '||b.product_name as PRODUCT"
                   +" from project_request a,province c,project d,proj_status e,product b"
                   +" where a.request_id="+sIRM+" and a.proj_code=d.proj_code and d.area_id=c.id and a.rep_status=e.id and a.product_id=b.product_id";
			  //System.out.print("\n获取重点故障信息sql="+sSql+"\n");
		   }
		   Vector ver = new Vector();
		   DBConnection lib = new DBConnection();
		   ver=lib.selectVector(sSql);
		   return ver;
	   }

	   //查询需求
	   //modify by huyf
	   public Vector getRequirementList(String sdemandTitle,String sStartTime,String sEndTime,String sProductName,String sReqState,String sDemandID)
	   {

		   String  sSql="select '[R'||a.demand_id||']--'||a.demand_title as DEMAND_NAME,a.DEMAND_DESC as DEMAND_DESC, a.demand_id as DEMAND_ID,c.id as DEMAND_PROV_ID, c.name  as DEMAND_PROV,"
			  +" e.sta_id as STATEID,e.sta_name as STATE,to_char(a.plan_dev_time,'YYYY-MM-DD') as PLAN_DEV_TIME,a.dev_one_time as REAL_DEV_TIME,to_char(a.report_time,'YYYY-MM-DD') as REPORT_TIME, to_char(a.plan_dev_begin_time,'YYYY-MM-DD') as PLAN_DEV_BEGIN_TIME "
              +" ,(select op_name from op_login where op_id=a.dev_id) as DEV_ID ,(select op_name from op_login where op_id=a.tester_id) as TESTER_ID"
			  +" ,a.pso_deploy_time as PLAN_TEST_TIME,a.qa_time as REAL_TEST_TIME,'['||a.product_id||'] '||b.product_name as PRODUCT,d.project_name as PROJECT_NAME,decode(a.level_id,1,'紧急','一般'） as LEVEL_ID,a.finishtime as FINISHTIME "
              +" ,(select subsys_name_cn from subsys_def where subsys_id=a.SUB_SYS_ID) as SUBSYS_NAME ,(select module_name from product_detail where subsys_id=a.SUB_SYS_ID and module_id=a.module_id) as MODULE_NAME"
			  +" from demand_request a,province c,project d,demand_status e,product b "
              +" where a.project_code=d.proj_code and d.area_id=c.id and a.status=e.sta_id and a.product_id=b.product_id ";
	     
		   System.out.print("\n获取需求信息sql="+sSql+"\n");
	     
		  
		   if(!sStartTime.equals(""))
		   {
			   sSql=sSql+" and a.REP_TIME >= to_date('"+sStartTime+" 00:00:00','yyyy-mm-dd hh24:mi:ss')";
		   }
		   if(!sEndTime.equals(""))
		   {
			   sSql=sSql+" and a.REP_TIME<=to_date('"+sEndTime+" 23:59:59','yyyy-mm-dd hh24:mi:ss')";   
		   }
//		   if(!sProductName.equals(""))
//		   {
//			   sSql=sSql+" and substr(product,instr(product,'[')+1,instr(product,']')-instr(product,'[')-1) in("+sProductName+")";
//		   }
		   if(!sReqState.equals(""))  //需求状态
		   {
			   sSql=sSql+" and a.STATUS in("+sReqState+")"; 
		   }
		   if(!sdemandTitle.equals("") && sdemandTitle != null)  
		   {
			   sSql=sSql+" and a.DEMAND_TITLE like '%"+sdemandTitle+"%'"; 
		   }
		   if(!sDemandID.equals(""))  
		   {
			   sSql=sSql+" and a.DEMAND_ID ="+sDemandID; 
		   }
		 
		   sSql += " order by DEMAND_ID";
		   System.out.print("\ngetRequirementList函数根据查询条件查询需求列表sql="+sSql+"\n");
		   Vector ver = new Vector();
		   DBConnection lib = new DBConnection();
		   ver=lib.selectVector(sSql);
		   System.out.print("\n"+sSql);
		   return ver;
	   }

	   public Vector getDemandRequestById(String sDemandId)
	   {

		   String  sSql="select DEMAND_ID, PROJECT_CODE, PRODUCT_ID, MODULE_ID, DEMAND_TITLE, DEMAND_DESC, REP_TIME, REP_TEL, STATUS, FINISHTIME, DEMAND_TYPE, LEVEL_ID, REPORT_DOC, OPEN_ID, CONFIRM_ID, CONFRIM_TIME, REPORT_ID, REPORT_TIME, SCCB_ID, SCCB_TIME, DMR_ID, DMR_TIME, OPEN_VERSION, CLOSE_VERSION, DEPENDID, CLOSE_TIME, DOCUMENTS, DEV_TIME, QA_TIME, RM_TIME, WORKTIME_SCCB, WORKTIME_PM, WORKTIME_DEV, WORKTIME_QA, WORKTIME_BM, RESOURCE_ID, PLANTIME, INTRICACY, PSO_FOLLOW_TIME, DEV_ONE_TIME, PM_ONE_TIME, DEMAND_FILE, CUSTOMER_DEMD_ID, ISSUE_ID, SOURCE_ID, QA_INTEG_TIME, CC_MAIL, PSO_DEPLOY_TIME, JF_CONFIRM, INTEGRATION_TIME, INTEGRATION, LT_TIME, NG_STATUS, OLD_DEMAND_ID, GROUP_ID, DEV_ID, TESTER_ID, QA_LEADER, PLAN_DEV_TIME, REAL_DEV_TIME, PLAN_TEST_TIME, REAL_TEST_TIME, PLAN_RELEASE_TIME, REAL_RELEASE_TIME, SUB_SYS_ID, DEMAND_SRC_ID, VERSION_ID, PLAN_DEV_BEGIN_TIME "
			  +" from DEMAND_REQUEST "
              +" where 1=1 ";
	     
		   System.out.print("\n获取需求信息sql="+sSql+"\n");
		  
		   if(!sDemandId.equals(""))  
		   {
			   sSql=sSql+" and DEMAND_ID ="+sDemandId; 
		   }
		 
		   sSql += " order by DEMAND_ID";
		   System.out.print("\n getDemandRequestById函数根据查询条件查询需求列表sql="+sSql+"\n");
		   Vector ver = new Vector();
		   DBConnection lib = new DBConnection();
		   ver=lib.selectVector(sSql);
		   return ver;
	   }
	   
	   //获取测试人员编号和名称
	   public Vector getImportRequirementTesterInfo(String sIRM,int iIRMType)
	   {
		   String sSql="";
		   if(iIRMType==1) //获取需求测试人员编号和名称
		   {
			   sSql="select distinct(b.closer_id) as TESTER_ID,(select op_name from op_login where op_id=b.closer_id ) as TESTER_NAME"
                    +" from demand_request a,assignment b where a.demand_id="+sIRM+" and a.demand_id=b.dependid ";
		         //System.out.print("\n获取需求测试人员编号和名称sql="+sSql+"\n");
		   }
		   else    //获取故障测试人员编号和名称
		   {
			   sSql="select a.rep_qa as TESTER_ID,(select op_name from op_login where op_id = a.rep_qa ) as TEST_NAME"
                   +" from project_request a,province c,project d,proj_status e "
                   +" where a.request_id="+sIRM+" and a.proj_code=d.proj_code and d.area_id=c.id and a.rep_status=e.id";
		         //System.out.print("\n获取故障测试人员编号和名称sql="+sSql+"\n");  
		   }
		   Vector ver = new Vector();
		   DBConnection lib = new DBConnection();
		   ver=lib.selectVector(sSql);
		   return ver;
	   }
	   
	   //获取开发人员编号和名称
	   public Vector getImportRequirementDevInfo(String sIRM,int iIRMType)
	   {
		   String sSql="";
		   if(iIRMType==1) //获取需求开发人员编号和名称
		   {
			   sSql="select distinct(b.accepter_id) as DEV_ID,(select op_name from op_login where op_id=b.accepter_id ) as DEV_NAME"
                    +" from demand_request a,assignment b where a.demand_id="+sIRM+" and a.demand_id=b.dependid";
		         System.out.print("\n获取需求开发人员编号和名称sql="+sSql+"\n");
		   }
		   else    //获取故障开发人员编号和名称
		   {
			   sSql="select null as DEV_ID,null as DEV_NAME from project_request a,province c,project d,proj_status e"
                    +" where a.request_id="+sIRM+" and a.proj_code=d.proj_code and d.area_id=c.id and a.rep_status=e.id";
		         System.out.print("\n获取故障开发人员编号和名称sql="+sSql+"\n");  
		   }
		   Vector ver = new Vector();
		   DBConnection lib = new DBConnection();
		   ver=lib.selectVector(sSql);
		   return ver;
	   }
	
	   //判断需求或者故障是否存在
	   public boolean checkImportRequirementInfo(String sIRM,int iIRMType)
	   {
		   String sValue="";
		   String sSql="select * from ESPECIAL_DEMAND where type="+iIRMType+" and value="+sIRM;
		   //System.out.print("\n判断需求或者故障是否存在sql="+sSql);
		   DBConnection lib = new DBConnection();
		   ResultSet RS = lib.executeQuery(sSql);
	       try
	        {
	            RS.next();
	            sValue = RS.getString("VALUE");         
	            RS.close();
	        }catch(SQLException ex)
	        {
			   System.err.println("aq.executeQuery:"+ex.getMessage());
		    }
		    if((sValue != null ) &&  !(sValue.equals("")))
	              return true;
	        else
	              return false;
	   }
	   
	   public void insertImportRequirementInfo(String sIRM,int iIRMType,String opId,boolean sInsertTest,String sTestDate,boolean sInsertDev,String sDevDate,String sEmail,String sPlanDevDate,String sPlanTestDate,String sPlanReleaseDate,String sRemark,boolean sInsertRelease,String sReleaseDate)
	   {
		  //获取测试人员编号和名称
		    String sSql="";
			Vector vtest =getImportRequirementTesterInfo(sIRM,iIRMType);
			String sTestName="";
			String sTestId="";
			if(vtest.size()>0)
			{
			   for(int itest=0;itest<vtest.size();itest++)
			   {
			      HashMap testMap =(HashMap) vtest.get(itest);
			      if(itest==0)
			      {
			         sTestName=(String) testMap.get("TESTER_NAME");
			         sTestId=(String) testMap.get("TESTER_ID");
			      }
                  else
                  {
                     sTestName=sTestName+";"+(String) testMap.get("TESTER_NAME");
                     sTestId=sTestId+";"+(String) testMap.get("TESTER_ID");
                  }
			   }
			}
			//System.out.print("\n获取测试人员编号为="+sTestId+";获取测试人员名称为="+sTestName+"\n");
		   //获取开发人员编号和名称
			Vector vdve =getImportRequirementDevInfo(sIRM,iIRMType);
			String sDevName="";
			String sDevId="";
			if(vdve.size()>0)
			{
			   for(int idev=0;idev<vdve.size();idev++)
			   {
			      HashMap devMap =(HashMap) vdve.get(idev);
			      if(idev==0)
			      {
			         sDevName=(String) devMap.get("DEV_NAME");
			         sDevId=(String)devMap.get("DEV_ID");
			      }
                  else
                  {
                     sDevName=sDevName+";"+(String) devMap.get("DEV_NAME");
                     sDevId=sDevId+";"+(String) devMap.get("DEV_ID");
                  }
			   }
			}
			//System.out.print("\n获取开发人员编号为="+sDevId+";获取开发人员名称为="+sDevName+"\n");
         //获取需求或者故障信息
			Vector ver = getImportRequirementInfo(sIRM,iIRMType);
		    if(ver.size()>0)
		    {
                String SEQ="";
                //select nvl(max(seq)+1,1) as seq from ESPECIAL_DEMAND
		    	sSql="(select decode(seq,null,1,seq) as seq from (select max(seq)+1 as seq from ESPECIAL_DEMAND))";
				DBConnection lib = new DBConnection();
				ResultSet RS = lib.executeQuery(sSql);
			    try
			    {
			         RS.next();
			         SEQ = RS.getString("SEQ");         
			         RS.close();
			    }catch(SQLException ex)
			    {
					System.err.println("aq.executeQuery:"+ex.getMessage());
				}
			    //System.out.print("\n插入编号="+SEQ+"\n");
		    	HashMap map =(HashMap) ver.get(0);
		        String sFuncName=(String) map.get("FUNCNAME");
		        String sDEMAND_PROV=(String)map.get("DEMAND_PROV");
		        String STATEID=(String) map.get("STATEID");
		        String PLAN_DEV_TIME=(String) map.get("PLAN_DEV_TIME");
		        String REAL_DEV_TIME=(String) map.get("REAL_DEV_TIME");
     			String PLAN_TEST_TIME=(String) map.get("PLAN_TEST_TIME");
     			String REAL_TEST_TIME=(String) map.get("REAL_TEST_TIME");
     			String PRODUCT=(String)map.get("PRODUCT");
     			if(PLAN_DEV_TIME==null)
     				PLAN_DEV_TIME="";
     			if(PLAN_DEV_TIME!=null)
     		    {
     			  if(PLAN_DEV_TIME.length()>20)
     			    PLAN_DEV_TIME=PLAN_DEV_TIME.substring(0,19);
     			}
     			if(REAL_DEV_TIME==null)
     				REAL_DEV_TIME="";
     			if(REAL_DEV_TIME!=null)
     			{
     			  if(REAL_DEV_TIME.length()>20)
     			    REAL_DEV_TIME=REAL_DEV_TIME.substring(0,19);
     		    }
     			if(PLAN_TEST_TIME==null)
     				PLAN_TEST_TIME="";
     		    if(PLAN_TEST_TIME!=null)
     		    {
     			  if(PLAN_TEST_TIME.length()>20)
     			    PLAN_TEST_TIME=PLAN_TEST_TIME.substring(0,19);
     			}
     		    if(REAL_TEST_TIME==null)
     		    	REAL_TEST_TIME="";
     			if(REAL_TEST_TIME!=null)
     			{
     			  if(REAL_TEST_TIME.length()>20)
     			    REAL_TEST_TIME=REAL_TEST_TIME.substring(0,19);
     			}
     			sSql="insert into ESPECIAL_DEMAND(SEQ,TYPE,VALUE,NAME,DEMAND_PROV,DEV_ID,DEV_NAME,TESTER_ID,TESTER_NAME,STATE,PLAN_DEV_TIME,REAL_DEV_TIME,PLAN_TEST_TIME,REAL_TEST_TIME,OP_ID,OP_TIME,FLAG,PRODUCT,PLAN_RELEASE_TIME,REAL_RELEASE_TIME,REMARK) "
     				 +" values("+SEQ+","+iIRMType+","+sIRM+",'"+sFuncName+"','"+sDEMAND_PROV+"','"+sDevId+"','"+sDevName+"','"+sTestId+"','"+sTestName+"','"+STATEID+"',to_date('"+sPlanDevDate+"','yyyy-mm-dd hh24:mi:ss'),"+"to_date('"+REAL_DEV_TIME+"','yyyy-mm-dd hh24:mi:ss'),"+"to_date('"+sPlanTestDate+"','yyyy-mm-dd hh24:mi:ss'),"+"to_date('"+REAL_TEST_TIME+"','yyyy-mm-dd hh24:mi:ss'),"+opId+",sysdate,"+1+",'"+PRODUCT+"',to_date('"+sPlanReleaseDate+"','yyyy-mm-dd hh24:mi:ss'),"+"to_date('','yyyy-mm-dd hh24:mi:ss'),'"+sRemark+"')";
    		    
     			//System.out.print("将重点需求故障插入到重点需求表中sql="+sSql);
     			lib.executeUpdate(sSql);
     			//System.out.print("插入成功\n");
     			//插入提醒时间
     			insertRuleInfo(SEQ,sInsertTest,sTestDate,sInsertDev,sDevDate,sEmail, sInsertRelease,sReleaseDate);
		    }
		   
	   }
	   
	   public void insertRuleInfo(String sSeq,boolean sInsertTest,String sTestDate,boolean sInsertDev,String sDevDate,String sEmail,boolean sInsertRelease,String sReleaseDate)
	   {
		  String sSql="";
		  int iCheck=0;
		  int iSeq=1;
		  DBConnection lib = new DBConnection();
		  if(sInsertTest==true)  //当测试时间需要提醒的时候
		  {
			  sSql="insert into DEMAND_REMINDER_RULE(DEMAND_SEQ,RULE_ID,COND_FIELD,COND_VALUE,REMINDER_OP)"
				  +" values("+sSeq+",(select nvl(max(rule_id)+1,1)  from DEMAND_REMINDER_RULE where demand_seq="+sSeq+"),'PLAN_TEST_TIME','"+sTestDate+"','"+sEmail+"')";
			  //System.out.print("将重点需求故障提醒时间插入DEMAND_REMINDER_RULE到sql="+sSql);
 			  lib.executeUpdate(sSql);
 			 iCheck=1;
		  }
		  if(sInsertDev==true) //当开发时间需要提醒的时候
		  {
			 if(iCheck==1)
			 {
				 iSeq=2; 
			 }
			  sSql="insert into DEMAND_REMINDER_RULE(DEMAND_SEQ,RULE_ID,COND_FIELD,COND_VALUE,REMINDER_OP)"
				  +" values("+sSeq+",(select nvl(max(rule_id)+1,1)  from DEMAND_REMINDER_RULE where demand_seq="+sSeq+"),'PLAN_DEV_TIME','"+sDevDate+"','"+sEmail+"')";
			  //System.out.print("将重点需求故障提醒时间插入DEMAND_REMINDER_RULE到sql="+sSql);
 			  lib.executeUpdate(sSql);
 			 iCheck=2;
		  }
		  if(sInsertRelease==true) //当发布时间需要提醒的时候
		  {
			 if(iCheck==2)
			 {
				 iSeq=3; 
			 }
			  sSql="insert into DEMAND_REMINDER_RULE(DEMAND_SEQ,RULE_ID,COND_FIELD,COND_VALUE,REMINDER_OP)"
				  +" values("+sSeq+",(select nvl(max(rule_id)+1,1)  from DEMAND_REMINDER_RULE where demand_seq="+sSeq+"),'PLAN_RELEASE_TIME','"+sReleaseDate+"','"+sEmail+"')";
			  //System.out.print("将重点需求故障提醒时间插入DEMAND_REMINDER_RULE到sql="+sSql);
 			  lib.executeUpdate(sSql);
		  }
		  //System.out.print("\n插入成功\n");
	   }
	   
	   //查询重点需求故障录入信息
	   public Vector getDataBaseDate()
	   {
		   String sSql="select to_char(sysdate-7,'YYYY-MM-DD') sdate_s,to_char(sysdate,'YYYY-MM-DD') sdate from dual";
		   Vector ver = new Vector();
		   DBConnection lib = new DBConnection();
		   ver=lib.selectVector(sSql);
		   return ver;
	   }
	   
	   public Vector getAllProductInfo(String sproductid)
	   {
		   String sSql="select product_id,product_name,'['||product_id||']'||product_name as name "
			   +" from product where product_id in ("+sproductid+") order by name";
		   Vector ver = new Vector();
		   DBConnection lib = new DBConnection();
		   ver=lib.selectVector(sSql);
		   return ver;
	   }
	   
	   public Vector getAllRequirement(String DemandStatus)
	   {
		   String sSql="select sta_id as id,sta_name as name from demand_status where sta_id in ("+DemandStatus+")";
		   Vector ver = new Vector();
		   DBConnection lib = new DBConnection();
		   ver=lib.selectVector(sSql);
		   return ver;
	   }
	   
	   public Vector getAllMalfunction(String Projectstatus)
	   {
		   String sSql="select id,name from proj_status where id in ("+Projectstatus+")";
		   Vector ver = new Vector();
		   DBConnection lib = new DBConnection();
		   ver=lib.selectVector(sSql);
		   return ver;
	   }
	   
	   public Vector getQueryImportRequirement(String sStartTime,String sEndTime,String sProductName,String sReqState,String sGuState,String sReqCode,String sGuCode,String opId,String sflag)
	   {
		//   String sSql="select * from  ESPECIAL_DEMAND where type=1 ";  //需求
		//   String sSql1="select * from  ESPECIAL_DEMAND where type=2 ";  //故障
		   String sSql=" select SEQ,TYPE,VALUE,NAME,DEMAND_PROV,DEV_ID,DEV_NAME,TESTER_ID,TESTER_NAME,STATE,"
			          +" to_char(PLAN_DEV_TIME,'YYYY-MM-DD HH24:MI:SS') as PLAN_DEV_TIME,to_char(REAL_DEV_TIME,'YYYY-MM-DD HH24:MI:SS') as REAL_DEV_TIME,"
			          +" to_char(PLAN_TEST_TIME,'YYYY-MM-DD HH24:MI:SS') as PLAN_TEST_TIME,to_char(REAL_TEST_TIME,'YYYY-MM-DD HH24:MI:SS') as REAL_TEST_TIME,"
			          +" OP_ID,to_char(OP_TIME,'YYYY-MM-DD HH24:MI:SS') as OP_TIME,FLAG,PRODUCT,(select sta_name from demand_status where sta_id in(STATE))  as state_name,"
			          +" to_char(PLAN_RELEASE_TIME,'YYYY-MM-DD HH24:MI:SS') as PLAN_RELEASE_TIME,to_char(REAL_RELEASE_TIME,'YYYY-MM-DD HH24:MI:SS') as REAL_RELEASE_TIME,REMARK "
			          +" from  ESPECIAL_DEMAND where type=1 ";  //需求
		   String sSql1="select SEQ,TYPE,VALUE,NAME,DEMAND_PROV,DEV_ID,DEV_NAME,TESTER_ID,TESTER_NAME,STATE,"
			   		  +" to_char(PLAN_DEV_TIME,'YYYY-MM-DD HH24:MI:SS') as PLAN_DEV_TIME,to_char(REAL_DEV_TIME,'YYYY-MM-DD HH24:MI:SS') as REAL_DEV_TIME,"
			   		  +" to_char(PLAN_TEST_TIME,'YYYY-MM-DD HH24:MI:SS') as PLAN_TEST_TIME,to_char(REAL_TEST_TIME,'YYYY-MM-DD HH24:MI:SS') as REAL_TEST_TIME,"
			   		  +" OP_ID,to_char(OP_TIME,'YYYY-MM-DD HH24:MI:SS') as OP_TIME,FLAG,PRODUCT,(select name  from proj_status  where id in(STATE))  as state_name,"
			   		  +" to_char(PLAN_RELEASE_TIME,'YYYY-MM-DD HH24:MI:SS') as PLAN_RELEASE_TIME,to_char(REAL_RELEASE_TIME,'YYYY-MM-DD HH24:MI:SS') as REAL_RELEASE_TIME,REMARK "
			   		  +" from  ESPECIAL_DEMAND where type=2 ";  //故障
		   if(!opId.equals(""))
		   {
			   sSql=sSql+" and OP_ID="+opId;
			   sSql1=sSql1+" and OP_ID="+opId;
		   }
		   if(!sStartTime.equals(""))
		   {
			   sSql=sSql+" and op_time>=to_date('"+sStartTime+" 00:00:00','yyyy-mm-dd hh24:mi:ss')";
			   sSql1=sSql1+" and op_time>=to_date('"+sStartTime+" 00:00:00','yyyy-mm-dd hh24:mi:ss')";
		   }
		   if(!sEndTime.equals(""))
		   {
			   sSql=sSql+" and op_time<=to_date('"+sEndTime+" 23:59:59','yyyy-mm-dd hh24:mi:ss')";   
			   sSql1=sSql1+" and op_time<=to_date('"+sEndTime+" 23:59:59','yyyy-mm-dd hh24:mi:ss')";   
		   }
		   if(!sProductName.equals(""))
		   {
			   sSql=sSql+" and substr(product,instr(product,'[')+1,instr(product,']')-instr(product,'[')-1) in("+sProductName+")";
			   sSql1=sSql1+" and substr(product,instr(product,'[')+1,instr(product,']')-instr(product,'[')-1) in("+sProductName+")";
		   }
		   if(!sReqState.equals(""))  //需求状态
		   {
			   sSql=sSql+" and state in("+sReqState+")"; 
		   }
		   if(!sGuState.equals(""))//故障状态
		   {
			   sSql1=sSql1+" and state in("+sReqState+")"; 
		   }
		   if(!sReqCode.equals(""))//需求编号
		   {
			   sSql=sSql+" and value in("+sReqCode+")";
		   }
		   if(!sGuCode.equals(""))//故障编号
		   {
			   sSql1=sSql1+" and value in("+sGuCode+")";
		   }
		   if(!sflag.equals(""))//重点需求标识
		   {
			   sSql=sSql+" and flag ="+sflag;
			   sSql1=sSql1+" and flag ="+sflag;
		   }
		   sSql=sSql+" union "+sSql1;
		   
		   sSql += " order by demand_prov,product,seq";
		   //System.out.print("\ngetQueryImportRequirement函数根据查询条件查询重点需求故障信息sql="+sSql+"\n");
		   Vector ver = new Vector();
		   DBConnection lib = new DBConnection();
		   ver=lib.selectVector(sSql);
		   //System.out.print("\n"+sSql);
		   return ver;
	   }


	   
	 public void updateDate()
	 {
	    //System.out.print("\n调用存储过程更新数据，执行updateDateupdateDate\n");
	    DBConnection lib = new DBConnection();
	    String procedure = "{call UpdateImportRequirement()}";
	    lib.executeProcess(procedure);
	 }
	   
	   
	 public static void main(String args[])
	 {
		 ImportRequriment test1 =new ImportRequriment();
		 test1.updateDate();
		 //String sStartTime,String sEndTime,String sProductName,String sReqState,String sGuState,String sReqCode,String sGuCode
		// Vector ver =test1.getQueryImportRequirement("2009-01-07","2009-01-07","2,3","10","10","19921","19921");
		// System.out.print("\n");
	//	 for(int i=0;i<ver.size();i++)
	//	 {
	///		HashMap map =(HashMap) ver.get(i);
	//		String sSeq =(String) map.get("SEQ");
	//		System.out.print("获取记录为="+sSeq+"\n");
	//	 }
		 //boolean test =test1.checkImportRequirementInfo("19921",1);
		
		 //System.out.print("\n结果为="+test+"\n");
		//test1.insertImportRequirementInfo("19921",1,"1");
		 
		 //boolean sInsertTest,String sTestDate,boolean sInsertDev,String sDevDate,String sEmail)
		// test1.insertImportRequirementInfo("19921",1,"1",true,"2",true,"3","pansq@asiainfo.com");
		// Vector ver =test1.getImportRequirementTesterInfo("19921", 1);
		// Vector ver =test1.getImportRequirementDevInfo("19921", 1);
		// Vector ver = test1.getImportRequirementInfo("19921", 1);
		// Vector ver =test1.getAllMailInfo();
	 //    for(int i=0;i<ver.size();i++)
		// {
	  //  	 HashMap has = (HashMap) ver.get(i);
		//	 String email =(String) has.get("DEV_ID");
		//	 System.out.print(email+"\n");
			 
		// }
	 }

}
