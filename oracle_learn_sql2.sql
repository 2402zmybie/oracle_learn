--分组查询
--分组查询中,出现在group by后面的原始列,才能出现在select后面,没有出现在group by后面的列,想在select后面,必须加上聚合函数
  --查询出每个部门的平均工资
  select deptno,avg(sal) from emp group by deptno;
  --查询平均工资高于2000的部门信息,(所有条件都不能使用别名判断, 只能用avg(e.sal)>2000, 因为where条件先于select)
  select e.deptno,avg(e.sal) from emp e group by e.deptno having avg(e.sal) > 2000;
  --查询出每个部门工资高于800的员工的平均工资
  select e.deptno,avg(e.sal)
  from emp e
  where e.sal > 800
  group by e.deptno;
--where是过滤分组前的数据,having是过滤分组后的数据. 表现形式:where必须在group by之前,having是在group by之后
  --查询出每个部门工资高于800的员工的平均工资,然后再查询出平均工资高于2000的部门
  select e.deptno,avg(e.sal) from emp e where e.sal >800 group by e.deptno having avg(e.sal) > 2000;
  

--多表查询
--笛卡尔积
select * from emp e,dept d;  
--等值连接
select * from emp e,dept d where e.deptno = d.deptno;
--内连接 (和等值连接一样)
select * from emp e inner join dept d on e.deptno = d.deptno;
--(外连接) 查询出所有部门,已经部门下员工的信息(表中40号部门是空部门)  
select * from dept d left join emp e on d.deptno = e.deptno; 
--查询所有员工信息,以及员工所属部门
select * from emp e left join dept d on e.deptno = d.deptno;
--oracle中专用外连接(显示部门表的全部数据,即是在对面的等值连接 后加上(+)  )
select * from emp e,dept d where e.deptno(+) = d.deptno;



--自连接: 自连接其实就是站在不同的角度把一张表看成是多张表
--查询出员工姓名,员工领导姓名 (e1是员工表, e2是领导表)
select e1.ename,e2.ename
from emp e1,emp e2
where e1.mgr = e2.empno
--查询出员工姓名,员工部门名称,员工领导名称,员工领导部门名称
select e1.ename 员工,e2.ename 领导,d1.dname 员工部门,d2.dname 领导部门
from emp e1,emp e2,dept d1,dept d2
where e1.mgr = e2.empno
and e1.deptno = d1.deptno
and e2.deptno = d2.deptno;
--查询出每个员工编号，姓名，部门名称，工资等级和他的上级领导的姓名，工资等级 
select e1.empno,e1.ename,d.dname,
       case s1.grade
         when 1 then '一等'
           when 2 then '二等'
             when 3 then '三等'
               when 4 then '四等'
                 when 5 then '五等'
                   end,
                   e2.ename,
                   case s2.grade
                     when 1 then '一等'
                       when 2 then '二等'
                         when 3 then '三等'
                           when 4 then '四等'
                             when 5 then '五等'
                               end
from emp e1, emp e2,dept d,salgrade s1,salgrade s2
where e1.mgr = e2.empno
and e1.deptno = d.deptno
and e1.sal between s1.losal and s1.hisal
and e2.sal between s2.losal and s2.hisal;


--子查询
--子查询返回一个值
    --查询出工资和SCOTT一样的员工信息(此处可以用= ,但是不保证公司只有一个名为SCOTT的员工)
    select * from emp e1 where e1.sal in ( select e.sal from emp e where e.ename = 'SCOTT')
--子查询返回一个集合
    --查询出工资和10号部门任意员工一样的员工信息
    select * from emp where sal in (select sal from emp where deptno = 10);
--子查询返回一张表
    --查询出每个部门最低工资,和最低工资员工姓名,和该员工所在部门名称
    select t.msal,e.ename,d.dname
    from (select e.deptno, min(e.sal) msal
            from emp e
            group by e.deptno) t, emp e,dept d
    where t.msal = e.sal and e.deptno = d.deptno
    
    
--oracle中的分页
--rownum行号: 当我们做select操作的时候,每查询出一条记录,就会在该行上加上一个行号,行号从1开始,依次递增,不能跳着走
            --emp表工资倒序排列后,每页五条记录,查询第二页(由于select先于order by执行,所以排序会影响rownum的顺序)
            select rownum, e.* from emp e order by e.sal desc; 
            --如果涉及到排序,但是还要使用rownum的话,我们可以再次嵌套查询:
            select rownum, e.* from (select * from emp order by sal desc)e;
        --emp表工资倒序排列后,每页五条数据,查询第二页
        select * from (
               select rownum rn, tt.* 
               from (
                     select * from emp order by sal desc
               )tt where rownum <11
        ) where rn > 5;
















  
  
  
