DROP TABLE IF EXISTS informationTags;
DROP TABLE IF EXISTS information;
DROP TABLE IF EXISTS tag;

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
