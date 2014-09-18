create table TEST_DATA 
(
   ID                   NUMBER(22)           not null,
   NAME                 VARCHAR(1000),
   APPLES               INTEGER,
   ORANGES              INTEGER,
   PEARS                INTEGER,
   GRAPES               INTEGER,
   BANANAS              INTEGER,
   constraint PK_TEST_DATA primary key (ID)
);

insert into test_data values (QMS_SEQ.Nextval, 'John', 15, 3, 4, 7, 12);
insert into test_data values (QMS_SEQ.Nextval, 'Jane', 2, 34, 13, 2, 10);
insert into test_data values (QMS_SEQ.Nextval, 'Joe', 3, 24, 14, 22, 5);
commit;

select * from test_data;

--1.Add query via page.
select query_sql from query_def where query_id = 10000000023;
select * from test_data;
--2.Add aliases.
insert into ALIASES values (QMS_SEQ.NEXTVAL, 10000000023, 1, 'ÐòºÅ', 'ID');
insert into ALIASES values (QMS_SEQ.NEXTVAL, 10000000023, 2, 'Ãû×Ö', 'NAME');
insert into ALIASES values (QMS_SEQ.NEXTVAL, 10000000023, 3, 'Æ»¹û', 'APPLES');
insert into ALIASES values (QMS_SEQ.NEXTVAL, 10000000023, 4, 'éÙ×Ó', 'ORANGES');
insert into ALIASES values (QMS_SEQ.NEXTVAL, 10000000023, 5, 'Àæ×Ó', 'PEARS');
insert into ALIASES values (QMS_SEQ.NEXTVAL, 10000000023, 6, 'ÆÏÌÑ', 'GRAPES');
insert into ALIASES values (QMS_SEQ.NEXTVAL, 10000000023, 7, 'Ïã½¶', 'BANANAS');
commit;
select * from ALIASES where query_id = 10000000023;
--3.Config chart.
insert into chart values (QMS_SEQ.nextval, 10000000023, 0, '{"columns":[{"data":"ID"},{"data":"NAME"},{"data":"APPLES"},{"data":"ORANGES"},{"data":"PEARS"},{"data":"GRAPES"},{"data":"BANANAS"}]}');
insert into chart values (QMS_SEQ.nextval, 10000000023, 1, '{"seriesname" : "testDatas", "namecol":"NAME", "ycol":"ORANGES"}');
insert into chart values (QMS_SEQ.nextval, 10000000023, 2, '{"namecol":"NAME", "dataCol":[''APPLES'',''ORANGES'',''PEARS'',''GRAPES'',''BANANAS'']}');
insert into chart values (QMS_SEQ.nextval, 10000000023, 3, '{"namecol":"NAME", "dataCol":[''APPLES'',''ORANGES'',''PEARS'',''GRAPES'',''BANANAS'']}');
commit;
select * from chart where query_id = 10000000023;


