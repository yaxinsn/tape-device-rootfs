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


dofile("./lib/log.lua");
my_log("-----------login.cgi");
--PWD=os.getenv("PWD");
--dofile(dirname(__FILE__) .. "/lib/lib_path.lua");
DIR=dirname(__FILE__);
package.path = DIR .. '../lib/lua/5.1/?.lua;'
package.cpath = DIR .. '../lib/lua/5.1/?.so;'
local cjson = require("cjson");
dofile("./lib/app.lua");

my_log("app.lua is out");
my_log("method is " .. method .. "and esssion is nil");
--get_data, cookie_data, post_data, method = get_user_input()

function post_output()

	json_data = {};
	http_data = {};
	json_data["STATUS"] = "OK"
	json_data["INFO"] = "success"
	json_http_resp(json_data);
	my_log("-POST-is end");
end
--
if method == "POST" then
	local _data={};
        if post_data["PASSWORD"] then
            local success,user, sessionid = do_login(post_data["USER"],post_data["PASSWORD"]);
            if success then
                 _data["SESSIONID"]=sessionid;
                 _data["STATUS"]="OK"
            else
                 _data["STATUS"]="PASSWORD ERROR";
            end
            json_http_resp(_data);
        end
	bak_log("post.login.cgi");
else
        my_log("get is end");
	bak_log("get.login.cgi");
end

--main end

