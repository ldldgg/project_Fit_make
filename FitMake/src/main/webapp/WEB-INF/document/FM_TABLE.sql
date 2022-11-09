
/* Drop Tables */

DROP TABLE FM_BMI_STANDARD CASCADE CONSTRAINTS;
DROP TABLE FM_CALORY_STANDARD CASCADE CONSTRAINTS;
DROP TABLE FM_ORDER_DETAIL CASCADE CONSTRAINTS;
DROP TABLE FM_CART CASCADE CONSTRAINTS;
DROP TABLE FM_RECOMMAND CASCADE CONSTRAINTS;
DROP TABLE FM_REPLY CASCADE CONSTRAINTS;
DROP TABLE FM_REVIEW CASCADE CONSTRAINTS;
DROP TABLE FM_ITEM CASCADE CONSTRAINTS;
DROP TABLE FM_CATEGORY CASCADE CONSTRAINTS;
DROP TABLE FM_ORDER CASCADE CONSTRAINTS;
DROP TABLE FM_USER_BMI CASCADE CONSTRAINTS;
DROP TABLE FM_USER CASCADE CONSTRAINTS;



/* Drop Sequences */
-- 시퀀스명이 길어 생성이 안되는 오류가 있어서 일관성을 위해 테이블명을 일괄 삭제함

DROP SEQUENCE SEQ_FM_CART_NO;
DROP SEQUENCE SEQ_FM_CATEGORY_NO;
DROP SEQUENCE SEQ_FM_ITEM_NO;
DROP SEQUENCE SEQ_FM_ORDER_DETAIL_NO;
DROP SEQUENCE SEQ_FM_ORDER_NO;
DROP SEQUENCE SEQ_FM_REPLY_NO;
DROP SEQUENCE SEQ_FM_REVIEW_NO;
DROP SEQUENCE SEQ_FM_USER_NO;




/* Create Sequences */

CREATE SEQUENCE SEQ_FM_CART_NO INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_FM_CATEGORY_NO INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_FM_ITEM_NO INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_FM_ORDER_DETAIL_NO INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_FM_ORDER_NO INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_FM_REPLY_NO INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_FM_REVIEW_NO INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_FM_USER_NO INCREMENT BY 1 START WITH 1;



/* Create Tables */

CREATE TABLE FM_BMI_STANDARD
(
	FM_BMI_GRADE number NOT NULL,
	FM_BMI_MIN float NOT NULL,
	FM_BMI_MAX float NOT NULL,
	CONSTRAINT FM_BMI_GRADE_U UNIQUE (FM_BMI_GRADE)
);


CREATE TABLE FM_CALORY_STANDARD
(
	FM_CALORY_GRADE number NOT NULL,
	FM_CALORY_MIN float NOT NULL,
	FM_CALORY_MAX float NOT NULL,
	CONSTRAINT FM_CALORY_GRADE_U UNIQUE (FM_CALORY_GRADE)
);


CREATE TABLE FM_CART
(
	FM_CART_NO number NOT NULL,
	FM_ITEM_NO number NOT NULL,
	FM_USER_NO number NOT NULL,
	FM_CART_COUNT number NOT NULL,
	CONSTRAINT FM_CART_NO_PK PRIMARY KEY (FM_CART_NO)
);


CREATE TABLE FM_CATEGORY
(
	FM_CATEGORY_NO number NOT NULL,
	FM_CATEGORY_NAME varchar2(30) NOT NULL,
	FM_PARENT_CATEGORY_NO number,
	CONSTRAINT FM_CATEGORY_NO_PK PRIMARY KEY (FM_CATEGORY_NO),
	CONSTRAINT CATEGORY_CATEGORY_NAME_U UNIQUE (FM_CATEGORY_NAME)
);


CREATE TABLE FM_ITEM
(
	FM_ITEM_NO number NOT NULL,
	FM_CATEGORY_NO number NOT NULL,
	FM_ITEM_NAME varchar2(100) NOT NULL,
	FM_ITEM_CALORY varchar2(300) NOT NULL,
	FM_ITEM_RAWPRICE number NOT NULL,
	FM_ITEM_SELLPRICE number NOT NULL,
	FM_ITEM_COUNT number NOT NULL,
	FM_ITEM_THUMBNAIL varchar2(4000) NOT NULL,
	FM_ITEM_DETAIL varchar2(4000) NOT NULL,
	FM_CALORY_GRADE number NOT NULL,
	CONSTRAINT FM_ITEM_NO_PK PRIMARY KEY (FM_ITEM_NO)
);


CREATE TABLE FM_ORDER
(
	FM_ORDER_NO number NOT NULL,
	FM_USER_NO number NOT NULL,
	FM_ORDER_DATE date NOT NULL,
	FM_ORDER_STATUS varchar2(30) NOT NULL,
	CONSTRAINT FM_ORDER_NO_PK PRIMARY KEY (FM_ORDER_NO)
);


CREATE TABLE FM_ORDER_DETAIL
(
	FM_ORDER_DETAIL_NO number NOT NULL,
	FM_ORDER_NO number NOT NULL,
	FM_ITEM_NO number NOT NULL,
	FM_CART_NO number,
	FM_ORDER_DETAIL_COUNT number NOT NULL,
	FM_ORDER_DETAIL_PRICE number NOT NULL,
	CONSTRAINT FM_ORDER_DETAIL_NO_PK PRIMARY KEY (FM_ORDER_DETAIL_NO)
);


CREATE TABLE FM_RECOMMAND
(
	FM_ITEM_NO number NOT NULL,
	FM_USER_BMI_NO number NOT NULL
);


CREATE TABLE FM_REPLY
(
	FM_REPLY_NO number NOT NULL,
	FM_REVIEW_NO number NOT NULL,
	FM_USER_NO number NOT NULL,
	FM_REPLY_TITLE varchar2(100) NOT NULL,
	FM_REPLY_CONTENT varchar2(300) NOT NULL,
	FM_REPLY_CRE_DATE date NOT NULL,
	FM_PARENT_REPLY_NO number,
	CONSTRAINT FM_REPLY_NO_PK PRIMARY KEY (FM_REPLY_NO)
);


CREATE TABLE FM_REVIEW
(
	FM_REVIEW_NO number NOT NULL,
	FM_ITEM_NO number NOT NULL,
	FM_USER_NO number NOT NULL,
	FM_REVIEW_TITLE varchar2(100) NOT NULL,
	FM_REVIEW_CONTENT varchar2(300) NOT NULL,
	FM_REVIEW_IMAGE varchar2(4000) NOT NULL,
	FM_REVIEW_CRE_DATE date NOT NULL,
	FM_REVIEW_MOD_DATE date NOT NULL,
	CONSTRAINT FM_REVIEW_NO_PK PRIMARY KEY (FM_REVIEW_NO)
);


CREATE TABLE FM_USER
(
	FM_USER_NO number NOT NULL,
	FM_USER_NICKNAME varchar2(30) NOT NULL,
	FM_USER_EMAIL varchar2(30) NOT NULL,
	FM_USER_PASSWORD varchar2(100) NOT NULL,
	FM_USER_MOBILE varchar2(13) NOT NULL,
	FM_USER_ZIP_CODE varchar2(10) NOT NULL,
	FM_USER_ADDRESS varchar2(300) NOT NULL,
	FM_USER_CRE_DATE date NOT NULL,
	FM_USER_POINT number NOT NULL,
	CONSTRAINT FM_USER_NO_PK PRIMARY KEY (FM_USER_NO),
	CONSTRAINT FM_USER_FM_USER_NICKNAME_U UNIQUE (FM_USER_NICKNAME),
	CONSTRAINT FM_USER_FM_USER_EMAIL_U UNIQUE (FM_USER_EMAIL),
	CONSTRAINT FM_USER_FM_USER_MOBILE_U UNIQUE (FM_USER_MOBILE)
);


CREATE TABLE FM_USER_BMI
(
	FM_USER_BMI_NO number NOT NULL,
	FM_USER_NO number NOT NULL,
	FM_USER_BMI_WEIGHT float NOT NULL,
	FM_USER_BMI_HEIGHT float NOT NULL,
	-- M / F
	FM_USER_BMI_GENDER varchar2(2) NOT NULL,
	FM_USER_BMI_RAW float NOT NULL,
	FM_USER_GOAL_BMI float NOT NULL,
	FM_USER_GOAL_CALORY float NOT NULL,
	CONSTRAINT FM_USER_BMI_NO_PK PRIMARY KEY (FM_USER_BMI_NO)
);



/* Create Foreign Keys */

ALTER TABLE FM_ORDER_DETAIL
	ADD FOREIGN KEY (FM_CART_NO)
	REFERENCES FM_CART (FM_CART_NO)
;


ALTER TABLE FM_ITEM
	ADD FOREIGN KEY (FM_CATEGORY_NO)
	REFERENCES FM_CATEGORY (FM_CATEGORY_NO)
;


ALTER TABLE FM_CART
	ADD FOREIGN KEY (FM_ITEM_NO)
	REFERENCES FM_ITEM (FM_ITEM_NO)
;


ALTER TABLE FM_ORDER_DETAIL
	ADD FOREIGN KEY (FM_ITEM_NO)
	REFERENCES FM_ITEM (FM_ITEM_NO)
;


ALTER TABLE FM_RECOMMAND
	ADD FOREIGN KEY (FM_ITEM_NO)
	REFERENCES FM_ITEM (FM_ITEM_NO)
;


ALTER TABLE FM_REVIEW
	ADD FOREIGN KEY (FM_ITEM_NO)
	REFERENCES FM_ITEM (FM_ITEM_NO)
;


ALTER TABLE FM_ORDER_DETAIL
	ADD FOREIGN KEY (FM_ORDER_NO)
	REFERENCES FM_ORDER (FM_ORDER_NO)
;


ALTER TABLE FM_REPLY
	ADD FOREIGN KEY (FM_REVIEW_NO)
	REFERENCES FM_REVIEW (FM_REVIEW_NO)
;


ALTER TABLE FM_CART
	ADD FOREIGN KEY (FM_USER_NO)
	REFERENCES FM_USER (FM_USER_NO)
;


ALTER TABLE FM_ORDER
	ADD FOREIGN KEY (FM_USER_NO)
	REFERENCES FM_USER (FM_USER_NO)
;


ALTER TABLE FM_REPLY
	ADD FOREIGN KEY (FM_USER_NO)
	REFERENCES FM_USER (FM_USER_NO)
;


ALTER TABLE FM_REVIEW
	ADD FOREIGN KEY (FM_USER_NO)
	REFERENCES FM_USER (FM_USER_NO)
;


ALTER TABLE FM_USER_BMI
	ADD FOREIGN KEY (FM_USER_NO)
	REFERENCES FM_USER (FM_USER_NO)
;


ALTER TABLE FM_RECOMMAND
	ADD FOREIGN KEY (FM_USER_BMI_NO)
	REFERENCES FM_USER_BMI (FM_USER_BMI_NO)
;

COMMIT;