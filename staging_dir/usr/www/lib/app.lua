#!/usr/bin/lua
TOP="/home/root/rundir/usr/www"
dofile(TOP .. "/lib/log.lua");                                            
dofile(TOP .. "/lib/webutil.lua");                                        
dofile(TOP .. "/lib/config.lua");                                         
package.path = package.path..";?.lua"
dofile(TOP .. "/lib/password.lua");

--[[ This is main entry for this webapp
    We handle requests like streams.
    get_params()
    auth_check()
    dispatch()
    render()
]]--

-- 1.get request infomations
get_data, cookie_data, post_data, method, sessionid = get_user_input()

local script_name=os.getenv("SCRIPT_NAME") or ""

my_log("script name " .. script_name);
-- 2.check auth
if not string.find(script_name,"login")  and not is_authed(sessionid) then 
      obj = 
	{
		status = "401",
		msg = "URL is Unauthorized (401)",
	}
	json_http_resp(obj)
end

my_log("script name " .. script_name .. " app.lua is end");
-- 3.route
