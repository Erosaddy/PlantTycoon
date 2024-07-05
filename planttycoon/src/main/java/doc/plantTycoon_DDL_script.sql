
/* Drop Tables */

DROP TABLE authority CASCADE CONSTRAINTS;
DROP TABLE memberAuthority CASCADE CONSTRAINTS;
DROP TABLE journal CASCADE CONSTRAINTS;
DROP TABLE control CASCADE CONSTRAINTS;
DROP TABLE measurement CASCADE CONSTRAINTS;
DROP TABLE notice CASCADE CONSTRAINTS;
DROP TABLE wateringRecord CASCADE CONSTRAINTS;
DROP TABLE persistent_logins CASCADE CONSTRAINTS;
DROP TABLE member CASCADE CONSTRAINTS;



/* Create Tables */


CREATE TABLE authority
(
	authority varchar2(100),
	CONSTRAINT authority_authority_PK PRIMARY KEY (authority)
);


CREATE TABLE journal
(
	journalId number(10,0),
	journalTitle varchar2(100) NOT NULL,
	journalContent clob NOT NULL,
	memberId varchar2(100) NOT NULL,
	journalRegdate date DEFAULT SYSDATE NOT NULL,
	CONSTRAINT journal_journalId_PK PRIMARY KEY (journalId)
);


CREATE TABLE control
(
	ledId number(10,0),
	ledStatus varchar2(1) DEFAULT 'F' NOT NULL,
	memberId varchar2(100) NOT NULL,
	wateringInterval number(3,0) DEFAULT 7 NOT NULL,
	CONSTRAINT Control_ledId_PK PRIMARY KEY (ledId)
);


CREATE TABLE measurement
(
	measurementId number(10,0),
	memberId varchar2(100) NOT NULL,
	temperature number(4,1),
	humidity number(4,1),
	illuminance number(4,0),
	soilMoisture number(4,0),
	measurementRegdate date DEFAULT SYSDATE NOT NULL,
	CONSTRAINT measurement_measurementId_PK PRIMARY KEY (measurementId)
);


CREATE TABLE member
(
	memberId varchar2(100),
	memberPw varchar2(300) NOT NULL,
	nickname varchar2(100) NOT NULL,
	enabled char DEFAULT '1' NOT NULL,
	lastLogin date DEFAULT SYSDATE NOT NULL,
    regDate date DEFAULT SYSDATE NOT NULL,
    plant varchar2(100),
	CONSTRAINT member_memberId_PK PRIMARY KEY (memberId)
);


CREATE TABLE memberAuthority
(
	memberAuthorityId number(10,0),
	memberId varchar2(100) NOT NULL,
	authority varchar2(100) DEFAULT 'ROLE_MEMBER' NOT NULL,
	CONSTRAINT memberAuthority_memberAuthorityId_PK PRIMARY KEY (memberAuthorityId)
);


CREATE TABLE notice
(
	noticeId number(10,0),
	noticeTitle varchar2(100) NOT NULL,
	noticeContent clob NOT NULL,
	memberId varchar2(100) NOT NULL,
	regdate date DEFAULT SYSDATE NOT NULL,
	CONSTRAINT notice_noticeId_PK PRIMARY KEY (noticeId)
);


CREATE TABLE wateringRecord
(
	recordId number(10,0),
	wateredRegdate date DEFAULT SYSDATE NOT NULL,
	wateringType varchar2(6) NOT NULL,
	memberId varchar2(100) NOT NULL,
	CONSTRAINT wateringRecord_recordId_PK PRIMARY KEY (recordId)
);


CREATE TABLE persistent_logins (
    username    VARCHAR2(64) NOT NULL,
    series      VARCHAR2(64) PRIMARY KEY,
    token       VARCHAR2(64) NOT NULL,
    last_used   TIMESTAMP NOT NULL
);



/* Create Foreign Keys */

ALTER TABLE memberAuthority
ADD CONSTRAINT memberAuthority_authority_authority_FK
FOREIGN KEY (authority)
REFERENCES authority (authority)
ON DELETE CASCADE;

ALTER TABLE journal
ADD CONSTRAINT journal_member_memberId_FK
FOREIGN KEY (memberId)
REFERENCES member (memberId)
ON DELETE CASCADE;

ALTER TABLE Control
ADD CONSTRAINT Control_member_memberId_FK
FOREIGN KEY (memberId)
REFERENCES member (memberId)
ON DELETE CASCADE;

ALTER TABLE measurement
ADD CONSTRAINT measurement_member_memberId_FK
FOREIGN KEY (memberId)
REFERENCES member (memberId)
ON DELETE CASCADE;

ALTER TABLE memberAuthority
ADD CONSTRAINT memberAuthority_member_memberId_FK
FOREIGN KEY (memberId)
REFERENCES member (memberId)
ON DELETE CASCADE;

ALTER TABLE notice
ADD CONSTRAINT notice_member_memberId_FK
FOREIGN KEY (memberId)
REFERENCES member (memberId)
ON DELETE CASCADE;

ALTER TABLE wateringRecord
ADD CONSTRAINT wateringRecord_member_memberId_FK
FOREIGN KEY (memberId)
REFERENCES member (memberId)
ON DELETE CASCADE;


/* 시퀀스 삭제 및 생성 */

DROP SEQUENCE memberAuthority_seq;
DROP SEQUENCE journal_seq;
DROP SEQUENCE notice_seq;
DROP SEQUENCE control_seq;
DROP SEQUENCE measurement_seq;
DROP SEQUENCE wateringRecord_seq;

CREATE SEQUENCE memberAuthority_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE;

CREATE SEQUENCE journal_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE;

CREATE SEQUENCE notice_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE;

CREATE SEQUENCE control_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE;

CREATE SEQUENCE measurement_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE;

CREATE SEQUENCE wateringRecord_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE;

/* 권한 종류 설정 */

INSERT INTO authority
VALUES('ROLE_MEMBER');

INSERT INTO authority
VALUES('ROLE_ADMIN');

COMMIT;
