--1.직원들의 이름과 직급명(job_title)을 조회하시오.
--107건...즉, job_id는 null인 데이터가 없다. 
select count(*) from employees;
select count(job_id) from employees;


select e.first_name,  j.job_title
from employees e, jobs j
where e.job_id = j.job_id;



select e.first_name || ' ' || e.last_name as 이름, j.job_title as 직급명
from employees e join jobs j
using (job_id);



--2.부서이름과 부서가 속한 도시명(city)을 조회하시오.

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




--3. 직원의 이름과 근무국가명을 조회하시오. (employees, departments, locations,countries)
select e.first_name || ' ' || e.last_name as 이름, c.country_name as 근무국가명
from employees e
join departments d using (department_id)
join locations l using (location_id)
join countries c using (country_id);

select count(*) from employees;
select count(department_id) from employees;



--4. 직책(job_title)이 'manager' 인 사람의 이름, 직책, 부서명을 조회하시오.
select e.first_name || ' ' || e.last_name as 이름, j.job_title as 직책, d.department_name as 부서명
from employees e
join jobs j using(job_id) 
join departments d using(department_id)
--where j.job_title Like '%'|| initCap('manager') || '%';
where j.job_title Like initCap('%manager%');


select department_id,avg(salary)
from employees
group by department_id;



select e.first_name || ' ' || e.last_name as 이름, j.job_title as 직책, d.department_name as 부서명
from employees e
join jobs j using(job_id) 
join departments d using(department_id)
where substr( j.job_title  , -7) = initCap('manager');


select * from jobs;




--5. 직원들의 이름, 입사일, 부서명을 조회하시오.
select  e.first_name || ' ' || e.last_name as 이름, e.hire_date as 입사일, department_name as 부서명
from employees e
join departments d using(department_id);





--6. 직원들의 이름, 입사일, 부서명을 조회하시오.
--단, 부서가 없는 직원이 있다면 그 직원정보도 출력결과에 포함시킨다.
select e.first_name || ' ' || e.last_name as 이름, e.hire_date as 입사일, department_name as 부서명
from employees e left outer join departments d using(department_id);

select e.first_name || ' ' || e.last_name as 이름, e.hire_date as 입사일, department_name as 부서명
from departments d  right outer join employees e using(department_id);




--7. 직원의 이름과 직책(job_title)을 출력하시오.
--단, 사용되지 않는 직책이 있다면 그 직책정보도 출력결과에 포함시키시오.
select e.first_name || ' ' || e.last_name as 이름, j.job_title as 직책
from employees e right join jobs j using(job_id);

--직원table에서 사용한 job의 갯수
select  count(distinct job_id) from employees;

select count(*) from jobs;

desc jobs;

insert into jobs values('play','매일매일play', 1000, 20000);
commit;

select * from jobs;


--Non equi join (=이외의 연산자를 이용해서 조인)
create table salgrade( grade char(1) primary key, minsal number, maxsal number);

insert into salgrade values('A', 0, 5000);
insert into salgrade values('B', 5001, 15000);
insert into salgrade values('C', 15001, 20000);
insert into salgrade values('D', 20001, 30000);
commit;

select * from salgrade;

---직원이름과 급여와 급여의 등급출력
select e.first_name, e.salary, s.grade
from employees e,  salgrade s
where e.salary between s.minsal and s.maxsal 


select first_name, salary, grade
from employees join salgrade on (salary between minsal and maxsal );

--건수 : 106
select 직원.employee_id, 직원.first_name, 메니져.employee_id , 메니져.first_name 
from employees 직원,  employees 메니져 
where 직원.manager_id = 메니져.employee_id(+)   --Oracle문법 outer join
order by 1;

select 직원.employee_id, 직원.first_name, 메니져.employee_id , 메니져.first_name
from employees 직원 join employees 메니져 on (직원.manager_id = 메니져.employee_id)

select 직원.employee_id, 직원.first_name, 메니져.employee_id , 메니져.first_name
from employees 직원 left outer  join employees 메니져 on (직원.manager_id = 메니져.employee_id);

--매니저가 KING인 사원들의 이름과 직급을 출력하시오.


select  직원.employee_id, 직원.first_name, 직원.last_name , job_title
from  employees 직원, employees 메니져, jobs 
where 직원.manager_id = 메니져.employee_id 
and 직원.job_id = jobs.job_id 
and 메니져.last_name = 'King';


--'King'의 직원id알아내기 
--subquery 
select employee_id,  first_name, last_name
from employees
where manager_id = (select  employee_id from employees
                                    where first_name = 'Steven' and  last_name = 'King');


--Steven King과 동일한 부서에서 근무하는 사원의 이름을 출력하시오.
--1.Steven King 부서
--2.직원의 근무지 


--self join
select  직원.employee_id, 직원.first_name, 직원.last_name , 직원.department_id
from  employees 직원, employees m 
where 직원.department_id = m.department_id 
and m.first_name = 'Steven' and m.last_name = 'King';

--subquery 
select *
from employees
where department_id = (select department_id from employees
                                        where first_name = 'Steven' and  last_name = 'King');

 

--부서와 직원
desc departments;
desc employees;

--부서정보출력, manager_id는 부서장을 의미, 부서장은 직원중에 1인이다. (부서장이름, 급여, 입사일)
--부서장이 없는 부서도 출력결과에 포함한다. 
select  departments.*, employees.first_name, employees.salary, employees.hire_date
from departments, employees
where departments.manager_id = employees.employee_id(+)

select  departments.*, employees.first_name, employees.salary, employees.hire_date
from departments left outer join employees on (departments.manager_id = employees.employee_id)


select  first_name, salary, department_name 
from employees full outer  join departments using (department_id) 

--Neena와 동일한 직급을 가진 사원을 출력하는 SQL 문을 작성해 보시오. 
--subquery에서 subquery의 결과가 단일행인지 다중행인지 주의...단일행연산자(=,>,<),  다중행연산자(in, =ANY)
select * 
from employees
where job_id  =ANY   (         
            select job_id
            from employees
            where first_name = 'Alexander' )  ; --IT_PROG, PU_CLERK
            


--SCOTT의 급여와 동일하거나 더 많이 받는 사원 명과 급여를 출력하시오.
--subquery결과가 1건이면 단일행 연산자를 사용: = > ,>=, < , <=
--subquery결과가 1건이상 다중행 연산자를 사용:in, >=ALL, >ALL, >=ANY >ANY 
select *
from employees
where salary >=ALL (
        select salary
        from employees
        where first_name = 'Alexander')  --9000, 3100


--Seattle에서 근무하는 사원의 이름, 부서 번호를 출력하시오. (18명)

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


--IT 부서에서 근무하는 모든 사원의 이름과 급여를 출력하시오

select first_name, salary, department_id
from employees
where department_id = (
                    SELECT department_id 
                     FROM DEPARTMENTS
                    where department_name = 'IT')

--직속상관이 KING인 사원의 이름과 급여를 출력하시오. 

select *
from employees
where manager_id =ANY(
            select employee_id
            from employees
            where last_name = 'King' ) --and  first_name = 'Steven'  )



--평균 급여보다 더 많은 급여를 받는 사원을 검색하는 문장은 다음과 같습니다. 

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


--부서별로 가장 급여를 많이 받는 사원의 정보(사원 번호, 사원이름, 급여, 부서번호)를 출력하시오.(IN 연산자 이용)

--다중칼럼 SUBQUERY 
SELECT *
FROM EMPLOYEES
WHERE (department_id, salary     ) IN (
                SELECT DEPARTMENT_ID, MAX(SALARY)
                FROM EMPLOYEES
                GROUP BY DEPARTMENT_ID)


select count(distinct DEPARTMENT_ID)
from EMPLOYEES;



--직급(JOB)이 MANAGER인 사람의 속한 부서의 부서 번호와 부서명과 지역을 출력하시오.

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
--사이즈를 늘리는것을 가능 , 이미 데이터가 있을때 사이즈줄이는 것은 불가 
alter table tbl_emp4 modify (first_name varchar2(30)) ;
--데이터가 있어도 지워진다. 
alter table tbl_emp4 drop  column first_name ;


insert into tbl_emp4 values(1, '12345678901234567890','ABC');

drop table tbl_emp4;


desc tbl_employee;
select * from tbl_emp;
truncate table  tbl_emp; --복구불가 

select * from tbl_emp;
delete from tbl_emp;--원상복구가능 
rollback;  --원상복구가능 

rename tbl_emp to tbl_employee;

--딕셔너리뷰

select *
from user_tables;

select *
from all_tables;


select *
from dba_tables;

--char : 고정길이
--varchar2 : 가변길이 
create table tbl_jin(id number, name1 char(10), name2 varchar2(10));
--name1에는 '123       '
--name2에는 '123'
insert into tbl_jin values(1, '123','123');

---제약조건은 복사안됨 , notnull은 복사됨 
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

--칼럼의 값을 넣지않으면 암시적으로 null이다. 
--명시적으로 null값을 부여가능 
insert into tbl_emptest(employee_id,first_name, hire_date ) values(4,null, sysdate);
insert into tbl_emptest(employee_id,first_name, hire_date ) values(5,'', sysdate); --''는 null


--table의 구조만들기 
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

--transaction처리를 하는 명령어 (transaction : 하나의 논리적인 작업)
rollback; --D작업을 끝내고 DB반영안한다. 
commit; --D작업을 끝내고 DB에 반영한다. 


부서가 90번이 직원들을 
Diana직원과 같은 부서, 같은 salary로 변경한다, 

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

 
--EMP02에 있는 1건 수정하기 
select * from emp02;
select * from emp01;

update emp02 set  job='aa' , SAL = 9999, comm = 0.1, deptno=88
where empno=103;

--EMP02에 신규를 삽입하기 
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
                   
--subquery 내일 추가함                   
                   