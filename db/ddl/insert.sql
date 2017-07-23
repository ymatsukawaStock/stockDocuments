INSERT INTO information
  (subject, detail, created, updated)
VALUES
  ('sample', 'hello world some what', NOW(), NOW());

INSERT INTO information
  (subject, detail, created, updated)
VALUES
  ('whoa', 'hello world some what', NOW(), NOW());

INSERT INTO tag
  (name, created)
VALUES
  ('some', NOW()),
  ('what', NOW());

INSERT INTO informationTags
  (informationid, tagid)
VALUES
  (
    (SELECT informationid from information order by informationid desc LIMIT 1), -- 2
    (SELECT tagid from tag order by tagid desc LIMIT 1) -- 2
  ),
  (
    (SELECT informationid from information order by informationid desc LIMIT 1), -- 2
    (SELECT tagid from tag order by tagid desc LIMIT 1) - 1 -- 1
  );

INSERT INTO tag
  (name, created)
VALUES
  ('else', NOW());

INSERT INTO informationTags
  (informationid, tagid)
VALUES
  (
    (SELECT informationid from information order by informationid desc LIMIT 1) - 1, -- 1
    (SELECT tagid from tag order by tagid desc LIMIT 1) -- 3
  );
