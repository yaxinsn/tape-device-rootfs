function dirname(str)
    if str:match(".-/.-") then
        local name = string.gsub(str, "(.*/)(.+)", "%1")
        return name
   elseif str:match(".-\\.-") then
        local name = string.gsub(str, "(.*\\)(.+)", "%1")
        return name
    else
       return ''
    end
end

local __FILE__ = debug.getinfo(1,'S').source:sub(2)


--print("fff " .. __FILE__ .. "  dir :" .. dirname(__FILE__) .. "\n");



--PWD=os.getenv("PWD");
--dofile(dirname(__FILE__) .. "/lib/lib_path.lua");
DIR=dirname(__FILE__);
package.path = DIR .. '../lib/lua/5.1/?.lua;'
package.cpath = DIR .. '../lib/lua/5.1/?.so;'
local cjson = require("cjson");
dofile("./lib/app.lua");
--dofile("./lib/log.lua");
--dofile("./lib/webutil.lua");
--dofile("./lib/config.lua");
--dofile("./lib/config.lua");

--get_data, cookie_data, post_data, method = get_user_input()

function post_output()

	json_data = {};
	http_data = {};
	json_data["STATUS"] = "OK"
json_data["msg"] = " success"
	json_http_resp(json_data);
	my_log("-POST-is end");
end
--
if method == "POST" then
	
	config_["PASSWORD"]=post_data;
        set_config(config_);
	post_output();
	bak_log("post.hostip.cgi");
else

	json_data = {};
	http_data = {};
	json_data["STATUS"] = "OK"
--json_data["msg"] = "get csip success"
	json_data["HOSTIP"] = config_["HOSTIP"];
	if json_data["HOSTIP"] == nil then
		json_data["HOSTIP"]={};
	end
	json_data["HOSTIP"]["MAC"] = "00:22:33:44:55:66"
	json_http_resp(json_data);
	my_log("-get-is end");
	bak_log("get.hostip.cgi");
end

--main end

