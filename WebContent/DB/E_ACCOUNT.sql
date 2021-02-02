select * from tab;
select * from E_ACCOUNT;
drop table E_ACCOUNT;
drop sequence seq_aidx;

create sequence seq_aidx  nocache nocycle;
CREATE TABLE E_ACCOUNT(
    aIDX NUMBER(5) PRIMARY KEY, --예약번호
    mIDX NUMBER(5), --회원번호
    hIDX NUMBER(5), --숙소번호
    
    aCHECKIN VARCHAR2(100), --입실일
    aCHECKOUT VARCHAR2(100), --퇴실일
    aPERSON NUMBER(2), --인원
    
    aPRICE NUMBER(10), --결제금액
    aSTATE VARCHAR2(20) DEFAULT '대기중', --결제상태 (대기중/승인완료/승인거절)
    aCARD VARCHAR2(20), --카드회사
    
    aCARDNUM VARCHAR2(20), --카드번호
    aEXDATE VARCHAR2(20), --카드만료일
    aCVV VARCHAR2(20), --cvv번호
    
    aPOSTNUM VARCHAR2(20), --우편번호
    aAREA VARCHAR2(20), --지역
    aDATE  DATE DEFAULT SYSDATE --예약신청날짜
);

truncate table E_ACCOUNT;

INSERT INTO E_ACCOUNT(aIDX, mIDX, hIDX, aCHECKIN, aCHECKOUT, aPERSON, aPRICE, aCARD, aCARDNUM, aEXDATE, aCVV, aPOSTNUM, aAREA) 
VALUES(seq_aidx.nextval, 1, 1, '2020-12-20', '2020-12-24', 3, 360000, 'sol', '123123123', '23/08', '123', '123', '서울')
INSERT INTO E_ACCOUNT(aIDX, mIDX, hIDX, aCHECKIN, aCHECKOUT, aPERSON, aPRICE, aCARD, aCARDNUM, aEXDATE, aCVV, aPOSTNUM, aAREA) 
VALUES(seq_aidx.nextval, 2, 1, '2020-12-20', '2020-12-24', 3, 360000, 'sol', '123123123', '23/08', '123', '123', '서울')

SELECT A.aIDX, A.mIDX, A.aSTATE, A.aAREA, A.aCHECKIN, A.aCHECKOUT, B.hNAME
FROM E_ACCOUNT A
JOIN E_HOUSE B
ON A.hIDX=B.hIDX
AND A.mIDX ='1'

SELECT A.userID,
	B.aIDX,
	B.aDATE,
	B.aCHECKIN,
	B.aCHECKOUT,
	B.aPERSON,
	B.aPRICE,
	C.hIMAGE,
	C.hNAME 
FROM E_USER A
INNER JOIN E_ACCOUNT B
	ON A.uIDX = B.mIDX
INNER JOIN E_HOUSE C
	ON B.hIDX = C.hIDX
WHERE C.mIDX = '1' AND B.aSTATE LIKE '대기중'

UPDATE E_ACCOUNT
SET aSTATE='승인완료'
WHERE aIDX='1'

SELECT A.aSTATE
FROM E_ACCOUNT A
INNER JOIN E_HOUSE B
	ON A.hIDX = B.hIDX
WHERE B.mIDX LIKE '1'