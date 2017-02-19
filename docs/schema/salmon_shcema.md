
## <a name="resource-todo">Todo</a>

Stability: `prototype`

FIXME

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **id** | *integer* | unique identifier of todo | `42` |
| **title** | *string* | title of todo | `"example"` |
| **content** | *string* | content of todo | `"example"` |

### <a name="link-POST-todo-localhost:3000/api/v1/users/{(%23%2Fdefinitions%2Fuser%2Fdefinitions%2Fidentity)}/todos">Todo Create</a>

Create a new todo.

```
POST localhost:3000/api/v1/users/{user_id}/todos
```


#### Curl Example

```bash
$ curl -H POST 'Content-Type:application/json' \
      -d '{ "todo" : {"title": "title","content": "content", "done": false} }' \
      http://localhost:3000/api/v1/users/1/todos -w '\n%{http_code}\n' -s
```


#### Response Example

```
201
```

```json
{
    "id":       114,
    "title":    "title",
    "content":  "content",
    "done":     false,
    "user_id":  1
}
```

### <a name="link-DELETE-todo-localhost:3000/api/v1/users/{(%23%2Fdefinitions%2Fuser%2Fdefinitions%2Fidentity)}/todos">Todo Delete</a>

Delete an existing todo.

```
DELETE localhost:3000/api/v1/users/{user_id}/todos
```


#### Curl Example

```bash
curl -X DELETE -H 'Content-Type:application/json' \
      http://localhost:3000/api/v1/users/1/todos/100 -w '\n%{http_code}\n' -s
```


#### Response Example

```
200
```

```json
{
    "id":       100,
    "title":    "title_100",
    "content":  "content_100",
    "done":     false,
    "user_id":  10
}
```

### <a name="link-GET-todo-localhost:3000/api/v1/users/{(%23%2Fdefinitions%2Fuser%2Fdefinitions%2Fidentity)}/todos/{(%23%2Fdefinitions%2Ftodo%2Fdefinitions%2Fidentity)}">Todo Show</a>

Show existing todo.

```
GET localhost:3000/api/v1/users/{user_id}/todos/{todo_id}
```


#### Curl Example

```bash
$ curl -X GET -H 'Content-Type:application/json' \
http://localhost:3000/api/v1/users/1/todos/1 -w '\n%{http_code}\n' -s
```


#### Response Example

```
200
```

```json
{
    "id":       1,
    "title":    "title_1",
    "content":  "content_1",
    "done":     false,
    "user_id":  1
}

```

### <a name="link-GET-todo-localhost:3000/api/v1/users/{(%23%2Fdefinitions%2Fuser%2Fdefinitions%2Fidentity)}/todos">Todo Index</a>

Index existing todos.

```
GET localhost:3000/api/v1/users/{user_id}/todos
```


#### Curl Example

```bash
$ curl -X GET -H 'Content-Type:application/json' \
http://localhost:3000/api/v1/users/1/todos -w '\n%{http_code}\n' -s
```


#### Response Example

```
200
```

```json
[
  {
    "id":       1,
    "title":    "title_1",
    "content":  "content_1",
    "done":     false,
    "user_id":  1
  },
  {
    "id":       2,
    "title":    "title_2",
    "content":  "content_2",
    "done":     false,
    "user_id":  1
  }
]
```

### <a name="link-PATCH-todo-localhost:3000/api/v1/users/{(%23%2Fdefinitions%2Fuser%2Fdefinitions%2Fidentity)}/todos/{(%23%2Fdefinitions%2Ftodo%2Fdefinitions%2Fidentity)}">Todo Update</a>

Update an existing todo.

```
PATCH localhost:3000/api/v1/users/{user_id}/todos/{todo_id}
```


#### Curl Example

```bash
$ curl -X PATCH -H 'Content-Type:application/json' \
      -d '{ "todo" : {"title": "update_title",  "content": "update_content", "done": false} }' \
      http://localhost:3000/api/v1/users/1/todos/3 -w '\n%{http_code}\n' -s
```


#### Response Example

```
200
```

```json
{
    "id":       3,
    "title":    "update_title",
    "content":  "update_content",
    "done":     false,
    "user_id":  1
}
```


## <a name="resource-user">User</a>

Stability: `prototype`

FIXME

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **id** | *integer* | unique identifier of user | `42` |
| **name** | *string* | name of user | `"example"` |
| **email** | *email* | email of user | `"username@example.com"` |

### <a name="link-POST-user-localhost:3000/users">User Create</a>

Create a new user.

```
POST localhost:3000/api/v1/users
```


#### Curl Example

```bash
$ curl -H POST 'Content-Type:application/json' \
      -d '{ "user" : {"name": "create_name","password": "12345", "password_confirmation": "12345", "email": "create_name@example.com"} }' \
      http://localhost:3000/api/v1/users -w '\n%{http_code}\n' -s
```


#### Response Example

```
201
```

```json
{
    "id":               13,
    "name":             "create_name",
    "email":            "create_name@example.com"
}
```

### <a name="link-DELETE-user-localhost:3000/api/v1/users/{(%23%2Fdefinitions%2Fuser%2Fdefinitions%2Fidentity)}">User Delete</a>

Delete an existing user.

```
DELETE localhost:3000/api/v1/users/{user_id}
```


#### Curl Example

```bash
$ curl -X DELETE -H 'Content-Type:application/json' \
      http://localhost:3000/api/v1/users/13 -w '\n%{http_code}\n' -s
```


#### Response Example

```
200
```

```json
{
    "id":13,
    "name":"name",
    "email":"create_name@example.com",
}
```

### <a name="link-GET-user-localhost:3000/api/v1/users/{(%23%2Fdefinitions%2Fuser%2Fdefinitions%2Fidentity)}">User Show</a>

Show existing user.

```
GET localhost:3000/api/v1/users/{user_id}
```


#### Curl Example

```bash
$ curl -X GET -H 'Content-Type:application/json' \
http://localhost:3000/api/v1/users/1 -w '\n%{http_code}\n' -s
```


#### Response Example

```
200
```

```json
{
    "id":1,
    "name":"name_1",
    "email":"user_1@example.com"
}
```

### <a name="link-GET-user-localhost:3000/users">User Index</a>

Index existing users.

```
GET localhost:3000/api/v1/users
```


#### Curl Example

```bash
$ curl -X GET -H 'Content-Type:application/json' \
http://localhost:3000/api/v1/users -w '\n%{http_code}\n' -s
```


#### Response Example

```
200
```

```json
[
 {
    "id":       1,
    "name":     "name_1",
    "email":    "user_1@example.com"
 },
 {
    "id":       2,
    "name":     "name_2",
    "email":    "user_2@example.com"
 }
]
```

### <a name="link-PATCH-user-localhost:3000/api/v1/users/{(%23%2Fdefinitions%2Fuser%2Fdefinitions%2Fidentity)}">User Update</a>

Update an existing user.

```
PATCH localhost:3000/api/v1/users/{user_id}
```


#### Curl Example

```bash
$ curl -X PATCH -H 'Content-Type:application/json' \
      -d '{ "user" : {"name": "update_name",  "email": "update_user@example.com" } }' \
      http://localhost:3000/api/v1/users/1 -w '\n%{http_code}\n' -s
```


#### Response Example

```
200
```

```json
{
    "id":       1,
    "name":     "update_name",
    "email":    "update_user@example.com"
}

```


