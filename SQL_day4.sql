-- LAB4
-- 1��
-- 'IT'�μ����� �ٹ��ϴ� �������� �̸�, �޿�, �Ի����� ��ȸ�Ͻÿ�.
select first_name, salary, hire_date, department_id
from employees
where department_id = (
                        select department_id
                        from departments
                        where department_name = 'IT');

select e.first_name, e.salary, e.hire_date, department_id
from employees e join departments using(department_id)
where department_name = 'IT';

 
-- 2��
-- 'Alexander' �� ���� �μ����� �ٹ��ϴ� ������ �̸��� �μ�id�� ��ȸ�Ͻÿ�.
select first_name, department_id
from employees
where department_id in(
                                select department_id
                                from employees;
                                
select first_name, department_id
from employees
where department_id =ANY(
                                select department_id
                                from employees
                                where first_name = 'Alexander');                              

-- 3��
-- 80���μ��� ��ձ޿����� ���� �޿��� �޴� ������ �̸�, �μ�id, �޿��� ��ȸ�Ͻÿ�., 
select first_name, department_id, salary
from employees
where salary > (
                            select avg(salary)
                            from employees
                            where department_id = 80);
                            
                            
-- 80���μ��� ��ձ޿����� ���� �޿��� �޴� ������ �̸�, �μ�id, �޿��� ��ȸ�Ͻÿ�., 
-- 80���μ��� ��ձ޿��� ��°�� ���Խ�Ų��. (��Į�� subquery ) 
select first_name, department_id, salary, (
                                                                        select avg(salary)
                                                                        from employees
                                                                        where department_id = 80)
from employees
where salary > (
                            select avg(salary)
                            from employees
                            where department_id = 80);

------inline view
select first_name, department_id, salary,  dept80.sal80
from employees, (
                            select avg(salary) sal80
                            from employees
                            where department_id = 80) dept80
where salary > dept80.sal80;




-- 4��
-- 'South San Francisco'�� �ٹ��ϴ� ������ �ּұ޿����� �޿��� ���� �����鼭 
-- 50 ���μ��� ��ձ޿����� ���� �޿��� �޴� ������ �̸�, �޿�, �μ���, �μ�id�� ��ȸ�Ͻÿ�.(70��)
select first_name, salary, department_name, department_id
from employees left outer  join departments using(department_id)
where salary > (
                    select min(salary)
                    from employees join departments using(department_id)
                                               join locations using(location_id)
                    where city = 'South San Francisco')
and salary > (
                    select avg(salary)
                    from employees
                    where department_id = 50);

-------------------------->ALL�� ��κ���ũ���̴ѱ� �ִ뺸��ũ�� 
select first_name, salary, department_name, department_id
from employees left outer join departments using(department_id)
where salary >ALL (  
                        (
                                            select min(salary)
                                            from employees join departments using(department_id)
                                                                       join locations using(location_id)
                                            where city = 'South San Francisco'),
                        
                        (
                                            select avg(salary)
                                            from employees
                                            where department_id = 50)
) ;

 

-- LAB5
-- 1��
-- ������ �̸��� ������ �̸��� ��ȸ�Ͻÿ�.(self join)
select ����.first_name, �Ŵ���.first_name
from employees ����, employees �Ŵ���
where ����.manager_id = �Ŵ���.employee_id ;

select ����.first_name, �Ŵ���.first_name
from employees ����  inner join employees �Ŵ��� on(����.manager_id = �Ŵ���.employee_id)
 




-- 2��
-- ������ �̸��� ������ �̸��� ��ȸ�Ͻÿ�.�����ڰ� ���� ���������� ��� ����Ͻÿ�.
select ����.employee_id, ����.first_name, �Ŵ���.employee_id, �Ŵ���.first_name
from employees ����, employees �Ŵ���
where ����.manager_id = �Ŵ���.employee_id(+);

select ����.first_name, �Ŵ���.first_name
from employees ����  left outer join employees �Ŵ��� on(����.manager_id = �Ŵ���.employee_id)
 


-- 3��
-- ������ �̸��� �����ڰ� �����ϴ� ������ ���� ��ȸ�Ͻÿ�. ��, ������������ 3�� �̻��� �����ڸ� ��µǵ��� �Ͻÿ�.


select  �Ŵ���.employee_id, �Ŵ���.first_name, count(����.first_name) 
from employees ����, employees �Ŵ���
where ����.manager_id = �Ŵ���.employee_id 
group by �Ŵ���.employee_id, �Ŵ���.first_name
having count(����.first_name) >= 3
order by 1;


select count(*)
from employees
where manager_id = 103 



select �Ŵ���.first_name, count(*)
from employees ����, employees �Ŵ���
where ����.manager_id = �Ŵ���.employee_id
group by �Ŵ���.first_name
having count(*) >=3;


-- LAB6
--  1��
-- �������� �̸�, �Ի���, �μ����� ��ȸ�Ͻÿ�. ��, �μ��� ���� ������ �ִٸ� �� ���������� ��°���� ���Խ�Ų��.
-- �׸��� �μ��� ���� ������ ���ؼ��� '<�μ�����>' �� ��µǵ��� �Ѵ�.(outer-join , nvl() )
select first_name, hire_date, 
nvl(department_name, '<�μ�����>') department_name,
nvl(to_char(department_id),'<�μ�����>') ,
nvl2(department_id, to_char(department_id),'<�μ�����>') 
from employees left join departments using(department_id);




-- 2��
-- ������ ��å�� ���� ������ �ٸ��� �����Ϸ��� �Ѵ�.��å�� 'Manager'�� ���Ե� ������ �޿��� 0.5�� ���ϰ�
-- ������ �����鿡 ���ؼ��� ������ �޿��� �����ϵ��� �Ѵ�. �����ϰ� ��ȸ�Ͻÿ�. (decode)
select first_name, job_id, salary, job_title,
decode(substr(job_title,-7,7), 'Manager', salary*0.5, salary) salary2,
case when job_title like '%Manager' then salary*0.5 else salary end salary3
from employees join jobs using(job_id);
--Nancy
create table empBackup_JIN
as
select * from employees;

select * from empBackup_JIN;


---SQL�� ��������,....
update empBackup_JIN
set salary =    salary*0.5               
where employee_id in ( select employee_id 
                                    from empBackup_JIN join jobs using(job_id)
                                    where substr(job_title,-7,7) = 'Manager'
                                    )
 
;

 





---100�� ���� 6900
--30  2500

-- 3��
-- �� �μ����� �����޿��� �޴� ������ �̸��� �μ�id, �޿��� ��ȸ�Ͻÿ�.
select first_name, department_id, salary
from employees
where (department_id, salary) in ( 
                                select department_id, min(salary)
                                from employees
                                group by department_id);

select * from employees where department_id=100 and salary = 6900


-- 4��
-- �� ���޺�(job_title) �ο����� ��ȸ�ϵ� ������ ���� ������ �ִٸ� �ش� ���޵� ��°���� ���Խ�Ű�ÿ�. 
-- �׸��� ���޺� �ο����� 3�� �̻��� ���޸� ��°���� ���Խ�Ű�ÿ�.
select job_title, count(employee_id)�ο���
from employees right outer join jobs using(job_id)
group by job_title
having count(*) >= 3;
 
 
-- 5��
-- �� �μ��� �ִ�޿��� �޴� ������ �̸�, �μ���, �޿��� ��ȸ�Ͻÿ�.
select first_name, department_name, salary
from employees join departments using(department_id)
where (department_id, salary) in ( 
                                select department_id, max(salary)
                                from employees
                                group by department_id);
--inline view
select first_name, department_name, salary 
from employees , departments  , ( 
                                select department_id, max(salary) maxsal
                                from employees
                                group by department_id) deptSalMax
where employees.department_id = departments.department_id
and employees.department_id = deptSalMax.department_id
and employees.salary = deptSalMax.maxsal



select count( distinct department_id)
from employees;



-- 6��  Scalar subquery , �����subquery 
-- ������ �̸�, �μ�id, �޿��� ��ȸ�Ͻÿ�. �׸��� ������ ���� �ش� �μ��� �ּұ޿��� �������� ���Խ��� ��� �Ͻÿ�.
select first_name, department_id, salary, (  select min(salary) 
                                                                            from employees
                                                                            where department_id = mainEmp.department_id
                                                                              )
from employees mainEmp;

--inline view (OK)...ciew�� ������ ���̺��̴�. 
select first_name, department_id, salary, sal 
from employees join (select department_id, min(salary) sal
                                from employees
                                group by department_id) deptminsal   using (department_id)


select department_id, min(salary) 
from employees
group by department_id



select min(salary) 
from employees
where department_id = ?


 
==========================================
	Inline View �� Top-N SubQuery
==========================================

1. �޿��� ���� ���� �޴� ���� 5���� ���� ������ ��ȸ�Ͻÿ�.
--pseudo Į��( ����Į���� �ƴѵ� Į���ΰ�ó�� �ൿ�ϴ� ��ü)

select rownum , aa.*
from (
            select  first_name, salary 
            from employees  
            order by salary desc   ) aa
where  rownum <= 5


select *
from(
 
                select rownum rr , aa.*
                from (
                            select  first_name, salary 
                            from employees  
                            order by salary desc   ) aa
 )
 where rr between 5 and 10 ;



--mysql  :
                 select rownum,  first_name, salary 
                    from employees  
                    order by salary desc limit 5;


2. Ŀ�̼��� ���� ���� �޴� ���� 3���� ���� ������ ��ȸ�Ͻÿ�.

select *
from (
            select   first_name, salary, commission_pct
            from employees
            order by commission_pct desc nulls last, salary desc ) 
where rownum = 3;

select   first_name, salary, commission_pct
                        from employees
where salary >=30000


select * 
from (
            select rownum rr, aa.*
            from (
                        select   first_name, salary, commission_pct
                        from employees
                        order by commission_pct desc nulls last, salary desc )  aa
        )
where rr = 3;

select *
from (
            select  rownum rr, aa.*
            from (
                            select    first_name, salary, commission_pct  --2
                             from employees  --1
                            order by commission_pct desc nulls last, salary desc  )aa )
where  rr=2;                           
 



select *
from (
             select   first_name, salary, commission_pct
             from employees
             order by commission_pct desc nulls last, salary desc)
 where rownum <=5
 

 select   first_name, salary, commission_pct
             from employees
where 1=0;


3. ���� �Ի��� ���� ��ȸ�ϵ�, �Ի��� ���� 5�� �̻��� ���� ����Ͻÿ�.

select  to_char(hire_date, 'mm') ��, count(*) "�Ի��� ��"
from employees 
group by to_char(hire_date, 'mm')
having count(*)>=5;


4. �⵵�� �Ի��� ���� ��ȸ�Ͻÿ�. 
��, �Ի��ڼ��� ���� �⵵���� ��µǵ��� �մϴ�.

select  to_char(hire_date, 'yyyy') yy, count(*) "�Ի��� ��"
from employees 
group by to_char(hire_date, 'yyyy')
order by 2 desc
 
select * from user_constraints
where table_name = 'TBL_ORDER';

select * from user_cons_columns where table_name = 'TBL_ORDER';


drop table tbl_test1;

create table tbl_test1(id number  constraint pk_tbl_test1_id    primary key,  
                                    name varchar2(20) not null,
                                    phone_number varchar2(13)  constraint u_phone  unique 
                                    );

insert into tbl_test1(id, name) values(1, 'aa');
insert into tbl_test1(id, name, phone_number) values(3, 'aa','010-4567-7896');


--�ֹ�(��, ��ǰ, ����, ����)
create table tbl_order ( �� number, ��ǰ number, order_date date, price number,                          
            constraint pk_order  primary key(��, ��ǰ) 
);
--primary key = not null +  unique
insert into tbl_order values(1, 100, sysdate, 1000);


select * from departments;
select * from employees;
select * from user_constraints where table_name = 'DEPARTMENTS';
select * from user_constraints where table_name = 'EMPLOYEES';
select * from user_cons_columns where table_name = 'EMPLOYEES';

--parent key not found�̱⶧���� ���� 
update employees
set department_id = 1;

alter trigger UPDATE_JOB_HISTORY disable;

drop table tbl_parent;
create table tbl_parent (deptid number primary key , deptname varchar2(20));

drop table tbl_child;
create table tbl_child(empid number primary key, empname varchar2(20) not null, 
                 deptid number  constraints   tbl_child_deptid_FK  REFERENCES tbl_parent(deptid) on delete cascade,
                 salary number constraint tbl_child_salary_check check ( salary between 1000 and 2000  ),
                 gender char(1) constraint tbl_child_gender_check check (gender in ('M','F')   ),
                 phone_number char(13) unique ,
                 ���� varchar2(30) default '�ѱ�' 
 );
insert into tbl_child(empid, empname,deptid, salary, gender,phone_number  ) values( 1, 'aa', 10, null, null, null );
insert into tbl_child values( 2, 'bb', 10, 1500, 'M', '12345' );
insert into tbl_child values( 3, 'bb', 10, 1500, 'M', '12345' );
   
select * from tbl_child;
 
 insert into tbl_parent(deptid, deptname) values (10, '���ߺ�');
 insert into tbl_parent(deptid, deptname) values (20, '������');
 insert into tbl_parent(deptid, deptname) values (30, '�ѹ���');
 
insert into tbl_child(empid, empname, deptid) values(1,'aa',10);
insert into tbl_child values(2,'bb',20);
insert into tbl_child(empid, deptid, empname) values(3,30,'cc' );
insert into tbl_child(empid,  empname) values(4,'cc' );

select * from tbl_child;


--subquery�� �̿��ؼ� table����, notnull�� ���� 

create table tbl_emp_backup
as
select * from employees
where department_id = 60;

select * from tbl_emp_backup;

select * from user_constraints where table_name = 'TBL_EMP_BACKUP';

update tbl_emp_backup
set department_id = 100;

rollback;

--���������߰� 
alter TABLE tbl_emp_backup 
drop  constraints  tbl_emp_backup_PK;

alter TABLE tbl_emp_backup 
add constraint  tbl_emp_backup_PK  PRIMARY KEY(employee_id);
 
 
ALTER TABLE tbl_emp_backup
ADD CONSTRAINT tbl_emp_backup_FK 
FOREIGN KEY(department_id) REFERENCES departments(department_id);

--------------------
desc employees;

create or replace view empView1
as
select employee_id, first_name, last_name, EMAIL, HIRE_DATE, JOB_ID, department_id
from employees
where department_id = 60 ; --with check option;

select * from user_views;
desc empView1;

select * from empView1;

update empView1
set department_id = 100;

rollback;


select empView1.*, jobs.job_title
from empView1 join  jobs on(empView1.job_id = jobs.job_id);

update empView1
set email = 'wed0406@daum.net'
where employee_id = 103;
commit;

select * from employees where employee_id = 103;

--force:�����ǻ���, noforce(default) :üũ�ؼ� ���������� ���� 

create or replace  force   view view_join4
as
select first_name, department_name, city , country_name 
from employees join departments using (department_id)
                           join locations using (location_id)
                           join countries using (country_id) ;
 

select * from view_join4;


create sequence seq_board;

create table tbl_board ( bno number primary key, 
                                        title varchar2(50) not null, 
                                        contents varchar2(2000) , 
                                        writer varchar2(30) not null);

insert into tbl_board (bno, title,contents,  writer) values(seq_board.nextval, '�����', 'SQL����', 'pp');
select * from tbl_board
where title = '������'
;

create index idx_tbl_board_title
on  tbl_board(title  );



select 2000/3 from dual;

show recyclebin; 
purge recyclebin; 

select * 
from user_ind_columns
where table_name = 'EMPLOYEES';

--�����ȹ 

select *
from employees
where first_name = initCap('steven') and last_name = initCap('king');




