--���ڿ���
select sysdate, hire_date , 
     floor((sysdate- hire_date)/365) �⵵1,    
     floor(months_between(  sysdate, hire_date)/12) �⵵2 ,
     add_months(hire_date, 1) "10������",
     last_day(hire_date) �������� ,
     next_day(hire_date, '������') ó�����ÿ��� ,
     round(hire_date, 'month') "�ݿø�1-16�̻�",
     trunc(hire_date, 'month') "����1-������������",
     first_name, salary 
from EMPLOYEES;
--where
--order by 

select  sysdate, to_char(sysdate, 'yyyy/mm/dd hh:mi:ss DAY DY MON AM'),
    to_char(10000000, 'L999,9999,999') ,
    to_date(20220101, 'YYYYMMDD')
from dual;

select  first_name, hire_date
from EMPLOYEES
where hire_date = to_date('030617','rrmmdd');

--nls_date_format������ �ٲܼ��ִ�.  alter session set nls_date_format='';
--rr/mm/dd  rrmmdd   rr�� 50�̻��̸� 19, �̸��̸� 20 
select  first_name, hire_date
from EMPLOYEES
where hire_date = '03/06/17';

select  first_name, hire_date
from EMPLOYEES
where hire_date = '030617';

select  first_name, hire_date
from EMPLOYEES
where hire_date = '20030617';



select * from nls_session_parameters;


select  first_name, hire_date, salary, commission_pct, 
        salary + salary * nvl(commission_pct,0) �Ǽ��ɾ� ,
         salary + salary * nvl2(commission_pct, commission_pct, 0) �Ǽ��ɾ�2 ,
         nvl2(commission_pct, 'Ŀ�̼�����', 'Ŀ�̼Ǿ���') "nvl2����"
from EMPLOYEES
order by commission_pct ; -- nulls first


--��manager_id�� null�̸� �����̴�. 
select  first_name, manager_id, nvl(to_char(manager_id), 'CEO'),
      nvl2(manager_id,to_char(manager_id), 'CEO'), 
      department_id,
      nvl(to_char(department_id),'�μ�����') "nvl����",
      decode(department_id,10,'A',60,'B',90,'C','D') �μ�decode,
      salary, case when salary>=10000 then '�ſ츹��'
                           when salary>=7000 then '����'
                            when salary>=5000 then '�⺻'
                            else '����'
                           end "case����", 
            case when first_name like 'A%' then 'A�ν���' else '�ƴ�' end "case����2"  ,
            case when first_name like '%a' then 'A�γ�' else '�ƴ�' end "case����2" 
      
from EMPLOYEES;


desc EMPLOYEES;


--
1. �̸��� 'adam' �� ������ �޿��� �Ի����� ��ȸ�Ͻÿ�.
select first_name, salary, hire_date
from employees
where first_name =initCap('adam');


2. ���� ���� 'united states of america' �� ������ ���� �ڵ带 ��ȸ�Ͻÿ�.
select *
from countries
where lower(country_name)='united states of america';


where country_id = initCap('united states of america');

select country_id from countries WHERE country_name LIKE 'United% S%';


3. 'Adam�� �Ի����� 95/11/02 �̰�, �޿��� 7000 �Դϴ�.' �̷� ������ ���������� ��ȸ�Ͻÿ�.
select first_name||'�� �Ի�����'|| hire_date||'�̰�, �޿���'|| salary||'�Դϴ�.'
from employees





4. �̸��� 5���� ������ �������� �̸�, �޿�, �Ի����� ��ȸ�Ͻÿ�.
select first_name, salary, hire_date
from employees
where length(first_name)<=5;

5.2006�⵵�� �Ի��� ������ �̸�, �Ի����� ��ȸ�Ͻÿ�.
select first_name, hire_date
from employees
where to_char(hire_date,'yyyy')='2006';

6. 7�� �̻� ��� �ټ��� �������� �̸�, �Ի���, �޿�, �ٹ������� ��ȸ�Ͻÿ�.
select first_name, hire_date, salary, trunc(months_between(sysdate,hire_date)/12)
from employees
where trunc(months_between(sysdate,hire_date)/12) >= 7;



select first_name �̸�, hire_date �Ի���, salary �޿�, substr(sysdate,1,2)-substr(hire_date,1,2) �ٹ�����
from employees
where (substr(sysdate,1,2)-substr(hire_date,1,2)) >= 7;


select first_name, hire_date, salary, to_char(sysdate, 'yyyy') - to_char(hire_date, 'yyyy') �ٹ�����
from employees
where  to_char(sysdate, 'yyyy') - to_char(hire_date, 'yyyy') >= 7;


select first_name, salary, hire_date,
EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM hire_date) �ٹ����� 
from employees 
WHERE EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM hire_date) >= 7;



----------Group
--�����Լ�(Į���̸�) : ���� null�� �����Ѵ�. 
--�����Լ�(*) : null������ 
--group by���� ������ ��ü�� ���� �����̴�. 
select sum(salary), sum(commission_pct), avg(salary), count(salary), sum(salary)/count(salary),
          count(salary), count(*) ��ü�Ǽ� ,count(commission_pct), count(manager_id)  
from employees 

--���� �ֱٿ� �Ի��� ����� �Ի��ϰ� �Ի����� ���� ������ ����� �Ի����� ����ϴ� �������� �ۼ��Ͻÿ�. 
select max(hire_date) "���� �ֱٿ� �Ի�"
          , min(hire_date) "���� ������ ���" 
from employees 

--80�� �μ� �Ҽ� ����߿��� Ŀ�̼��� �޴� ����� ���� ���غ��ÿ�.

select  count( commission_pct), count( *)
from employees 
where department_id =80
--and commission_pct is not null;


select  count( distinct job_id)  , count(  job_id)  , count(department_id) , count(distinct department_id)
from employees;

select  distinct department_id
from employees
where department_id is not null;

--�����Լ��� ����������� Į���� select�� �ִٸ� �ݵ�� group by���� �����ؾ��Ѵ�. 
--�μ��� salary���
select department_id, max(job_id), avg(salary)
from employees
where department_id <= 110
group by department_id
order by 1 ;

select department_id, job_id, avg(salary) avg_sal  --5
from employees  --1
where department_id <= 110  --2
group by department_id, job_id --3
having avg(salary)>=10000 --4
order by avg_sal desc; --6


select department_id, max(salary), min(salary)
from employees
group by department_id



select count(*)
from employees
where department_id = 10;





=============Group �Լ�==================
7. �� �μ��� �ο����� ��ȸ�ϵ� �ο����� 5�� �̻��� �μ��� ��µǵ��� �Ͻÿ�.
select  department_id, count(*)
from employees
group by department_id
having count(*) >= 5;


8. �� �μ��� �ִ�޿��� �ּұ޿��� ��ȸ�Ͻÿ�.
   ��, �ִ�޿��� �ּұ޿��� ���� �μ��� ������ �Ѹ��� ���ɼ��� ���⶧���� 
   ��ȸ������� ���ܽ�Ų��.
select department_id,  max(salary), min(salary)
from employees
group by department_id
having max(salary)<> min(salary)
--having count(*) > 1;

   
9. �μ��� 50, 80, 110 ���� ������ �߿��� �޿��� 5000 �̻� 24000 ���ϸ� �޴�
   �������� ������� �μ��� ��� �޿��� ��ȸ�Ͻÿ�.
   ��, ��ձ޿��� 8000 �̻��� �μ��� ��µǾ�� �ϸ�, ��°���� ��ձ޿��� ����
   �μ����� ��µǵ��� �ؾ� �Ѵ�.


select department_id, avg(salary) avgsal
from employees
where department_id in(50,80,110) 
and salary between 5000 and 24000
group by department_id
having avg(salary) >= 8000
order by avgsal desc;


select employee_id, last_name, first_name from employees;


update employees
set employee_id = 1
where employee_id = 100;

create table JJ ( id number primary key, name varchar2(20)    );
insert into JJ values(1, 'AA');
insert into JJ values(2, 'BB');

select * from jj;

update JJ set id=100 where id=1;


--100�������� �ٹ��ϴ� �μ��̸��� �˰�ʹ�.
--������ �μ��� �����Ѵ�. (�Ǽ��� �����Ǽ���ŭ ���´�. ) 

--DB Vendor����
select  employee_id,    first_name, department_name , departments.department_id
from employees, departments
where employees.department_id = departments.department_id 
order by 1;
---------------------------ANSIǥ�ع��� 
--join�ϰ����ϴ� Į���� ��ġ�ϴ� ��� ��� 
select  employee_id,    first_name, department_name , department_id
from employees join departments using(department_id);
 
--join�ϰ����ϴ� Į���� ��ġ���� �ʴ� ��� ��� 
select  employee_id,    first_name, department_name , departments.department_id
from employees join departments on(employees.department_id = departments.department_id );

select  employee_id,    first_name, department_name , departments.department_id
from employees left outer  join departments on(employees.department_id = departments.department_id );

select  employee_id,    first_name, department_name , departments.department_id
from employees full outer  join departments on(employees.department_id = departments.department_id );

--������ � �������� �ڼ��� �˰����Ѵ�. job_title, max_salry, min_salary 

desc employees;
desc jobs;
--PK(primary key) : NULL�Ұ� + UNIQUE 
--FK(Foreign key) : ����Ű , �ٸ����̺� Ȥ�� �ڽ��� table�� pk�� �����Ѵ�. 


select employees.first_name, employees.salary, jobs.*
from employees, jobs
where employees.JOB_ID = jobs.JOB_ID;


select employees.first_name, employees.salary, job_id, job_title, max_salary, min_salary 
from employees join jobs using(JOB_ID)

select employees.first_name, employees.salary, jobs.* 
from employees join jobs on(employees.JOB_ID = jobs.JOB_ID)





select 107*27 from dual;
--employees: 107�� 
--departments : 27�� 

select *
from employees
where employee_id = 100 

select *
from departments
where department_id = 90;











 










