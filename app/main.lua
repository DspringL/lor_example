local lor = require("lor.index")
local session_middleware = require("lor.lib.middleware.session")
local check_login_middleware = require("app.middleware.check_login")
local security = require("app.config.config").security
local whitelist = require("app.config.config").whitelist
local router = require("app.router")
local app = lor()

app:conf("view enable", true)
app:conf("view engine", "tmpl")
app:conf("view ext", "html")
app:conf("views", "./app/views")

app:use(session_middleware({session_aes_key=security.session_aes_key,session_aes_secret=security.session_aes_secret}))

-- filter: add response header
app:use(function(req, res, next)
    res:set_header('X-Powered-By', 'Lor Framework')
    next()
end)

-- intercepter: login or not
app:use(check_login_middleware(whitelist))

router(app) -- business routers and routes

-- 404 error
-- app:use(function(req, res, next)
--     if req:is_found() ~= true then
--         res:status(404):send("404! sorry, page not found.")
--     end
-- end)

-- error handle middleware
app:erroruse(function(err, req, res, next)
    ngx.log(ngx.ERR, err)
    if req:is_found() ~= true then
         res:status(404):send("404! sorry, page not found. uri:" .. req.path)
    else
        res:status(500):send("unknown error")
    end
end)


--ngx.say(app.router.trie:gen_graph())

app:run()
