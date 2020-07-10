--������ռ�,����ָ�������ļ�����λ��, �����ļ���׺������.dbf
create tablespace hr
datafile 'e:\hr.dbf'
size 100m
autoextend on 
next 10m;
--ɾ����ռ�
drop tablespace hr;

--�����û�(�û���,����,��ռ�)
create user herun
identified by herun
default tablespace hr;
--���û���Ȩ(���򴴽����û��޷���¼)
        --oracle���ݿ��г��ý�ɫ: connect:���ӽ�ɫ, ������ɫ;resource: �����߽�ɫ;dba:��������Ա��ɫ
--��herun�û�����dba��ɫ
grant dba to herun;



--����һ��person��
create table person(
       pid number(20),
       pname varchar2(10)
);
--��ɾ��
drop table person;
--�޸ı�ṹ
     --����һ��
     alter table person add (gender number(1));
     --�޸������� (char��varchar2������: char�ǹ̶�����,��varchar2���������ݳ���Ϊ׼)
     alter table person modify gender char(1);
     --�޸�������
     alter table person rename column gender to sex;
     --ɾ��һ��
     alter table person drop column sex;
     
     
     
     
--���һ����¼(��ɾ�ı����ύ����)
insert into person(pid,pname) values (1,'С��');
commit;
--�޸�һ����¼
update person set pname='С��' where pid = 1;
commit;
--ɾ��
       --1 ɾ������ȫ����¼
       delete from person;
       --2 ɾ����ṹ
       drop table person;
       --3 ��ɾ����,�ٴδ�����. Ч����ͬ��ɾ������ȫ����¼
       --����������������,�����ڱ��д��������������,�ò���Ч�ʸ�
       --����������߲�ѯЧ��,���ǻ�Ӱ����ɾ��Ч��
       truncate table person;     
     

--���в���������κ�һ�ű�,���ǿ����߼��ͱ�����
--����: Ĭ�ϴ�1��ʼ,���ε���,��Ҫ������������ֵʹ��
--dual: ���, ֻ��Ϊ�˲�ȫ�﷨,û���κ�����
        --��������
        create sequence s_person;
        --���д������֮��,���е��Զ�����Ӧ�����û��Լ�����,�������������ṩ�����µ����ֲ���
        --nextval: ȡ�����е���һ������
        --currval: ȡ�����еĵ�ǰ����
        select s_person.nextval from dual;
        select s_person.currval from dual;
--ʹ���������һ��
insert into person(pid,pname) values (s_person.nextval,'С��');
commit;



--scott�û�,  Ĭ������tiger 
--����scott�û�
alter user scott account unlock;
--����scott�û�������(�˾�Ҳ������������)
alter user scott identified by tiger;
--�л���scott�û�����



--���к���
--�ַ�����
select upper('yes') from dual; --YES
select lower('YES') from dual; --yes
--��ֵ����
       --��������,����Ĳ�����ʾ������λ��   
       select round(26.18, 1) from dual;  
       --ֱ�ӽ�ȡ,���ٿ������λ���������Ƿ����5 
       select round(26.18, 1) from dual;  
       --����
       select mod(10,3) from dual;
--���ں���
--��ѯemp��������Ա����ְ�������ڼ���?
select sysdate-e.hiredate from emp e;
--�������˿�
select sysdate+1 from dual;
--��ѯemp��������Ա����ְ�������ڼ���?
select months_between(sysdate,e.hiredate) from emp e;
--��ѯemp��������Ա����ְ�������ڼ���? (ֻ��months_between)
select months_between(sysdate, e.hiredate)/12 from emp e;
--��ѯemp��������Ա����ְ�������ڼ���,������������? 
select round((sysdate-e.hiredate)/7) from emp e;
--ת������
       --����ת�ַ���
       select to_char(sysdate,'yyyy-mm-dd hh:mi:ss') from dual;
       select to_char(sysdate, 'fm yyyy-mm-dd hh:mi:ss') from dual;
       select to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss') from dual;
       --�ַ���ת����
       select to_date('2020-7-10 9:39:32','yyyy-mm-dd hh24:mi:ss') from dual;
--ͨ�ú���
--���emp��������Ա������н
--����������nullֻ, ���nullֵ��������������������,�������null, ����ʹ��ͨ�ú���nvl
select (e.sal*12+nvl(e.comm,0)) from emp e;

--�������ʽ
--��emp����Ա���������� (case,end �Ƕ�ռһ��, when then��������,else����ʡ��)
--��ֵ�ж� (mysql��oracleͨ��)
select e.ename,
       case e.ename
         when 'SMITH' then '����'
           when 'ALLEN' then '���С��'
             else '����' 
               end 
from emp e;
--�ж�emp����Ա������,�������3000��ʾ������,�������1500����3000��ʾ�е�����,������ʾ�͵�����
--��Χ�ж�(mysql��oracleͨ��)
select e.sal,
       case 
         when e.sal > 3000 then '������'
           when e.sal > 1500 then '�е�����'
             else '�͵�����'
               end
from emp e;
---����: oracle�г������������,���õ�����
--oracleר���������ʽ
select e.ename,
       decode(e.ename,
               'SMITH','����',
               'ALLEN','���С��',
               '����') ������
from emp e;



--���к���[�ۺϺ���] : �����ڶ���,����һ��ֵ,һ��ֻ��5�����к���
select count(1) from emp;
select sum(1) from emp;
select max(1) from emp;
select min(1) from emp;
select avg(1) from emp;





























     
     
     
     
     
     
     
     
     
     
     
     
     
        
        
        
