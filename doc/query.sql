create table QUERY_DEF 
(
   QUERY_ID             NUMBER(22)           not null,
   QUERY_NAME           VARCHAR(1000),
   QUERY_SQL            VARCHAR(2000),
   QUERY_VALID          INTEGER,
   constraint PK_QUERY_DEF primary key (QUERY_ID)
);
create sequence QUERY_SEQ increment by 1 start with 1 nomaxvalue nocycle nocache;
commit;

select sequence_name, to_char(min_value) min_value,
   to_char(max_value) max_value, increment_by,
   cycle_flag, order_flag, cache_size, to_char(Last_number) last_number
from user_sequences
where sequence_name='QUERY_SEQ';

select * from query_def;
insert into QUERY_DEF values (1, '查询统计测试', 'select * from stat_field;', 1);
insert into QUERY_DEF values (2, '查询统计测试2', 'select * from stat_def;', 1);
insert into QUERY_DEF values (QUERY_SEQ.Nextval, 'lasdjf', 'asdfasd', 0);
commit;

update query_def q set q.query_sql = '' where q.query_id =  16;

commit;
