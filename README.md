restify-nedb (for [nedb](https://github.com/louischatriot/nedb))
===============

restify-nedb was built to give you restful api resources for client side application frameworks like `angular.js`, `ember.js`, `backbone.js` or `knockout.js` as well as give you a simple file/memory based cache utilizing [nedb](https://github.com/louischatriot/nedb). (ps, i love nedb, you should too.) If you haven't already checked it out, maybe you want to use it separate of all of this extra stuff, do it. It's like sqlite, with a subset of mongodb's api. Really neat.

- Let me know if you have any issues, please open issues/prs etc, it's a lot more fun that way
- There's still a good chunk of the `nedb` api I need to wrap in, if you need the core crud stuff, this should work well for you
- I'd like to point out there's a few rough parts, but it's coming along.  

----

### Features
- Super fast `nedb` file/memory backed cache w/ simple garbage collection
- 100% coffeescript, hate it or love it
- restful routing: `GET`, `POST`, `PUT`, `DELETE` 
- parses `json/multi-part`

### Installation (w/ Express)

`npm install restify-nedb --save`

```coffee
express = require "express"
app = module.exports = express()

nedb = require("restify-nedb").mount
ensure = require "../passport/middleware"

new nedb {
  prefix: "/session"
  middleware: [ensure.admins]
  excludes: ['_id', 'stale']
  cache: 
    maxAge: 1000 * 60 * 60
}, app
```
----

## Settings
- `prefix` defaults to `/ds`
- `version` defaults to `/v1`
- `exclude` defaults to `[]` (showing all)
- `middleware` array of middleware, defaults to `[]`
- `memory_store` defaults to false
- `file_name` defaults to `nedb-filestore.db`
- `file_path` defaults to `../db`
- `cache.store` defaults to `undefined` set a store name
- `cache.maxAge` defaults to 1hour or `1000 * 60 * 60`

## Routes

```md
GET http://localhost:3000/session/v1
POST http://localhost:3000/session/v1

GET http://localhost:3000/session/v1/:id
PUT http://localhost:3000/session/v1/:id
DELETE http://localhost:3000/session/v1/:id
```

### Ordering

```md
GET http://localhost:3000/session/v1/:id?limit=20
GET http://localhost:3000/session/v1/:id?skip=10
GET http://localhost:3000/session/v1/:id?limit=20&skip=10
```

### Additional

```md
PUT http://localhost:3000/session/v1/:id?append=true

append defaults to false. Set to true to do something similar to findOrUpdate
```

##### Pro-tip
I would recommend using something like [Advanced REST Client](https://chrome.google.com/webstore/detail/advanced-rest-client/hgmloofddffdnphfgcellkdfbfbjeloo?hl=en-US) for testing, it'll help.

## License
```md
The MIT License (MIT)

Copyright (c) 2013 David Higginbotham 

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
```
