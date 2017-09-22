#!/usr/bin/lua
local cjson = require("cjson");
dofile("./lib/log.lua");
dofile("./lib/webutil.lua");
dofile("./lib/config.lua");

get_data, cookie_data, post_data, method = get_user_input()

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

	config_["HOSTIP"]=post_data;
	post_output();
        set_config(config_);
	bak_log("post.hostip.cgi");
else

	json_data = {};
	http_data = {};
	json_data["STATUS"] = "OK"
--json_data["msg"] = "get csip success"
	json_data["HOSTIP"] = config_["HOSTIP"]
	json_data["HOSTIP"]["MAC"] = "00:22:33:44:55:66"
	json_http_resp(json_data);
	my_log("-get-is end");
	bak_log("get.hostip.cgi");
end

--main end

