## Salmon (Todoリスト の REST API)

### Models

* User (has_many  :todos)
* Todo (belongs_to :user)

### Controllers

* UserTokenController
* UsersController
* TodosController

### Authorization


* Json Web Tokenによる認証 ([gem 'knock'](https://github.com/nsarno/knock))
* Basic認証

### Download

* [yukihirop/salmon](https://github.com/yukihirop/salmon)



## <a name="resource-todo">Todo</a>

Stability: `prototype`

Todoリストを検索・登録・更新・削除できるAPIです。

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **id** | *integer* | unique identifier of todo | `42` |
| **title** | *string* | title of todo | `"example"` |
| **content** | *string* | content of todo | `"example"` |
| **done** | *boolean* | done of todo | `false` |

### Rooting

| Verb | URI Pattern | Controller#Action | Authenticate |
| ------- | ------- | ------- | ------- |
| **POST** | */api/v1/user_token* | api/v1/user_token#create | `JWT` |
| **GET** | */api/v1/users/:user_id/todos* | api/v1/todos#index | `JWT` |
| **POST** | */api/v1/users/:user_id/todos* | api/v1/todos#create | `JWT` |
| **GET** | */api/v1/users/:user_id/todos/:id* | api/v1/todos#show | `JWT` |
| **PATCH** | */api/v1/users/:user_id/todos/:id* | api/v1/todos#update | `JWT` |
| **PUT** | */api/v1/users/:user_id/todos/:id* | api/v1/todos#update | `JWT` |
| **DELETE** | */api/v1/users/:user_id/todos/:id* | api/v1/todos#destroy | `JWT` |



### <a name="link-POST-todo-localhost:3000/api/v1/users/{(%23%2Fdefinitions%2Fuser%2Fdefinitions%2Fidentity)}/todos">Todo Create</a>

Create a new todo.

```
POST localhost:3000/api/v1/users/{user_id}/todos
```


#### Curl Example

```bash
$ curl -H "Accept: application/json" -H "Content-Type: application/json" \
 -X POST -d $'{"auth": {"email": "user_1@example.com", "password": "12345"}}' \
 http://localhost:3000/api/v1/user_token -w '\n%{http_code}\n' -s -c cookie

$ curl -H "Accept: application/json" -H "Content-Type: application/json" \
      -X POST -d '{"todo": {"title": "create_title", "content": "create_content", "done": false} }' \
      http://localhost:3000/api/v1/users/1/todos -w '\n%{http_code}\n' -s -b cookie
```


#### Response Example

```
201
```

```json
{
    "id":       102(任意に変わる),
    "title":    "create_title",
    "content":  "create_content",
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
$ curl -H "Accept: application/json" -H "Content-Type: application/json" \
 -X POST -d $'{"auth": {"email": "user_1@example.com", "password": "12345"}}' \
 http://localhost:3000/api/v1/user_token -w '\n%{http_code}\n' -s -c cookie

$ curl -X DELETE -H 'Content-Type:application/json' \
      http://localhost:3000/api/v1/users/1/todos/102 -w '\n%{http_code}\n' -s -b cookie
```


#### Response Example

```
200
```

```json
{
    "id":       102,
    "title":    "create_title",
    "content":  "create_content",
    "done":     false,
    "user_id":  1
}
```

### <a name="link-GET-todo-localhost:3000/api/v1/users/{(%23%2Fdefinitions%2Fuser%2Fdefinitions%2Fidentity)}/todos/{(%23%2Fdefinitions%2Ftodo%2Fdefinitions%2Fidentity)}">Todo Show</a>

Show existing todo.

```
GET localhost:3000/api/v1/users/{user_id}/todos/{todo_id}
```


#### Curl Example

```bash
$ curl -H "Accept: application/json" -H "Content-Type: application/json" \
 -X POST -d $'{"auth": {"email": "user_1@example.com", "password": "12345"}}' \
 http://localhost:3000/api/v1/user_token -w '\n%{http_code}\n' -s -c cookie

$ curl -X GET -H 'Content-Type:application/json' \
http://localhost:3000/api/v1/users/1/todos/1 -w '\n%{http_code}\n' -s -b cookie
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
$ curl -H "Accept: application/json" -H "Content-Type: application/json" \
 -X POST -d $'{"auth": {"email": "user_1@example.com", "password": "12345"}}' \
 http://localhost:3000/api/v1/user_token -w '\n%{http_code}\n' -s -c cookie

$ curl -X GET -H 'Content-Type:application/json' \
http://localhost:3000/api/v1/users/1/todos -w '\n%{http_code}\n' -s -b cookie
```


#### Response Example

```
200
```

```json(最初の２つだけ)
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
$ curl -H "Accept: application/json" -H "Content-Type: application/json" \
 -X POST -d $'{"auth": {"email": "user_1@example.com", "password": "12345"}}' \
 http://localhost:3000/api/v1/user_token -w '\n%{http_code}\n' -s -c cookie

$ curl -X PATCH -H 'Content-Type:application/json' \
      -d '{ "todo" : {"title": "update_title",  "content": "update_content", "done": false} }' \
      http://localhost:3000/api/v1/users/1/todos/1 -w '\n%{http_code}\n' -s -b cookie
```


#### Response Example

```
200
```

```json
{
    "id":       1,
    "title":    "update_title",
    "content":  "update_content",
    "done":     false,
    "user_id":  1
}
```


## <a name="resource-user">User</a>

Stability: `prototype`

Todoリストを作成するユーザーの検索・登録・更新・削除ができるAPIです。

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **id** | *integer* | unique identifier of user | `42` |
| **name** | *string* | name of user | `"example"` |
| **email** | *email* | email of user | `"username@example.com"` |
| **password** | *email* | password of user | `"12345"` |
| **password_confirmation** | *email* | password_confirmation of user | `"12345"` |

### Rooting

| Verb | URI Pattern | Controller#Action | Authenticate |
| ------- | ------- | ------- | ------- |
| **POST** | */api/v1/user_token* | api/v1/user_token#create | `JWT` |
| **GET** | */api/v1/users* | api/v1/todos#index | `Basic` |
| **POST** | */api/v1/users* | api/v1/todos#create | `Nothing` |
| **GET** | */api/v1/users/:id* | api/v1/todos#show | `JWT` |
| **PATCH** | */api/v1/users/:id* | api/v1/todos#update | `JWT` |
| **PUT** | */api/v1/users/:id* | api/v1/todos#update | `JWT` |
| **DELETE** | */api/v1/users/:id* | api/v1/todos#destroy | `JWT` |

### <a name="link-POST-user-localhost:3000/users">User Create</a>

Create a new user.

```
POST localhost:3000/api/v1/users
```


#### Curl Example

```bash
$ curl -H "Accept: application/json" -H "Content-Type:application/json" \
      -X POST -d '{ "user" : {"name": "create_name","password": "12345", "password_confirmation": "12345", "email": "create_name@example.com"} }' \
      http://localhost:3000/api/v1/users -w '\n%{http_code}\n' -s
```


#### Response Example

```
201
```

```json
{
    "id":               11,
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
$ curl -H "Accept: application/json" -H "Content-Type: application/json" \
 -X POST -d $'{"auth": {"email": "user_1@example.com", "password": "12345"}}' \
 http://localhost:3000/api/v1/user_token -w '\n%{http_code}\n' -s -c cookie

$ curl -X DELETE -H "Accept: application/json" -H "Content-Type:application/json" \
      http://localhost:3000/api/v1/users/1 -w '\n%{http_code}\n' -s -b cookie
```


#### Response Example

```
200
```

```json
{
    "id":1,
    "name":"user_1",
    "email":"user_1@example.com",
}
```

### <a name="link-GET-user-localhost:3000/api/v1/users/{(%23%2Fdefinitions%2Fuser%2Fdefinitions%2Fidentity)}">User Show</a>

Show existing user.

```
GET localhost:3000/api/v1/users/{user_id}
```


#### Curl Example

```bash
$ curl -H "Accept: application/json" -H "Content-Type: application/json" \
 -X POST -d $'{"auth": {"email": "user_1@example.com", "password": "12345"}}' \
 http://localhost:3000/api/v1/user_token -w '\n%{http_code}\n' -s -c cookie

$ curl -X GET -H "Content-Type:application/json" \
http://localhost:3000/api/v1/users/1 -w '\n%{http_code}\n' -s -b cookie
```


#### Response Example

```
200
```

```json
{
    "id":1,
    "name":"user_1",
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
# username: 'salmon'  password: 'salmon' として実行
$ curl -X GET -H "Content-Type: application/json" \
 -u username:password \
 http://localhost:3000/api/v1/users/ -w '\n%{http_code}\n' -s 
```


#### Response Example

```
200
```

```json(最初の２つだけ表示)
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
$ curl -H "Accept: application/json" -H "Content-Type: application/json" \
 -X POST -d $'{"auth": {"email": "user_1@example.com", "password": "12345"}}' \
 http://localhost:3000/api/v1/user_token -w '\n%{http_code}\n' -s -c cookie
 
$ curl -X PATCH -H 'Content-Type:application/json' \
      -d '{ "user" : {"name": "update_name",  "email": "update_user@example.com" } }' \
      http://localhost:3000/api/v1/users/1 -w '\n%{http_code}\n' -s -b cookie
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