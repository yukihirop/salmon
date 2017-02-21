# salmon (Todoリスト の REST API)

[![wercker status](https://app.wercker.com/status/1c37d030690bc03ebb4075cdfb9260eb/s/master "wercker status")](https://app.wercker.com/project/byKey/1c37d030690bc03ebb4075cdfb9260eb)
[![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)](LICENSE)

## 推奨されるシステム環境

* Ruby 2.3.1p112 (2016-04-26 revision 54768)[x86_64-darwin14]
* psql (9.5.4, server 9.6.1)
* Rails 5.0.1
* Docker version 1.13.1

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

## Todo

Stability: `prototype`

Todoリストを検索・登録・更新・削除できるAPIです。

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **id** | *integer* | unique identifier of todo | `42` |
| **title** | *string* | title of todo | `"example"` |
| **content** | *string* | content of todo | `"example"` |
| **done** | *string* | done of todo | `"false"` |

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

## User

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