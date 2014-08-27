package dbOperation;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.*;

import java.net.URL;
import java.sql.Blob;
import java.io.*;

import org.omg.CORBA.portable.InputStream;

import dbOperation.*;


public class CaseOpera {
    /**
     * 根据case序列号返回case信息
     * @param scaseSeq case序列号，case唯一标识
     */
	public Vector querycaseRec (String scaseSeq)
	{ 

		String ssql = " select CASE_SEQ,CASE_ID,DEMAND_ID,CASE_NAME,CASE_DESC,CASE_DATA_PREPARE,EXP_RESULT,"
					+ " PRO_VERSION_CODE,CLI_INFO_ID,SVR_INFO_ID,SUB_SYS_ID,MODULE_ID,PROGRAM_NAME,STATUS,"
					+ " STATUS_TIME,CASE_TYPE,CASE_SOURCE,OP_ID,OP_TIME,CREATE_TIME,CASE_ENV,CASE_CONCLUSION from case_rec"
					+ " where 1=1";
		if(scaseSeq==null)
		{
			ssql += " and case_seq=''";
		}
		else
		{
			ssql+= " and case_seq=" + scaseSeq;
		}
		//System.out.print("\n" + "	" + ssql + "	" + "\n");
		 Vector ver = new Vector();
		 DBConnection lib = new DBConnection();
		 ver=lib.selectVector(ssql);
		 return ver;
    }
	
	public Vector querycaseRecbyCaseId (String sCaseId)
	{ 

		String ssql = " select CASE_SEQ,CASE_ID,DEMAND_ID,CASE_NAME,CASE_DESC,CASE_DATA_PREPARE,EXP_RESULT,"
					+ " PRO_VERSION_CODE,CLI_INFO_ID,SVR_INFO_ID,SUB_SYS_ID,MODULE_ID,PROGRAM_NAME,STATUS,"
					+ " STATUS_TIME,CASE_TYPE,CASE_SOURCE,OP_ID,OP_TIME,CREATE_TIME,CASE_ENV,CASE_CONCLUSION from case_rec"
					+ " where 1=1";
		if(sCaseId==null)
		{
			ssql += " and case_id=''";
		}
		else
		{
			ssql+= " and case_id='" + sCaseId +"'";
		}
		//System.out.print("\n" + "	" + ssql + "	" + "\n");
		 Vector ver = new Vector();
		 DBConnection lib = new DBConnection();
		 ver=lib.selectVector(ssql);
		 return ver;
    }

    /**
     * 根据需求编号、故障编号返回case信息
     * @param scaseSeq case序列号，case唯一标识
     */
	public Vector querycaseProcess (String scaseSeq,String sprocessid)
	{ 
		String ssql = " select CASE_SEQ,CASE_ID,PROCESS_ID,PROCESS_DESC,EXP_RESULT,CASE_DATA_CHECK,CASE_LOG,"
					+ " REAL_RESULT,STATUS,STATUS_TIME,IN_DUMP,OUT_DUMP,ACCESSORY from case_process"
					+ " where CASE_SEQ=" + scaseSeq ;
		if((sprocessid!=null)&&(sprocessid!=""))
		{
			ssql += " and process_id="+sprocessid+" order by process_id";
		}
		else
		{
			ssql += " order by process_id";
		}
		//System.out.print("\n" + "	" + ssql + "	" + "\n");
		 Vector ver = new Vector();
		 DBConnection lib = new DBConnection();
		 ver=lib.selectVector(ssql);
		 return ver;
    }

	/**
	 * 根据入参更新case信息（insert case_rec表）
	 * @param stype  编号类型：1：需求编号；2：故障编号
	 * @param svalue  编号值，与stype配合使用，当stype=1时，此处为需求编号；当stype=2时，此处为故障编号
	 */
	public String addcaseinfo(String stype,String svalue,String scaseid,String scasename,String scasedesc,String scasedataprepare,String sexpresult,String sproversioncode,String scliinfoid,String ssvrinfoid,String ssubsysid,String smoduleid,String sprogramname,String scasetype,String sopid,String scaseenv,String scaseconclusion)
	{
		String ssql="";
		String ssql1="";
		String snewCaseSeq="";

		DBConnection lib = new DBConnection();
		ssql="select case_seq.nextval as NEWCASESEQ from dual";
		//System.out.print("\n" + "	" + ssql + "	" + "\n");
		ResultSet RS = lib.executeQuery(ssql);
        try
        {
            RS.next();
            snewCaseSeq = RS.getString("NEWCASESEQ");   
            RS.close();
        }catch(SQLException ex)
        {
		  System.err.println("aq.executeQuery:"+ex.getMessage());
	    }
        //System.out.print("新caseseq="+ snewCaseSeq +"\n");
        
		  if(svalue!=null)
			  svalue=svalue.replaceAll("'", "''");
		  if(scasename!=null)
			  scasename=scasename.replaceAll("'", "''");
		  if(scasedesc!=null)
			  scasedesc=scasedesc.replaceAll("'", "''");
		  if(scasedataprepare!=null)
			  scasedataprepare=scasedataprepare.replaceAll("'", "''");
		  if(sexpresult!=null)
			  sexpresult=sexpresult.replaceAll("'", "''");
		  if(sprogramname!=null)
			  sprogramname=sprogramname.replaceAll("'", "''");
		  if(scaseenv!=null)
			  scaseenv=scaseenv.replaceAll("'", "''");
		  if(scaseconclusion!=null)
			  scaseconclusion=scaseconclusion.replaceAll("'", "''");
		
		ssql1= "insert into case_rec(CASE_SEQ,CASE_ID,DEMAND_ID,CASE_NAME,CASE_DESC,CASE_DATA_PREPARE,EXP_RESULT,PRO_VERSION_CODE,CLI_INFO_ID,SVR_INFO_ID,SUB_SYS_ID,MODULE_ID,PROGRAM_NAME,STATUS,STATUS_TIME,CASE_TYPE,CASE_SOURCE,OP_ID,OP_TIME,CREATE_TIME,CASE_ENV,CASE_CONCLUSION)"
		    + " values(" + snewCaseSeq + ",'"+ scaseid +"','" + svalue +"','" + scasename + "','" + scasedesc + "','" +scasedataprepare + "','" +sexpresult + "','" + sproversioncode + "','" + scliinfoid + "','"+ ssvrinfoid + "','" + ssubsysid + "','" + smoduleid + "','" + sprogramname + "','1',sysdate,'"+ scasetype+"','" + stype + "','" + sopid + "',sysdate ,sysdate,'" + scaseenv + "','" +scaseconclusion + "')";
		//System.out.print("插入sql="+ssql1);
		 lib.executeUpdate(ssql1);
		 //System.out.print("插入成功!");
		 //System.out.print("\n" + "	" + ssql1 + "	" + "\n");
		 return snewCaseSeq;
	}

	
	/**
	 * 根据入参更新case信息（包含功能：insert、update、delete操作case_rec表）
	 * @param stype  编号类型：1：需求编号；2：故障编号
	 * @param svalue  编号值，与stype配合使用，当stype=1时，此处为需求编号；当stype=2时，此处为故障编号
	 */
	public String updatecaseinfo(String scaseseq,String scasename,String scasedesc,String scasedataprepare,String sexpresult,String sproversioncode,String scliinfoid,String ssvrinfoid,String ssubsysid,String smoduleid,String sprogramname,String scasetype,String sopid,String scaseenv,String scaseconclusion)
	{
		String ssql="";
		String snewCaseSeq="";

		DBConnection lib = new DBConnection();
		  if(scasename!=null)
			  scasename=scasename.replaceAll("'", "''");
		  if(scasedesc!=null)
			  scasedesc=scasedesc.replaceAll("'", "''");
		  if(scasedataprepare!=null)
			  scasedataprepare=scasedataprepare.replaceAll("'", "''");
		  if(sexpresult!=null)
			  sexpresult=sexpresult.replaceAll("'", "''");
		  if(sprogramname!=null)
			  sprogramname=sprogramname.replaceAll("'", "''");
		  if(scaseenv!=null)
			  scaseenv=scaseenv.replaceAll("'", "''");
		  if(scaseconclusion!=null)
			  scaseconclusion=scaseconclusion.replaceAll("'", "''");
		snewCaseSeq=scaseseq;
		ssql= "update case_rec set CASE_NAME='"+ scasename +"',CASE_DESC='" + scasedesc + "',CASE_DATA_PREPARE='"+scasedataprepare+"',EXP_RESULT='"+sexpresult+"',PRO_VERSION_CODE='"+sproversioncode+"',CLI_INFO_ID='"+scliinfoid+"',SVR_INFO_ID='"+ssvrinfoid+"',SUB_SYS_ID='"+ssubsysid+"',MODULE_ID='"+smoduleid+"',PROGRAM_NAME='"+sprogramname+"',CASE_TYPE='"+ scasetype + "',OP_ID='"+sopid+"',CASE_ENV='"+scaseenv+"',CASE_CONCLUSION='"+scaseconclusion+"' "
			+ " where case_seq='"+ scaseseq+"'";
			
		//System.out.print("更新sql="+ssql);
		 lib.executeUpdate(ssql);
		 //System.out.print("更新成功!");
		 //System.out.print("\n" + "	" + ssql + "	" + "\n");
		 return snewCaseSeq;
	}

    /**
     * 根据case_seq返回步骤id（原则：取此case的最大步骤id+1）
     * @param scaseSeq case序列号
     */
	public String getCaseProcessID (String scaseSeq)
	{ 	String sNewCaseProcessID="";
		//String ssql = " select max(decode((select max(process_id) from case_process where case_seq="+scaseSeq+"),"
		//			+ " null,0,(select max(process_id) from case_process where case_seq="+scaseSeq+")))+1"
		//			+ " AS NEWSTEPID from dual";
		String ssql="select nvl(max(process_id)+1,1) as NEWSTEPID from case_process where case_seq="+scaseSeq;
        
		 DBConnection lib = new DBConnection();
		 //System.out.print("\n" + "	" + ssql + "	" + "\n");
		 ResultSet RS = lib.executeQuery(ssql);
	        try
	        {
	            RS.next();
	            sNewCaseProcessID = RS.getString("NEWSTEPID");   
	            RS.close();
	        }catch(SQLException ex)
	        {
			  System.err.println("aq.executeQuery:"+ex.getMessage());
		    }
	     //System.out.print("新caseseq="+ sNewCaseProcessID +"\n");
		 return sNewCaseProcessID;
    }


    /**
     * 新增case步骤
     * @param scaseSeq case序列号
     * @param scaseProcessId case步骤编号
     */
	public void addCaseProcessInfo(String scaseeq,String sprocessid,String sprocessdesc,String sexpresult,String scasedatacheck,String scaselog,String srealresult,String sindump,String soutdump,String saccessory)
	{
		if(sprocessdesc!=null)
			sprocessdesc=sprocessdesc.replaceAll("'", "''");
		if(sexpresult!=null)
			sexpresult=sexpresult.replaceAll("'", "''");
		if(scasedatacheck!=null)
			scasedatacheck=scasedatacheck.replaceAll("'", "''");
		if(scaselog!=null)
			scaselog=scaselog.replaceAll("'", "''");
		if(srealresult!=null)
			srealresult=srealresult.replaceAll("'", "''");
		if(sindump!=null)
			sindump=sindump.replaceAll("'", "''");
		if(soutdump!=null)
			soutdump=soutdump.replaceAll("'", "''");
		if(saccessory!=null)
			saccessory=saccessory.replaceAll("'", "''");
		
		String ssql=" insert into case_process(CASE_SEQ,CASE_ID,PROCESS_ID,PROCESS_DESC,EXP_RESULT,CASE_DATA_CHECK,CASE_LOG,REAL_RESULT,STATUS,STATUS_TIME,IN_DUMP,OUT_DUMP,ACCESSORY)"
				   + " values("+scaseeq+",(select case_id from case_rec where case_seq="+scaseeq+"),'"+sprocessid+"','"+sprocessdesc+"','"+sexpresult+"','"+scasedatacheck+"','"+scaselog+"','"+srealresult+"',0,sysdate,'"+sindump+"','"+soutdump+"','"+saccessory+"') ";
		
		//System.out.print("插入sql="+ssql);
		DBConnection lib = new DBConnection();
		lib.executeUpdate(ssql);
		//System.out.print("插入成功");
	
	}
	
	
    /**
     * 修改case步骤
     * @param scaseSeq case序列号
     * @param ssourceprocess case步骤原编号
     */
	public void updateCaseProcessInfo(String scaseeq,String ssourceprocess,String sprocessid,String sprocessdesc,String sexpresult,String scasedatacheck,String scaselog,String srealresult,String sindump,String soutdump,String saccessory)
	{
		String ssql="";
		
		if(sprocessdesc!=null)
			sprocessdesc=sprocessdesc.replaceAll("'", "''");
		if(sexpresult!=null)
			sexpresult=sexpresult.replaceAll("'", "''");
		if(scasedatacheck!=null)
			scasedatacheck=scasedatacheck.replaceAll("'", "''");
		if(scaselog!=null)
			scaselog=scaselog.replaceAll("'", "''");
		if(srealresult!=null)
			srealresult=srealresult.replaceAll("'", "''");
		if(sindump!=null)
			sindump=sindump.replaceAll("'", "''");
		if(soutdump!=null)
			soutdump=soutdump.replaceAll("'", "''");
		if(saccessory!=null)
			saccessory=saccessory.replaceAll("'", "''");
		
		if((saccessory!=null)&&(saccessory!=""))
		{	
			ssql=" update case_process set PROCESS_ID="+sprocessid+",PROCESS_DESC='"+sprocessdesc+"',EXP_RESULT='"+sexpresult+"',CASE_DATA_CHECK='"+scasedatacheck+"',CASE_LOG='"+scaselog+"',REAL_RESULT='"+srealresult+"',IN_DUMP='"+sindump+"',OUT_DUMP='"+soutdump+"',ACCESSORY='"+saccessory+"'"
				   + " where case_seq="+scaseeq+" and process_id="+ssourceprocess;
		}
		else
		{
			ssql=" update case_process set PROCESS_ID="+sprocessid+",PROCESS_DESC='"+sprocessdesc+"',EXP_RESULT='"+sexpresult+"',CASE_DATA_CHECK='"+scasedatacheck+"',CASE_LOG='"+scaselog+"',REAL_RESULT='"+srealresult+"',IN_DUMP='"+sindump+"',OUT_DUMP='"+soutdump+"'"
			   + " where case_seq="+scaseeq+" and process_id="+ssourceprocess;
		}
		//System.out.print("修改sql="+ssql);
		DBConnection lib = new DBConnection();
		lib.executeUpdate(ssql);
		//System.out.print("修改成功");
	
	}

    /**
     * 修改case步骤
     * @param scaseSeq case序列号
     * @param scaseProcessId case步骤编号
     */
	public void deleteCaseProcessInfo(String scaseeq,String sprocessid)
	{
		String ssql=" delete case_process where case_seq="+scaseeq+" and process_id="+sprocessid;
		
		//System.out.print("删除sql="+ssql);
		DBConnection lib = new DBConnection();
		lib.executeUpdate(ssql);
		//System.out.print("删除成功");
	
	}
    /**
     * 复制case步骤附件
     * @param Path 附件路径
     * @param oldFile 步骤附件旧文件
     * @param newFile 步骤附件新文件
     */
	public void copyFile(String Path, String oldFile,String newFile)
	{
	   try{
	     int bytesum = 0;
	     int byteread = 0;
	     //windows系统适用
	     oldFile=Path+"\\"+"\\"+oldFile;
	     //unix系统适用
	     //oldFile=Path+"/"+oldFile;
	     System.out.print("旧文件路径="+oldFile);
	     //windows系统适用
	     newFile=Path+"\\"+"\\"+newFile; 
	     //unix系统适用
	     //newFile=Path+"/"+newFile;   
	     System.out.print("新文件路径="+newFile);    
	     
	     File oldfile = new File(oldFile);
	     if (oldfile.exists()) { //文件存在时
	       FileInputStream inStream = new FileInputStream(oldFile); //读入原文件
	       FileOutputStream fs = new FileOutputStream(newFile);
	       byte[] buffer = new byte[1444];
	       int length;
	       while ( (byteread = inStream.read(buffer)) != -1) {
	         bytesum += byteread; //字节数 文件大小
	         //System.out.println(bytesum);
	         fs.write(buffer, 0, byteread);
	       }
	       inStream.close();
	     }
	   }
	   catch (Exception e) {
	     System.out.println("复制单个文件操作出错");
	     e.printStackTrace();

	   }
	 }

	
	/**
     * 复制case步骤
     * @param scaseSeq case序列号
     * @param scaseProcessId case步骤编号
     */
	public void copyCaseProcessInfo(String scaseeq,String sprocessid,String sPath)
	{
		DBConnection lib = new DBConnection();
		String ssql1="select (select max(PROCESS_ID)+1 from case_process where case_seq="+scaseeq+") as PROCESS_ID,ACCESSORY from case_process where case_seq="+scaseeq+" and process_id="+sprocessid;
		ResultSet RS = lib.executeQuery(ssql1);
		String oldFile="";
		String sProcessId="";
		String ACCESSORY="";
		 try
	        {
	            while(RS.next())
	            {
	            	sProcessId=RS.getString("PROCESS_ID");
	            	oldFile=RS.getString("ACCESSORY");
	            	
	    		
	    		   java.util.Date date = new java.util.Date(System.currentTimeMillis()); 
	    		   java.text.SimpleDateFormat sdf=new java.text.SimpleDateFormat("yyyyMMddHHmmss"); 
	    		   String sTime = sdf.format(date);
	    			
	    		   ACCESSORY=scaseeq+"-"+sProcessId+"-"+sTime+".jpg";
	    			if(oldFile!=null&&!oldFile.equals(""))
	    			{
	    				ACCESSORY=ACCESSORY;
	    			}
	    			else
	    			{
	    				ACCESSORY="";
	    			}
	            	if(oldFile!=null&&!oldFile.equals(""))
	    			{
	    			   copyFile(sPath,oldFile,ACCESSORY);
	    			}
	            	//System.out.print("\n完成\n");
	            	}		
		
		String ssql=" insert into case_process value "
				   + " (select CASE_SEQ,CASE_ID,(select max(PROCESS_ID)+1 from case_process "
				   + " where case_seq="+scaseeq+"),PROCESS_DESC,EXP_RESULT,CASE_DATA_CHECK,CASE_LOG,"
				   + " REAL_RESULT,STATUS,STATUS_TIME,IN_DUMP,OUT_DUMP,'"+ACCESSORY+"' from case_process "
				    +" where case_seq="+scaseeq+" and process_id="+sprocessid+")";
		
		//System.out.print("复制sql="+ssql);
		lib.executeUpdate(ssql);
		//System.out.print("复制成功");
	        }
		 	catch(SQLException ex)
	        {
			  System.err.println("aq.executeQuery:"+ex.getMessage());
		    }
	}
	
    /**
     * 删除附件图片（更新case_process表中ACCESSORY字段为空）
     * @param scaseeq case序列号
     * @param sprocessid case步骤编号
     */	
	public void deleteCaseProcessPic(String scaseeq,String sprocessid)
	{
		String ssql="update case_process set ACCESSORY='' where case_seq="+scaseeq+" and process_id="+sprocessid;
		//System.out.print("\n删除图片sql="+ssql+"\n");
		DBConnection lib = new DBConnection();
		lib.executeUpdate(ssql);
		//System.out.print("\n删除图片成功\n");
	}


	
    /**
     * 根据caseseq返回界面上显示的信息，不需做其他转换
     * @param scaseseq
     */
	public Vector querycasedetailinfo (String scaseseq) 
	{ 	
		String ssql="select a.case_id,a.case_name,a.case_desc,a.EXP_RESULT,"
				   +"(select '['||code_value||'] '||cname from sys_base_type where table_name='CASE_REC' and col_name='CLI_INFO_ID' and code_value=a.cli_info_id) as cli_info_id,"
				   +"(select '['||code_value||'] '||cname from sys_base_type where table_name='CASE_REC' and col_name='SVR_INFO_ID' and code_value=a.svr_info_id) as svr_info_id,"
				   +"a.case_env,a.CASE_DATA_PREPARE,CASE_CONCLUSION,"
				   +"(select substr(subsys_name_cn,instr(subsys_name_cn,'(')+1,instr(subsys_name_cn,')')-instr(subsys_name_cn,'(')-1)||' -- '||subsys_name_cn from subsys_def  where subsys_id=a.SUB_SYS_ID) as SUB_SYS_ID,"
				   +"(select module_name from product_detail where module_id = a.MODULE_ID) as MODULE_ID,"
				   +"(select op_mail||' - '||op_name from op_login where op_id =a.OP_ID) as op_id, "
				   +"(select '['||code_value||'] '||cname from sys_base_type where table_name='CASE_REC' and col_name='CASE_TYPE' and code_value=a.case_type ) as case_type"
				   +" from case_rec a where a.case_seq="+scaseseq;
		//System.out.print("\n" +ssql + "\n");
		 Vector ver = new Vector();
		 DBConnection lib = new DBConnection();
		 ver=lib.selectVector(ssql);	 
		 return ver;
    }
	
	
/* 调试用函数 */
/*	public static void main(String args[])
	{
	   Vector ver = new Vector();
	   String s="";
//	   s=getCaseProcessID("238");
	   deleteCaseProcessInfo("239","2");
	   System.out.print("\n----BEGIN-----\n");
	   System.out.print("ver.size()="+ver.size()+"\n");
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
			//sCASEENV = (String) CaseInfohash.get("CASE_ENV");
//			String sCASEDATAPREPARE = (String) CaseInfohash.get("CASE_DATA_PREPARE");
//			String sSUBSYSID = (String) CaseInfohash.get("SUB_SYS_ID");
//			String sMODULEID = (String) CaseInfohash.get("MODULE_ID");
//			String sOPID = (String) CaseInfohash.get("OP_ID");
//			System.out.print(sCASEID + "\n----\n"+ sCASENAME + "----\n" + sCASEDESC + "----\n" + sEXPRESULT + "----\n" + sCLIINFOID + "----\n" + sSVRINFOID + "----\n" + "" + "----\n" + sCASEDATAPREPARE + "----\n" + sSUBSYSID + "----\n" + sMODULEID + "----\n" + sOPID + "----\n");
//		  }
//	   	}
//	   else System.out.print("ver.size()="+ver.size()+"，不显示！");

	  }  
	
*/ 	
}