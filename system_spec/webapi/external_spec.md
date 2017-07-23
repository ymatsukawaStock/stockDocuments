# External Design Stock API Version Beta

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->


- [About API Convention](#about-api-convention)
  - [Request type](#request-type)
  - [Response type](#response-type)
  - [Error Response](#error-response)
- [About Information](#about-information)
  - [GET information list](#get-information-list)
    - [Request](#request)
    - [Constraint](#constraint)
    - [Example](#example)
    - [Response](#response)
      - [200](#200)
      - [404](#404)
  - [GET information detail](#get-information-detail)
    - [Request](#request-1)
    - [Constraint](#constraint-1)
    - [Example](#example-1)
    - [Response](#response-1)
      - [200](#200-1)
      - [404](#404-1)
  - [POST crate information](#post-crate-information)
    - [Request](#request-2)
    - [Constraint](#constraint-2)
    - [Example](#example-2)
    - [Response](#response-2)
      - [201](#201)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## About API Convention

### Request type

GET is allowed ```application/x-www-form-url-encoded``` or ```application/json```.

POST is only allowed ```application/json```

### Response type

Only ```application/json``` is produced.

### Error Response

When requested path and query does not exist in api resource,

404 response is returned.

```
{"message":"Not Found", "statusCode": 404}
```

When requested legal path and query but response is illegal,

500 response should be returned. If api does not seem to recover after a waiting, contact to ....

```
{"message":"Internal Server Error", "statusCode": 500}
```

## About Information

Operations about information.

### GET information list

#### Request

```
/information?limit={limit}&tag={tag}?&sort={sort}&sortBy={sortBy}
```

#### Constraint

about query

|name|required|default value<br />(passed value when not specified)|constraint|description|note|
|--|--|--|--|--|--|
|limit|YES|-|-|Limit of how many get info. If number is over registered info,<br /> all data is returned.|-|
|tag|NO|""|Comma separated word; means multiple tag,<br />single word or blank("")|Tag(s) which information have.|Multiple tags are used "and search" when finding information.|
|sort|NO|"created"|"created" or "updated"<br />If not passed them, api considered "created" is passed.|Data what to sort.|-|
|sortBy|NO|"desc"|"asc" or "desc"<br />If not passed them, api considered "desc" is passed.|Data how to sort.|-|

#### Example

**Plan A.** "Get latest created 10 information. Do not think about tag."

```
GET /information?limit=10
```

or

```
GET /information?sortBy=created
```

**Plan B.** "Get latest updated 5 information. The information has 'api'."

```
GET /information?limit=10&tag=api&sort=updated
```

or

```
GET /information?limit=10&tag=api&sort=updated&sortBy=asc
```

**PlanB.** "Get old updated 5 information. Tag is 'api' and 'document'."

```
GET /information?limit=5&tag=api,document&sort=updated&sortBy=asc
```

#### Response

##### 200

Found information.

```
{
  "statusCode": 200,
  "information": [
    {
      "infoId":7,
      "subject":"knowledge of apidoc",
      "tag": {
        "name":["api", "document"]
      }
      "created":"2017-03-01-00-00",
      "updated":"2017-01-01-00-00"
    },
    {
      "infoId":6,
      "subject":"apidoc ver2",
      "tag": {
        "name":["api"]
      }
      "created":"2017-02-01-12-00",
      "updated":"2017-02-01-12-00"
    }
  ]
}
```

##### 404

Not found any information.

```
{
  "statusCode": 404
}
```


### GET information detail

#### Request

```
/information/{id}
```

#### Constraint

about path parameter

|name|constraint|description|note|
|--|--|--|--|--|
|{id}|Number. 1 to 2^32.|The data identifies information only one.|If number is out of 1 to 2^32, 404 response is returned.|

#### Example

**Plan A.** "Get information of id = 2."

```
GET /information/2
```

#### Response

##### 200

Found information.

```
{
  "statusCode": 200,
  "information": {
    "infoId":7,
    "subject":"knowledge of apidoc",
    "detail":"when write apidoc, blah blah.",
    "tag":"api,document",
    "created":"2017-03-01-00-00",
    "updated":"2017-01-01-00-00"
  }
}
```

##### 404

Not found any information.

```
{
  "statusCode": 404
}
```


### POST crate information

#### Request

```
/information/create
```

```
{
  "information": {
    "subject":"note of feature 1 creation",
    "detail":"when create feature 1, see feature 3.\nand..."
  },
  "tag": {
    "name":"api,document"
  }
}
```

#### Constraint

about request body

|name|constraint|description|note|
|--|--|--|--|--|
|subject|pass string. null, number, boolean and another type is not permitted.|Information's subject.|-|
|detail|pass string. null, number, boolean and another type is not permitted.|Information's detail.|-|
|subject|pass string. null, number, boolean and another type is not permitted.<br />String should be blank, single word or comma separated.|Information's tag.|-|

#### Example

**Plan A.** "Register no tagged information"

```
POST /information/create

{
  "information": {
    "subject":"note of feature 1 creation",
    "detail":"when create feature 1, see feature 3.\nand..."
  },
  "tag": {
    "name":""
  }
}
```

**Plan B.** "Register information tag is only one."

```
POST /information/create

{
  "information": {
    "subject":"note of feature 1 creation",
    "detail":"when create feature 1, see feature 3.\nand..."
  },
  "tag": {
    "name":"api"
  }
}
```

**Plan B.** "Register information with two tags."

```
POST /information/create

{
  "information": {
    "subject":"note of feature 1 creation",
    "detail":"when create feature 1, see feature 3.\nand..."
  },
  "tag": {
    "name":"api,document"
  }
}
```

#### Response

##### 201

Information was created.

```
{
  "statusCode": 201,
  "location": "/information/8"
}
```

---

spec change point

* constnize literal
* re-check commonize error handle > put message; reason



document change point

divide response header

{
  "information": {
    "subject": "foo", << infor.save << inforgtag.save
    "detail": "bar", << infor.save << infotag.save
    tag: ["foo", "bar"] << infotag.save
  }
  addedTag: ["bar"] << tag.save
}
