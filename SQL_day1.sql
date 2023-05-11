--SQL���� ��ҹ��ڱ��� ���� 
--������������ �ۼ����� 
--���峡�� ; 
--select *  *�� ���Į���� �ǹ� 
--invalid identifier : �ĺ��ڿ��� (�ĺ���-->Į���̸�, table�̸�)
-- ���ڰ��� �ݵ�� ''�� ����Ѵ�. 
-- "table or view does not exist"
--Oracle�� �����ͻ������ִ�...�����ͻ����� ���̺��̸��� �빮�ڷ� �����س��´�. 
--���� ��ҹ��� �����Ѵ�. 

desc employees;
select * from tab;
select * from employees;

select EMPLOYEE_ID, FIRST_name, 1+2 , 'SQL����'
from "EMPLOYEES";

select DISTINCT DEPARTMENT_ID
from EMPLOYEES ;

--���̾��� : null
--null���� ����ϸ�  null
--null�� ��ü�� �ʿ䰡 �ִ�. nvl(�񱳰�, ��ü��)
--Ư�����ڰ� ���Ե� �ĺ����̸��� ""���� ���Ѵ�. 
--��Ī�� ���� as�� ���������ϴ�. 
--���Ῥ���ڴ� +�� �ƴϴ�. Oracle�� ||�̴�. oracle, mysql�� concat()�Լ��̿� 

select employee_id ������ȣ , first_name||' '||last_name as �̸�, 
        concat(concat(first_name,' '), last_name) �̸�2,
        salary, commission_pct, 
       salary+ salary*nvl(commission_pct,0) "Ŀ�̼� ����޿�",        --�ؼ�2
       hire_date
from employees;  --�ؼ�1

--distinct�� ����Į������ �������� ������ �����ȴ�. 
select distinct department_id, job_id
from employees ;

--������

select employee_id , first_name, last_name, salary �޿� --�ؼ�3
from employees /*--�ؼ�1*/
where salary >= 10000  --�ؼ�2
order by 4 desc;--�ؼ�4

--order by Į���̸� �Ǵ� ���� �Ǵ� select����(SQL�� ������ 1���ͽ���) 
--order by salary desc;
--order by �޿� desc; --�ؼ�4
 


-----------------------------------------------
select Į���̸���--3
from table�̸��� --1
where ������ --2
order by Į����; --4

--�⵵�� 2�ڸ� 
--99
--00 (1900? 2000?) Y2K
--1955  1980   2022  1951  2040


select * from v$nls_parameters;


-->RR���� : >50�� 1900��� <50 2000���  
select employee_id, first_name, salary
, to_char(hire_date,'yyyy/mm/dd hh:mi:ss') �Ի���
,department_id   --3
from employees --1
where salary>=10000 --2
and department_id = 80
and first_name = 'Lisa'
order by hire_date asc, salary desc; --4


--DUAL table�� Oracle���� �����ϴ� dummy table
desc DUAL;
select * from dual;

select  1+2, sysdate ,  floor(10.9) �����ǹ���, ceil(10.1) �����ǿø�,
       round(35.678) �����ιݿø�, round(35.678,1) �ݿø�2, round(35.678,-1) �ݿø�3
from dual;

--����� Ȧ���� ������ȸ
select *
from EMPLOYEES 
where mod(EMPLOYEE_ID,2)=1

select first_name, upper(first_name), lower(first_name), initCap(email), length(first_name),
  length('�ѱ�'), lengthB('�ѱ�')
from EMPLOYEES ;

--first_name�� david�� �˻��Ѵ�. 
--1

--���࿡ first_nameĮ������ ����(index)�� �����Ǿ��־��ٸ� �Լ��� �̿������� index�� ������.(index���Ұ�)
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
		SELECT �⺻
========================================

1. �޿��� 15000 �̻��� �������� �̸�, �޿�, �μ�id�� ��ȸ�Ͻÿ�.

select FIRST_NAME, SALARY, DEPARTMENT_ID
from employees 
where SALARY>=15000;


2. ���� �߿��� ������ 170000 �̻��� �������� �̸�, ������ ��ȸ�Ͻÿ�.
   ������ �޿�(salary)�� 12�� ���� ���Դϴ�.

select FIRST_NAME, SALARY * 12 aa
from employees 
where SALARY * 12 >=170000;

--null�� ���̾���. �̹Ƿ� =�����ڷ� �񱳺Ұ� 
3. ���� �߿��� �μ�id�� ���� ������ �̸��� �޿��� ��ȸ�Ͻÿ�.
select FIRST_NAME, SALARY , DEPARTMENT_ID 
from employees 
where DEPARTMENT_ID is null;      



4. 2004�� ������ �Ի��� ������ �̸�, �޿�, �Ի����� ��ȸ�Ͻÿ�.
select FIRST_NAME, SALARY , hire_date
from employees 
where hire_date <= '2004/12/31';    --�ڵ�����ȯ���� 

select FIRST_NAME, SALARY , hire_date
from employees 
where to_char(hire_date,'yyyy') <= '2004'; 


-- ��������  not / and / or   -- 
1. 80, 50 �� �μ��� ���������鼭 �޿��� 13000 �̻��� ������ �̸�, �޿�, �μ�id
�� ��ȸ�Ͻÿ�.
select FIRST_NAME, SALARY , DEPARTMENT_ID
from employees 
where (DEPARTMENT_ID=80 or DEPARTMENT_ID=50) and SALARY >=13000 

select FIRST_NAME, SALARY , DEPARTMENT_ID
from employees 
where DEPARTMENT_ID in (50, 80) and SALARY >=13000 



2. 2005�� ���Ŀ� �Ի��� ������ �߿��� �޿��� 1300 �̻� 20000 ������ �������� 
�̸�, �޿�, �μ�id, �Ի����� ��ȸ�Ͻÿ�.

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


-- SQL �񱳿����� --
 


3. 2005�⵵ �Ի��� ������ ������ ����Ͻÿ�.

select FIRST_NAME, SALARY , DEPARTMENT_ID, hire_date
from employees 
where to_char(hire_date, 'yyyy') = 2005; --�ڵ�����ȯ 


select * from v$nls_parameters;
--NLS_CHARACTERSET �� AL32UTF8�̴�....�ѱ��� 3byte
select lengthb('oracle'), lengthb('����Ŭ')
from dual;


2.05�⵵�� �Ի��� ������ �˾Ƴ��� ���� SUBSTR �Լ��� �̿��Ͽ� HIREDATE �÷����� ù ���ں��� 2���� �����Ͽ� 
�� ���� 05������ üũ�ϴ� ������ε� ���� ������ �ϼ���.

select * 
from EMPLOYEES 
where SUBSTR(hire_date, 1, 2) = '05';

select * 
from EMPLOYEES 
where to_char(hire_date, 'RR') = '05';

select * 
from EMPLOYEES 
where to_char(hire_date, 'yyyy') = '2005';


3.  ������ �̸��� E�� ������ ����� �˻��� ������ �սô�. SUBSTR �Լ��� �̿��Ͽ�
ENAME �÷��� ������ ���� �Ѱ��� �����ؼ� �̸��� E�� ������ ����� �˻��� ������ �Ͻÿ�.
<��Ʈ> ���� ��ġ�� -1�� �ְ� ������ ���� ������ 1�� �ָ� �˴ϴ�. 

select * 
from EMPLOYEES 
where SUBSTR(first_name, -1) ='e';

select * 
from EMPLOYEES 
where SUBSTR(first_name, -1) =lower('E');


4. �̸��� D�� �����ϴ� ������ �̸�, �޿�, �Ի����� ��ȸ�Ͻÿ�.
select  first_name, salary, hire_date
from EMPLOYEES 
where SUBSTR(first_name, 1, 1) = 'D';


5. 12���� �Ի��� ������ �̸�, �޿�, �Ի����� ��ȸ�Ͻÿ�.
--RR/mm/dd  => 00/00/00
select * 
from EMPLOYEES 
where SUBSTR(hire_date, 4, 2) = '12';

--
select * 
from EMPLOYEES 
where to_char(hire_date, 'mm') = '12';

-----indexã��  instr(first_name, 'a', ������ġ, ��°) 
 select  first_name, instr(first_name, 'a') , instr(first_name, 'a', 2, 2) 
from EMPLOYEES ;


5. �̸��� �� ��° �ڸ��� R�� ������ ����� �˻��ϱ� ���ؼ� ���ϵ�ī�� _ �� LIKE �����ڸ� ����Ͽ� ������ ���� ǥ���� �� �ֽ��ϴ�.
 -- _�� ������ ���� 1�� , %�� �����ǹ��� 0���̻� 
 select  first_name 
from EMPLOYEES 
where first_name like '__r%';

6. �̸��� le �� �� ������ �̸�, �޿�, �Ի����� ��ȸ�Ͻÿ�.
 select  first_name , salary, hire_date 
from EMPLOYEES 
where first_name like '%le%';



7. �̸��� m���� ������ ������ �̸�, �޿�, �Ի����� ��ȸ�Ͻÿ�.
 select  first_name , salary, hire_date 
from EMPLOYEES 
where first_name like '%m';



8. �̸��� ����° ���ڰ� r�� �̸�, �޿�, �Ի����� ��ȸ�Ͻÿ�.
 
 select  first_name , salary, hire_date 
from EMPLOYEES 
where first_name like '__r%';

 select  first_name , salary, hire_date 
from EMPLOYEES 
where substr(first_name,3,1) = 'r';


9. Ŀ�̼��� �޴� ������ �̸�, Ŀ�̼�, �޿��� ��ȸ�Ͻÿ�.
 select  first_name , salary, commission_pct 
from EMPLOYEES 
where commission_pct is not null;



10. Ŀ�̼��� ���� �ʴ� ������ �̸�, Ŀ�̼�, �޿��� ��ȸ�Ͻÿ�.
 select  first_name , salary, commission_pct 
from EMPLOYEES 
where commission_pct is null;

desc employees;
select * from tab;

11. 2000��뿡 �Ի��ؼ� 30, 50, 80 �� �μ��� ���������鼭, 
�޿��� 5000 �̻� 17000 ���ϸ� �޴� ������ ��ȸ�Ͻÿ�. 
��, Ŀ�̼��� ���� �ʴ� �������� �˻� ��󿡼� ���ܽ�Ű��, ���� �Ի��� ������ 
���� ��µǾ�� �ϸ� �Ի����� ���� ��� �޿��� ���� ������ ���� ��µǷ� �Ͻÿ�.
--2000~29999
 select  first_name , salary, commission_pct  , hire_date
from EMPLOYEES 
where substr(to_char(hire_date,'yyyy'),1,1) = 2   -- >=2000/01/01
and  department_id in (30, 50, 80)   --department_id=30 or department_id=50 or department_id=80
and commission_pct is not null
order by hire_date, salary desc 

--ASC : null�� �ڿ����� ��å.....  nulls first�� null��ġ�� ������ �������� 
--DESC : null�� �տ����� ��å .... nulls last�� null��ġ�� ������ �������� 
select * 
from EMPLOYEES
order by commission_pct desc nulls last;
--order by commission_pct nulls first;


select lpad(first_name, 8, '#') ,rpad(first_name, 8, '#') , 
        '!'||ltrim('        oracle')||'!' ����, '!'||rtrim('        oracle         ')||'!' ������,
        '!'||trim('        oracle         ')||'!' ����,
        '!'||trim('o' from 'ooooracleooooo')||'!' ����
from employees














---------------

select *
from departments;


--������ �����ϴ� ����
select *
from A, B
where A.id = B.id(+);

--ANSI ǥ�ع���
select *
from A left outer join B using id;