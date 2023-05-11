--SQL문은 대소문자구별 없음 
--여러문장으로 작성가능 
--문장끝은 ; 
--select *  *는 모든칼럼을 의미 
--invalid identifier : 식별자오류 (식별자-->칼럼이름, table이름)
-- 문자값은 반드시 ''를 써야한다. 
-- "table or view does not exist"
--Oracle은 데이터사전이있다...데이터사전에 테이블이름을 대문자로 저장해놓는다. 
--값은 대소문자 구별한다. 

desc employees;
select * from tab;
select * from employees;

select EMPLOYEE_ID, FIRST_name, 1+2 , 'SQL배우기'
from "EMPLOYEES";

select DISTINCT DEPARTMENT_ID
from EMPLOYEES ;

--값이없다 : null
--null값을 계산하면  null
--null을 대체할 필요가 있다. nvl(비교값, 대체값)
--특수문자가 포함된 식별자이름은 ""으로 감싼다. 
--별칭을 쓸때 as는 생략가능하다. 
--연결연산자는 +가 아니다. Oracle은 ||이다. oracle, mysql은 concat()함수이용 

select employee_id 직원번호 , first_name||' '||last_name as 이름, 
        concat(concat(first_name,' '), last_name) 이름2,
        salary, commission_pct, 
       salary+ salary*nvl(commission_pct,0) "커미션 적용급여",        --해석2
       hire_date
from employees;  --해석1

--distinct은 나열칼럼들의 같은값이 있으면 배제된다. 
select distinct department_id, job_id
from employees ;

--조건절

select employee_id , first_name, last_name, salary 급여 --해석3
from employees /*--해석1*/
where salary >= 10000  --해석2
order by 4 desc;--해석4

--order by 칼럼이름 또는 별명 또는 select순서(SQL은 순서가 1부터시작) 
--order by salary desc;
--order by 급여 desc; --해석4
 


-----------------------------------------------
select 칼럼이름들--3
from table이름들 --1
where 조건절 --2
order by 칼럼들; --4

--년도를 2자리 
--99
--00 (1900? 2000?) Y2K
--1955  1980   2022  1951  2040


select * from v$nls_parameters;


-->RR형식 : >50면 1900년대 <50 2000년대  
select employee_id, first_name, salary
, to_char(hire_date,'yyyy/mm/dd hh:mi:ss') 입사일
,department_id   --3
from employees --1
where salary>=10000 --2
and department_id = 80
and first_name = 'Lisa'
order by hire_date asc, salary desc; --4


--DUAL table은 Oracle에서 제공하는 dummy table
desc DUAL;
select * from dual;

select  1+2, sysdate ,  floor(10.9) 무조건버림, ceil(10.1) 무조건올림,
       round(35.678) 정수로반올림, round(35.678,1) 반올림2, round(35.678,-1) 반올림3
from dual;

--사번이 홀수인 직원조회
select *
from EMPLOYEES 
where mod(EMPLOYEE_ID,2)=1

select first_name, upper(first_name), lower(first_name), initCap(email), length(first_name),
  length('한글'), lengthB('한글')
from EMPLOYEES ;

--first_name가 david를 검색한다. 
--1

--만약에 first_name칼럼으로 색인(index)가 구성되어있었다면 함수를 이용했을때 index는 깨진다.(index사용불가)
select *
from employees
where first_name = 'david';


select *
from employees
where lower(first_name) = 'david';

select * 
from employees 
where first_name=initCap('DAVID');

select * 
from employees 
where upper(first_name)=upper('david');
-----------------------------------

hr/hr
========================================
		SELECT 기본
========================================

1. 급여가 15000 이상인 직원들의 이름, 급여, 부서id를 조회하시오.

select FIRST_NAME, SALARY, DEPARTMENT_ID
from employees 
where SALARY>=15000;


2. 직원 중에서 연봉이 170000 이상인 직원들의 이름, 연봉을 조회하시오.
   연봉은 급여(salary)에 12를 곱한 값입니다.

select FIRST_NAME, SALARY * 12 aa
from employees 
where SALARY * 12 >=170000;

--null은 값이없다. 이므로 =연산자로 비교불가 
3. 직원 중에서 부서id가 없는 직원의 이름과 급여를 조회하시오.
select FIRST_NAME, SALARY , DEPARTMENT_ID 
from employees 
where DEPARTMENT_ID is null;      



4. 2004년 이전에 입사한 직원의 이름, 급여, 입사일을 조회하시오.
select FIRST_NAME, SALARY , hire_date
from employees 
where hire_date <= '2004/12/31';    --자동형변환제공 

select FIRST_NAME, SALARY , hire_date
from employees 
where to_char(hire_date,'yyyy') <= '2004'; 


-- 논리연산자  not / and / or   -- 
1. 80, 50 번 부서에 속해있으면서 급여가 13000 이상인 직원의 이름, 급여, 부서id
를 조회하시오.
select FIRST_NAME, SALARY , DEPARTMENT_ID
from employees 
where (DEPARTMENT_ID=80 or DEPARTMENT_ID=50) and SALARY >=13000 

select FIRST_NAME, SALARY , DEPARTMENT_ID
from employees 
where DEPARTMENT_ID in (50, 80) and SALARY >=13000 



2. 2005년 이후에 입사한 직원들 중에서 급여가 1300 이상 20000 이하인 직원들의 
이름, 급여, 부서id, 입사일을 조회하시오.

select employee_id, FIRST_NAME, SALARY , DEPARTMENT_ID, hire_date
from employees 
where to_char(hire_date,'yyyy') >= '2005' and (SALARY>=1300 and SALARY<= 20000) ; 

 
update employees
set salary = 7700, hire_date = '2005/09/30' 
where employee_id = 111;
commit;



select FIRST_NAME, SALARY , DEPARTMENT_ID, hire_date
from employees 
where to_char(hire_date,'yyyy') >= '2005' and SALARY between 1300 and   20000; 


-- SQL 비교연산자 --
 


3. 2005년도 입사한 직원의 정보만 출력하시오.

select FIRST_NAME, SALARY , DEPARTMENT_ID, hire_date
from employees 
where to_char(hire_date, 'yyyy') = 2005; --자동형변환 


select * from v$nls_parameters;
--NLS_CHARACTERSET 이 AL32UTF8이다....한글이 3byte
select lengthb('oracle'), lengthb('오라클')
from dual;


2.05년도에 입사한 직원을 알아내기 위해 SUBSTR 함수를 이용하여 HIREDATE 컬럼에서 첫 글자부터 2개를 추출하여 
그 값이 05인지를 체크하는 방법으로도 구해 보도록 하세요.

select * 
from EMPLOYEES 
where SUBSTR(hire_date, 1, 2) = '05';

select * 
from EMPLOYEES 
where to_char(hire_date, 'RR') = '05';

select * 
from EMPLOYEES 
where to_char(hire_date, 'yyyy') = '2005';


3.  다음은 이름이 E로 끝나는 사원을 검색해 보도록 합시다. SUBSTR 함수를 이용하여
ENAME 컬럼의 마지막 문자 한개만 추출해서 이름이 E로 끝나는 사원을 검색해 보도록 하시오.
<힌트> 시작 위치를 -1로 주고 추출할 문자 개수를 1로 주면 됩니다. 

select * 
from EMPLOYEES 
where SUBSTR(first_name, -1) ='e';

select * 
from EMPLOYEES 
where SUBSTR(first_name, -1) =lower('E');


4. 이름이 D로 시작하는 직원의 이름, 급여, 입사일을 조회하시오.
select  first_name, salary, hire_date
from EMPLOYEES 
where SUBSTR(first_name, 1, 1) = 'D';


5. 12월에 입사한 직원의 이름, 급여, 입사일을 조회하시오.
--RR/mm/dd  => 00/00/00
select * 
from EMPLOYEES 
where SUBSTR(hire_date, 4, 2) = '12';

--
select * 
from EMPLOYEES 
where to_char(hire_date, 'mm') = '12';

-----index찾기  instr(first_name, 'a', 시작위치, 번째) 
 select  first_name, instr(first_name, 'a') , instr(first_name, 'a', 2, 2) 
from EMPLOYEES ;


5. 이름의 세 번째 자리가 R로 끝나는 사원을 검색하기 위해서 와일드카드 _ 와 LIKE 연산자를 사용하여 다음과 같이 표현할 수 있습니다.
 -- _는 임의의 문자 1자 , %는 임의의문자 0자이상 
 select  first_name 
from EMPLOYEES 
where first_name like '__r%';

6. 이름에 le 가 들어간 직원의 이름, 급여, 입사일을 조회하시오.
 select  first_name , salary, hire_date 
from EMPLOYEES 
where first_name like '%le%';



7. 이름이 m으로 끝나는 직원의 이름, 급여, 입사일을 조회하시오.
 select  first_name , salary, hire_date 
from EMPLOYEES 
where first_name like '%m';



8. 이름의 세번째 글자가 r인 이름, 급여, 입사일을 조회하시오.
 
 select  first_name , salary, hire_date 
from EMPLOYEES 
where first_name like '__r%';

 select  first_name , salary, hire_date 
from EMPLOYEES 
where substr(first_name,3,1) = 'r';


9. 커미션을 받는 직원의 이름, 커미션, 급여를 조회하시오.
 select  first_name , salary, commission_pct 
from EMPLOYEES 
where commission_pct is not null;



10. 커미션을 받지 않는 직원의 이름, 커미션, 급여를 조회하시오.
 select  first_name , salary, commission_pct 
from EMPLOYEES 
where commission_pct is null;

desc employees;
select * from tab;

11. 2000년대에 입사해서 30, 50, 80 번 부서에 속해있으면서, 
급여를 5000 이상 17000 이하를 받는 직원을 조회하시오. 
단, 커미션을 받지 않는 직원들은 검색 대상에서 제외시키며, 먼저 입사한 직원이 
먼저 출력되어야 하며 입사일이 같은 경우 급여가 많은 직원이 먼저 출력되록 하시오.
--2000~29999
 select  first_name , salary, commission_pct  , hire_date
from EMPLOYEES 
where substr(to_char(hire_date,'yyyy'),1,1) = 2   -- >=2000/01/01
and  department_id in (30, 50, 80)   --department_id=30 or department_id=50 or department_id=80
and commission_pct is not null
order by hire_date, salary desc 

--ASC : null이 뒤에나는 정책.....  nulls first로 null위치를 앞으로 조정가능 
--DESC : null이 앞에나는 정책 .... nulls last로 null위치를 앞으로 조정가능 
select * 
from EMPLOYEES
order by commission_pct desc nulls last;
--order by commission_pct nulls first;


select lpad(first_name, 8, '#') ,rpad(first_name, 8, '#') , 
        '!'||ltrim('        oracle')||'!' 왼쪽, '!'||rtrim('        oracle         ')||'!' 오른쪽,
        '!'||trim('        oracle         ')||'!' 양쪽,
        '!'||trim('o' from 'ooooracleooooo')||'!' 양쪽
from employees














---------------

select *
from departments;


--벤더가 제공하는 문법
select *
from A, B
where A.id = B.id(+);

--ANSI 표준문법
select *
from A left outer join B using id;