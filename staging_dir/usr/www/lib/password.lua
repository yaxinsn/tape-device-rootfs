#!/usr/bin/lua
dofile "/tmp/rundir/usr/lib/ablwebutil.lua"
local core = require"md5.core"
local mime = require("mime")
local internalHashKey = "95276543210xdeabloomyNameIsYic"

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
	local n = io.open("./chpw","w")
	n:write(passwd)
	n:close()
	local result = exec_get_local("/tmp/rundir/sbin/checkpw "..user.." ".."`cat chpw`")
	os.remove("chpw")
    if string.find(result, "1") then
        return true
    end

    return false
end


function is_authed(cookie)
    --local result = exec_get_local("cat /tmp/rundir/usr/etc/stamp")
		if cookie["username"] and cookie["salt"] then
				local hash = core.sumhexa(cookie["username"]..internalHashKey);
				--print(cookie["salt"] == hash)
		    return cookie["salt"] == hash
		else
		    return false
		end
end

function do_login(user, password)
    local salt = core.sumhexa(user..internalHashKey);
    --local stamp = os.time()
    if check_password(user, password) then
        --login success, so return username and salt for add cookies
    	--os.execute("/bin/echo "..stamp.." > /tmp/rundir/usr/etc/stamp")
        return true, user, salt
    else --passwd error or username error
        return  false
    end
	end

function change_password(user, new_password)
	local n = io.open("./pw","w")
	n:write(new_password)
	n:close()
	change_pwd(user)
	os.remove("pw")
    return do_login(user,new_password) 
end 

