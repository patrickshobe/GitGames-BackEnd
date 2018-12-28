# GitGames-Backend

GitGames is a tool to give developer's metrics regarding their git history and to gamify being a developer.

### Agile Board:

[![Waffle.io - Columns and their card
count](https://badge.waffle.io/patrickshobe/GitGames-BackEnd.svg?columns=all)](https://waffle.io/patrickshobe/GitGames-BackEnd)

### Build Status
[![CircleCI](https://circleci.com/gh/patrickshobe/GitGames-BackEnd/tree/master.svg?style=svg)](https://circleci.com/gh/patrickshobe/GitGames-BackEnd/tree/master)

## Endpoints

All routes prepended by the app url: `https://gitgames.herokuapp.com`

### Users

The users endpoint returns the data for one user, it takes the username as a URL parameter.

`/api/v1/users?username=coder123`

##### Successful Response

```
# Request
get `/api/v1/users?username=coder123`

# Response
{
    "avatarUrl": "https://url_to_coder123_avatar_image",
    "createdAt": "2018-01-31T21:48:32Z",
    "email": "coder123@email.com",
    "login": "coder123",
    "name": "Coder 123"
}
```


##### Failed Response

```
# Request
get `/api/v1/users?username=notarealuser`

# Response
{
  "error": "User notarealuser Not Found"
}
```


### Commit Message

The commit query endpoint returns the data for one user, it takes the username as a URL parameter.

`/api/v1/commit_messages?username=coder123`

##### Successful Response

```
# Request
get `/api/v1/commit_messages?username=coder123`

# Response
{
  "update": 13,
  "readme": 8,
  "removes": 12,
  "vulnerability": 1,
  "completes": 2,
  "admin": 7,
  "testing": 2
}
```


##### Failed Response

```
# Request
get `/api/v1/commit_messages?username=notarealuser`

# Response
{
  "error": "User notarealuser Not Found"
}
```


### Language Percentages

The language percentages endpoint returns a breakdown of the amount a coding language is used in a user's repositories. It takes a username as a URL parameter.

`/api/v1/languages?username=coder123`

#### Successful Response

```
# Request
get '/api/v1/languages?username=coder123`

# Response
{
    "Ruby": 0.32084981003334107,
    "CSS": 0.027025474950164895,
    "HTML": 0.08653465642994071,
    "Roff": 0.0014041645410913647,
    "JavaScript": 0.5640444497178823,
    "CoffeeScript": 0.00014144432757969987
}
```

#### Failed Response

```
#Request
get '/api/v1/languages?username=notarealuser`

# Response
{
  "error": "User notarealuser Not Found"
}
```
