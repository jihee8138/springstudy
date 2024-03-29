DROP SEQUENCE USER_SEQ;
DROP SEQUENCE ACCESS_HISTORY_SEQ;
DROP SEQUENCE LEAVE_USER_SEQ;

CREATE SEQUENCE USER_SEQ;
CREATE SEQUENCE ACCESS_HISTORY_SEQ;
CREATE SEQUENCE LEAVE_USER_SEQ;


DROP TABLE LEAVE_USER_T;
DROP TABLE ACCESS_HISTORY_T;
DROP TABLE USER_T;

CREATE TABLE USER_T (
    /* 회원번호(PK) */                  USER_NO      NUMBER            NOT NULL,
    /* 이메일(인증수단) */              EMAIL        VARCHAR2(100 BYTE) NOT NULL UNIQUE,
    /* 암호화(SHA-256) */               PW           VARCHAR2(64 BYTE),
    /* 이름 */                          NAME         VARCHAR2(100 BYTE),
    /* 성별 */                          GENDER       VARCHAR2(5 BYTE),
    /* 휴대전화 */                      MOBILE       VARCHAR2(20 BYTE),
    /* 이벤트 동의여부(0, 1) */         EVENT_AGREE  NUMBER,
    /* 가입 형태(0: 직접, 1: 네이버) */ SIGNUP_KIND  NUMBER,
    /* 비밀번호 수정일 */               PW_MODIFY_DT DATE,
    /* 가입일 */                        SIGNUP_DT DATE,
    CONSTRAINT PK_USER PRIMARY KEY(USER_NO)
);

CREATE TABLE ACCESS_HISTORY_T (
    ACCESS_HISTORY_NO NUMBER NOT NULL,
    EMAIL             VARCHAR2(100 BYTE),
    IP                VARCHAR2(50 BYTE),
    SIGNIN_DT         DATE,
    SINGOUT_DT        DATE,
    CONSTRAINT PK_ACCESS_HISTORY PRIMARY KEY (ACCESS_HISTORY_NO),
    CONSTRAINT FK_ACCESS_HISTORY_USER
        FOREIGN KEY(EMAIL)
            REFERENCES USER_T(EMAIL)
                ON DELETE CASCADE
);

CREATE TABLE LEAVE_USER_T (
    LEAVE_USER_NO NUMBER             NOT NULL,
    EMAIL         VARCHAR2(100 BYTE) NOT NULL UNIQUE,
    LEAVE_DT DATE,
    CONSTRAINT PK_LEAVE_USER PRIMARY KEY(LEAVE_USER_NO)
);
