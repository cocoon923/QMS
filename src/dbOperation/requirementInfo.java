package dbOperation;
import java.util.*;
import dbOperation.*;
public class requirementInfo {
/*
 * 查询操作员待处理需求单 
 */	
   public Vector getRequirementInfoAll(String sOpId)
   {
	   String sSql="select distinct(a.demand_id),a.demand_title,c.sta_name from demand_request a,assignment b,demand_status c "
		         +" where a.demand_id=b.demand_id and a.status=c.sta_id and a.status in ('2','3','4','5') "
		         +" and b.closer_id="+sOpId+" order by demand_id";
	   Vector ver = new Vector();
	   DBConnection lib = new DBConnection();
	   ver=lib.selectVector(sSql);
	   return ver;
   }
   
   public Vector getMultiRequirementInfoAll(String sOpId)
   {
	   String sSql=" select demand_id,demand_title,status,(select sta_name from demand_status where sta_id = status) as STATUS_NAME, "
		          +" decode(INTEGRATION,'1','完成联调测试','未完成联调') as INTEGRATION_NAME,to_char(INTEGRATION_TIME,'YYYY-MM-DD') as TIME "
		          +" from demand_request where 1=1  and status in (1,2,3,4,5,6,7,8,10,11,13,14,15,16,17,18,19,20,21,22) "
		          +" and integration is null and demand_id in (select ora_demand_id from demand_multi_relation) "
		          +" and qa_leader = "+sOpId+" order by demand_id";
	   Vector ver = new Vector();
	   DBConnection lib = new DBConnection();
	   ver=lib.selectVector(sSql);
	   return ver;
   }
/*
   public static void main(String args[])
   {
	   Vector ver = new Vector();
	   ver=getRequirementInfoAll("");
	   System.out.print("BEGIN-----\n");
	   System.out.print("ver.size()="+ver.size());
	   for (int i = 0; i < ver.size(); i++) {
		    HashMap hash = (HashMap) ver.get(i);
		    String name = (String) hash.get("DEMAND_ID");
		    String password = (String) hash.get("CASE_DESC");
		    System.out.println(name+"   "+password);
		    System.out.print("-----\n");
		  }
   }*/
}
