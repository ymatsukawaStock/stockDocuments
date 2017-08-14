INSERT INTO account
  (email, name, password, created, updated)
VALUES
  ('ex@example.com', 'ymatsukawa', 'ex', NOW(), NOW());

INSERT INTO authenticate
  (token, created)
VALUES
  ('ex', NOW());

INSERT INTO accountauthenticate
  (accountid, authenticateid)
VALUES
  (
    (SELECT accountid from account order by accountid desc LIMIT 1),
    (SELECT authenticateid from authenticate order by authenticateid desc LIMIT 1)
  );

INSERT INTO information
  (subject, detail, created, updated)
VALUES
  ('sample', 'hello world some what', NOW(), NOW());

INSERT INTO information
  (subject, detail, created, updated)
VALUES
  ('whoa', 'hello world some what', NOW(), NOW());

INSERT INTO accountinformation
  (accountid, informationid)
VALUES
  (
    (SELECT accountid from account order by accountid desc LIMIT 1),
    (SELECT informationid from information order by informationid desc LIMIT 1)
  ),
  (
    (SELECT accountid from account order by accountid desc LIMIT 1), -- 1
    (SELECT informationid from information order by informationid desc LIMIT 1) - 1 -- 1
  );

INSERT INTO tag
  (name, created)
VALUES
  ('some', NOW()),
  ('what', NOW());

INSERT INTO informationTags
  (informationid, tagid)
VALUES
  (
    (SELECT informationid from information order by informationid desc LIMIT 1), -- 1
    (SELECT tagid from tag order by tagid desc LIMIT 1) -- 2
  ),
  (
    (SELECT informationid from information order by informationid desc LIMIT 1), -- 1
    (SELECT tagid from tag order by tagid desc LIMIT 1) - 1 -- 1
  );

INSERT INTO tag
  (name, created)
VALUES
  ('else', NOW());

INSERT INTO informationtags
  (informationid, tagid)
VALUES
  (
    (SELECT informationid from information order by informationid desc LIMIT 1) - 1, -- 1
    (SELECT tagid from tag order by tagid desc LIMIT 1) -- 3
  );

INSERT INTO accounttags
  (accountid, tagid)
VALUES
  (
    (SELECT accountid from account order by accountid desc LIMIT 1),
    (SELECT tagid from tag order by tagid desc LIMIT 1) -- 3
  ),
  (
    (SELECT accountid from account order by accountid desc LIMIT 1),
    (SELECT tagid from tag order by tagid desc LIMIT 1) - 1 -- 2
  ),
  (
    (SELECT accountid from account order by accountid desc LIMIT 1),
    (SELECT tagid from tag order by tagid desc LIMIT 1) - 2 -- 1
  );
