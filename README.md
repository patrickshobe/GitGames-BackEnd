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
User notarealuser Not Found
```
