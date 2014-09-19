SELECT A.TASK_ID AS TASK_ID,
       DECODE(D.DEMAND_SRC_ID, '', D.DEMAND_ID, D.DEMAND_SRC_ID) AS DEMAND_NO,
       D.DEMAND_TITLE,
       B.CNAME AS DEMAND_STATUS,
       DECODE(to_char(D.QA_TIME,'YYYY-MM-DD'), '', '未完成需求', to_char(D.QA_TIME,'YYYY-MM-DD'))  as CLOSETIME,
       C.DEV_DAY,
       C.TEST_DAY,
       ROUND(C.DEV_DAY / (C.DEV_DAY + C.TEST_DAY) * 100, 0) || '%' AS DEV_PER,
       ROUND(C.TEST_DAY / (C.DEV_DAY + C.TEST_DAY) * 100, 0) || '%' AS TEST_PER
  FROM DEMAND_REQUEST D, ASSIGNMENT A, SYS_BASE_TYPE B, (select D.DEMAND_ID, DECODE(D.DEV_TIME, NULL, 1, TRUNC(D.DEV_TIME - D.REPORT_TIME) + 1) AS DEV_DAY,
       DECODE(D.QA_TIME, NULL, 1, TRUNC(D.QA_TIME - D.DEV_TIME) + 1) AS TEST_DAY from DEMAND_REQUEST D) C
 WHERE A.DEMAND_ID = D.DEMAND_ID
   AND B.TABLE_NAME = 'DEMAND_REQUEST'
   AND B.COL_NAME = 'STATUS'
   AND B.CODE_VALUE = D.STATUS
   AND C.DEMAND_ID = D.DEMAND_ID;
   
select * from query_def;         
                 
insert into ALIASES values (QMS_SEQ.NEXTVAL, 10000000044, 1, '任务编号', 'TASK_ID');
insert into ALIASES values (QMS_SEQ.NEXTVAL, 10000000044, 2, '需求编号', 'DEMAND_NO');
insert into ALIASES values (QMS_SEQ.NEXTVAL, 10000000044, 3, '需求描述', 'DEMAND_TITLE');
insert into ALIASES values (QMS_SEQ.NEXTVAL, 10000000044, 4, '需求状态', 'DEMAND_STATUS');
insert into ALIASES values (QMS_SEQ.NEXTVAL, 10000000044, 5, '完成时间', 'CLOSETIME');
insert into ALIASES values (QMS_SEQ.NEXTVAL, 10000000044, 6, '开发时间', 'DEV_DAY');
insert into ALIASES values (QMS_SEQ.NEXTVAL, 10000000044, 7, '测试时间', 'TEST_DAY');
insert into ALIASES values (QMS_SEQ.NEXTVAL, 10000000044, 8, '开发时间比例', 'DEV_PER');
insert into ALIASES values (QMS_SEQ.NEXTVAL, 10000000044, 9, '测试时间比例', 'TEST_PER');
commit;


insert into chart values (QMS_SEQ.nextval, 10000000044, 0, '{"columns":[{"data":"TASK_ID"},{"data":"DEMAND_NO"},{"data":"DEMAND_TITLE"},{"data":"DEMAND_STATUS"},{"data":"CLOSETIME"},{"data":"DEV_DAY"},{"data":"TEST_DAY"},{"data":"DEV_PER"},{"data":"TEST_PER"}]}');
insert into chart values (QMS_SEQ.nextval, 10000000044, 1, '{"seriesname" : "开发时间", "namecol":"DEMAND_TITLE", "ycol":"DEV_PER"}');
insert into chart values (QMS_SEQ.nextval, 10000000044, 2, '{"namecol":"DEMAND_TITLE", "dataCol":[''DEV_DAY'',''TEST_DAY'']}');
insert into chart values (QMS_SEQ.nextval, 10000000044, 3, '{"namecol":"DEMAND_TITLE", "dataCol":[''DEV_DAY'',''TEST_DAY'']}');
commit;

select * from chart where query_id = 10000000044;

delete from chart where chart_id = 10000000058;

