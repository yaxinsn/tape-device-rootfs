DIR="/home/root/rundir/usr/lib/lua/"
package.cpath = DIR .. '?.so;' .. DIR .. '/5.1/?.so;' 

DIR="/home/root/rundir/usr/lib/lua/"
package.path = DIR .. '/5.1/?.lua;'
local core = require"md5.core"
dofile("./lib/log.lua");
dofile("./lib/webutil.lua");
dofile("./lib/config.lua");

----------------------------------------------------------------------------
-- @param k String with original message.
-- @return String with the md5 hash value converted to hexadecimal digits

function core.sumhexa (k)
  k = core.sum(k)
  return (string.gsub(k, ".", function (c)
           return string.format("%02x", string.byte(c))
         end))
end



function check_password(user, passwd)
	my_log("check_password : user=" .. user .. "password=" .. passwd);
	local local_passwd="";
	if config_["PASSWORD"] == nil then
		local_passwd = md5_sumhexa("Hzivy_Box");
		my_log("check_password: config no password and default passwordmd5 is " .. local_passwd);
	else
		if config_["PASSWORD"]["PASSWORD"] == nil then
			local_passwd = md5_sumhexa("Hzivy_Box");
			my_log("check_password: config no password's password and default passwordmd5 is " .. local_passwd);
		else
			local_passwd =  config_["PASSWORD"]["PASSWORD"];
			my_log("check_password: I get the password's md5code is " .. local_passwd); 
		end
	end
	
	if passwd == local_passwd then
		my_log("password is ok!");
		return true;
	else
		my_log("password is error!");
		return false;
	end

end

--[[
function is_authed(cookie)
    local result = exec_get_local("cat /tmp/web_stamp")
	
		if cookie["username"] and cookie["salt"] then
				local hash = core.sumhexa(cookie["username"]..internalHashKey);
				--print(cookie["salt"] == hash)
		    return cookie["salt"] == hash
		else
		    return false
		end
end
--]]

function is_authed(sess_id)
	local l_sessionid = exec_get_local("cat /tmp/web_session_id");
    if l_sessionid == sess_id then
        my_log("session id is matched !");
        local result = exec_get_local("cat /tmp/web_stamp");
        local l_uptime = exec_get_local("awk -F. '{print $1}' /proc/uptime ");
        local x= l_uptime - result;
        my_log("session during time is " .. x); 
        if x > 180 then
		return false;
        end
        return true
    end
	return false;
end
function do_login(user, password)
    local salt = core.sumhexa(user..internalHashKey);
    --local stamp = os.time()
    if check_password(user, password) then
        --login success, so return username and salt for add cookies
	local time=print(os.date("%s"));
        salt = core.sumhexa(time..internalHashKey);  
        os.execute("echo " ..salt.. "/tmp/web_session_id");
        os.execute("awk -F. '{print $1}' /proc/uptime > /tmp/web_stamp")
        return true, user, salt
    else --passwd error or username error
        return  false
    end
end


