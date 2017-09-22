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

	config_["HEART"]=post_data;
        set_config(config_);
	post_output();
	bak_log("heart.log");
else

	json_data = {};
	http_data = {};
	json_data["STATUS"] = "OK"
--json_data["msg"] = "get csip success"
	json_data["HEART"] = config_["HEART"]
	json_http_resp(json_data);
	my_log("-get-is end");
	bak_log("heart.log");
end

--main end

