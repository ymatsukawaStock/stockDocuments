SELECT
  *
FROM
  information;

SELECT
  *
FROM
  tag;

SELECT
  *
FROM
  informationtags;

SELECT
  informationid
FROM
  informationtags AS INFOTAG
WHERE
  INFOTAG.tagid IN (4, 6) -- change OR, and 'name'
GROUP BY
  informationid
HAVING
  COUNT(informationid) = (SELECT COUNT(*) FROM tag WHERE tagid IN(4, 6));
  -- SELECT COUNT(*) FROM tag WHERE tagid IN (...) => tag.size()
