--�����ѯ
--�����ѯ��,������group by�����ԭʼ��,���ܳ�����select����,û�г�����group by�������,����select����,������ϾۺϺ���
  --��ѯ��ÿ�����ŵ�ƽ������
  select deptno,avg(sal) from emp group by deptno;
  --��ѯƽ�����ʸ���2000�Ĳ�����Ϣ,(��������������ʹ�ñ����ж�, ֻ����avg(e.sal)>2000, ��Ϊwhere��������select)
  select e.deptno,avg(e.sal) from emp e group by e.deptno having avg(e.sal) > 2000;
  --��ѯ��ÿ�����Ź��ʸ���800��Ա����ƽ������
  select e.deptno,avg(e.sal)
  from emp e
  where e.sal > 800
  group by e.deptno;
--where�ǹ��˷���ǰ������,having�ǹ��˷���������. ������ʽ:where������group by֮ǰ,having����group by֮��
  --��ѯ��ÿ�����Ź��ʸ���800��Ա����ƽ������,Ȼ���ٲ�ѯ��ƽ�����ʸ���2000�Ĳ���
  select e.deptno,avg(e.sal) from emp e where e.sal >800 group by e.deptno having avg(e.sal) > 2000;
  

--����ѯ
--�ѿ�����
select * from emp e,dept d;  
--��ֵ����
select * from emp e,dept d where e.deptno = d.deptno;
--������ (�͵�ֵ����һ��)
select * from emp e inner join dept d on e.deptno = d.deptno;
--(������) ��ѯ�����в���,�Ѿ�������Ա������Ϣ(����40�Ų����ǿղ���)  
select * from dept d left join emp e on d.deptno = e.deptno; 
--��ѯ����Ա����Ϣ,�Լ�Ա����������
select * from emp e left join dept d on e.deptno = d.deptno;
--oracle��ר��������(��ʾ���ű��ȫ������,�����ڶ���ĵ�ֵ���� �����(+)  )
select * from emp e,dept d where e.deptno(+) = d.deptno;



--������: ��������ʵ����վ�ڲ�ͬ�ĽǶȰ�һ�ű����Ƕ��ű�
--��ѯ��Ա������,Ա���쵼���� (e1��Ա����, e2���쵼��)
select e1.ename,e2.ename
from emp e1,emp e2
where e1.mgr = e2.empno
--��ѯ��Ա������,Ա����������,Ա���쵼����,Ա���쵼��������
select e1.ename Ա��,e2.ename �쵼,d1.dname Ա������,d2.dname �쵼����
from emp e1,emp e2,dept d1,dept d2
where e1.mgr = e2.empno
and e1.deptno = d1.deptno
and e2.deptno = d2.deptno;
--��ѯ��ÿ��Ա����ţ��������������ƣ����ʵȼ��������ϼ��쵼�����������ʵȼ� 
select e1.empno,e1.ename,d.dname,
       case s1.grade
         when 1 then 'һ��'
           when 2 then '����'
             when 3 then '����'
               when 4 then '�ĵ�'
                 when 5 then '���'
                   end,
                   e2.ename,
                   case s2.grade
                     when 1 then 'һ��'
                       when 2 then '����'
                         when 3 then '����'
                           when 4 then '�ĵ�'
                             when 5 then '���'
                               end
from emp e1, emp e2,dept d,salgrade s1,salgrade s2
where e1.mgr = e2.empno
and e1.deptno = d.deptno
and e1.sal between s1.losal and s1.hisal
and e2.sal between s2.losal and s2.hisal;


--�Ӳ�ѯ
--�Ӳ�ѯ����һ��ֵ
    --��ѯ�����ʺ�SCOTTһ����Ա����Ϣ(�˴�������= ,���ǲ���֤��˾ֻ��һ����ΪSCOTT��Ա��)
    select * from emp e1 where e1.sal in ( select e.sal from emp e where e.ename = 'SCOTT')
--�Ӳ�ѯ����һ������
    --��ѯ�����ʺ�10�Ų�������Ա��һ����Ա����Ϣ
    select * from emp where sal in (select sal from emp where deptno = 10);
--�Ӳ�ѯ����һ�ű�
    --��ѯ��ÿ��������͹���,����͹���Ա������,�͸�Ա�����ڲ�������
    select t.msal,e.ename,d.dname
    from (select e.deptno, min(e.sal) msal
            from emp e
            group by e.deptno) t, emp e,dept d
    where t.msal = e.sal and e.deptno = d.deptno
    
    
--oracle�еķ�ҳ
--rownum�к�: ��������select������ʱ��,ÿ��ѯ��һ����¼,�ͻ��ڸ����ϼ���һ���к�,�кŴ�1��ʼ,���ε���,����������
            --emp���ʵ������к�,ÿҳ������¼,��ѯ�ڶ�ҳ(����select����order byִ��,���������Ӱ��rownum��˳��)
            select rownum, e.* from emp e order by e.sal desc; 
            --����漰������,���ǻ�Ҫʹ��rownum�Ļ�,���ǿ����ٴ�Ƕ�ײ�ѯ:
            select rownum, e.* from (select * from emp order by sal desc)e;
        --emp���ʵ������к�,ÿҳ��������,��ѯ�ڶ�ҳ
        select * from (
               select rownum rn, tt.* 
               from (
                     select * from emp order by sal desc
               )tt where rownum <11
        ) where rn > 5;
















  
  
  
