# GitGames-Backend

GitGames is a tool to give developer's metrics regarding their git history and to gamify being a developer.

The back end of this application was built by Tara Craig (Github: @tcraig7) and Patrick Shobe (Github: @patrickshobe).

The front end of this application was built by Aaron Weissman (Github: @aweissman11).

#### Agile Board:

[![Waffle.io - Columns and their card
count](https://badge.waffle.io/patrickshobe/GitGames-BackEnd.svg?columns=all)](https://waffle.io/patrickshobe/GitGames-BackEnd)

#### Build Status
[![CircleCI](https://circleci.com/gh/patrickshobe/GitGames-BackEnd/tree/master.svg?style=svg)](https://circleci.com/gh/patrickshobe/GitGames-BackEnd/tree/master)

# Endpoints

All routes prepended by the app url: `https://gitgames.herokuapp.com`

## Users

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


## Commit Message

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


## Language Percentages

The language percentages endpoint returns a breakdown of the amount a coding language is used in a user's repositories. It takes a username as a URL parameter.

`/api/v1/languages?username=coder123`

##### Successful Response

```
# Request
get '/api/v1/languages?username=coder123'

# Response
{
    "Overall": {
        "Ruby": 0.3217743199811868,
        "CSS": 0.026966700991256136,
        "HTML": 0.08624164451602329,
        "Roff": 0.0013994099496176787,
        "JavaScript": 0.5634769591739295,
        "CoffeeScript": 0.00014096538798663122
    },
    "Repositories": [
        {
            "Ruby": 0.09082092918358142,
            "CSS": 0.7837843933243122,
            "HTML": 0.12539467749210645,
            "name": "example-1"
        },
        {
            "Ruby": 0.7972954105750244,
            "JavaScript": 0.02259808125735485,
            "CSS": 0.045615014859285555,
            "HTML": 0.13449149330833515,
            "name": "example-2"
        }
}
```

##### Failed Response

```
#Request
get '/api/v1/languages?username=notarealuser`

# Response
{
  "error": "User notarealuser Not Found"
}
```


## Commit Timeline

The commit timeline endpoint returns a breakdown of the user's commits over time
averaged in weekly increments as well as daily count.

It takes a username as a URL parameter and an OPTIONAL start date, it's
important to not that Github limits the farthest back start date as being 366
days in the past, this can only be used to reduce that time frame.

### Without Start Date

`/api/v1/commit_timelines?username=coder123`

##### Successful Response

```
# Request
get '/api/v1/commit_timelines?username=coder123`

# Response
[
  {
    "firstDay"=>"2017-12-31",
    "contributionDays"=>
      [
        {"date"=>"2017-12-31", "contributionCount"=>0},
        {"date"=>"2018-01-01", "contributionCount"=>0},
        {"date"=>"2018-01-02", "contributionCount"=>0},
        {"date"=>"2018-01-03", "contributionCount"=>3},
        {"date"=>"2018-01-04", "contributionCount"=>1},
        {"date"=>"2018-01-05", "contributionCount"=>5},
        {"date"=>"2018-01-06", "contributionCount"=>3}
      ],
    "averageCommits"=>1.7142857142857142},
  {
    "firstDay"=>"2018-01-07",
    "contributionDays"=>
      [
        {"date"=>"2018-01-07", "contributionCount"=>2},
        {"date"=>"2018-01-08", "contributionCount"=>19},
        {"date"=>"2018-01-09", "contributionCount"=>3},
        {"date"=>"2018-01-10", "contributionCount"=>1},
        {"date"=>"2018-01-11", "contributionCount"=>5},
        {"date"=>"2018-01-12", "contributionCount"=>0},
        {"date"=>"2018-01-13", "contributionCount"=>0}
      ],
    "averageCommits"=>4.285714285714286}
]
```

##### Failed Response

```
#Request
get '/api/v1/commit_timelines?username=notarealuser`

# Response
{
  "error": "User notarealuser Not Found"
```
}

### With Start Date

`/api/v1/commit_timelines?username=coder123&startDate=2019-01-01`

##### Successful Response

```
# Request
get '`/api/v1/commit_timelines?username=coder123&startDate=2019-01-01`

# Response

  [
    {
      :firstDay=>"2018-09-02",
      :contributionDays=>
        [
          {:date=>"2018-09-02", :contributionCount=>45},
          {:date=>"2018-09-03", :contributionCount=>20},
          {:date=>"2018-09-04", :contributionCount=>4},
          {:date=>"2018-09-05", :contributionCount=>8},
          {:date=>"2018-09-06", :contributionCount=>1},
          {:date=>"2018-09-07", :contributionCount=>5},
          {:date=>"2018-09-08", :contributionCount=>21}],
      :averageCommits=>14.857142857142858
    },
    {
      :firstDay=>"2018-09-09",
      :contributionDays=>
      [
        {:date=>"2018-09-09", :contributionCount=>18},
        {:date=>"2018-09-10", :contributionCount=>4},
        {:date=>"2018-09-11", :contributionCount=>18},
        {:date=>"2018-09-12", :contributionCount=>4},
        {:date=>"2018-09-13", :contributionCount=>29},
        {:date=>"2018-09-14", :contributionCount=>8},
        {:date=>"2018-09-15", :contributionCount=>3}],
     :averageCommits=>12.0
    }
  ]

##### Failed Response

#Request
get '`/api/v1/commit_timelines?username=notarealuser&startDate=2019-01-01`

# Response
{
  "error": "User notarealuser Not Found"
}
```

