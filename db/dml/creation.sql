DROP VIEW IF EXISTS viewAccountWithAuthentication;
DROP TABLE IF EXISTS accountauthenticate;
DROP TABLE IF EXISTS authenticate;
DROP TABLE IF EXISTS accounttags;
DROP TABLE IF EXISTS accountinformation;
DROP TABLE IF EXISTS account;

DROP VIEW IF EXISTS viewinformationtags;
DROP TABLE IF EXISTS informationtags;
DROP TABLE IF EXISTS information;
DROP TABLE IF EXISTS tag;
DROP VIEW IF EXISTS viewInformationTags;

CREATE TABLE account (
  accountid BIGSERIAL
    NOT NULL,
  email VARCHAR(255)
    NOT NULL,
  name VARCHAR(255)
    NOT NULL,
  password VARCHAR(255)
    NOT NULL,
  created TIMESTAMP
    NOT NULL,
  updated TIMESTAMP
    NOT NULL,
  PRIMARY KEY(accountid),
  UNIQUE(email),
  UNIQUE(name)
);

CREATE TABLE authenticate (
  authenticateid BIGSERIAL
    NOT NULL,
  token VARCHAR(255)
    NOT NULL,
  created TIMESTAMP
    NOT NULL,
  -- NO updated because token is creation only.
  PRIMARY KEY(authenticateid),
  UNIQUE(token)
);

CREATE TABLE accountauthenticate (
  accountid BIGINT
    NOT NULL,
  authenticateid BIGINT
    NOT NULL,
  FOREIGN KEY(accountid) REFERENCES account(accountid),
  FOREIGN KEY(authenticateid) REFERENCES authenticate(authenticateid)
);

CREATE TABLE information (
  informationid BIGSERIAL
    NOT NULL,
  subject VARCHAR(255)
    NOT NULL DEFAULT '',
  detail TEXT
    NOT NULL DEFAULT '',
  created TIMESTAMP
    NOT NULL,
  updated TIMESTAMP
    NOT NULL,
  PRIMARY KEY(informationid)
);

CREATE TABLE tag (
  tagid BIGSERIAL,
  name VARCHAR(255)
    NOT NULL DEFAULT '',
  PRIMARY KEY (tagid),
  created TIMESTAMP
    NOT NULL,
  -- NO updated date because tag should be created only.
  UNIQUE(name)
);

CREATE TABLE informationtags (
  informationid BIGINT
    NOT NULL,
  tagid BIGINT
    NOT NULL,
  PRIMARY KEY(informationid, tagid),
  FOREIGN KEY(informationid) REFERENCES information (informationid),
  FOREIGN KEY(tagid) REFERENCES tag (tagid)
);

CREATE TABLE accountinformation (
  accountid BIGINT
    NOT NULL,
  informationid BIGINT
    NOT NULL,
  PRIMARY KEY(accountid, informationid),
  FOREIGN KEY(informationid) REFERENCES information (informationid),
  FOREIGN KEY(accountid) REFERENCES account (accountid)
);

CREATE TABLE accounttags (
  accountid BIGINT
    NOT NULL,
  tagid BIGINT
    NOT NULL,
  PRIMARY KEY(accountid, tagid),
  FOREIGN KEY(accountid) REFERENCES account (accountid),
  FOREIGN KEY(tagid) REFERENCES tag (tagid)
);

CREATE VIEW viewInformationTags
AS
SELECT
  INFO.informationid,
  INFO.subject,
  INFO.detail,
  INFO.created,
  INFO.updated,
  TAG.name
FROM
  information AS INFO
INNER JOIN
  informationtags AS INFOTAG
ON
  INFO.informationid = INFOTAG.informationid
INNER JOIN
  tag AS TAG
ON
  TAG.tagid = INFOTAG.tagid;

CREATE VIEW viewAccountWithAuthentication
AS
SELECT
  ACCOUNT.accountid,
  AUTHN.token
from
  account AS ACCOUNT
INNER JOIN
  accountauthenticate AS ACAUTHN
ON
  ACCOUNT.accountid = ACAUTHN.accountid
INNER JOIN
  authenticate AS AUTHN
ON
  ACAUTHN.authenticateid = AUTHN.authenticateid;
