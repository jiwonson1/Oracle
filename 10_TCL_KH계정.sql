/*
    < TCL : TRANSACTION CONTROL LANGUAGE >
    Ʈ������� �����ϴ� ���
    
    * Ʈ�����
    - �����ͺ��̽��� ���� �������
    - �������� �������(DML)���� �ϳ��� Ʈ����ǿ� ��� ó��
        COMMIT �ϱ� �� ������ �����Ϙ������� �ϳ��� Ʈ����ǿ� ��Ե�
        
    - Ʈ������� ����� �Ǵ� SQL : INSERT, UPDATE, DELETE (DML)
    
    COMMIT (Ʈ����� ����ó�� �� Ȯ��), ROLLBACK (Ʈ����� ���), SAVEPINT (�ӽ�����)
    
    COMMIT ���� : �ϳ��� Ʈ����ǿ� ����ִ� ������׵��� ���� DB�� �ݿ��ϰڵ��� �ǹ�
    ROLLBACK ���� : �ϳ��� Ʈ����ǿ� ����ִ� ������׵��� ������ �� ������ COMMIT �������� ���ư�
    
    SAVEPOINT : �ӽ��������� �����صδ� ��
    
                ROLLBACK ����� ��ü�۾��� �� �����ϴ°� �ƴ� SAVEPOINT������ �Ϻθ� ROLLBACK ����
                
                SAVEPINT ����Ʈ��1;             --������ ����
                ROLLBACK TO ����Ʈ��1;          --�ش� ����Ʈ ���������� Ʈ����Ǹ� �ѹ���
    
*/

SELECT * FROM EMP_01;

DELETE FROM EMP_01
WHERE EMP_ID = 901;

DELETE FROM EMP_01
WHERE EMP_ID = 900;


----------------------------------------------------


--200�� ��� �����
DELETE FROM EMP_01
WHERE EMP_ID = 200;

-- 800, ȫ�浿, �ѹ���, 
INSERT INTO EMP_01 VALUES(800, 'ȫ�浿', '�ѹ���');

COMMIT;

SELECT * FROM EMP_01;

ROLLBACK;
---------------------------------------------------------


DELETE FROM EMP_01
WHERE EMP_ID IN (217, 216, 214);

-- 3���� ���� ������ ������ SAVEPOINT ����
SAVEPOINT SP1;

INSERT INTO EMP_01 VALUES(801, '�踻��', '�λ��');

DELETE FROM EMP_01 WHERE EMP_ID = 218;

ROLLBACK TO SP1;
COMMIT;

DELETE FROM EMP_01
WHERE EMP_ID IN (900, 901);

DELETE FROM EMP_01
WHERE EMP_ID = 218;

-- ���̺� ���� (DDL)
CREATE TABLE TEST (
    TID NUMBER
);

--> DDL ����(CREATE, ALTER, DROP)�� �����ϴ� ���� ������ Ʈ����ǿ� �ִ� ������׵��� ������ ���� DB�� �ݿ��ع���(COMMIT ���ѹ���)

ROLLBACK;
SELECT * FROM EMP_01;