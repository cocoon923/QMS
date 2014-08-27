package dbOperation;
import java.util.*;

import dbOperation.*;
public class malfunctionInfo {
   public Vector getMalfunctionInfoAll(String sOpId)
   {
	  // String sSql="select case_id,case_name,case_desc,case_module,run_id from aiga_case where case_name='开停短信_3_10_01' and rownum<6 order by case_id desc";
	   String sSql=" select a.request_id,a.rep_title,b.name from project_request a,proj_status b "
		   		  + " where a.rep_status=b.id and a.rep_qa="+sOpId+" and a.rep_status in (1,3,4,5,6)";
	   Vector ver = new Vector();
	   DBConnection lib = new DBConnection();
	   ver=lib.selectVector(sSql);
	   return ver;
   }
   /*
   public static void main(String args[])
   {
	   Vector ver = new Vector();
	   ver=getMalfunctionInfoAll("101982");
	   System.out.print("BEGIN-----\n");
	   System.out.print("ver.size()="+ver.size());
	   for (int i = 0; i < ver.size(); i++) {
		    HashMap hash = (HashMap) ver.get(i);
		    String name = (String) hash.get("REQUEST_ID");
		    String password = (String) hash.get("REP_TITLE");
		    String password1 = (String) hash.get("NAME");
		    System.out.println(name+"   "+password+"  "+password1);
		    System.out.print("-----\n");
		  }
   }*/
}