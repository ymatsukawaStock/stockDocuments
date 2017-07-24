# External Design Stock API Version Beta

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->


- [About API Convention](#about-api-convention)
  - [Request type](#request-type)
  - [Response type](#response-type)
  - [Error Response](#error-response)
    - [400](#400)
    - [404](#404)
    - [500](#500)
- [Resource "Information"](#resource-information)
  - [GET information subject](#get-information-subject)
    - [Request](#request)
    - [Constraint](#constraint)
    - [Example](#example)
    - [Response](#response)
      - [200](#200)
      - [404](#404-1)
  - [GET information detail](#get-information-detail)
    - [Request](#request-1)
    - [Constraint](#constraint-1)
    - [Example](#example-1)
    - [Response](#response-1)
      - [200](#200-1)
      - [404](#404-2)
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

POST is only allowed ```application/json```.

### Response type

Only ```application/json``` is produced.

### Error Response

#### 400

When requested exist resource, but parameter's key or value is invalid.

```
HTTP/1.1 400 Bad Request
{"message":"Bad Request", "reason":["xyz is blank"]}
```

#### 404

When requested not exist resource.

```
HTTP/1.1 404 Not Found
{"message":"location /xyz?abc=def is Not Found"}
```

#### 500

When requested exist resource, but server happened error.

If api does not seem to recover after a minue, contact to ....

```
HTTP/1.1 500 Internal Server Error
{"message":"wait a moment and try again."}
```

## Resource "Information"

### GET information subject

#### Request

```
/information?limit={limit}&tag={tag}?&sort={sort}&sortBy={sortBy}
```

#### Constraint

|name|required|default value<br />(passed value when not specified)|constraint|description|note|
|--|--|--|--|--|--|
|limit|YES|-|-|Limit of how many get info. If number is over registered info,<br /> all data is returned.|-|
|tag|NO|""|Comma separated word; means multiple tag,<br />single word or blank("")|Tag(s) which information have.|Multiple tags are used "and search" when finding information.|
|sort|NO|"created"|"created" or "updated"<br />If not passed them, api considered "created" is passed.|Data what to sort.|-|
|sortBy|NO|"desc"|"asc" or "desc"<br />If not passed them, api considered "desc" is passed.|Data how to sort.|-|

#### Example

**Plan A.** ```"Get latest created 10 information. Do not think about tag."```

```
GET /information?limit=10
```

or

```
GET /information?sortBy=created
```

**Plan B.** ```"Get latest updated 5 information. The information has 'api'."```

```
GET /information?limit=10&tag=api&sort=updated
```

or

```
GET /information?limit=10&tag=api&sort=updated&sortBy=asc
```

**PlanC.** ```"Get old updated 5 information. Tag is 'api' and 'document'."```

```
GET /information?limit=5&tag=api,document&sort=updated&sortBy=asc
```

#### Response

##### 200

When information exist.

```
HTTP/1.1 200 OK
{
  "information": [
    {
      "infomationId":7,
      "subject":"knowledge of apidoc",
      "tag": {
        "name":["api", "document"]
      }
      "created":"2017-03-01-00-00",
      "updated":"2017-01-01-00-00"
    },
    {
      "infomationId":6,
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

When information does not exist.

```
HTTP/1.1 404 Not Found
{"message":"information does not found"}
```


### GET information detail

#### Request

```
/information/{id}
```

#### Constraint

|name|constraint|description|note|
|--|--|--|--|
|{id}|Number. 1 to 2^32.|The data identifies information only one.|If number is out of 1 to 2^32, 404 response is returned.|

#### Example

**Plan A.** ```"Get information of id = 2."```

```
GET /information/2
```

#### Response

##### 200

When information eixst.

```
HTTP/1.1 200 OK
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

When information does not exist.

```
HTTP/1.1 404 OK
{ "message":"information not found" }
```


### POST crate information

#### Request

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

#### Constraint

|name|constraint|description|note|
|--|--|--|--|
|subject|pass string. null, number, boolean and another type is not permitted.|Information's subject.|-|
|detail|pass string. null, number, boolean and another type is not permitted.|Information's detail.|-|
|subject|pass string. null, number, boolean and another type is not permitted.<br />String should be blank, single word or comma separated.|Information's tag.|-|

#### Example

**Plan A.** ```"Register no tagged information"```

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

**Plan B.** ```"Register information tag is only one."```

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

**Plan C.** ```"Register information with two tags."```

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

When information is created.

```
HTTP/1.1 201 Created
{
  "location":"/information/8",
  "information":{
    "subject":"hello",
    "detail":"this is hello detail",
    "created":"2017-07-01-00-00",
    "updated":"2017-07-01-01-30",
    "tag": {
      "name": ["foo", "bar"]
    }
  }
}
```
