-- LAB4
-- 1번
-- 'IT'부서에서 근무하는 직원들의 이름, 급여, 입사일을 조회하시오.
select first_name, salary, hire_date, department_id
from employees
where department_id = (
                        select department_id
                        from departments
                        where department_name = 'IT');

select e.first_name, e.salary, e.hire_date, department_id
from employees e join departments using(department_id)
where department_name = 'IT';

 
-- 2번
-- 'Alexander' 와 같은 부서에서 근무하는 직원의 이름과 부서id를 조회하시오.
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

-- 3번
-- 80번부서의 평균급여보다 많은 급여를 받는 직원의 이름, 부서id, 급여를 조회하시오., 
select first_name, department_id, salary
from employees
where salary > (
                            select avg(salary)
                            from employees
                            where department_id = 80);
                            
                            
-- 80번부서의 평균급여보다 많은 급여를 받는 직원의 이름, 부서id, 급여를 조회하시오., 
-- 80번부서의 평균급여도 출력결과 포함시킨다. (스칼라 subquery ) 
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




-- 4번
-- 'South San Francisco'에 근무하는 직원의 최소급여보다 급여를 많이 받으면서 
-- 50 번부서의 평균급여보다 많은 급여를 받는 직원의 이름, 급여, 부서명, 부서id를 조회하시오.(70건)
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

-------------------------->ALL은 모두보다크다이닌까 최대보다크다 
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
-- 1번
-- 직원의 이름과 관리자 이름을 조회하시오.(self join)
select 직원.first_name, 매니저.first_name
from employees 직원, employees 매니저
where 직원.manager_id = 매니저.employee_id ;

select 직원.first_name, 매니저.first_name
from employees 직원  inner join employees 매니저 on(직원.manager_id = 매니저.employee_id)
 




-- 2번
-- 직원의 이름과 관리자 이름을 조회하시오.관리자가 없는 직원정보도 모두 출력하시오.
select 직원.employee_id, 직원.first_name, 매니저.employee_id, 매니저.first_name
from employees 직원, employees 매니저
where 직원.manager_id = 매니저.employee_id(+);

select 직원.first_name, 매니저.first_name
from employees 직원  left outer join employees 매니저 on(직원.manager_id = 매니저.employee_id)
 


-- 3번
-- 관리자 이름과 관리자가 관리하는 직원의 수를 조회하시오. 단, 관리직원수가 3명 이상인 관리자만 출력되도록 하시오.


select  매니저.employee_id, 매니저.first_name, count(직원.first_name) 
from employees 직원, employees 매니저
where 직원.manager_id = 매니저.employee_id 
group by 매니저.employee_id, 매니저.first_name
having count(직원.first_name) >= 3
order by 1;


select count(*)
from employees
where manager_id = 103 



select 매니저.first_name, count(*)
from employees 직원, employees 매니저
where 직원.manager_id = 매니저.employee_id
group by 매니저.first_name
having count(*) >=3;


-- LAB6
--  1번
-- 직원들의 이름, 입사일, 부서명을 조회하시오. 단, 부서가 없는 직원이 있다면 그 직원정보도 출력결과에 포함시킨다.
-- 그리고 부서가 없는 직원에 대해서는 '<부서없음>' 이 출력되도록 한다.(outer-join , nvl() )
select first_name, hire_date, 
nvl(department_name, '<부서없음>') department_name,
nvl(to_char(department_id),'<부서없음>') ,
nvl2(department_id, to_char(department_id),'<부서없음>') 
from employees left join departments using(department_id);




-- 2번
-- 직원의 직책에 따라 월급을 다르게 지급하려고 한다.직책에 'Manager'가 포함된 직원은 급여에 0.5를 곱하고
-- 나머지 직원들에 대해서는 원래의 급여를 지급하도록 한다. 적절하게 조회하시오. (decode)
select first_name, job_id, salary, job_title,
decode(substr(job_title,-7,7), 'Manager', salary*0.5, salary) salary2,
case when job_title like '%Manager' then salary*0.5 else salary end salary3
from employees join jobs using(job_id);
--Nancy
create table empBackup_JIN
as
select * from employees;

select * from empBackup_JIN;


---SQL을 비절차적,....
update empBackup_JIN
set salary =    salary*0.5               
where employee_id in ( select employee_id 
                                    from empBackup_JIN join jobs using(job_id)
                                    where substr(job_title,-7,7) = 'Manager'
                                    )
 
;

 





---100번 최저 6900
--30  2500

-- 3번
-- 각 부서별로 최저급여를 받는 직원의 이름과 부서id, 급여를 조회하시오.
select first_name, department_id, salary
from employees
where (department_id, salary) in ( 
                                select department_id, min(salary)
                                from employees
                                group by department_id);

select * from employees where department_id=100 and salary = 6900


-- 4번
-- 각 직급별(job_title) 인원수를 조회하되 사용되지 않은 직급이 있다면 해당 직급도 출력결과에 포함시키시오. 
-- 그리고 직급별 인원수가 3명 이상인 직급만 출력결과에 포함시키시오.
select job_title, count(employee_id)인원수
from employees right outer join jobs using(job_id)
group by job_title
having count(*) >= 3;
 
 
-- 5번
-- 각 부서별 최대급여를 받는 직원의 이름, 부서명, 급여를 조회하시오.
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



-- 6번  Scalar subquery , 상관형subquery 
-- 직원의 이름, 부서id, 급여를 조회하시오. 그리고 직원이 속한 해당 부서의 최소급여를 마지막에 포함시켜 출력 하시오.
select first_name, department_id, salary, (  select min(salary) 
                                                                            from employees
                                                                            where department_id = mainEmp.department_id
                                                                              )
from employees mainEmp;

--inline view (OK)...ciew가 가상의 테이블이다. 
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
	Inline View 와 Top-N SubQuery
==========================================

1. 급여를 가장 많이 받는 상위 5명의 직원 정보를 조회하시오.
--pseudo 칼럼( 실제칼럼은 아닌데 칼럼인것처럼 행동하는 객체)

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


2. 커미션을 가장 많이 받는 상위 3명의 직원 정보를 조회하시오.

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


3. 월별 입사자 수를 조회하되, 입사자 수가 5명 이상인 월만 출력하시오.

select  to_char(hire_date, 'mm') 월, count(*) "입사자 수"
from employees 
group by to_char(hire_date, 'mm')
having count(*)>=5;


4. 년도별 입사자 수를 조회하시오. 
단, 입사자수가 많은 년도부터 출력되도록 합니다.

select  to_char(hire_date, 'yyyy') yy, count(*) "입사자 수"
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


--주문(고객, 상품, 일자, 가격)
create table tbl_order ( 고객 number, 상품 number, order_date date, price number,                          
            constraint pk_order  primary key(고객, 상품) 
);
--primary key = not null +  unique
insert into tbl_order values(1, 100, sysdate, 1000);


select * from departments;
select * from employees;
select * from user_constraints where table_name = 'DEPARTMENTS';
select * from user_constraints where table_name = 'EMPLOYEES';
select * from user_cons_columns where table_name = 'EMPLOYEES';

--parent key not found이기때문에 실패 
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
                 국적 varchar2(30) default '한국' 
 );
insert into tbl_child(empid, empname,deptid, salary, gender,phone_number  ) values( 1, 'aa', 10, null, null, null );
insert into tbl_child values( 2, 'bb', 10, 1500, 'M', '12345' );
insert into tbl_child values( 3, 'bb', 10, 1500, 'M', '12345' );
   
select * from tbl_child;
 
 insert into tbl_parent(deptid, deptname) values (10, '개발부');
 insert into tbl_parent(deptid, deptname) values (20, '영업부');
 insert into tbl_parent(deptid, deptname) values (30, '총무부');
 
insert into tbl_child(empid, empname, deptid) values(1,'aa',10);
insert into tbl_child values(2,'bb',20);
insert into tbl_child(empid, deptid, empname) values(3,30,'cc' );
insert into tbl_child(empid,  empname) values(4,'cc' );

select * from tbl_child;


--subquery를 이용해서 table생성, notnull만 복사 

create table tbl_emp_backup
as
select * from employees
where department_id = 60;

select * from tbl_emp_backup;

select * from user_constraints where table_name = 'TBL_EMP_BACKUP';

update tbl_emp_backup
set department_id = 100;

rollback;

--제약조건추가 
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

--force:무조건생성, noforce(default) :체크해서 문제없으면 생성 

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

insert into tbl_board (bno, title,contents,  writer) values(seq_board.nextval, '목요일', 'SQL배우기', 'pp');
select * from tbl_board
where title = '수요일'
;

create index idx_tbl_board_title
on  tbl_board(title  );



select 2000/3 from dual;

show recyclebin; 
purge recyclebin; 

select * 
from user_ind_columns
where table_name = 'EMPLOYEES';

--실행계획 

select *
from employees
where first_name = initCap('steven') and last_name = initCap('king');




