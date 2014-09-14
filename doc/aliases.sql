drop table ALIASES cascade constraints;

/*==============================================================*/
/* Table: ALIASES                                               */
/*==============================================================*/
create table ALIASES 
(
   ALIASES_ID           NUMBER(22)           not null,
   QUERY_ID             NUMBER(22),
   ALIASES_SEQ          INTEGER,
   ALIASES_NAME         VARCHAR(100),
   ALIASES_COL          VARCHAR(100),
   constraint PK_ALIASES primary key (ALIASES_ID)
);

create sequence ALIASES_SEQ increment by 1 start with 1 nomaxvalue nocycle nocache;
commit;

insert into ALIASES values (ALIASES_SEQ.NEXTVAL, 16, 1, '版本号', 'PRODUCT_VERSION_ID');
insert into ALIASES values (ALIASES_SEQ.NEXTVAL, 16, 2, '测试人员', 'OP_NAME');
insert into ALIASES values (ALIASES_SEQ.NEXTVAL, 16, 3, '需求名称', 'DEMAND_TITLE');
insert into ALIASES values (ALIASES_SEQ.NEXTVAL, 16, 4, '测试时间', 'QA_TIME');
insert into ALIASES values (ALIASES_SEQ.NEXTVAL, 16, 5, '需求ID', 'DEMAND_ID');
insert into ALIASES values (ALIASES_SEQ.NEXTVAL, 16, 6, '地区', 'NAME');
commit;

select * from ALIASES where QUERY_ID = 16 order by ALIASES_SEQ asc;
