drop table CHART_CFG cascade constraints;

/*==============================================================*/
/* Table: CHART_CFG                                             */
/*==============================================================*/
create table CHART_CFG 
(
   CFG_ID               NUMBER(22)           not null,
   CFG_NAME             VARCHAR(1000),
   CFG_KEY              VARCHAR(1000),
   CFG_VALUE            VARCHAR(2000),
   constraint PK_CHART_CFG primary key (CFG_ID)
);
