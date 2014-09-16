create table QUERY_DEF 
(
   QUERY_ID             NUMBER(22)           not null,
   QUERY_NAME           VARCHAR(1000),
   QUERY_SQL            VARCHAR(2000),
   QUERY_VALID          INTEGER,
   constraint PK_QUERY_DEF primary key (QUERY_ID)
);

select * from query_def;

insert into QUERY_DEF values (QMS_SEQ.Nextval, '统计部门完成工作', 'select distinct (a.demand_id) as demand_id,  a.demand_title as demand_title,   f.product_version_id,   h.name,   to_char(a.qa_time, ''yyyy-mm-dd'') as qa_time,   e.op_name as op_name,   dbms_random.value(1, 100) as datas from demand_request a,  assignment b,  group_op_info d,  op_login e,  product_version f,  project  g,  province h where a.demand_id = b.demand_id and b.closer_id = d.op_id and d.op_id = e.op_id and a.project_code = g.proj_code and g.area_id = h.id', 1);
commit;

create sequence QMS_SEQ increment by 1 start with 10000000000 nomaxvalue nocycle nocache;
commit;



select sequence_name, to_char(min_value) min_value,
   to_char(max_value) max_value, increment_by,
   cycle_flag, order_flag, cache_size, to_char(Last_number) last_number
from user_sequences
where sequence_name='QMS_SEQ';
