#!/usr/bin/lua


CONF_FILE="/home/root/rundir/etc/base.config"
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
package.path = '/usr/local/share/lua/5.1/?.lua;' .. DIR .. '../lib/lua/5.1/?.lua;'
package.cpath = '/usr/local/lib/lua/5.1/?.so;' .. DIR .. '../lib/lua/5.1.?.so;'  
local cjson=require("cjson")



function serialize (o)
	if type(o) == "number" then
		io.write(o)
			io.write("\n")
	elseif type(o) == "string" then
		io.write(string.format("%q", o))
			io.write("\n")
	elseif type(o) == "table" then
		io.write("{\n")
		for k,v in pairs(o) do
			io.write(" ", k, " = ")
			serialize(v)
		end
		io.write("}\n")
	else
		error("cannot serialize a " .. type(o))
	end
end
config_={}; --这是一个空的table
function _read_all_config(file)

	local f = io.open(file,"r");
	if f == nil then
--		print("f is null ");
		return "{}";
	end
	t=f:read("*all");--读取整个文件。
	f:close();
	--print("t: " .. t);	
	return t;
end
function _write_all_config(file,buf)
	local f=io.open(file,"w");
	f:write(buf);
	f:close();
end

function read_fmt_table(file)
	local raw=_read_all_config(file);
	local table__=cjson.decode(raw);   --把json字符串变成table
	return table__;

end


function write_fmt_table(file,buf)
	local str=cjson.encode(buf);--把table变成json字符串
	_write_all_config(file,str);

end


function set_config(c)
	write_fmt_table(CONF_FILE,c);
end

--global:
--
config_={};
config_ = read_fmt_table(CONF_FILE);



--serialize(table_a);
--
--
---main---------
--
--
