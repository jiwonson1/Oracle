/*

    DML (MANIPULATION ����) : SELECT, INSERT, UPDATE, DELETE
    DDL (DEFINITION ����) : CREATE, ALTER, DROP 
    DCL (CONTROL ����) : GRANT, REVOKE, COMMIT, ROLLBACK
    
    DQL (QUERY ����) : SELECT
    DML             : INSERT, UPDATE, DELETE
    DDL             : CREATE, ALTER, DROP
    DCL             : GRANT, REVOKE
    TCL (TRANSACTION) : COMMIT, ROLLBACK
    
    
    * DDL(DATA DEFINITION LANGUAGE) : ������ ���� ���
    ����Ŭ���� �����ϴ� ��ü(OBJCECT)���� 
    ������ �����(CREATE), ������ ����(ALTER)�ϰ�, ���� ��ü�� ����(DROP)�ϴ� ����
    
    �ַ� DB������, �����ڰ� ����ϴ� ����
    
    ����Ŭ������ ��ü(����) : ���̺�(TABLE), ��(VIEW), ������(SEQUENCE),
                          �ε���(INDEX), ��Ű��(PACKAGE), Ʈ����(TRIGGER),
                          ���ν���(PROCEDURE), �Լ�(FUNCTION), 
                          ���Ǿ�(SYNONYM), �����(USER)
                          
    
    < CREATE >
    �پ��� ��ü(����)�� �����ϴ� ����
    
    1. ���̺� ����
    - ���̺�? : ��(ROW)�� ��(COLUMN)�� �����Ǵ� ���� �⺻���� �����ͺ��̽� ��ü
               �����͵��� �����ϱ� ���� ���� �ٽ����� ��ü
    
    [ǥ����]
    CREATE TABLE ���̺��(
        �÷��� �ڷ���(ũ��),
        �÷��� �ڷ���(ũ��), 
        �÷��� �ڷ���,
        ....
    );
    
    * �ڷ���(DATA TYPE)
    
    - ���� (CHAR(ũ��) / VARCHAR2(ũ��))
      > CHAR(ũ��) : �ִ� 2000BYTE ���� ���� ���� / �������� (�ƹ��� ���� ���� ���͵� ó�� �Ҵ��� ũ�� �״��)
      > VARCHAR2(ũ��) : �ִ� 4000BYTE ���� ���� ���� / �������� (��� ���� ���� ������ ũ�� ������)
    
    - ���� (NUMBER)
    
    - ��¥ (DATE)
    
*/

--> ȸ���� ���� �����͸� ������� ���̺� MEMBER �����ϱ�
CREATE TABLE MEMBER(
    MEM_NO NUMBER,      -- ȸ�� ��ȣ 
    MEM_ID VARCHAR2(20),-- ȸ�� ���̵�
    MEM_PWD VARCHAR2(20), -- ȸ�� ��й�ȣ
    MEM_NAME VARCHAR2(20), -- ȸ����
    GENDER CHAR(3),        -- ����
    PHONE CHAR(13),        -- ��ȭ��ȣ
    EMAIL VARCHAR2(50),    -- �̸���
    MEM_DATE DATE          -- ȸ��������
);

SELECT * FROM MEMBER;

------------------------------------------------------------------------------

/*
    2. �÷��� �ּ� �ޱ� (�÷��� ���� ��������)
    
    [ǥ����]
    COMMENT ON COLUMN ���̺��.�÷��� IS '�ּ�����';
*/
COMMENT ON COLUMN MEMBER.MEM_NO IS 'ȸ����ȣ';
COMMENT ON COLUMN MEMBER.MEM_ID IS 'ȸ�����̵�';
COMMENT ON COLUMN MEMBER.MEM_PWD IS 'ȸ����й�ȣ';
COMMENT ON COLUMN MEMBER.MEM_NAME IS 'ȸ����';
COMMENT ON COLUMN MEMBER.GENDER IS '����(��/��)';
COMMENT ON COLUMN MEMBER.PHONE IS '��ȭ��ȣ';
COMMENT ON COLUMN MEMBER.EMAIL IS '�̸���';
COMMENT ON COLUMN MEMBER.MEM_DATE IS 'ȸ��������';


-- ������ ��ųʸ� : �پ��� ��ü���� ������ �����ϰ� �ִ� �ý��� ���̺�(�̹� ����) --
-- [����] USER_TABLES : �� ����ڰ� ������ �ִ� ���̺���� �������� ������ Ȯ���� �� �ִ� �ý��� ���̺�
SELECT * FROM USER_TABLES;
-- [����] USER_TAB_COLUMNS : ���̺�� ���ǵǾ��ִ� ��� �÷��� �������� ������ Ȯ���� �� �ִ� �ý��� ���̺�
SELECT * FROM USER_TAB_COLUMNS;

SELECT * FROM MEMBER;

-- ������ �߰��Ҽ� �ִ� ����
-- INSERT INTO ���̺�� VALUES(�÷���, �÷���, �÷���, ...);

INSERT INTO MEMBER VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1111-2222', null, SYSDATE);
SELECT * FROM MEMBER;

INSERT INTO MEMBER VALUES('2', 'user02', 'pass02', 'ȫ���', '��', '010-1111-2222', null, '19/07/21');
SELECT * FROM MEMBER;

INSERT INTO MEMBER VALUES(NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

SELECT * FROM MEMBER;

/*
    < �������� CONSTRAINTS >
    - ���ϴ� �����Ͱ�(��ȿ�� ��)�� �����ϱ� ���ؼ� Ư�� �÷��� �����ϴ� ����
    - ������ ���Ἲ ������ �������� �Ѵ�.
    - ���� �����Ͱ��� ������ ������ �ڵ����� �˻��� ����
    
    * ���� : NOT NULL, UNIQUE, CHECK(����), PRIMARY KEY, FOREIGN KEY
*/

/*
    * NOT NULL ��������
      �ش� �÷��� �ݵ�� ���� �־�߸� �ϴ� ��� ��� (�ش� �÷��� NULL���� ���ͼ��� �ȵǴ� ���)
      ����/������ NULL���� ������� �ʵ��� ����
*/

-- ���������� �ο��ϴ� ����� ũ�� 2���� ���� (�÷�������� / ���̺������)
-- NOT NULL�������� �ο��� ������ �÷����� ��Ĺۿ� �ȵ� �Ф�
-- �÷����� ��� : �÷��� �ڷ���[(ũ��)] ��������
CREATE TABLE MEM_NOTNULL(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50)
);

SELECT * FROM MEM_NOTNULL;

INSERT INTO MEM_NOTNULL VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', null, NULL);
INSERT INTO MEM_NOTNULL VALUES(2, 'user02', 'pass02', '�踻��', NULL, NULL, NULL);
--> NOT NULL �������ǿ� ����Ǿ� ���� �߻���!! (���� �ǵ��ߴ� ���)


INSERT INTO MEM_NOTNULL 
VALUES(3, 'user01', 'pass03', 'ȫ���', '��', '010-2222-3333', 'aaa@naver.com');
--> ���̵� �ߺ��������� �ұ��ϰ� ���������� ���Ե�!!
SELECT * FROM MEM_NOTNULL;

----------------------------------------------------------------------------

/*
    * UNIQUE �������� 
      �÷����� �ߺ����� �����ϴ� ��������
      ����/������ ������ �ִ� �����Ͱ� �߿� �ߺ����� ���� ��� ���� �߻�
      
      �÷����� ���/ ���̺��� ��� �� �� ��� ����
*/

DROP TABLE MEM_UNIQUE;
/*
CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, --> �÷����� ���
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE CHAR(13), 
    EMAIL VARCHAR2(50)
);
*/
-- ���̺��� ��� : ��������(�÷���)
CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE CHAR(13), 
    EMAIL VARCHAR2(50),
    UNIQUE(MEM_ID)  --> ���̺� ���� ���
);

INSERT INTO MEM_UNIQUE VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', null, NULL);
INSERT INTO MEM_UNIQUE VALUES(2, 'user02', 'pass02', '�踻��', NULL, NULL, NULL);
INSERT INTO MEM_UNIQUE VALUES(3, 'user01', 'pass03', 'ȫ���', null, null, null);
--> UNIQUE �������ǿ� ����Ǿ����Ƿ� INSERT ����!!
--> ���� ������ �������Ǹ����� �˷���!! (Ư�� �÷��� � ���������� ����Ǿ����� ���� �˷���������..)
--> ���� �ľ��ϱ� �����.. (�������Ǹ��� ���������� ������ �ý��ۿ��� �˾Ƽ� ������ �������Ǹ��� �ο��ع���..)

/*
    * �������Ǹ���� �̸������ָ鼭 ���������� �ο��ϴ� ǥ����
    
    > �÷� ���� ���
    CREATE TABLE ���̺��(
        �÷��� �ڷ���(ũ��) [CONSTRAINT �������Ǹ�] ��������,
        �÷��� �ڷ���
    );
    
    > ���̺� ���� ���
    CREATE TABLE ���̺��(
        �÷��� �ڷ���,
        �÷��� �ڷ���,
        [CONSTRAINT �������Ǹ�] ��������(�÷���)
    );
    
*/

DROP TABLE MEM_UNIQUE;

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER CONSTRAINT MEM_NO_NN NOT NULL,
    MEM_ID VARCHAR2(20) CONSTRAINT MEM_ID_NN NOT NULL,
    MEM_PWD VARCHAR2(20) CONSTRAINT MEM_PWD_NN NOT NULL,
    MEM_NAME VARCHAR2(20) CONSTRAINT MEM_NAME_NN NOT NULL,
    GENDER CHAR(3),
    PHONE CHAR(13), 
    EMAIL VARCHAR2(50),
    CONSTRAINT MEM_ID_UQ UNIQUE(MEM_ID)  --> ���̺� ���� ���
);

INSERT INTO MEM_UNIQUE VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', null, NULL);
INSERT INTO MEM_UNIQUE VALUES(2, 'user02', 'pass02', '�踻��', NULL, NULL, NULL);
INSERT INTO MEM_UNIQUE VALUES(3, 'user01', 'pass03', 'ȫ���', null, null, null);


INSERT INTO MEM_UNIQUE VALUES(3, 'user03', 'pass03', 'ȫ���', '��', null, null);
--> ������ ��ȿ�� ���� �ƴѰ� �־ �� INSERT �ǹ���! �Ф�
SELECT * FROM MEM_UNIQUE;

--------------------------------------------------------------------

/*
    * CHECK(����) ��������
      �÷��� ���� ���� ���� ������ �����ص� �� ����
      �ش� ���ǿ� �����ϴ� �����Ͱ��� ��� �� ����
    
*/
CREATE TABLE MEM_CHECK(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CONSTRAINT GENDER_CK CHECK(GENDER IN ('��', '��')),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    UNIQUE(MEM_ID)
    -- ,CONSTRAINT GENDER_CK CHECK(GENDER IN ('��', '��'))
);

INSERT INTO MEM_CHECK VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', null, NULL);
INSERT INTO MEM_CHECK VALUES(2, 'user02', 'pass02', '�踻��', NULL, NULL, NULL);
INSERT INTO MEM_CHECK VALUES(3, 'user03', 'pass03', 'ȫ���', '��', null, null);
--> GENDER �÷��� ���� ���´ٸ� '��' �Ǵ� '��'�� ���� 
--> �Ӹ� �ƴ϶� NULL���� INSERT����!!
--> ���࿡ NULL���� �������Բ� �ϰ��� �Ѵٸ� NOT NULL�������ǵ� ���� �ο��ϸ��!!

INSERT INTO MEM_CHECK VALUES(3, 'user04', 'pass04', '�踻��', '��', '010-1111-2222', 'bbb@naver.com');
--> ȸ����ȣ�� �����ص� ���������� insert��... 

SELECT * FROM MEM_CHECK;

------------------------------------------------------------------------------------

/*
    * PRIMARY KEY (�⺻Ű) ��������
      ���̺��� �� ���� ������ �ĺ��ϱ� ���� ����� �÷��� �ο��ϴ� �������� (�ĺ����� ����)
      EX) �й�, ȸ����ȣ, �����ȣ, �μ��ڵ�, �����ڵ�, �ֹ���ȣ, �����ȣ, ����� ��ȣ, ...
      
      PRIMARY KEY ���������� �ο��ϰ� �Ǹ�
      �ش� �� �÷��� NOT NULL + UNIQUE ���������� �ǹ�
      
      �������� : �� ���̺�� �Ѱ��� ���� ����
      
*/

CREATE TABLE MEM_PRIMARYKEY(
    MEM_NO NUMBER CONSTRAINT MEM_NO_PK PRIMARY KEY, --> �÷����� ���
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,    --> ȸ����ȣ�� �ƴ϶� ���̵� ���� �ĺ��� ���� �����ϱ���(��üŰ)
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    CHECK(GENDER IN ('��', '��')) 
    -- , CONSTRAINT MEM_NO_PK PRIMARY KEY(MEM_NO) --> ���̺��� ���
);

INSERT INTO MEM_PRIMARYKEY
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', null, null);

INSERT INTO MEM_PRIMARYKEY
VALUES(NULL, 'user02', 'pass02', '�̼���', NULL, NULL, NULL);
--> �⺻Ű�� NULL�� �������� �� �� ��������

INSERT INTO MEM_PRIMARYKEY
VALUES(1, 'user02', 'pass02', '�̼���', NULL, NULL, NULL);
--> �⺻Ű�� �ߺ����� �������� �� �� ��������

--> PRIMARY KEY == NOT NULL + UNIQUE
INSERT INTO MEM_PRIMARYKEY
VALUES(2, 'user02', 'pass02', '�̼���', NULL, NULL, NULL);
SELECT * FROM MEM_PRIMARYKEY;


--- * ������ �� : �� ���̺�� �Ѱ��� PRIMARY KEY�� ����!!
CREATE TABLE MEM_PRIMARYKEY2(
    MEM_NO NUMBER, 
    MEM_ID VARCHAR2(20),    
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    CHECK(GENDER IN ('��', '��')),
    PRIMARY KEY(MEM_NO, MEM_ID) --> ��� PRIMARY KEY �������� �ο����� (����Ű)
);

INSERT INTO MEM_PRIMARYKEY2
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', null, null);

INSERT INTO MEM_PRIMARYKEY2
VALUES(1, 'user02', 'pass02', 'ȫ���', '��', null, null);

INSERT INTO MEM_PRIMARYKEY2
VALUES(2, 'user02', 'pass03', '�踻��', NULL, null, null);

INSERT INTO MEM_PRIMARYKEY2
VALUES(NULL, 'user03', 'pass04', '�踻��', NULL, null, null);
--> �⺻Ű�� �����ִ� �� �÷����� ���� NULL���� ������ �ȵ�!!


SELECT * FROM MEM_PRIMARYKEY2;



-- ȸ����޿� ���� �����͸� ���� �����ϴ� ���̺�
CREATE TABLE MEM_GRADE(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);

INSERT INTO MEM_GRADE VALUES(10, '�Ϲ�ȸ��');
INSERT INTO MEM_GRADE VALUES(20, '���ȸ��');
INSERT INTO MEM_GRADE VALUES(30, 'Ư��ȸ��');

SELECT * FROM MEM_GRADE;

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER     --> ȸ����޹�ȣ ���� ������ �÷�
);

INSERT INTO MEM VALUES(1, 'user01', 'pass01', 'ȫ�浿', null, null, null, null);
INSERT INTO MEM VALUES(2, 'user02', 'pass02', '�踻��', '��', NULL, NULL, 10);
INSERT INTO MEM VALUES(3, 'user03', 'pass03', '�̼���', null, null, null, 40);


SELECT * FROM MEM;

-------------------------------------------------------------------------------

/*
    * FOREIGN KEY (�ܷ�Ű) ��������
      �ٸ� ���̺� �����ϴ� ���� ���;� �Ǵ� Ư�� �÷��� �ο��ϴ� ��������
      
      --> �ٸ� ���̺��� �����Ѵٰ� ǥ��
      --> FOREIGN KEY �������ǿ� ���� ���̺� ���� ���谡 ������!!
      
      > �÷����� ���
        �÷��� �ڷ��� [CONSTRAINT �������Ǹ�] REFERENCES ���������̺��[(�÷���)]
        
      > ���̺��� ���
        [CONSTRAINT �������Ǹ�] FOREIGN KEY(�÷���) REFERENCES ���������̺��[(�÷���)]
*/

SELECT * FROM MEM_GRADE;

DROP TABLE MEM;
CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER, -- REFERENCES MEM_GRADE--(GRADE_CODE) --> �÷����� ���
    FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE--(GRADE_CODE)  --> ���̺��� ���
);

INSERT INTO MEM VALUES(1, 'user01', 'pass01', 'ȫ�浿', NULL, NULL, NULL, 10);
INSERT INTO MEM VALUES(2, 'user02', 'pass02', '�踻��', NULL, NULL, NULL, 20);
INSERT INTO MEM VALUES(3, 'user03', 'pass03', '�̼���', NULL, NULL, NULL, 10);
INSERT INTO MEM VALUES(4, 'user04', 'pass04', '���߱�', NULL, NULL, NULL, NULL);
--> �ܷ�Ű ���������� �ο��� �÷��� �⺻������ NULL�� ��°� ���� 
INSERT INTO MEM VALUES(5, 'user05', 'pass05', '�Ż��Ӵ�', NULL, NULL, NULL, 40);
--> parent key�� ã�� �� ���ٴ� ���� �߻�
-- 40�̶�� ���� mem_grade ���̺� grade_code �÷����� �����ǰ� �ִ� ���� �ƴ�


SELECT * FROM MEM;


----------------------------------------------------------
/*
   - PRIMARY KEY   : ALTER TABLE  ���̺�� ADD FRIMARY KEY (�÷���);
    - FOREIGN KEY   : ALTER TABLE ���̺�� ADD FOREIGN KEY(�÷���) REFERENCES ���������̺�
    - UNIQUE        : ALTER TABLE ���̺�� ADD UNIQUE (�÷���);
    - CHECK         : ALTER TABLE ���̺�� ADD CHECK (�÷������� ����);
    - NOT NULL      : ALTER TABLE ���̺�� MODIFY 
    
    
*/

-- EMPLOYEE_COPY 
ALTER TABLE EMPLOYEE_COPY ADD PRIMARY KEY(EMP_ID);

ALTER TABLE EMPLOYEE ADD FOREIGN KEY(DEPT_CODE) REFERENCES JOB; -- (DEPT_ID)



































