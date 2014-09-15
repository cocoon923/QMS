create table CHART 
(
   CHART_ID             NUMBER(22)           not null,
   QUERY_ID             NUMBER(22)           not null,
   CHART_TYPE           INTEGER,
   CHART_OPTION         VARCHAR(1000),
   constraint PK_CHART primary key (CHART_ID)
);
create sequence CHART_SEQ increment by 1 start with 1 nomaxvalue nocycle nocache;
commit;

select * from chart;
select * from query_def;
insert into chart values (CHART_SEQ.nextval, 16, 1, '');
commit;

select * from chart where query_id = 16;
update chart c set c.chart_option = '{"columns":[{"data":"PRODUCT_VERSION_ID"},{"data":"OP_NAME"},{"data":"DEMAND_TITLE"},{"data":"QA_TIME"},{"data":"DEMAND_ID"},{"data":"NAME"},{"data":"DATAS"}]}'
where c.chart_id=2;

update chart c set c.chart_option = '' where c.chart_id=3;

commit;

select * from chart where query_id = 16 and chart_type = 1;
