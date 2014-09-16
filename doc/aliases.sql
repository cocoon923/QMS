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

insert into ALIASES values (QMS_SEQ.NEXTVAL, 10000000000, 1, '�汾��', 'PRODUCT_VERSION_ID');
insert into ALIASES values (QMS_SEQ.NEXTVAL, 10000000000, 2, '������Ա', 'OP_NAME');
insert into ALIASES values (QMS_SEQ.NEXTVAL, 10000000000, 3, '��������', 'DEMAND_TITLE');
insert into ALIASES values (QMS_SEQ.NEXTVAL, 10000000000, 4, '����ʱ��', 'QA_TIME');
insert into ALIASES values (QMS_SEQ.NEXTVAL, 10000000000, 5, '����ID', 'DEMAND_ID');
insert into ALIASES values (QMS_SEQ.NEXTVAL, 10000000000, 6, '����', 'NAME');
insert into ALIASES values (QMS_SEQ.NEXTVAL, 10000000000, 7, '����', 'DATAS');
commit;

select * from ALIASES where QUERY_ID = 10000000000 order by ALIASES_SEQ asc;

truncate table aliases;
