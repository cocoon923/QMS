package dbOperation;

import java.net.URL;
import java.sql.Blob;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;
import java.io.*;

import org.omg.CORBA.portable.InputStream;

import dbOperation.*;
public class Approval 
{
	/*
	 * 查询操作员待处理的任务单/bug单
	 @para sType -- 传入操作员类型：1：DEV  2：QA 。 不能为空
	 @para sOpId -- 操作员id。不能为空,多个id用英文逗号分割。
	 @para sAssignmentStatus -- 任务单状态。不能为空,多个id用英文逗号分割。
	 @para sSlipStatus --- bug单状态。不能为空,多个id用英文逗号分割。
	 * --select * from qcs.assignment_status
		*--2	检验中
		*--3	再处理中
		*--4	确认完成
		*--1	开发中
		*--5	提交完成待预编译
		*--6	预编译完成
	*--select * from qcs.slip_status
		*--2	已经解决
		*--3	已删除
		*--4	待QA确认
		*--6	待DEV处理
		*--7	暂时不解决
		*--8	下版本解决
		*--9	工程Bug待确认
		*--10	不是Bug
		*--11	提交完成待预编译
		*--12	预编译完成
	 */   
	public Vector getPendingTask(String sType,String sOpId,String sAssignmentStatus,String sSlipStatus)
	   {
		   String sSql="";
		   if(sType.equals("1"))
		   {
			sSql=" select  '['||task_id||'] - '||title||' ( 需求ID-'||dependid||' )' as name,task_id as id,1 as type from qcs.assignment "
				+" where accepter_id in ("+sOpId+") and status_id in ("+sAssignmentStatus+")"
				+" union "
				+" select '['||slip_id||'] - '||title,slip_id as id,2 as type from qcs.slips "
				+" where accepter_id in ("+sOpId+") and status_id in ("+sSlipStatus+")"
				+" order by type,id ";		
		   }
		   else if(sType.equals("2"))
		   {
			sSql=" select  '['||task_id||'] - '||title||' ( 需求ID-'||dependid||' )' as name,task_id as id,1 as type from qcs.assignment "
				+" where CLOSER_ID in ("+sOpId+") and status_id in ("+sAssignmentStatus+")"
				+" union "
				+" select '['||slip_id||'] - '||title,slip_id as id,2 as type from qcs.slips "
				+" where CLOSER_ID in ("+sOpId+") and status_id in ("+sSlipStatus+")"
				+" order by type,id ";				   
		   }
		   else
		   {
			   System.out.print("传入的sType类型不正确，只能传入1、2，请确认");
		   }
		   System.out.print("sSql="+sSql);
			Vector ver = new Vector();
			DBConnection lib = new DBConnection();
			ver=lib.selectVector(sSql);		   
			return ver;
	   }
	
/*
 * 查询配置审批流程
 */
	public Vector getApprovalProcessDef(String sType)
	{
		String sSql="select * from aicms.approval_process where approval_type="+ sType +"order by sequence desc";
		Vector ver = new Vector();
		DBConnection lib = new DBConnection();
		ver=lib.selectVector(sSql);		   
		return ver;
	}
	
	/*
	 * 获取申请单序列号
	 */
		public String getRecordSeq()
		{
			String sSql="select aicms.application_record_seq.nextval as SEQ from dual";
			String sSeq="";
			Vector ver = new Vector();
			DBConnection lib = new DBConnection();
			ver=lib.selectVector(sSql);	
			HashMap hash = (HashMap) ver.get(0);
			sSeq = (String)hash.get("SEQ");
			return sSeq;
		}
	
	public void CommitApplicationRecord(String sType,String sOpID,String sProductId,String sSubsysId,String sModuleId,String sVersion,String sSlips,String sAssignment,String sRemark,String sOBD,String sDB)
	{
		if(sSlips==null) sSlips="";
		if(sAssignment==null) sAssignment="";
		
		Vector vApprovalProcessDef = new Vector();
		vApprovalProcessDef = getApprovalProcessDef(sType);
		String sPROCESS_ID="";
		String sAPPROVAL_OFFICER_ID="";
		String sAPPROVAL_OFFICER_NAME="";
		String sIS_FINISH="";
		String sIS_OP_ID="";
		String sSEQUENCE="";
		
		String sapproval_officer_id_temp="";
		
		String sRecordSeq="";
		sRecordSeq=getRecordSeq();
		//写申请单记录表
		String sSql=" insert into aicms.application_record (seq,application_type,applicants_id,current_approval_id,product_id,sub_sys_id,module_id,version,"
			       +" application_time,approval_last_time,bug_id,assignment_id,is_finish,approval_sts,remark,db,obd)"
			       +" values("+sRecordSeq+","+sType+","+sOpID+",null,"+sProductId+","+sSubsysId+","+sModuleId+","+sVersion
			       +",sysdate,null,'"+sSlips+"','"+sAssignment+"',0,0,'"+sRemark+"',"+sOBD+","+sDB+")";
		DBConnection lib = new DBConnection();
		//System.out.print("sSql="+sSql);
		lib.executeUpdate(sSql);
		
		String sSqlTrack="";
		String sSqlUpdateRecord="";
		
		//写申请单审批轨迹表
		if(vApprovalProcessDef.size()>0)
		{
			for(int i=0;i<vApprovalProcessDef.size();i++)
			{
				HashMap hash = (HashMap) vApprovalProcessDef.get(i);
				sPROCESS_ID=(String)hash.get("PROCESS_ID");
				sAPPROVAL_OFFICER_ID=(String)hash.get("APPROVAL_OFFICER_ID");
				sAPPROVAL_OFFICER_NAME=(String)hash.get("APPROVAL_OFFICER_NAME");
				sIS_FINISH=(String)hash.get("IS_FINISH");
				sIS_OP_ID=(String)hash.get("IS_OP_ID");
				sSEQUENCE=(String)hash.get("SEQUENCE");
				//如果取到审批人员占位符，不是具体的opid，则取审批单关联的任务单或bug单对应的qa或dev。
				if(sIS_OP_ID.equals("0"))
				{
					if(sAPPROVAL_OFFICER_ID.equals("0"))//通配qa
					{
						if(!sAssignment.equals(""))
						{
							sapproval_officer_id_temp="(select closer_id from qcs.assignment where task_id in("+sAssignment+") and rownum<2)";
						}
						else if (!sSlips.equals(""))
						{
							sapproval_officer_id_temp="(select closer_id from qcs.slips where slip_id in("+sSlips+") and rownum<2)";
						}
													
						sSqlTrack="insert into aicms.application_record_track (record_seq,sequence,process_id,approval_officer_id,approval_result,is_finish)"
							     +"values("+sRecordSeq+","+sSEQUENCE+","+sPROCESS_ID+","+sapproval_officer_id_temp+",0,"+sIS_FINISH+")";
					}
					else if(sAPPROVAL_OFFICER_ID.equals("1")) //通配DEV
					{
						if(!sAssignment.equals(""))
						{
							sapproval_officer_id_temp="(select ACCEPTER_ID from qcs.assignment where task_id in("+sAssignment+"))";
						}
						else if (!sSlips.equals(""))
						{
							sapproval_officer_id_temp="(select ACCEPTER_ID from qcs.slips where slip_id in("+sSlips+"))";
						}
													
						sSqlTrack="insert into aicms.application_record_track (record_seq,sequence,process_id,approval_officer_id,approval_result,is_finish)"
							 	 +"values("+sRecordSeq+","+sSEQUENCE+","+sPROCESS_ID+","+sapproval_officer_id_temp+",0,"+sIS_FINISH+")";
					}
				}
				else //sIS_OP_ID=1，配置的是具体的审批人，直接写入表中。
				{
					sSqlTrack="insert into aicms.application_record_track (record_seq,sequence,process_id,approval_officer_id,approval_result,is_finish)"
						     +"values("+sRecordSeq+","+sSEQUENCE+","+sPROCESS_ID+","+sAPPROVAL_OFFICER_ID+",0,"+sIS_FINISH+")";
				}
				System.out.print("sSqlTrack="+sSqlTrack);
				lib.executeUpdate(sSqlTrack);	
			}
			//更新申请单记录表中的第一审批人
			sSqlUpdateRecord="update aicms.application_record set current_approval_id="
							+"(select approval_officer_id from aicms.application_record_track where record_seq="+sRecordSeq+" and sequence=1) "
							+" where seq="+sRecordSeq;
			System.out.print("sSqlUpdateRecord="+sSqlUpdateRecord);
			lib.executeUpdate(sSqlUpdateRecord);
		}

	}
	
	/*
	 * 查询我的审批信息
	 * @para sType：0-查询我提交的审批；1-查询待我审批的记录
	 * @para sOpId:查询用户的id。
	 */
		public Vector getMyApproval(String sType,String sOpId)
		{
			String sSql="";
			if(sType.equals("0"))
			{
				sSql="select a.seq as SEQ,a.current_approval_id as OP_ID,'[' || b.op_id || '] ' || b.op_name as OP_NAME,a.application_type as TYPE_ID,"
					+"(select  '[' ||code_value || '] ' ||cname from aicms.sys_base_type where table_name='APPLICATION_RECORD' and col_name='APPLICATION_TYPE' and code_value=a.APPLICATION_TYPE) as TYPE_NAME, "
					+"a.approval_sts as STS_ID,(select  '[' ||code_value || '] ' ||cname from aicms.sys_base_type where table_name='APPLICATION_RECORD' and col_name='APPROVAL_STS' and code_value=a.APPROVAL_STS) as STS_NAME,"
					+"a.application_time as TIME from aicms.application_record a, qcs.op_login b where a.current_approval_id=b.op_id and a.APPLICANTS_ID ="+sOpId+" order by a.seq";
			}
			else //sType=1
			{
				sSql="select a.seq as SEQ,a.current_approval_id as OP_ID,'[' || b.op_id || '] ' || b.op_name as OP_NAME,a.application_type as TYPE_ID,"
					+"(select  '[' ||code_value || '] ' ||cname from aicms.sys_base_type where table_name='APPLICATION_RECORD' and col_name='APPLICATION_TYPE' and code_value=a.APPLICATION_TYPE) as TYPE_NAME, "
					+"a.approval_sts as STS_ID,(select  '[' ||code_value || '] ' ||cname from aicms.sys_base_type where table_name='APPLICATION_RECORD' and col_name='APPROVAL_STS' and code_value=a.APPROVAL_STS) as STS_NAME,"
					+"a.application_time as TIME from aicms.application_record a, qcs.op_login b where a.current_approval_id=b.op_id and a.CURRENT_APPROVAL_ID ="+sOpId+" order by a.seq";
			}
			
			Vector ver = new Vector();
			DBConnection lib = new DBConnection();
			ver=lib.selectVector(sSql);		   
			return ver;
		}
		
		
		/*
		 * 查询审批单轨迹信息
		 * @para sRecordSeq : 申请单号
		 * @para sSts ：0--只查已经审批的记录；1--查所有记录
		 */
			public Vector getMyApplicationRecordTrackInfo(String sRecordSeq,String sSts)
			{
				String sSql="select a.sequence as SEQ,a.approval_officer_id as OP_ID,'[' || b.op_id || '] ' || b.op_name as OP_NAME,a.process_id as PROCESS_ID,"
					       +"(select  '[' ||id || '] '||name from aicms.approval_process_def where sts=1 and id=a.process_id) as PROCESS_NAME,"
					       +"a.approval_result as RESULT_ID,(select  '[' ||code_value || '] ' ||cname from aicms.sys_base_type where table_name='APPLICATION_RECORD_TRACK' and col_name='APPROVAL_RESULT' and code_value=a.approval_result) as RESULT_NAME,"
					       +"a.approval_time as TIME,a.remark as REMARK from aicms.application_record_track a, qcs.op_login b "
					       +" where a.approval_officer_id = b.op_id and a.record_seq ="+sRecordSeq;
				if(sSts.equals("0"))
				{
					sSql += " and a.approval_finish <>0";
				}
				
				sSql += " order by a.sequence";
				
				Vector ver = new Vector();
				DBConnection lib = new DBConnection();
				ver=lib.selectVector(sSql);		   
				return ver;
			}


/*   
	   public static void main(String args[])
	   {
		   copyCaseInfo("19925",1,"2");
		  // updateDemandInfo("19925",1,"原始需求内容","需求的解决方案","需求变更确认信息","[注释1] 功能适用","[注释2] 需求单号","[注释3] 涉及修改","[注释4] 测试结论","[注释5]备注|特别提醒");
	   }

	   public static void main(String args[])
	   {
		   //Vector ver = new Vector();
		   //ver=getAllCaseInfo("19925",1);
		   String test=test();
		   System.out.print("test="+test);
		   
		  /*System.out.print("ver.size()="+ver.size()+"\n");
		   for (int i = 0; i < ver.size(); i++) {
			    HashMap hash = (HashMap) ver.get(i);
			    String name = (String) hash.get("DEMAND_ID");
			    String password = (String) hash.get("CASE_ID");
			    System.out.println(name+"   "+password);
			    System.out.print("-----\n");
			  }*/
	   //}*/
}