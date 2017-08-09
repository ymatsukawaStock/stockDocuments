DROP TABLE IF EXISTS informationTags;
DROP TABLE IF EXISTS information;
DROP TABLE IF EXISTS tag;
DROP VIEW IF EXISTS viewInformationTags;

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

CREATE TABLE informationTags (
  informationid BIGINT
    NOT NULL,
  tagid BIGINT
    NOT NULL,
  PRIMARY KEY(informationid, tagid),
  FOREIGN KEY(informationid) REFERENCES information(informationid),
  FOREIGN KEY(tagid) REFERENCES tag(tagid)
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