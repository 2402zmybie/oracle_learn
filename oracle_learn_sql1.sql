--创建表空间,并且指定数据文件所在位置, 数据文件后缀必须是.dbf
create tablespace hr
datafile 'e:\hr.dbf'
size 100m
autoextend on 
next 10m;
--删除表空间
drop tablespace hr;

--创建用户(用户名,密码,表空间)
create user herun
identified by herun
default tablespace hr;
--给用户授权(否则创建的用户无法登录)
        --oracle数据库中常用角色: connect:连接角色, 基本角色;resource: 开发者角色;dba:超级管理员角色
--给herun用户授予dba角色
grant dba to herun;



--创建一个person表
create table person(
       pid number(20),
       pname varchar2(10)
);
--表删除
drop table person;
--修改表结构
     --增加一列
     alter table person add (gender number(1));
     --修改列类型 (char和varchar2的区别: char是固定长度,而varchar2是依据数据长度为准)
     alter table person modify gender char(1);
     --修改列名称
     alter table person rename column gender to sex;
     --删除一列
     alter table person drop column sex;
     
     
     
     
--添加一条记录(增删改必须提交事务)
insert into person(pid,pname) values (1,'小明');
commit;
--修改一条记录
update person set pname='小马' where pid = 1;
commit;
--删除
       --1 删除表中全部记录
       delete from person;
       --2 删除表结构
       drop table person;
       --3 先删除表,再次创建表. 效果等同于删除表中全部记录
       --在数据量大的情况下,尤其在表中带有索引的情况下,该操作效率高
       --索引可以提高查询效率,但是会影响增删改效率
       truncate table person;     
     

--序列不真的属于任何一张表,但是可以逻辑和表做绑定
--序列: 默认从1开始,依次递增,主要用来给主键赋值使用
--dual: 虚表, 只是为了补全语法,没有任何意义
        --创建序列
        create sequence s_person;
        --序列创建完成之后,所有的自动增长应该由用户自己处理,所以在序列中提供了以下的两种操作
        --nextval: 取得序列的下一个内容
        --currval: 取得序列的当前内容
        select s_person.nextval from dual;
        select s_person.currval from dual;
--使用序列添加一条
insert into person(pid,pname) values (s_person.nextval,'小明');
commit;



--scott用户,  默认密码tiger 
--解锁scott用户
alter user scott account unlock;
--解锁scott用户的密码(此句也可以重置密码)
alter user scott identified by tiger;
--切换到scott用户下面



--单行函数
--字符函数
select upper('yes') from dual; --YES
select lower('YES') from dual; --yes
--数值函数
       --四舍五入,后面的参数表示保留的位数   
       select round(26.18, 1) from dual;  
       --直接截取,不再看后面的位数的数字是否大于5 
       select round(26.18, 1) from dual;  
       --求余
       select mod(10,3) from dual;
--日期函数
--查询emp表中所有员工入职距离现在几天?
select sysdate-e.hiredate from emp e;
--算出明天此刻
select sysdate+1 from dual;
--查询emp表中所有员工入职距离现在几月?
select months_between(sysdate,e.hiredate) from emp e;
--查询emp表中所有员工入职距离现在几年? (只有months_between)
select months_between(sysdate, e.hiredate)/12 from emp e;
--查询emp表中所有员工入职距离现在几周,并且四舍五入? 
select round((sysdate-e.hiredate)/7) from emp e;
--转换函数
       --日期转字符串
       select to_char(sysdate,'yyyy-mm-dd hh:mi:ss') from dual;
       select to_char(sysdate, 'fm yyyy-mm-dd hh:mi:ss') from dual;
       select to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss') from dual;
       --字符串转日期
       select to_date('2020-7-10 9:39:32','yyyy-mm-dd hh24:mi:ss') from dual;
--通用函数
--算出emp表中所有员工的年薪
--奖金里面有null只, 如果null值和任意数字做算术运算,结果都是null, 所以使用通用函数nvl
select (e.sal*12+nvl(e.comm,0)) from emp e;

--条件表达式
--给emp表中员工起中文名 (case,end 是独占一列, when then不限数量,else可以省略)
--等值判断 (mysql和oracle通用)
select e.ename,
       case e.ename
         when 'SMITH' then '曹贼'
           when 'ALLEN' then '诸葛小儿'
             else '无名' 
               end 
from emp e;
--判断emp表中员工工资,如果高于3000显示高收入,如果高于1500低于3000显示中等收入,其余显示低等收入
--范围判断(mysql和oracle通用)
select e.sal,
       case 
         when e.sal > 3000 then '高收入'
           when e.sal > 1500 then '中等收入'
             else '低等收入'
               end
from emp e;
---经验: oracle中除了起别名以外,都用单引号
--oracle专用条件表达式
select e.ename,
       decode(e.ename,
               'SMITH','曹贼',
               'ALLEN','诸葛小儿',
               '无名') 中文名
from emp e;



--多行函数[聚合函数] : 作用于多行,返回一个值,一共只有5个多行函数
select count(1) from emp;
select sum(1) from emp;
select max(1) from emp;
select min(1) from emp;
select avg(1) from emp;





























     
     
     
     
     
     
     
     
     
     
     
     
     
        
        
        
