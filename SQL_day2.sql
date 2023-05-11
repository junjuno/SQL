--일자연습
select sysdate, hire_date , 
     floor((sysdate- hire_date)/365) 년도1,    
     floor(months_between(  sysdate, hire_date)/12) 년도2 ,
     add_months(hire_date, 1) "10개월후",
     last_day(hire_date) 마지막일 ,
     next_day(hire_date, '수요일') 처음오늘요일 ,
     round(hire_date, 'month') "반올림1-16이상",
     trunc(hire_date, 'month') "버림1-월까지만본다",
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

--nls_date_format설정을 바꿀수있다.  alter session set nls_date_format='';
--rr/mm/dd  rrmmdd   rr은 50이상이면 19, 미만이면 20 
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
        salary + salary * nvl(commission_pct,0) 실수령액 ,
         salary + salary * nvl2(commission_pct, commission_pct, 0) 실수령액2 ,
         nvl2(commission_pct, '커미션있음', '커미션없음') "nvl2연습"
from EMPLOYEES
order by commission_pct ; -- nulls first


--ㅡmanager_id가 null이면 사장이다. 
select  first_name, manager_id, nvl(to_char(manager_id), 'CEO'),
      nvl2(manager_id,to_char(manager_id), 'CEO'), 
      department_id,
      nvl(to_char(department_id),'부서없음') "nvl연습",
      decode(department_id,10,'A',60,'B',90,'C','D') 부서decode,
      salary, case when salary>=10000 then '매우많음'
                           when salary>=7000 then '많음'
                            when salary>=5000 then '기본'
                            else '적음'
                           end "case연습", 
            case when first_name like 'A%' then 'A로시작' else '아님' end "case연습2"  ,
            case when first_name like '%a' then 'A로끝' else '아님' end "case연습2" 
      
from EMPLOYEES;


desc EMPLOYEES;


--
1. 이름이 'adam' 인 직원의 급여와 입사일을 조회하시오.
select first_name, salary, hire_date
from employees
where first_name =initCap('adam');


2. 나라 명이 'united states of america' 인 나라의 국가 코드를 조회하시오.
select *
from countries
where lower(country_name)='united states of america';


where country_id = initCap('united states of america');

select country_id from countries WHERE country_name LIKE 'United% S%';


3. 'Adam의 입사일은 95/11/02 이고, 급여는 7000 입니다.' 이런 식으로 직원정보를 조회하시오.
select first_name||'의 입사일은'|| hire_date||'이고, 급여는'|| salary||'입니다.'
from employees





4. 이름이 5글자 이하인 직원들의 이름, 급여, 입사일을 조회하시오.
select first_name, salary, hire_date
from employees
where length(first_name)<=5;

5.2006년도에 입사한 직원의 이름, 입사일을 조회하시오.
select first_name, hire_date
from employees
where to_char(hire_date,'yyyy')='2006';

6. 7년 이상 장기 근속한 직원들의 이름, 입사일, 급여, 근무년차를 조회하시오.
select first_name, hire_date, salary, trunc(months_between(sysdate,hire_date)/12)
from employees
where trunc(months_between(sysdate,hire_date)/12) >= 7;



select first_name 이름, hire_date 입사일, salary 급여, substr(sysdate,1,2)-substr(hire_date,1,2) 근무년차
from employees
where (substr(sysdate,1,2)-substr(hire_date,1,2)) >= 7;


select first_name, hire_date, salary, to_char(sysdate, 'yyyy') - to_char(hire_date, 'yyyy') 근무년차
from employees
where  to_char(sysdate, 'yyyy') - to_char(hire_date, 'yyyy') >= 7;


select first_name, salary, hire_date,
EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM hire_date) 근무년차 
from employees 
WHERE EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM hire_date) >= 7;



----------Group
--집계함수(칼럼이름) : 값이 null은 무시한다. 
--집계함수(*) : null이포함 
--group by절이 없으면 전체에 대한 집계이다. 
select sum(salary), sum(commission_pct), avg(salary), count(salary), sum(salary)/count(salary),
          count(salary), count(*) 전체건수 ,count(commission_pct), count(manager_id)  
from employees 

--가장 최근에 입사한 사원의 입사일과 입사한지 가장 오래된 사원의 입사일을 출력하는 쿼리문을 작성하시오. 
select max(hire_date) "가장 최근에 입사"
          , min(hire_date) "가장 오래된 사원" 
from employees 

--80번 부서 소속 사원중에서 커미션을 받는 사원의 수를 구해보시오.

select  count( commission_pct), count( *)
from employees 
where department_id =80
--and commission_pct is not null;


select  count( distinct job_id)  , count(  job_id)  , count(department_id) , count(distinct department_id)
from employees;

select  distinct department_id
from employees
where department_id is not null;

--집계함수를 사용하지않은 칼럼이 select에 있다면 반드시 group by절에 참여해야한다. 
--부서별 salary평균
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





=============Group 함수==================
7. 각 부서별 인원수를 조회하되 인원수가 5명 이상인 부서만 출력되도록 하시오.
select  department_id, count(*)
from employees
group by department_id
having count(*) >= 5;


8. 각 부서별 최대급여와 최소급여를 조회하시오.
   단, 최대급여와 최소급여가 같은 부서는 직원이 한명일 가능성이 높기때문에 
   조회결과에서 제외시킨다.
select department_id,  max(salary), min(salary)
from employees
group by department_id
having max(salary)<> min(salary)
--having count(*) > 1;

   
9. 부서가 50, 80, 110 번인 직원들 중에서 급여를 5000 이상 24000 이하를 받는
   직원들을 대상으로 부서별 평균 급여를 조회하시오.
   다, 평균급여가 8000 이상인 부서만 출력되어야 하며, 출력결과를 평균급여가 높은
   부서면저 출력되도록 해야 한다.


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


--100번직원의 근무하는 부서이름을 알고싶다.
--직원이 부서를 참조한다. (건수는 직원건수만큼 나온다. ) 

--DB Vendor문법
select  employee_id,    first_name, department_name , departments.department_id
from employees, departments
where employees.department_id = departments.department_id 
order by 1;
---------------------------ANSI표준문법 
--join하고자하는 칼럼이 일치하는 경우 사용 
select  employee_id,    first_name, department_name , department_id
from employees join departments using(department_id);
 
--join하고자하는 칼럼이 일치하지 않는 경우 사용 
select  employee_id,    first_name, department_name , departments.department_id
from employees join departments on(employees.department_id = departments.department_id );

select  employee_id,    first_name, department_name , departments.department_id
from employees left outer  join departments on(employees.department_id = departments.department_id );

select  employee_id,    first_name, department_name , departments.department_id
from employees full outer  join departments on(employees.department_id = departments.department_id );

--직원이 어떤 직급인지 자세히 알고자한다. job_title, max_salry, min_salary 

desc employees;
desc jobs;
--PK(primary key) : NULL불가 + UNIQUE 
--FK(Foreign key) : 참조키 , 다른테이블 혹은 자신의 table의 pk를 참조한다. 


select employees.first_name, employees.salary, jobs.*
from employees, jobs
where employees.JOB_ID = jobs.JOB_ID;


select employees.first_name, employees.salary, job_id, job_title, max_salary, min_salary 
from employees join jobs using(JOB_ID)

select employees.first_name, employees.salary, jobs.* 
from employees join jobs on(employees.JOB_ID = jobs.JOB_ID)





select 107*27 from dual;
--employees: 107건 
--departments : 27건 

select *
from employees
where employee_id = 100 

select *
from departments
where department_id = 90;











 










