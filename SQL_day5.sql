--복습1(  자신의 속한 부서의 평균 급여보다 더 적은 급여를 받는 직원들을 조회하시오)
--1) subquery 
select *
from employees outeremp
where salary  <   (   
                        select avg(salary)
                        from employees
                        where department_id = outeremp.department_id

        );
        
--2) inlineview (from절)
select *
from employees, 
                                 (select department_id, avg(salary) sal
                                from employees
                                group by  department_id )  inlineview_emp
where employees.department_id = inlineview_emp.department_id
and employees.salary < inlineview_emp.sal;



--JDBC로 작성해보기 
create sequence seq_employee start with 300;

insert into employees(EMPLOYEE_ID ,LAST_NAME, EMAIL, HIRE_DATE, JOB_ID) 
values(seq_employee.nextval, 'aa', 'bb', sysdate,  'IT_PROG');
rollback;


update employees
set EMAIL = ?, DEPARTMENT_ID =?, JOB_ID=?, SALARY=?
where EMPLOYEE_ID = ?;


alter trigger update_job_history enable;

delete from job_history;
commit;


update employees set hire_date = '2000/01/01'
where   employee_id = 302;


select * 
from user_constraints
where table_name = 'EMPLOYEES';


select * 
from user_constraints
where table_name = 'DEPARTMENTS';


delete from departments where department_id = 60;


delete from employees where employee_id = 304;

rollback;



select * from employees;
desc employees



select * from employees;

rollback;



select * from USER_TAB_PRIVS_MADE ;
select * from USER_TAB_PRIVS_RECD ;


--복습2( 복합키를 가진 table을 FK로 설정하기)
drop table tbl_parent   cascade constraints ;
drop table tbl_child   cascade constraints ;

create table tbl_parent( pid1 number, pid2 number, pname varchar2(30),
              constraint pk_tbl_parent primary key( pid1, pid2 )   
)
insert into tbl_parent values(1,1,'aa');
insert into tbl_parent values(1,2,'bb');
delete from tbl_parent where pid1=1 and pid2=1;

create table tbl_child(ch_id number primary key, ch_name varchar2(20),
             pid1 number, pid2 number,
             constraint fk_parent foreign key(pid1, pid2 ) references tbl_parent(pid1, pid2) on DELETE CASCADE
 )
insert into tbl_child values(100, 'AA', 1,1);
 select * from tbl_child;
 commit;

--
select column_name from  COLS where TABLE_NAME   = 'EMPLOYEES';










 