
## <a name="resource-todo">Todo</a>

Stability: `prototype`

FIXME

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **content** | *string* | content of todo | `"example"` |
| **id** | *integer* | unique identifier of todo | `42` |
| **title** | *string* | title of todo | `"example"` |

### <a name="link-POST-todo-localhost:3000/api/v1/users/{(%23%2Fdefinitions%2Fuser%2Fdefinitions%2Fidentity)}/todos">Todo Create</a>

Create a new todo.

```
POST localhost:3000/api/v1/users/{user_id}/todos
```


#### Curl Example

```bash
$ curl -n -X POST localhost:3000/api/v1/users/$USER_ID/todos \
  -d '{
}' \
  -H "Content-Type: application/json"
```


#### Response Example

```
HTTP/1.1 201 Created
```

```json
{
  "id": 42,
  "title": "example",
  "content": "example"
}
```

### <a name="link-DELETE-todo-localhost:3000/api/v1/users/{(%23%2Fdefinitions%2Fuser%2Fdefinitions%2Fidentity)}/todos">Todo Delete</a>

Delete an existing todo.

```
DELETE localhost:3000/api/v1/users/{user_id}/todos
```


#### Curl Example

```bash
$ curl -n -X DELETE localhost:3000/api/v1/users/$USER_ID/todos \
  -H "Content-Type: application/json"
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
{
  "id": 42,
  "title": "example",
  "content": "example"
}
```

### <a name="link-GET-todo-localhost:3000/api/v1/users/{(%23%2Fdefinitions%2Fuser%2Fdefinitions%2Fidentity)}/todos/{(%23%2Fdefinitions%2Ftodo%2Fdefinitions%2Fidentity)}">Todo Show</a>

Show existing todo.

```
GET localhost:3000/api/v1/users/{user_id}/todos/{todo_id}
```


#### Curl Example

```bash
$ curl -n localhost:3000/api/v1/users/$USER_ID/todos/$TODO_ID
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
{
  "id": 42,
  "title": "example",
  "content": "example"
}
```

### <a name="link-GET-todo-localhost:3000/api/v1/users/{(%23%2Fdefinitions%2Fuser%2Fdefinitions%2Fidentity)}/todos">Todo Index</a>

List existing todos.

```
GET localhost:3000/api/v1/users/{user_id}/todos
```


#### Curl Example

```bash
$ curl -n localhost:3000/api/v1/users/$USER_ID/todos
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
[
  {
    "id": 42,
    "title": "example",
    "content": "example"
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
$ curl -n -X PATCH localhost:3000/api/v1/users/$USER_ID/todos/$TODO_ID \
  -d '{
}' \
  -H "Content-Type: application/json"
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
{
  "id": 42,
  "title": "example",
  "content": "example"
}
```


## <a name="resource-user">User</a>

Stability: `prototype`

FIXME

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **email** | *email* | email of user | `"username@example.com"` |
| **id** | *integer* | unique identifier of user | `42` |
| **name** | *string* | name of user | `"example"` |

### <a name="link-POST-user-localhost:3000/users">User Create</a>

Create a new user.

```
POST localhost:3000/users
```


#### Curl Example

```bash
$ curl -n -X POST localhost:3000/users \
  -d '{
}' \
  -H "Content-Type: application/json"
```


#### Response Example

```
HTTP/1.1 201 Created
```

```json
{
  "id": 42,
  "name": "example",
  "email": "username@example.com"
}
```

### <a name="link-DELETE-user-localhost:3000/api/v1/users/{(%23%2Fdefinitions%2Fuser%2Fdefinitions%2Fidentity)}">User Delete</a>

Delete an existing user.

```
DELETE localhost:3000/api/v1/users/{user_id}
```


#### Curl Example

```bash
$ curl -n -X DELETE localhost:3000/api/v1/users/$USER_ID \
  -H "Content-Type: application/json"
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
{
  "id": 42,
  "name": "example",
  "email": "username@example.com"
}
```

### <a name="link-GET-user-localhost:3000/api/v1/users/{(%23%2Fdefinitions%2Fuser%2Fdefinitions%2Fidentity)}">User Show</a>

Show existing user.

```
GET localhost:3000/api/v1/users/{user_id}
```


#### Curl Example

```bash
$ curl -n localhost:3000/api/v1/users/$USER_ID
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
{
  "id": 42,
  "name": "example",
  "email": "username@example.com"
}
```

### <a name="link-GET-user-localhost:3000/api/v1/users">User Index</a>

Index existing users.

```
GET localhost:3000/api/v1/users
```


#### Curl Example

```bash
$ curl -n localhost:3000/api/v1/users
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
[
  {
    "id": 42,
    "name": "example",
    "email": "username@example.com"
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
$ curl -n -X PATCH localhost:3000/api/v1/users/$USER_ID \
  -d '{
}' \
  -H "Content-Type: application/json"
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
{
  "id": 42,
  "name": "example",
  "email": "username@example.com"
}
```


