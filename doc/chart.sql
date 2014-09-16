create table CHART 
(
   CHART_ID             NUMBER(22)           not null,
   QUERY_ID             NUMBER(22)           not null,
   CHART_TYPE           INTEGER,
   CHART_OPTION         VARCHAR(1000),
   constraint PK_CHART primary key (CHART_ID)
);

select * from chart;
select * from query_def;
insert into chart values (QMS_SEQ.nextval, 10000000000, 0, '{"columns":[{"data":"PRODUCT_VERSION_ID"},{"data":"OP_NAME"},{"data":"DEMAND_TITLE"},{"data":"QA_TIME"},{"data":"DEMAND_ID"},{"data":"NAME"},{"data":"DATAS"}]}');
insert into chart values (QMS_SEQ.nextval, 10000000000, 1, '{"seriesname" : "testDatas", "namecol":"DEMAND_TITLE", "ycol":"DATAS", "referto":"pieContainer"}');
commit;

truncate table chart;
