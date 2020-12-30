
--1. ȸ������ ���̺�

CREATE TABLE MEMBER_TBL(
	MB_ID					VARCHAR2(15)						PRIMARY KEY,
	MB_NAME             	VARCHAR2(30)						NOT NULL,
	MB_PW                 	VARCHAR2(60)						NOT NULL, 
	MB_EMAIL            	VARCHAR2(50)						NOT NULL,
	MB_ZIPCODE             	CHAR(5) 							NOT NULL,
	MB_ADDR              	VARCHAR2(100)						NOT NULL,
	MB_ADDR_D		    	VARCHAR2(100)						NOT NULL,
	MB_PHONE             	VARCHAR2(15)						NOT NULL,
	MB_NICKNAME           	VARCHAR2(20)						NOT NULL UNIQUE,
	MB_ACCEPT_E      	    CHAR(1)  DEFAULT 'Y'				NOT NULL,
	MB_POINT			    NUMBER DEFAULT 0          	    	NOT NULL,
	MB_DATE_SUB            	DATE  DEFAULT SYSDATE   	    	NOT NULL,
	MB_DATE_UP         	    DATE  DEFAULT SYSDATE	        	NOT NULL,  
	MB_DATE_LAST   	        DATE  DEFAULT SYSDATE    	        NOT NULL,
	MB_AUTHCODE	    	    CHAR(1) DEFAULT 'N'				    NOT NULL,
	MB_SESSION_KEY	        VARCHAR2(50),
	MB_SESSION_LIMIT	    TIMESTAMP
);

FOREIGN KEY(CG_CODE_PRT) REFERENCES CATEGORY_TBL(CG_CODE)
--2. ī�װ� ���̺�
CREATE TABLE CATEGORY_TBL (
    CG_CODE       			VARCHAR2(20)        				PRIMARY KEY,
    CG_CODE_PRT     		VARCHAR2(20),                                          
    CG_NAME           		VARCHAR2(50)         				NOT NULL,
    FOREIGN KEY(CG_CODE_PRT) REFERENCES CATEGORY_TBL(CG_CODE)
);

--3. ��ǰ ���̺�
 FOREIGN KEY(CG_CODE) REFERENCES CATEGORY_TBL(CG_CODE)
CREATE TABLE PRODUCT_TBL(
    PDT_NUM					NUMBER								PRIMARY KEY, 
    CG_CODE					VARCHAR2(20)						NOT NULL, 
    CG_CODE_PRT             VARCHAR2(20)                        NOT NULL, 
    PDT_NAME				VARCHAR2(50)						NOT NULL,
    PDT_PRICE				NUMBER								NOT NULL,
    PDT_DISCOUNT			NUMBER								NOT NULL,
    PDT_COMPANY		    	VARCHAR2(30)						NOT NULL,
    PDT_DETAIL				VARCHAR2(4000)					    NOT NULL,
    PDT_IMG					VARCHAR2(200)						NOT NULL,
    PDT_AMOUNT			    NUMBER								NOT NULL,
    PDT_BUY					CHAR(1)								NOT NULL,
    PDT_DATE_SUB			DATE 						    	NOT NULL,
    PDT_DATE_UP		    	DATE DEFAULT SYSDATE			    NOT NULL,
    FOREIGN KEY(CG_CODE) REFERENCES CATEGORY_TBL(CG_CODE)
);       
 FOREIGN KEY(PDT_NUM) REFERENCES PRODUCT_TBL(PDT_NUM),
 FOREIGN KEY(MB_ID)  REFERENCES MEMBER_TBL(MB_ID)
--4. ��ٱ��� ���̺� 
CREATE TABLE CART_TBL(
	CART_CODE				NUMBER								PRIMARY KEY,			
	PDT_NUM				    NUMBER								NOT NULL,
	MB_ID					VARCHAR2(15)						NOT NULL,
	CART_AMOUNT			    NUMBER								NOT NULL,
   FOREIGN KEY(PDT_NUM) REFERENCES PRODUCT_TBL(PDT_NUM),
 FOREIGN KEY(MB_ID)  REFERENCES MEMBER_TBL(MB_ID)
);
 FOREIGN KEY(MB_ID) REFERENCES MEMBER_TBL(MB_ID)
--5. �ֹ� ���̺�
CREATE TABLE ORDER_TBL(
	ODR_CODE				NUMBER								PRIMARY KEY,
	MB_ID					VARCHAR2(15)						NOT NULL,
	ODR_NAME				VARCHAR2(30)						NOT NULL,
	ODR_ZIPCODE		    	CHAR(5)								NOT NULL,
	ODR_ADDR				VARCHAR2(50)						NOT NULL,
	ODR_ADDR_D			    VARCHAR2(50)						NOT NULL,
	ODR_PHONE				VARCHAR2(20)						NOT NULL,
	ODR_TOTALPRICE		    NUMBER								NOT NULL,
	ODR_DATE				DATE DEFAULT SYSDATE			    NOT NULL,
    delivery                varchar2(20)                   default '����غ�',
   FOREIGN KEY(MB_ID) REFERENCES MEMBER_TBL(MB_ID)
);	
alter table ORDER_TBL add(delivery    varchar2(20)    default '����غ�');

PRIMARY KEY (ODR_CODE, PDT_NUM)
--6. �ֹ� �� ���̺�
CREATE TABLE ORDER_DETAIL_TBL(
	ODR_CODE				NUMBER								NOT NULL,
	PDT_NUM				    NUMBER								NOT NULL,
	ODR_AMOUNT			    NUMBER								NOT NULL,
	ODR_PRICE				NUMBER								NOT NULL,
	 PRIMARY KEY (ODR_CODE, PDT_NUM)
);
 FOREIGN KEY(MB_ID) REFERENCES MEMBER_TBL(MB_ID)
--7. �Խ��� ���̺� 
CREATE TABLE BOARD_TBL(
	BRD_NUM				    NUMBER								PRIMARY KEY, 
	MB_ID					VARCHAR2(15)						NOT NULL,
	BRD_TITLE				VARCHAR2(100)						NOT NULL,
	BRD_CONTENT		        VARCHAR2(4000)					    NOT NULL,
	BRD_DATE_REG			DATE DEFAULT SYSDATE		    	NOT NULL,
    FOREIGN KEY(MB_ID) REFERENCES MEMBER_TBL(MB_ID)
);
 FOREIGN KEY(MB_ID) REFERENCES  MEMBER_TBL(MB_ID)
--8. ��ǰ�ı� ���̺� 
CREATE TABLE REVIEW_TBL(
	REV_NUM					NUMBER								PRIMARY KEY, 
	MB_ID					VARCHAR2(15)						NOT NULL,
	PDT_NUM				    NUMBER								NOT NULL,
	REV_CONTENT			    VARCHAR2(200)						NOT NULL,
	REV_SCORE				NUMBER								NOT NULL,
	REV_DATE_REG		    DATE DEFAULT SYSDATE			    NOT NULL,
   FOREIGN KEY(MB_ID) REFERENCES  MEMBER_TBL(MB_ID)
);
insert into REVIEW_TBL(REV_NUM, MB_ID, PDT_NUM, REV_CONTENT, REV_SCORE, REV_DATE_REG) values('1','a1234','1','dd','3','2020.03.06');

--9. ������ �α��� ���̺�
CREATE TABLE ADMIN_TBL(
	ADMIN_ID				VARCHAR2(15)						PRIMARY KEY,
	ADMIN_PW				VARCHAR2(30)						NOT NULL,
	ADMIN_NAME			    VARCHAR2(15)						NOT NULL,
	ADMIN_DATE_LATE	    DATE DEFAULT	SYSDATE		        	NOT NULL
);
insert into ADMIN_TBL(ADMIN_ID,ADMIN_PW,ADMIN_NAME,ADMIN_DATE_LATE) values('admin','1234','����',SYSDATE);
select * from ADMIN_TBL;

/* ���̺� ��ȸ */
SELECT * FROM MEMBER_TBL;
SELECT * FROM CATEGORY_TBL;
SELECT * FROM PRODUCT_TBL;
SELECT * FROM CART_TBL;
SELECT * FROM ORDER_TBL;
SELECT * FROM ORDER_DETAIL_TBL;
SELECT * FROM BOARD_TBL;
SELECT * FROM REVIEW_TBL;

drop table MEMBER_TBL;
drop table CATEGORY_TBL;
drop table PRODUCT_TBL;
drop table CART_TBL;
drop table ORDER_TBL;
drop table ORDER_DETAIL_TBL;
drop table BOARD_TBL;
drop table ADMIN_TBL;
drop table REVIEW_TBL;
commit;


SELECT * FROM CATEGORY_TBL;
INSERT INTO CATEGORY_TBL
	VALUES('1000', NULL, 'TOP');
INSERT INTO CATEGORY_TBL
	VALUES('2000', NULL, 'PANTS');
INSERT INTO CATEGORY_TBL
	VALUES('3000', NULL, 'SHIRTS');
INSERT INTO CATEGORY_TBL
	VALUES('4000', NULL, 'OUTER');
INSERT INTO CATEGORY_TBL
	VALUES('5000', NULL, 'SHOES');
INSERT INTO CATEGORY_TBL
	VALUES('1100', 1000, '������');
INSERT INTO CATEGORY_TBL
	VALUES('1200', 1000, '��Ʈ');
INSERT INTO CATEGORY_TBL
	VALUES('1300', 1000, '����Ƽ');
INSERT INTO CATEGORY_TBL
	VALUES('2100', 2000, '������');
INSERT INTO CATEGORY_TBL
	VALUES('2200', 2000, '�����');
INSERT INTO CATEGORY_TBL
	VALUES('2300', 2000, 'û����');
INSERT INTO CATEGORY_TBL
	VALUES('3100', 3000, '������');
INSERT INTO CATEGORY_TBL
	VALUES('3200', 3000, 'û����');
INSERT INTO CATEGORY_TBL
	VALUES('3300', 3000, 'üũ,����');
INSERT INTO CATEGORY_TBL
	VALUES('4100', 4000, '�е�');
INSERT INTO CATEGORY_TBL
	VALUES('4200', 4000, '��Ʈ');
INSERT INTO CATEGORY_TBL
	VALUES('4300', 4000, '��Ʈ');

DELETE FROM CATEGORY_TBL WHERE CG_CODE='1300';
update CATEGORY_TBL set CG_NAME='üũ,����' WHERE CG_CODE='3300';


/* ������ ���� �� ���� */
-- 1-1. ��ǰ���̺�_��ǰ�ڵ� ������ ����
create sequence seq_pdt_num
start with 1
increment by 1;

-- 1-2. ������ ����
drop SEQUENCE seq_pdt_num;

-- 2-1. ��ٱ������̺�_��ٱ����ڵ� ������ ����
create sequence seq_cart_code
start with 1
increment by 1;

-- 2-2. ������ ����
drop SEQUENCE seq_cart_code;

-- 3-1. �ֹ����̺�_�ֹ��ڵ� ������ ����
create sequence seq_odr_code
start with 1
increment by 1;

--3-2. ������ ����
drop SEQUENCE seq_odr_code;

--4-1. �ֹ����̺�_�ֹ��ڵ� ������ ����
create sequence seq_rev_num
start with 1
increment by 1;

--4-2. ������ ����
drop SEQUENCE seq_rev_num;


--  �ֹ����̺� ������ ��ǰ ���̺��� ���� ���ҽ�Ű�� Ʈ����
CREATE OR REPLACE TRIGGER trg_order 
   AFTER INSERT 
   ON order_detail_tbl
   FOR EACH ROW 
DECLARE
   v_odr_amount NUMBER;
   v_pdt_num NVARCHAR2(50);
BEGIN
   DBMS_OUTPUT.PUT_LINE('trg_order�� �����մϴ�.');
   -- ����ڰ� �Է��� ���� ������ v_orderAmount�� ����
   SELECT :NEW.odr_amount INTO v_odr_amount FROM DUAL;
   -- ����ڰ� ������ ��ǰ���� v_prodName�� ����
   SELECT :NEW.pdt_num INTO v_pdt_num FROM DUAL;
   -- �ֹ� ������ŭ ���� ����
   UPDATE product_tbl SET pdt_amount = pdt_amount - v_odr_amount 
       WHERE pdt_num = v_pdt_num ;
END;

-- Ŀ��
commit;
alter table ADMIN_TBL drop constraint SCOTT.SYS_C0011240;

