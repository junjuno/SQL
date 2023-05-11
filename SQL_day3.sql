--1.�������� �̸��� ���޸�(job_title)�� ��ȸ�Ͻÿ�.
--107��...��, job_id�� null�� �����Ͱ� ����. 
select count(*) from employees;
select count(job_id) from employees;


select e.first_name,  j.job_title
from employees e, jobs j
where e.job_id = j.job_id;



select e.first_name || ' ' || e.last_name as �̸�, j.job_title as ���޸�
from employees e join jobs j
using (job_id);



--2.�μ��̸��� �μ��� ���� ���ø�(city)�� ��ȸ�Ͻÿ�.

select * from departments where department_id = 60;
select * from employees where department_id = 60;

select  count(*) from departments;
select * from locations;



select d.department_name, l.city
from DEPARTMENTS d
join locations l
using(location_id);

select d.department_name, l.city
from DEPARTMENTS d, locations l
where d.location_id = l.location_id




--3. ������ �̸��� �ٹ��������� ��ȸ�Ͻÿ�. (employees, departments, locations,countries)
select e.first_name || ' ' || e.last_name as �̸�, c.country_name as �ٹ�������
from employees e
join departments d using (department_id)
join locations l using (location_id)
join countries c using (country_id);

select count(*) from employees;
select count(department_id) from employees;



--4. ��å(job_title)�� 'manager' �� ����� �̸�, ��å, �μ����� ��ȸ�Ͻÿ�.
select e.first_name || ' ' || e.last_name as �̸�, j.job_title as ��å, d.department_name as �μ���
from employees e
join jobs j using(job_id) 
join departments d using(department_id)
--where j.job_title Like '%'|| initCap('manager') || '%';
where j.job_title Like initCap('%manager%');


select department_id,avg(salary)
from employees
group by department_id;



select e.first_name || ' ' || e.last_name as �̸�, j.job_title as ��å, d.department_name as �μ���
from employees e
join jobs j using(job_id) 
join departments d using(department_id)
where substr( j.job_title  , -7) = initCap('manager');


select * from jobs;




--5. �������� �̸�, �Ի���, �μ����� ��ȸ�Ͻÿ�.
select  e.first_name || ' ' || e.last_name as �̸�, e.hire_date as �Ի���, department_name as �μ���
from employees e
join departments d using(department_id);





--6. �������� �̸�, �Ի���, �μ����� ��ȸ�Ͻÿ�.
--��, �μ��� ���� ������ �ִٸ� �� ���������� ��°���� ���Խ�Ų��.
select e.first_name || ' ' || e.last_name as �̸�, e.hire_date as �Ի���, department_name as �μ���
from employees e left outer join departments d using(department_id);

select e.first_name || ' ' || e.last_name as �̸�, e.hire_date as �Ի���, department_name as �μ���
from departments d  right outer join employees e using(department_id);




--7. ������ �̸��� ��å(job_title)�� ����Ͻÿ�.
--��, ������ �ʴ� ��å�� �ִٸ� �� ��å������ ��°���� ���Խ�Ű�ÿ�.
select e.first_name || ' ' || e.last_name as �̸�, j.job_title as ��å
from employees e right join jobs j using(job_id);

--����table���� ����� job�� ����
select  count(distinct job_id) from employees;

select count(*) from jobs;

desc jobs;

insert into jobs values('play','���ϸ���play', 1000, 20000);
commit;

select * from jobs;


--Non equi join (=�̿��� �����ڸ� �̿��ؼ� ����)
create table salgrade( grade char(1) primary key, minsal number, maxsal number);

insert into salgrade values('A', 0, 5000);
insert into salgrade values('B', 5001, 15000);
insert into salgrade values('C', 15001, 20000);
insert into salgrade values('D', 20001, 30000);
commit;

select * from salgrade;

---�����̸��� �޿��� �޿��� ������
select e.first_name, e.salary, s.grade
from employees e,  salgrade s
where e.salary between s.minsal and s.maxsal 


select first_name, salary, grade
from employees join salgrade on (salary between minsal and maxsal );

--�Ǽ� : 106
select ����.employee_id, ����.first_name, �޴���.employee_id , �޴���.first_name 
from employees ����,  employees �޴��� 
where ����.manager_id = �޴���.employee_id(+)   --Oracle���� outer join
order by 1;

select ����.employee_id, ����.first_name, �޴���.employee_id , �޴���.first_name
from employees ���� join employees �޴��� on (����.manager_id = �޴���.employee_id)

select ����.employee_id, ����.first_name, �޴���.employee_id , �޴���.first_name
from employees ���� left outer  join employees �޴��� on (����.manager_id = �޴���.employee_id);

--�Ŵ����� KING�� ������� �̸��� ������ ����Ͻÿ�.


select  ����.employee_id, ����.first_name, ����.last_name , job_title
from  employees ����, employees �޴���, jobs 
where ����.manager_id = �޴���.employee_id 
and ����.job_id = jobs.job_id 
and �޴���.last_name = 'King';


--'King'�� ����id�˾Ƴ��� 
--subquery 
select employee_id,  first_name, last_name
from employees
where manager_id = (select  employee_id from employees
                                    where first_name = 'Steven' and  last_name = 'King');


--Steven King�� ������ �μ����� �ٹ��ϴ� ����� �̸��� ����Ͻÿ�.
--1.Steven King �μ�
--2.������ �ٹ��� 


--self join
select  ����.employee_id, ����.first_name, ����.last_name , ����.department_id
from  employees ����, employees m 
where ����.department_id = m.department_id 
and m.first_name = 'Steven' and m.last_name = 'King';

--subquery 
select *
from employees
where department_id = (select department_id from employees
                                        where first_name = 'Steven' and  last_name = 'King');

 

--�μ��� ����
desc departments;
desc employees;

--�μ��������, manager_id�� �μ����� �ǹ�, �μ����� �����߿� 1���̴�. (�μ����̸�, �޿�, �Ի���)
--�μ����� ���� �μ��� ��°���� �����Ѵ�. 
select  departments.*, employees.first_name, employees.salary, employees.hire_date
from departments, employees
where departments.manager_id = employees.employee_id(+)

select  departments.*, employees.first_name, employees.salary, employees.hire_date
from departments left outer join employees on (departments.manager_id = employees.employee_id)


select  first_name, salary, department_name 
from employees full outer  join departments using (department_id) 

--Neena�� ������ ������ ���� ����� ����ϴ� SQL ���� �ۼ��� ���ÿ�. 
--subquery���� subquery�� ����� ���������� ���������� ����...�����࿬����(=,>,<),  �����࿬����(in, =ANY)
select * 
from employees
where job_id  =ANY   (         
            select job_id
            from employees
            where first_name = 'Alexander' )  ; --IT_PROG, PU_CLERK
            


--SCOTT�� �޿��� �����ϰų� �� ���� �޴� ��� ��� �޿��� ����Ͻÿ�.
--subquery����� 1���̸� ������ �����ڸ� ���: = > ,>=, < , <=
--subquery����� 1���̻� ������ �����ڸ� ���:in, >=ALL, >ALL, >=ANY >ANY 
select *
from employees
where salary >=ALL (
        select salary
        from employees
        where first_name = 'Alexander')  --9000, 3100


--Seattle���� �ٹ��ϴ� ����� �̸�, �μ� ��ȣ�� ����Ͻÿ�. (18��)

SELECT first_name, last_name, salary, department_id
FROM EMPLOYEES join DEPARTMENTS using(department_id)
                                join locations using(location_id)
where  city = 'Seattle';

SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID =any (
                        SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE location_id =  (
                                    select location_id 
                                    from locations
                                    where city = 'Seattle' )
             )


--IT �μ����� �ٹ��ϴ� ��� ����� �̸��� �޿��� ����Ͻÿ�

select first_name, salary, department_id
from employees
where department_id = (
                    SELECT department_id 
                     FROM DEPARTMENTS
                    where department_name = 'IT')

--���ӻ���� KING�� ����� �̸��� �޿��� ����Ͻÿ�. 

select *
from employees
where manager_id =ANY(
            select employee_id
            from employees
            where last_name = 'King' ) --and  first_name = 'Steven'  )



--��� �޿����� �� ���� �޿��� �޴� ����� �˻��ϴ� ������ ������ �����ϴ�. 

select *
from employees
where salary >=(
                        select avg(salary)
                        from employees)

----------------
select *
from employees
where salary >=any(
                        select avg(salary)
                        from employees GROUP BY DEPARTMENT_ID)


--�μ����� ���� �޿��� ���� �޴� ����� ����(��� ��ȣ, ����̸�, �޿�, �μ���ȣ)�� ����Ͻÿ�.(IN ������ �̿�)

--����Į�� SUBQUERY 
SELECT *
FROM EMPLOYEES
WHERE (department_id, salary     ) IN (
                SELECT DEPARTMENT_ID, MAX(SALARY)
                FROM EMPLOYEES
                GROUP BY DEPARTMENT_ID)


select count(distinct DEPARTMENT_ID)
from EMPLOYEES;



--����(JOB)�� MANAGER�� ����� ���� �μ��� �μ� ��ȣ�� �μ���� ������ ����Ͻÿ�.

select  first_name,department_id, department_name , city 
from employees JOIN departments using(department_id)
                           join locations using(location_id) 
where job_id in (
            select job_id 
            from jobs
            where substr(job_title,-7) = initCap('MANAGER')
        ) ;



select  rowid, employee_id, first_name
from employees


create table tbl_test1( id number, name varchar2(20), gender char(1),
          year01 interval year(3) to month) ;

insert into tbl_test1 values(1,'abc', 'M',  interval '36' month(3));
insert into tbl_test1 values(2,'def', 'F',  interval '12' month(3));
commit;
select id,name,gender, sysdate+year01   from tbl_test1;

select *
from tbl_test1
where gender = 'M     ';

where name = 'abc        ';

delete from tbl_test1;


create table tbl_emp4
as
select employee_id, first_name from employees
where 1 = 0;


select * from tbl_emp4;

desc tbl_emp4;

alter table tbl_emp4 add ( job_id varchar2(50)) ;
alter table tbl_emp4 modify (job_id varchar2(100)) ;
--����� �ø��°��� ���� , �̹� �����Ͱ� ������ ���������̴� ���� �Ұ� 
alter table tbl_emp4 modify (first_name varchar2(30)) ;
--�����Ͱ� �־ ��������. 
alter table tbl_emp4 drop  column first_name ;


insert into tbl_emp4 values(1, '12345678901234567890','ABC');

drop table tbl_emp4;


desc tbl_employee;
select * from tbl_emp;
truncate table  tbl_emp; --�����Ұ� 

select * from tbl_emp;
delete from tbl_emp;--���󺹱����� 
rollback;  --���󺹱����� 

rename tbl_emp to tbl_employee;

--��ųʸ���

select *
from user_tables;

select *
from all_tables;


select *
from dba_tables;

--char : ��������
--varchar2 : �������� 
create table tbl_jin(id number, name1 char(10), name2 varchar2(10));
--name1���� '123       '
--name2���� '123'
insert into tbl_jin values(1, '123','123');

---���������� ����ȵ� , notnull�� ����� 
create table tbl_emptest
as
select employee_id, first_name, salary, hire_date
from employees
where department_id = 60; 

desc tbl_emptest;

insert into tbl_emptest values(1,'AA', 1000, sysdate);
insert into tbl_emptest(employee_id,first_name, hire_date ) values(2,'BB', sysdate);
insert into tbl_emptest(employee_id, hire_date ) values(3,  sysdate-1);
insert into tbl_emptest( hire_date ) values( sysdate-1);
select * from tbl_emptest;

--Į���� ���� ���������� �Ͻ������� null�̴�. 
--��������� null���� �ο����� 
insert into tbl_emptest(employee_id,first_name, hire_date ) values(4,null, sysdate);
insert into tbl_emptest(employee_id,first_name, hire_date ) values(5,'', sysdate); --''�� null


--table�� ��������� 
create table tbl_dept
as
select * from departments where 1=0;

desc tbl_dept;

select * from tbl_dept;

insert into tbl_dept
select employee_id, first_name, 100, 1700 from employees;


create table tbl_emp_update
as
select * from employees;


select * from tbl_emp_update;

update tbl_emp_update set salary = salary*1.1
where department_id = 50;

--transactionó���� �ϴ� ��ɾ� (transaction : �ϳ��� ������ �۾�)
rollback; --D�۾��� ������ DB�ݿ����Ѵ�. 
commit; --D�۾��� ������ DB�� �ݿ��Ѵ�. 


�μ��� 90���� �������� 
Diana������ ���� �μ�, ���� salary�� �����Ѵ�, 

select salary
from employees
where first_name  = 'Diana'


update tbl_emp_update
set department_id = (select department_id
                                    from employees
                                    where first_name  = 'Diana'), 
      salary=(select salary
                    from employees
                    where first_name  = 'Diana')
where department_id = 90;


delete  from tbl_emp_update
where department_id =  (select department_id
                                    from employees
                                    where first_name  = 'Diana')

commit;

drop table EMP01;
drop table EMP02;

create table EMP01
as
select employee_id empno, first_name ENAME, job_id JOB, manager_id MGR, 
          hire_date HIREDATE, salary SAL, commission_pct COMM, department_id DEPTNO
from employees
where department_id = 60;

create table EMP02
as
select employee_id empno, first_name ENAME, job_id JOB, manager_id MGR, 
          hire_date HIREDATE, salary SAL, commission_pct COMM, department_id DEPTNO
from employees
where department_id = 60;

 
--EMP02�� �ִ� 1�� �����ϱ� 
select * from emp02;
select * from emp01;

update emp02 set  job='aa' , SAL = 9999, comm = 0.1, deptno=88
where empno=103;

--EMP02�� �űԸ� �����ϱ� 
insert into emp02 values(111,'jj','bb',100, sysdate, 8888,0.2, 77);


MERGE INTO EMP01
USING EMP02 ON(EMP01.EMPNO=EMP02.EMPNO)
WHEN MATCHED THEN
        UPDATE SET
        EMP01.ENAME=EMP02.ENAME,
        EMP01.JOB=EMP02.JOB,
        EMP01.MGR=EMP02.MGR,
        EMP01.HIREDATE=EMP02.HIREDATE,
        EMP01.SAL=EMP02.SAL,
        EMP01.COMM=EMP02.COMM,
        EMP01.DEPTNO=EMP02.DEPTNO
WHEN NOT MATCHED THEN
        INSERT VALUES(EMP02.EMPNO, EMP02.ENAME, EMP02.JOB, 
        EMP02.MGR, EMP02.HIREDATE, EMP02.SAL, 
        EMP02.COMM, EMP02.DEPTNO);

select * from EMP01;


select * from jobs;



select first_name, salary, department_name, department_id
from employees left outer join departments using (department_id)
               left outer join LOCATIONS using (LOCATION_id)
               join jobs using (job_id)
where salary > (select avg(salary)
                from employees
                where department_id =50)
and salary > all ( select min_salary
                   from employees
                   where city = 'South San Francisco');
                   
--subquery ���� �߰���                   
                   