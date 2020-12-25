-- �ǽ����� --
-- �������� ���α׷��� ����� ���� ���̺�� ����� --
-- �̶�, �������ǿ� �̸��� �ο��� �� 
--      �� �÷��� �ּ��ޱ�

DROP TABLE TB_PUBLISHER;
DROP TABLE TB_BOOK;

-- ���ǻ�鿡 ���� �����͸� ������� ���ǻ� ���̺�(TB_PUBLISHER) 
-- �÷� : PUB_NO(���ǻ��ȣ) -- �⺻Ű(PUBLISHER_PK)
--          PUB_NAME(���ǻ��) -- NOT NULL(PUBLISHER_NN)
--          PHONE(���ǻ���ȭ��ȣ) -- �������� ����
CREATE TABLE TB_PUBLISHER(
    PUB_NO NUMBER CONSTRAINT PUBLISHER_PK PRIMARY KEY,
    PUB_NAME VARCHAR2(30) CONSTRAINT PUBLISHER_NN NOT NULL,
    PHONE CHAR(13)
    );
  
  COMMENT ON COLUMN TB_PUBLISHER.PUB_NO IS '���ǻ��ȣ';
  COMMENT ON COLUMN TB_PUBLISHER.PUB_NAME IS '���ǻ��';
  COMMENT ON COLUMN TB_PUBLISHER.PHONE IS '���ǻ���ȭ��ȣ';
  
  
-- 3�� ������ ���� ������ �߰��ϱ�
INSERT INTO TB_PUBLISHER VALUES(1, '������', NULL);
INSERT INTO TB_PUBLISHER VALUES(2, '�󸶹�', NULL);
INSERT INTO TB_PUBLISHER VALUES(3, '�����', NULL);

SELECT * FROM TB_PUBLISHER;


-- �����鿡 ���� �����͸� ������� ���� ���̺�(TB_BOOK)
-- �÷� : BK_NO (������ȣ) -- �⺻Ű(BOOK_PK)
--        BK_TITLE (������) -- NOT NULL(BOOK_NN_TITLE)
--        BK_AUTHOR(���ڸ�) -- NOT NULL(BOOK_NN_AUTHOR)
--        BK_PRICE(����)
--        BK_PUB_NO(���ǻ��ȣ) -- �ܷ�Ű(BOOK_FK) (TB_PUBLISHER ���̺��� �����ϵ���)
--                                  �̶� �����ϰ� �ִ� �θ����� ���� �� �ڽ� �����͵� ���� �ǵ��� �ɼ� ����
CREATE TABLE TB_BOOK(
    BK_NO NUMBER CONSTRAINT BOOK_PK PRIMARY KEY,
    BK_TITLE VARCHAR2(20) CONSTRAINT BOOK_NN_TITLE NOT NULL,
    BK_AUTHOR VARCHAR2(20) CONSTRAINT BOOK_NN_AUTHOR NOT NULL,
    BK_PRICE NUMBER,
    BK_PUB_NO NUMBER,
    CONSTRAINT BOOK_FK FOREIGN KEY(BK_PUB_NO) REFERENCES TB_PUBLISHER ON DELETE CASCADE
);                                     

  COMMENT ON COLUMN TB_BOOK.BK_NO IS '������ȣ';
  COMMENT ON COLUMN TB_BOOK.BK_TITLE IS '������';
  COMMENT ON COLUMN TB_BOOK.BK_AUTHOR IS '���ڸ�';
  COMMENT ON COLUMN TB_BOOK.BK_PRICE IS '����';
  COMMENT ON COLUMN TB_BOOK.BK_PUB_NO IS '���ǻ��ȣ';


-- 5�� ������ ���� ������ �߰��ϱ�

INSERT INTO TB_BOOK VALUES(1, '����', 'ȫ�浿', NULL, 1);
INSERT INTO TB_BOOK VALUES(2, '��', '��浿', NULL, 1);
INSERT INTO TB_BOOK VALUES(3, '��', '�̱浿', NULL, 1);
INSERT INTO TB_BOOK VALUES(4, '����', '�ڱ浿', NULL, 1);
INSERT INTO TB_BOOK VALUES(5, '���ڸ�', '��浿', NULL, 1);

SELECT * FROM TB_BOOK;
-- ȸ���� ���� �����͸� ������� ȸ�� ���̺� (TB_MEMBER)
-- �÷��� : MEMBER_NO(ȸ����ȣ) -- �⺻Ű(MEMBER_PK)
--         MEMBER_ID(���̵�)   -- �ߺ�����(MEMBER_UQ)
--         MEMBER_PWD(��й�ȣ) -- NOT NULL(MEMBER_NN_PWD)
--         MEMBER_NAME(ȸ����) -- NOT NULL(MEMBER_NN_NAME)
--         GENDER(����)        -- 'M' �Ǵ� 'F'�� �Էµǵ��� ����(MEMBER_CK_GEN)
--         ADDRESS(�ּ�)       
--         PHONE(����ó)       
--         STATUS(Ż�𿩺�)     -- �⺻������ 'N'  �׸��� 'Y' Ȥ�� 'N'���θ� �Էµǵ��� ��������(MEMBER_CK_STA)
--         ENROLL_DATE(������)  -- �⺻������ SYSDATE, NOT NULL ��������(MEMBER_NN_EN)
CREATE TABLE TB_MEMBER(
    MEMBER_NO NUMBER CONSTRAINT MEMBER_PK PRIMARY KEY,
    MEMBER_ID VARCHAR2(20) CONSTRAINT MEMBER_UQ UNIQUE,
    MEMBER_PWD VARCHAR2(20) CONSTRAINT MEMBER_NN_PWD NOT NULL,
    MEMBER_NAME VARCHAR2(20) CONSTRAINT MEMBER_NN_NAME NOT NULL,
    GENDER CHAR(3) CONSTRAINT MEMBER_CK_GEN CHECK(GENDER IN('M','F')),
    ADDRESS VARCHAR2(50),
    PHONE CHAR(13),
    STATUS CHAR(3) DEFAULT 'N' CONSTRAINT MEMBER_CK_STA CHECK(STATUS IN ('N','Y')),
    ENROLL_DATE DATE DEFAULT SYSDATE CONSTRAINT MEMBER_NN_EN NOT NULL
    
);

COMMENT ON COLUMN TB_MEMBER.MEMBER_NO IS 'ȸ����ȣ';
COMMENT ON COLUMN TB_MEMBER.MEMBER_ID IS '���̵�';
COMMENT ON COLUMN TB_MEMBER.MEMBER_PWD IS '��й�ȣ';
COMMENT ON COLUMN TB_MEMBER.MEMBER_NAME IS 'ȸ����';
COMMENT ON COLUMN TB_MEMBER.GENDER IS '����';
COMMENT ON COLUMN TB_MEMBER.ADDRESS IS '�ּ�';
COMMENT ON COLUMN TB_MEMBER.PHONE IS '����ó';
COMMENT ON COLUMN TB_MEMBER.STATUS IS 'Ż�𿩺�';
COMMENT ON COLUMN TB_MEMBER.ENROLL_DATE IS '������';
-- 5�� ������ ���� ������ �߰��ϱ�
INSERT INTO TB_MEMBER VALUES(1, 'A', 'A','A', 'M', NULL, NULL, NULL, '190202');
INSERT INTO TB_MEMBER VALUES(2, 'B', 'B','B', 'M', NULL, NULL, 'Y', '200202');
INSERT INTO TB_MEMBER VALUES(3, 'C', 'C','C', 'F', NULL, NULL, 'N', '191111');
INSERT INTO TB_MEMBER VALUES(4, 'D', 'A','A', 'F', NULL, NULL, NULL, '130220');
INSERT INTO TB_MEMBER VALUES(5, 'E', 'A','A', 'M', NULL, NULL, NULL, '101212');

SELECT * FROM TB_MEMBER;
-- � ȸ���� � ������ �뿩�ߴ����� ����  �뿩��� ���̺�(TB_RENT)
-- �÷� : RENT_NO(�뿩��ȣ) -- �⺻Ű(RENT_PK)
--        RENT_MEM_NO(�뿩ȸ����ȣ) -- �ܷ�Ű(RENT_FK_MEM)  TB_MEMBER�� �����ϵ���
--                                     �̶� �θ� ������ ������ �ڽ� ������ ���� NULL�� �ǵ��� �ɼ� ����
--        RENT_BOOK_NO(�뿩������ȣ) -- �ܷ�Ű(RENT_FK_BOOK)  TB_BOOK�� �����ϵ���
--                                      �̶� �θ� ������ ������ �ڽ� ������ ���� NULL���� �ǵ��� �ɼ� ����
--        RENT_DATE(�뿩��) -- �⺻�� SYSDATE

CREATE TABLE TB_RENT(
    RENT_NO NUMBER CONSTRAINT TB_RENT PRIMARY KEY,
    REMT_MEM_NO NUMBER CONSTRAINT RENT_FK_MEM REFERENCES TB_MEMBER ON DELETE SET NULL,
    RENT_BOOK_NO NUMBER CONSTRAINT RENT_FK_BOOK REFERENCES TB_BOOK ON DELETE SET NULL,
    RENT_DATE DATE DEFAULT SYSDATE
);
COMMENT ON COLUMN TB_RENT.REPNT_NO IS '�뿩��ȣ';
COMMENT ON COLUMN TB_RENT.RENT_MEM_NO IS '�뿩ȸ����ȣ';
COMMENT ON COLUMN TB_RENT.RENT_BOOK_NO IS '�뿩������ȣ';
COMMENT ON COLUMN TB_RENT.RENT_DATE IS '�뿩��';



-- ���õ����� 3�� ����  �߰��ϱ�
INSERT INTO TB_RENT VALUES(1,1,1,NULL);
INSERT INTO TB_RENT VALUES(2,2,2,NULL);
INSERT INTO TB_RENT VALUES(3,3,3,'200801');


SELECT * FROM TB_RENT;






