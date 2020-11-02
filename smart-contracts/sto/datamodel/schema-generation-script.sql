-- 테이블 순서는 관계를 고려하여 한 번에 실행해도 에러가 발생하지 않게 정렬되었습니다.

-- account Table Create SQL
CREATE TABLE account
(
    `id`           BIGINT          NOT NULL    AUTO_INCREMENT COMMENT 'ID', 
    `password`     VARCHAR(100)    NOT NULL    COMMENT '비밀번호', 
    `name`         VARCHAR(100)    NOT NULL    COMMENT '이름', 
    `type`         VARCHAR(15)     NOT NULL    COMMENT '유형 (INDIVIDUAL | CORPORATION))', 
    `email`        VARCHAR(256)    NOT NULL    COMMENT 'email 주소', 
    `is_active`    BOOLEAN         NOT NULL    DEFAULT true COMMENT '활성화 여부', 
    `is_admin`     BOOLEAN         NOT NULL    DEFAULT false COMMENT '관리자 여부', 
    `enrolled_at`  DATETIME        NOT NULL    COMMENT '가입일시 (yyyyMMddHHmmss)', 
    `create_date`  DATETIME        NULL        COMMENT '데이터 생성일시', 
    `modify_date`  DATETIME        NULL        COMMENT '데이터 최종수정일시', 
    PRIMARY KEY (id)
);

ALTER TABLE account COMMENT '사용자 계정';


-- account Table Create SQL
CREATE TABLE token
(
    `id`             BIGINT          NOT NULL    AUTO_INCREMENT COMMENT 'ID', 
    `issuer_id`      BIGINT          NOT NULL    COMMENT '발행자 ID', 
    `name`           VARCHAR(100)    NULL        COMMENT '이름', 
    `symbol`         VARCHAR(100)    NULL        COMMENT '기호', 
    `address`        CHAR(40)        NULL        COMMENT 'Contract 주소', 
    `issued_amt`     INT             NULL        COMMENT '발행량', 
    `desc`           TEXT            NULL        COMMENT '설명', 
    `registered_at`  DATETIME        NOT NULL    COMMENT '등록일시', 
    `issued_at`      DATETIME        NULL        COMMENT '발행일시', 
    `create_date`    DATETIME        NULL        COMMENT '데이터 생성일시', 
    `modify_date`    DATETIME        NULL        COMMENT '데이터 최종수정일시', 
    PRIMARY KEY (id)
);

ALTER TABLE token COMMENT 'Security Token';

ALTER TABLE token
    ADD CONSTRAINT FK_token_issuer_id_account_id FOREIGN KEY (issuer_id)
        REFERENCES account (id) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- account Table Create SQL
CREATE TABLE file
(
    `id`            BIGINT           NOT NULL    AUTO_INCREMENT COMMENT 'ID', 
    `file_name`     VARCHAR(200)     NOT NULL    COMMENT '파일명', 
    `file_type`     VARCHAR(50)      NOT NULL    COMMENT '파일 확장자', 
    `dir`           VARCHAR(200)     NULL        COMMENT '파일 위치', 
    `hash`          VARCHAR(100)     NULL        COMMENT 'Hash', 
    `submitter_Id`  BIGINT           NOT NULL    COMMENT '제출자 ID', 
    `title`         VAR'CHAR(100)    NULL        COMMENT '제목', 
    `status`        VARCHAR(15)      NOT NULL    COMMENT '상태 (SUBMITTED | VERIFIED | REJECTED)', 
    `reject_reson`  TEXT             NULL        COMMENT '거부 사유', 
    `submitted_at`  DATETIME         NOT NULL    COMMENT '제출일시', 
    `concluded_at`  DATETIME         NULL        COMMENT '판정일시', 
    `create_date`   DATETIME         NULL        COMMENT '데이터 생성일시', 
    `modify_date`   DATETIME         NULL        COMMENT '데이터 최종수정일시', 
    PRIMARY KEY (id)
);

ALTER TABLE file COMMENT '파일/문서';

ALTER TABLE file
    ADD CONSTRAINT FK_file_submitter_Id_account_id FOREIGN KEY (submitter_Id)
        REFERENCES account (id) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- account Table Create SQL
CREATE TABLE invest
(
    `id`                 BIGINT         NOT NULL    AUTO_INCREMENT COMMENT 'ID', 
    `token_id`           BIGINT         NOT NULL    COMMENT 'Token ID', 
    `investor_id`        BIGINT         NOT NULL    COMMENT '투자자 ID', 
    `offered_amt`        INT            NOT NULL    COMMENT '제안 수량', 
    `min_amt`            INT            NULL        COMMENT '최소 수량', 
    `offered_at`         DATETIME       NOT NULL    COMMENT '제안일시', 
    `expire_at`          DATETIME       NULL        COMMENT '만료일시', 
    `status`             VARCHAR(15)    NOT NULL    COMMENT '상태 (OFFERED | ACCEPTED | APPROVED | SIGNED ...)', 
    `accepted_amt`       INT            NULL        COMMENT '수락 수량', 
    `accepted_at`        DATETIME       NULL        COMMENT '수락일시 (투자자)', 
    `rejected_at`        DATETIME       NULL        COMMENT '거절일시 (투자자)', 
    `reject_reson`       TEXT           NULL        COMMENT '거절 사유 (투자자)', 
    `approved_at`        DATETIME       NULL        COMMENT '승인일시 (발행자)', 
    `disapproved_at`     DATETIME       NULL        COMMENT '거부일시 (발행자)', 
    `disapprove_reason`  TEXT           NULL        COMMENT '거부 사유 (발행자)', 
    `signed_at`          DATETIME       NULL        COMMENT '서명일시 (투자자)', 
    `finalizaed_at`      DATETIME       NULL        COMMENT '완료일시 (발행자)', 
    PRIMARY KEY (id)
);

ALTER TABLE invest COMMENT '투자';

ALTER TABLE invest
    ADD CONSTRAINT FK_invest_token_id_token_id FOREIGN KEY (token_id)
        REFERENCES token (id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE invest
    ADD CONSTRAINT FK_invest_investor_id_account_id FOREIGN KEY (investor_id)
        REFERENCES account (id) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- account Table Create SQL
CREATE TABLE compliance
(
    `id`                BIGINT          NOT NULL    AUTO_INCREMENT COMMENT 'ID', 
    `account_id`        BIGINT          NOT NULL    COMMENT '대상자 ID', 
    `status`            VARCHAR(15)     NOT NULL    COMMENT '상태 (SUBMITTED | SENT | VERIFIED | REJECTED | UPDATED)', 
    `data`              JSON            NOT NULL    COMMENT 'KYC 데이터', 
    `bank`              VARCHAR(100)    NULL        COMMENT '은행', 
    `bank_accnt`        VARCHAR(50)     NULL        COMMENT '은행 계좌', 
    `bank_accnt_owner`  VARCHAR(100)    NULL        COMMENT '은행 계좌주', 
    `result`            JSON            NULL        COMMENT 'KYC 검증 결과', 
    `remarks`           TEXT            NULL        COMMENT '비고', 
    `sent_at`           DATETIME        NULL        COMMENT '검증기관 송신일시', 
    `received_at`       DATETIME        NULL        COMMENT '검증결과 수신일시', 
    `create_date`       DATETIME        NULL        COMMENT '데이터 생성일시', 
    `modify_date`       DATETIME        NULL        COMMENT '데이터 최종수정일시', 
    PRIMARY KEY (id)
);

ALTER TABLE compliance COMMENT 'Compliance including KYC';

ALTER TABLE compliance
    ADD CONSTRAINT FK_compliance_account_id_account_id FOREIGN KEY (account_id)
        REFERENCES account (id) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- account Table Create SQL
CREATE TABLE invest_sign
(
    `id`            BIGINT         NOT NULL    AUTO_INCREMENT COMMENT 'ID', 
    `invest_id`     BIGINT         NOT NULL    COMMENT '투자 ID', 
    `sign_no`       VARCHAR(20)    NOT NULL    COMMENT '서명 번호', 
    `eth_tx_hash`   VARCHAR(34)    NULL        COMMENT 'Ethereum transaction hash (0x...)', 
    `status`        VARCHAR(15)    NOT NULL    COMMENT '상태 (REQUESTED | SIGNED | FAILED)', 
    `input_no`      VARCHAR(20)    NOT NULL    COMMENT '투자자 입력 번호', 
    `file_id`       BIGINT         NULL        COMMENT 'File ID', 
    `requested_at`  DATETIME       NULL        COMMENT '요청일시 (발행자)', 
    `responded_at`  DATETIME       NULL        COMMENT '응답(서명/실패) 일시 (투자자)', 
    PRIMARY KEY (id)
);

ALTER TABLE invest_sign COMMENT '투자 서명';

ALTER TABLE invest_sign
    ADD CONSTRAINT FK_invest_sign_invest_id_invest_id FOREIGN KEY (invest_id)
        REFERENCES invest (id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE invest_sign
    ADD CONSTRAINT FK_invest_sign_file_id_file_id FOREIGN KEY (file_id)
        REFERENCES file (id) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- account Table Create SQL
CREATE TABLE wallet
(
    `id`           BIGINT      NOT NULL    AUTO_INCREMENT COMMENT 'ID', 
    `account_id`   BIGINT      NOT NULL    COMMENT '사용자 ID', 
    `private_key`  CHAR(66)    NOT NULL    COMMENT 'Ethereum 개인 key (0x...)', 
    `address`      CHAR(42)    NOT NULL    COMMENT 'Ethereum account 주소 (0x...)', 
    `is_locked`    BOOLEAN     NULL        DEFAULT false COMMENT '잠김 여부', 
    `open_at`      DATETIME    NULL        COMMENT '생성일시', 
    `create_date`  DATETIME    NULL        COMMENT '데이터 생성일시', 
    `modify_date`  DATETIME    NULL        COMMENT '데이터 최종수정일시', 
    PRIMARY KEY (id)
);

ALTER TABLE wallet COMMENT 'Ethereum 보안 지갑';

ALTER TABLE wallet
    ADD CONSTRAINT FK_wallet_account_id_account_id FOREIGN KEY (account_id)
        REFERENCES account (id) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- account Table Create SQL
CREATE TABLE invitation
(
    `id`             BIGINT          NOT NULL    AUTO_INCREMENT COMMENT 'ID', 
    `invitee_id`     BIGINT          NULL        COMMENT '대상자 ID', 
    `email`          VARCHAR(256)    NOT NULL    COMMENT '대상자 email 주소', 
    `access_token`   VARCHAR(200)    NOT NULL    COMMENT 'Access token', 
    `expire_at`      DATETIME        NULL        COMMENT '만기일시', 
    `type`           VARCHAR(15)     NOT NULL    COMMENT '유형 (ISSUE | INVEST)', 
    `status`         VARCHAR(45)     NOT NULL    COMMENT '상태 (REGISTERED | SENT)', 
    `registered_at`  DATETIME        NOT NULL    COMMENT '등록일시', 
    `sent_at`        DATETIME        NULL        COMMENT '발송일시', 
    `create_date`    DATETIME        NULL        COMMENT '데이터 생성일시', 
    `modify_date`    DATETIME        NULL        COMMENT '데이터 최종수정일시', 
    PRIMARY KEY (id)
);

ALTER TABLE invitation COMMENT '발행/투자 초대';

ALTER TABLE invitation
    ADD CONSTRAINT FK_invitation_invitee_id_account_id FOREIGN KEY (invitee_id)
        REFERENCES account (id) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- account Table Create SQL
CREATE TABLE token_file
(
    `file_id`      BIGINT         NOT NULL    COMMENT 'File ID', 
    `token_id`     BIGINT         NOT NULL    COMMENT 'Token ID', 
    `type`         VARCHAR(50)    NOT NULL    COMMENT '유형', 
    `create_date`  DATETIME       NULL        COMMENT '데이터 생성일시', 
    `modify_date`  DATETIME       NULL        COMMENT '데이터 최종수정일시', 
    PRIMARY KEY (file_id, token_id)
);

ALTER TABLE token_file COMMENT '토큰 관련 문서';

ALTER TABLE token_file
    ADD CONSTRAINT FK_token_file_file_id_file_id FOREIGN KEY (file_id)
        REFERENCES file (id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE token_file
    ADD CONSTRAINT FK_token_file_token_id_token_id FOREIGN KEY (token_id)
        REFERENCES token (id) ON DELETE RESTRICT ON UPDATE RESTRICT;


