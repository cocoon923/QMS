package dbOperation;

import java.net.URL;
import java.sql.Blob;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;
import java.io.*;

import org.omg.CORBA.portable.InputStream;

import dbOperation.*;
public class CaseInfo 
{
/*	   public Vector getCaseInfoAll(String sOpId)
	   {
		  //String sSql="select 'R'||demand_id as SID,a.request_id,a.rep_title,b.name from project_request a,proj_status b where a.rep_status=b.id and a.rep_qa="+sOpId+" and a.rep_status in (1,3,4,5,6)";
		   String sSql="select 'R'||demand_id as SID,'R'||demand_id||'-'||demand_title as name from"
			   		 + "(select distinct(a.demand_id),a.demand_title from demand_request a,"
			   		 + "assignment b,demand_status c where a.demand_id=b.demand_id and "
			   		 + "a.status=c.sta_id and a.status in ('1','2','3','4') and b.closer_id="+sOpId+" order by demand_id) "
			   		 + "union select 'F'||request_id as SID,'F'||request_id||'-'||rep_title as name from"
			   		 + "(select a.request_id,a.rep_title from project_request a,proj_status b where a.rep_status=b.id "
			   		 + "and a.rep_qa="+sOpId+" and a.rep_status in (1,3,4,5,6))";
		   System.out.print("getCaseInfoAll: "+sSql);
		   Vector ver = new Vector();
		   DBConnection lib = new DBConnection();
		   ver=lib.selectVector(sSql);		   
		   return ver;
	   }*/
	   
	   
	   public Vector getDemandForCase(String sOpId)
	   {
		  //String sSql="select 'R'||demand_id as SID,a.request_id,a.rep_title,b.name from project_request a,proj_status b where a.rep_status=b.id and a.rep_qa="+sOpId+" and a.rep_status in (1,3,4,5,6)";
		   String sSql="select 'R'||demand_id as SID,'R'||demand_id||'-'||demand_title as name from"
			   		 + "(select distinct(a.demand_id),a.demand_title from demand_request a,"
			   		 + "assignment b,demand_status c where a.demand_id=b.demand_id and "
			   		 + "a.status=c.sta_id and a.status in ('1','2','3','4') and b.closer_id="+sOpId+" order by demand_id) ";
		   System.out.print("getDemandForCase: "+sSql);
		   Vector ver = new Vector();
		   DBConnection lib = new DBConnection();
		   ver=lib.selectVector(sSql);		   
		   return ver;
	   }
	   

	   
	   public Vector getAllCaseInfo(String sDemanId,int sCaseType)
	   {
		   //System.out.print("sDemanId="+sDemanId+"\n");
		   String sSql="select * from case_rec where demand_id="+sDemanId+" and case_source=" +sCaseType + " order by case_id";
		   //System.out.print("SQL="+sSql+"\n");
		   Vector ver = new Vector();
		   DBConnection lib = new DBConnection();
		   ver=lib.selectVector(sSql);
		   return ver;
	   }
	   
	   public Vector getAllCaseInfoall(String sDemanId,int sCaseType)
	   {
		   //System.out.print("sDemanId="+sDemanId+"\n");
		   String sSql="select * from case_rec a,product_detail b where a.demand_id="+sDemanId
		   			  +" and a.case_source=" +sCaseType + " and a.module_id=b.module_id order by a.case_id";
		   //System.out.print("SQL="+sSql+"\n");
		   Vector ver = new Vector();
		   DBConnection lib = new DBConnection();
		   ver=lib.selectVector(sSql);
		   return ver;
	   }
	   
	   public Vector getDemandInfo(String sDemanId,int sCaseType)
	   {
		   String sSql="select * from demand_property where demand_id="+sDemanId+" and demand_type="+sCaseType;
		   //System.out.print("SQL="+sSql+"\n");
		   Vector ver = new Vector();
		   DBConnection lib = new DBConnection();
		   ver=lib.selectVector(sSql);
		   return ver;
	   }
	   
	   public Vector getDemandAttachmentInfo(String sDemanId,int sCaseType,String sField,String sSeq)
	   {
		   String sSql="select * from demand_attachment where value="+sDemanId+" and type="+sCaseType;
		   if(!sField.equals(""))
		   {
			   sSql=sSql + " and field='"+sField+"'";
		   }
		   if(!sSeq.equals(""))
		   {
			   sSql=sSql + " and seq="+ sSeq;
		   }
		   sSql=sSql+"order by seq";
		   //System.out.print("SQL="+sSql+"\n");
		   Vector ver = new Vector();
		   DBConnection lib = new DBConnection();
		   ver=lib.selectVector(sSql);
		   return ver;
	   }
	   
	   public void updateDemandInfo(String sDemanId,int sCaseType,String sRemark1,String sRemark2,String sRemark3,String sRemark4,String sRemark5,String sRemark6,String sRemark7,String sRemark8,String sRemark9)
	   {
		  String sSql="";
		  int iCount=0;
		  
		  if(sRemark1!=null)
			  sRemark1=sRemark1.replaceAll("'", "''");
		  if(sRemark2!=null)
			  sRemark2=sRemark2.replaceAll("'", "''");
		  if(sRemark3!=null)
			  sRemark3=sRemark3.replaceAll("'", "''");
		  if(sRemark4!=null)
			  sRemark4=sRemark4.replaceAll("'", "''");
		  if(sRemark5!=null)
			  sRemark5=sRemark5.replaceAll("'", "''");
		  if(sRemark6!=null)
			  sRemark6=sRemark6.replaceAll("'", "''");
		  if(sRemark7!=null)
			  sRemark7=sRemark7.replaceAll("'", "''");
		  if(sRemark8!=null)
			  sRemark8=sRemark8.replaceAll("'", "''");
		  if(sRemark9!=null)
			  sRemark9=sRemark9.replaceAll("'", "''");
		  
		  DBConnection lib = new DBConnection();
		  sSql="select count(*) as COUNT from  demand_property where demand_id="+sDemanId+" and demand_type="+sCaseType;
		  //System.out.print("\n查询是否存在记录sql="+sSql);
	      ResultSet RS = lib.executeQuery(sSql);
	      try
	        {
	            RS.next();
	            iCount= RS.getInt("COUNT");   
	            RS.close();
	        }
	      catch(SQLException ex)
	        {
			  System.err.println("aq.executeQuery:"+ex.getMessage());
		    }
		  
	      if(iCount==0)
	      {
	    	  sSql="insert into demand_property(demand_id,ori_demand_info,demand_solution,demand_chg_info,remark1,remark2,remark3,remark4,remark5,remark6,demand_type) values("+sDemanId+",'"+sRemark1+"','"+sRemark2+"','"+sRemark3+"','"+sRemark4+"','"+sRemark5+"','"+sRemark6+"','"+sRemark7+"','"+sRemark8+"','"+sRemark9+"',"+sCaseType+")";
	    	  //System.out.print("\n新增数据，sql="+sSql);
	      }
	      else if(iCount==1)
	      {
	    	  sSql="update demand_property set ori_demand_info='"+sRemark1+"',demand_solution='"+sRemark2+"',demand_chg_info='"+sRemark3+"',remark1='"+sRemark4+"',remark2='"+sRemark5+"',remark3='"+sRemark6+"',remark4='"+sRemark7+"',remark5='"+sRemark8+"',remark6='"+sRemark9+"' where demand_id="+sDemanId+" and demand_type="+sCaseType;
	    	  //System.out.print("\n修改数据，sql="+sSql);
	      }
	      else
	      {
	    	  sSql="";
	    	  //System.out.print("\n表demand_property中数据不正确，请检查数据！");
	      }
	      
		  lib.executeUpdate(sSql);
		  //System.out.print("\n操作成功");
	   }
	   
	   /*
	    * 更新 需求附件（操作：demand_attachment表）
	    * @param  iType:操作类型，1：新增；2：删除
	    * 注：当iType为2时，sSeq必填；为1是，sSeq可不填，填了也不使用
	    */
	   public Vector updateDemandAttachmentInfo(int iType,String sSeq,String sDemanId,int sCaseType,String sField,String sAttachmentPath,String sRemark,String sOldName)
	   {
		   String sSql="";
		   if(sAttachmentPath!=null)
		   {
			   sAttachmentPath=sAttachmentPath.replaceAll("'", "''");
		   }
		   if(sRemark!=null)
		   {
			   sRemark=sRemark.replaceAll("'", "''");
		   }
		   if(sOldName!=null)
		   {
			   sOldName=sOldName.replaceAll("'", "''");
		   }
		   
		   if(iType==1) //新增
		   {
			   sSql="insert into demand_attachment(seq,type,value,field,attachment_name,remark,old_name)"
				   +" values(attachment_seq.nextval,"+sCaseType+",'"+sDemanId+"','"+sField+"','"+sAttachmentPath+"','"+sRemark+"','"+sOldName+"')";
		   }	
		   else if(iType==2)  //删除
		   {
			   sSql="delete from demand_attachment where seq="+sSeq+" and type="+sCaseType+" and value="+sDemanId+" and field='"+sField+"'";
		   }
		   else 
		   {
			   sSql="select 1 from dual";
			   System.out.print("\n 入参操作类型不正确，只能为1、2");
		   }
		   //System.out.print("SQL="+sSql+"\n");
		   Vector ver = new Vector();
		   DBConnection lib = new DBConnection();
		   ver=lib.selectVector(sSql);
		   return ver;
	   }
	   
	   
	   public void deleteCaseInfo(String sCaseSeq)
	   {
		  String sSql="";
	      DBConnection lib = new DBConnection();
	      sSql="delete from case_rec where case_seq="+sCaseSeq;
	      //System.out.print("\n删除case_rec表中的记录sql="+sSql);
		  lib.executeUpdate(sSql);
		  //System.out.print("\n删除成功");
	      sSql="delete from case_process where case_seq="+sCaseSeq;
	      //System.out.print("\n删除case_process表中的记录sql="+sSql);
		  lib.executeUpdate(sSql);
		  //System.out.print("\n删除成功");  
	   }
	   
	   public void copyFile(String Path, String oldFile,String newFile)
	   {
		    try
		    {
		      int bytesum = 0;
		      int byteread = 0;
		      //oldFile=Path+"\\"+"\\"+oldFile;
		      oldFile=Path+"/"+oldFile;
		      //System.out.print("旧文件路径="+oldFile);
		      //newFile=Path+"\\"+"\\"+newFile;   
		      newFile=Path+"/"+newFile; 
		      //System.out.print("新文件路径="+newFile);    
		      
		      File oldfile = new File(oldFile);
		      if (oldfile.exists()) 
		      { //文件存在时
		        FileInputStream inStream = new FileInputStream(oldFile); //读入原文件
		        FileOutputStream fs = new FileOutputStream(newFile);
		        byte[] buffer = new byte[1444];
		        int length;
		        while ( (byteread = inStream.read(buffer)) != -1) 
		        {
		          bytesum += byteread; //字节数 文件大小
		          //System.out.println(bytesum);
		          fs.write(buffer, 0, byteread);
		        }
		        inStream.close();
		       }
		     }
		    catch (Exception e) 
		    {
		      System.out.println("复制单个文件操作出错");
		      e.printStackTrace();

		    }
		  }
	   
	   
	   public void copyCaseInfo(String sDemanId,int sCaseType,String sCaseSeq,String sPath)
	   {
		   String sSql="";
		   String sNewCaseId="";
		   DBConnection lib = new DBConnection(); 
		  //先获取需求编号或者故障case编号
		   if(sCaseType==1)
	       {
			   //sSql="select b.product_name||'-'||d.product_vs_name||'-R"+ sDemanId +"'||'-'||" 
	           //   + " (select lpad(to_char(decode(caseid,null,0,caseid)+1),5,'0')"
	           //   + " from (select max(to_number(substr(case_id,length(case_id)-4,length(case_id)))) caseid " 
	           //   + " from case_rec where demand_id = "+ sDemanId +" and case_source = 1))  as NEWCASEID"
	           //   + " from demand_request a,product b,product_project c,product_version d "
	           //   + " where a.product_id=b.product_id and a.demand_id="+ sDemanId +" and a.product_id=c.product_id "
	           //   + " and c.project_id = (select area_id "
	           //   + " from project where proj_code=(select project_code from demand_request where demand_id="+ sDemanId +")) "
	           //   + " and c.product_version_id=d.product_version_id";
			   //sql语句优化
			   sSql="select b.product_name||'-'||d.product_vs_name||'-R"+ sDemanId +"'||'-'||" 
	              + " (select lpad(to_char(decode(caseid,null,0,caseid)+1),5,'0')"
	              + " from (select max(to_number(substr(case_id,length(case_id)-4,length(case_id)))) caseid " 
	              + " from case_rec where demand_id = "+ sDemanId +" and case_source = 1))  as NEWCASEID"
	              + " from demand_request a,product b,product_project c,product_version d,project e "
	              + " where a.product_id=b.product_id and a.demand_id="+ sDemanId +" and a.product_id=c.product_id "
	              + " and a.project_code =  c.project_code and c.project_id = e.area_id and e.proj_code = a.project_code"
	              + " and c.product_version_id=d.product_version_id";
	       }
	       else
	       {
	    	   //sSql="select b.product_name||'-'||d.product_vs_name||'-F"+ sDemanId +"'||'-'||"
	           //   + " (select lpad(to_char(decode(caseid,null,0,caseid)+1),5,'0') "
	           //   + " from (select max(to_number(substr(case_id,length(case_id)-4,length(case_id)))) caseid "
	           //   + " from case_rec where demand_id = "+ sDemanId +" and case_source = 2))  as NEWCASEID"
	           //   + " from project_request a,product b,product_project c,product_version d "
	           //   + " where a.product_id=b.product_id and a.request_id="+ sDemanId +" and a.product_id=c.product_id "
	           //   + " and c.project_id = (select area_id "
	           //   + " from project where proj_code=(select proj_code from project_request where request_id="+ sDemanId +")) "
	           //   + " and c.product_version_id=d.product_version_id";
	    	 //sql语句优化
	    	   sSql="select b.product_name||'-'||d.product_vs_name||'-F"+ sDemanId +"'||'-'||"
	              + " (select lpad(to_char(decode(caseid,null,0,caseid)+1),5,'0') "
	              + " from (select max(to_number(substr(case_id,length(case_id)-4,length(case_id)))) caseid "
	              + " from case_rec where demand_id = "+ sDemanId +" and case_source = 2))  as NEWCASEID"
	              + " from project_request a,product b,product_project c,product_version d,project e "
	              + " where a.product_id=b.product_id and a.request_id="+ sDemanId +" and a.product_id=c.product_id "
	              + " and a.proj_code =  c.project_code and c.project_id = e.area_id and e.proj_code = a.proj_code "
	              + " and c.product_version_id=d.product_version_id";
	       }
	        ResultSet RS = lib.executeQuery(sSql);
	        try
	        {
	            RS.next();
	            sNewCaseId= RS.getString("NEWCASEID");   
	            RS.close();
	        }catch(SQLException ex)
	        {
			  System.err.println("aq.executeQuery:"+ex.getMessage());
		    }
            System.out.print("新case编号="+sNewCaseId+"\n");
            
	       //获取case_rec的记录
	        sSql="select case_seq.nextval as NEWCASESEQ,demand_id,case_name,case_desc,case_data_prepare,exp_result,pro_version_code,cli_info_id,svr_info_id,sub_sys_id,module_id,program_name,status,status_time,case_type,case_source,op_id,op_time,create_time,case_env,case_conclusion from case_rec where case_seq="+sCaseSeq;
			Vector ver = new Vector();
			ver=lib.selectVector(sSql);
			HashMap hash= (HashMap) ver.get(0);
			String[] arr = new String[22];
			arr[0]=(String) hash.get("NEWCASESEQ");
			arr[1]=sNewCaseId;
			arr[2]=(String) hash.get("DEMAND_ID");
			arr[3]=(String) hash.get("CASE_NAME");
			if(arr[3]!=null)
				arr[3]=arr[3].replaceAll("'", "''");
			if(arr[3]==null) 
				arr[3]="";
			arr[4]=(String) hash.get("CASE_DESC");
			if(arr[4]!=null)
				arr[4]=arr[4].replaceAll("'", "''");
			if(arr[4]==null) 
				arr[5]="";
			arr[5]=(String) hash.get("CASE_DATA_PREPARE");
			if(arr[5]!=null)
				arr[5]=arr[5].replaceAll("'", "''");
			if(arr[5]==null) 
				arr[5]="";
			arr[6]=(String) hash.get("EXP_RESULT");
			if(arr[6]!=null)
				arr[6]=arr[6].replaceAll("'", "''");
			if(arr[6]==null) 
				arr[6]="";
			
			arr[7]=(String) hash.get("PRO_VERSION_CODE");
			if(arr[7]==null) 
				arr[7]="";
			arr[8]=(String) hash.get("CLI_INFO_ID");
			arr[9]=(String) hash.get("SVR_INFO_ID");
			arr[10]=(String) hash.get("SUB_SYS_ID");
			if(arr[10]==null) 
				arr[10]="";
			arr[11]=(String) hash.get("MODULE_ID");
			if(arr[11]==null) 
				arr[11]="";
			arr[12]=(String) hash.get("PROGRAM_NAME");
			if(arr[12]==null) 
				arr[12]="";
			arr[13]=(String) hash.get("STATUS");
			if(arr[13]==null) 
				arr[13]="";
			arr[14]=(String) hash.get("STATUS_TIME");
			
			arr[15]=(String) hash.get("CASE_TYPE");
			if(arr[15]==null) 
				arr[15]="";
			arr[16]=(String) hash.get("CASE_SOURCE");
			if(arr[16]==null) 
				arr[16]="";
			arr[17]=(String) hash.get("OP_ID");
			if(arr[17]==null) 
				arr[17]="";
			arr[18]=(String) hash.get("OP_TIME");
			arr[19]=(String) hash.get("CREATE_TIME");

			arr[20]=(String) hash.get("CASE_ENV");		
			if(arr[20]!=null)
				arr[20]=arr[20].replaceAll("'", "''");
			if(arr[20]==null) 
				arr[20]="";
			arr[21]=(String) hash.get("CASE_CONCLUSION");
			if(arr[21]!=null)
				arr[21]=arr[21].replaceAll("'", "''");
			if(arr[21]==null) 
				arr[21]="";
			//2008-12-03 00:00:00
			if(arr[14]!=null)
			{
			if(arr[14].length()>20)
				 arr[14]=arr[14].substring(0,19);
			}
			if(arr[14]==null) 
				arr[14]="";
			if(arr[18]!=null)
			{
			if(arr[18].length()>20)
				 arr[18]=arr[18].substring(0,19);
			}
			if(arr[18]==null) 
				arr[18]="";
			if(arr[19]!=null)
			{
			if(arr[19].length()>20)
			 arr[19]=arr[19].substring(0,19);
			}
			if(arr[19]==null) 
				arr[19]="";
			
			//for(int i=0;i<20;i++)
			//	System.out.print("第"+(i+1)+"的记录为:"+arr[i]+"\n");
			sSql="insert into case_rec (CASE_SEQ,CASE_ID,DEMAND_ID,CASE_NAME,CASE_DESC,CASE_DATA_PREPARE,EXP_RESULT,PRO_VERSION_CODE,CLI_INFO_ID,SVR_INFO_ID,SUB_SYS_ID,MODULE_ID,PROGRAM_NAME,STATUS,STATUS_TIME,CASE_TYPE,CASE_SOURCE,OP_ID,OP_TIME,CREATE_TIME,CASE_ENV,CASE_CONCLUSION)"
				+"values("+arr[0]+",'"+arr[1]+"',"+arr[2]+",'"+arr[3]+"','"+arr[4]+"','"+arr[5]+"','"+arr[6]+"',"+arr[7]+","+arr[8]+","+arr[9]+","+arr[10]+","+arr[11]+",'"+arr[12]+"',"+arr[13]+",to_date('"+arr[14]+"','yyyy-mm-dd hh24:mi:ss'),"+arr[15]+","+arr[16]+","+arr[17]+",to_date('"+arr[18]+"','yyyy-mm-dd hh24:mi:ss'),to_date('"+arr[19]+"','yyyy-mm-dd hh24:mi:ss')"+",'"+arr[20]+"','"+arr[21]+"')";
			//System.out.print("复制CASE的sql语句="+sSql);
			lib.executeUpdate(sSql);
	        
			//获取case_process记录
		    sSql="select * from case_process where case_seq="+sCaseSeq;
		    String[] arr1 =new String[11];
		    String oldFile="";
		    RS = lib.executeQuery(sSql);
	        try
	        {
	            while(RS.next())
	            {
	            	arr1[0]= RS.getString("PROCESS_ID"); 
	            	if(arr1[0]!=null)
	            		arr1[0]=arr1[0].replaceAll("'", "''");
	            	if(arr1[0]==null)
	            		arr1[0]="";
	            	arr1[1]= RS.getString("PROCESS_DESC"); 
	            	if(arr1[1]!=null)
	            		arr1[1]=arr1[1].replaceAll("'", "''");
	            	if(arr1[1]==null)
	            		arr1[1]="";
	            	arr1[2]= RS.getString("EXP_RESULT"); 
	            	if(arr1[2]!=null)
	            		arr1[2]=arr1[2].replaceAll("'", "''");
	            	if(arr1[2]==null)
	            		arr1[2]="";
	            	arr1[3]= RS.getString("CASE_DATA_CHECK"); 
	            	if(arr1[3]!=null)
	            		arr1[3]=arr1[3].replaceAll("'", "''");
	            	if(arr1[3]==null)
	            		arr1[3]="";
	            	arr1[4]= RS.getString("CASE_LOG"); 
	            	if(arr1[4]!=null)
	            		arr1[4]=arr1[4].replaceAll("'", "''");
	            	if(arr1[4]==null)
	            		arr1[4]="";
	            	arr1[5]= RS.getString("REAL_RESULT"); 
	            	if(arr1[5]!=null)
	            		arr1[5]=arr1[5].replaceAll("'", "''");
	            	if(arr1[5]==null)
	            		arr1[5]="";
	            	arr1[6]= RS.getString("STATUS"); 
	            	if(arr1[6]!=null)
	            		arr1[6]=arr1[6].replaceAll("'", "''");
	            	if(arr1[6]==null)
	            		arr1[6]="";
	            	arr1[7]= RS.getString("STATUS_TIME"); 
	    			if(arr1[7].length()>20)
	    				 arr1[7]=arr1[7].substring(0,19);
	    			if(arr1[7]==null)
	            		arr1[7]="";
	    			//修改2008-12-16
	    			arr1[8]= RS.getString("IN_DUMP"); 
	    			if(arr1[8]!=null)
	            		arr1[8]=arr1[8].replaceAll("'", "''");
	    			if(arr1[8]==null)
	            		arr1[8]="";
	    			arr1[9]= RS.getString("OUT_DUMP");
	    			if(arr1[9]!=null)
	            		arr1[9]=arr1[9].replaceAll("'", "''");
	    			if(arr1[9]==null)
	            		arr1[9]="";
	    			oldFile=RS.getString("ACCESSORY");
	    		//	arr1[10]= RS.getString("ACCESSORY");
	    		
	    		   java.util.Date date = new java.util.Date(System.currentTimeMillis()); 
	    		   java.text.SimpleDateFormat sdf=new java.text.SimpleDateFormat("yyyyMMddHHmmss"); 
	    		   String sTime = sdf.format(date);
	    			
	    			arr1[10]=arr[0]+"-"+arr1[0]+"-"+sTime+".jpg";
	    			if(oldFile!=null&&!oldFile.equals(""))
	    			{
	    				arr1[10]=arr1[10];
	    			}
	    			else
	    			{
	    				arr1[10]="";
	    			}
	    			sSql="insert into case_process(CASE_SEQ,CASE_ID,PROCESS_ID,PROCESS_DESC,EXP_RESULT,CASE_DATA_CHECK,CASE_LOG,REAL_RESULT,STATUS,STATUS_TIME,IN_DUMP,OUT_DUMP,ACCESSORY) "
	    				+" values("+arr[0]+",'"+sNewCaseId+"',"+arr1[0]+",'"+arr1[1]+"','"+arr1[2]+"','"+arr1[3]+"','"+arr1[4]+"','"+arr1[5]+"',"+arr1[6]+",to_date('"+arr1[7]+"','yyyy-mm-dd hh24:mi:ss')"+",'"+arr1[8]+"','"+arr1[9]+"','"+arr1[10]+"')";
	    			
	    			//System.out.print("复制步骤的sql语句="+sSql);
	    			lib.executeUpdate(sSql);
	    			//复制目录图片
	    			//if(oldFile.indexOf("jpg")>0)
	    			if(oldFile!=null&&!oldFile.equals(""))
	    			{
	    			   copyFile(sPath,oldFile,arr1[10]);
	    			}
	    			//System.out.print("\n完成\n");
	              }
	            	
	           	}
			        catch(SQLException ex)
			        {
					  System.err.println("aq.executeQuery:"+ex.getMessage());
				    }	        
	   	}
	   
	   /*
	    * 新增需求关联关系（insert demand_relation表中数据）
	    */
	   public void addDemandRealtion(String sDemandMain,String sDemandRelation,String sRelationType,String sOpId,String sRemark)
	   {
		  if(!sRemark.equals(""))
		  {
			  sRemark=sRemark.replaceAll("'", "''");
		  }
		   
		  String sSql="insert into demand_relation(demand_main,demand_relate,relate_type,create_time,op_id,remark)"
			  		 +" values("+sDemandMain+","+sDemandRelation+","+sRelationType+",sysdate,"+sOpId+",'"+sRemark+"')";
	      DBConnection lib = new DBConnection();
	      //System.out.print("\n新增demand_relation表中的记录sql="+sSql);
		  lib.executeUpdate(sSql);
	   }
	   
	   /*
	    * 删除需求关联关系（delete demand_relation表中数据）
	    */
	   public void deleteDemandRealtion(String sDemandMain,String sDemandRelation,String sRelationType)
	   {

		  String sSql="delete demand_relation where demand_main="+sDemandMain+" and relate_type = "+sRelationType;
		  if(!sDemandRelation.equals(""))
		  {
			  sSql+=" and demand_relate in ("+sDemandRelation+")";
		  }
	      DBConnection lib = new DBConnection();
	      //System.out.print("\n删除demand_relation表中的记录sql="+sSql);
		  lib.executeUpdate(sSql);
	   }
	   
	   /*
	    * 查询需求关联关系（select demand_relation表中数据）
	    */
	   public Vector queryDemandRealtion(String sDemandMain,String sDemandRelation,String sRelationType)
	   {
		   
		  String sSql="select * from demand_relation where  1=1";
		  if(!sDemandMain.equals(""))
		  {
			sSql+=" and demand_main="+sDemandMain;
		  }
		  if(!sDemandRelation.equals(""))
		  {
			 sSql+=" and demand_relate="+sDemandRelation;
		  }
		  if(!sRelationType.equals(""))
		  {
			  sSql+=" and relate_type="+sRelationType;
		  }
		  sSql+=" order by demand_main,demand_relate";
		  //System.out.print("\n查询demand_relation表中的记录sql="+sSql);
		  Vector ver = new Vector();
		  DBConnection lib = new DBConnection();
		  ver=lib.selectVector(sSql);
		  return ver;
	   }
	   
	   /*
	    * 查询需求关联关系（select demand_relation表中数据，条件为in条件）
	    */
	   public Vector queryDemandRealtionIn(String sDemandMain,String sDemandRelation,String sRelationType)
	   {
		   
		  String sSql="select * from demand_relation where  1=1";
		  if(!sDemandMain.equals(""))
		  {
			sSql+=" and demand_main in ("+sDemandMain+")";
		  }
		  if(!sDemandRelation.equals(""))
		  {
			 sSql+=" and demand_relate in ("+sDemandRelation+")";
		  }
		  if(!sRelationType.equals(""))
		  {
			  sSql+=" and relate_type in ("+sRelationType+")";
		  }
		  sSql+=" order by demand_main,demand_relate";
		  //System.out.print("\n查询demand_relation表中的记录sql="+sSql);
		  Vector ver = new Vector();
		  DBConnection lib = new DBConnection();
		  ver=lib.selectVector(sSql);
		  return ver;
	   }
	   
	   /*
	    * 查询详细需求关联关系（select demand_relation表中数据）
	    */
	   public Vector queryDemandRealtionMore(String sDemandMain,String sDemandRelation,String sRelationType)
	   {
		   
		  String sSql=" select a.demand_main,b.demand_title as MAIN_NAME,a.demand_relate,c.demand_title as RELATION_NAME,"
			         +" a.relate_type,a.create_time,a.op_id,d.op_name,a.remark "
			         +" from demand_relation a ,demand_request b,demand_request c,op_login d "
			         +" where a.demand_main=b.demand_id and a.demand_relate=c.demand_id and a.op_id=d.op_id";
		  if(!sDemandMain.equals(""))
		  {
			sSql+=" and a.demand_main="+sDemandMain;
		  }
		  if(!sDemandRelation.equals(""))
		  {
			 sSql+=" and a.demand_relate="+sDemandRelation;
		  }
		  if(!sRelationType.equals(""))
		  {
			  sSql+=" and a.relate_type="+sRelationType;
		  }
		  sSql+=" order by a.demand_main,a.demand_relate";
		  //System.out.print("\n查询demand_relation表中的记录sql="+sSql);
		  Vector ver = new Vector();
		  DBConnection lib = new DBConnection();
		  ver=lib.selectVector(sSql);
		  return ver;
	   }
	   
	   
	    /**
	     * 根据需求id、故障id 返回id号加名称
	     * @param stype 类型，1：需求；2：故障
	     * @param svalue id号
	     */
		public Vector queryDemandInfo (String stype,String svalue) 
		{ 	
			String ssql="";
			if(stype=="1")
			{
				ssql=" select  demand_id as ID,demand_title as NAME from demand_request "
					+" where demand_id in (" + svalue +")";
				
			}
			else if(stype=="2")
			{
				ssql=" select  request_id as ID,rep_title as NAME from project_request "
					+" where request_id in (" + svalue + ")";
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