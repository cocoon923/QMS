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

insert into chart_cfg values (QMS_SEQ.nextval, '±˝Õº≈‰÷√', 'PIE_CFG', '{  chart: {  renderTo: ''pieContainer'', plotBackgroundColor: null,  plotBorderWidth: null,  plotShadow: false  },  tooltip: {  pointFormat: ''{series.name}: <b>{point.percentage:.1f}%</b>''  },  plotOptions: {  pie: {   allowPointSelect: true,   cursor: ''pointer'',   dataLabels: {   enabled: false   },   showInLegend: true  }  } }');
insert into chart_cfg values (QMS_SEQ.nextval, '÷˘◊¥Õº≈‰÷√', 'BAR_CFG', '{  chart: {  renderTo: ''barContainer'', type: ''column''  },  credits: {  enabled: false  } }');
commit;

select * from chart_cfg;

truncate table chart_cfg;
