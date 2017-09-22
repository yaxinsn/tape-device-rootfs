#!/usr/bin/lua
dofile "/tmp/rundir/usr/lib/webutil.lua"
package.path = package.path..";?.lua"
local env = require("env")
dofile "/tmp/rundir/usr/lib/password.lua"
--[[ This is main entry for this webapp
    We handle requests like streams.
    get_params()
    auth_check()
    dispatch()
    render()
]]--

-- 1.get request infomations
get_data, cookie_data, post_data, method = get_user_input()

local script_name=os.getenv("SCRIPT_NAME") or ""
-- 2.check auth
if not string.find(script_name,"login")  and not is_authed(cookie_data) then 
      obj = 
	{
		status = "401",
		msg = "URL is Unauthorized (401)",
	}
	json_http_resp(obj)
end

-- 3.route
