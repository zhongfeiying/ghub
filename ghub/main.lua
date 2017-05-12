require "global"


hub_start("localhost",8000,10,60) --ip port max_accept max_accept_seconds




function process_cmd_imp(content,line)
	local fun,l = string.match(line,"([^\r\n]-)\r\n(.*)")
	if fun and l  and cmds[fun] then
		cmds[fun](content,l)
	elseif fun then
		--local sock = get_socket(content)
		--close_socket(sock)
		local ip,port = hub_addr(content)
		trace_out("unkown command :" .. fun .. "@" .. ip .. ":" .. port .. "\n")
	end
end

function process_data(content,line)
	local len,l = string.match(line,"^(%d+)\r\n(.*)")
	trace_out("process_data \n");	

	local num = 0
	if len then num = tonumber(len)
	end

	if len and l and num < string.len(l) then
		local str = string.sub(l,1,num)
		local left = string.sub(l,num +1)
		cs[content] = left
		process_cmd_imp(content,str)
		--trace_out(num .. "::" .. string.len(l) .. "   left\n")
		return false,left
	elseif len and l and num == string.len(l) then
		process_cmd_imp(content,l)
		cs[content] = true
		--trace_out(num .. "=\n")
		return true
	elseif len and l and num > string.len(l) then
		cs[content] = line
		--trace_out(num .. "need more\n")
		return true
	elseif string.len(line) > 10 then
		--trace_out("no len \n")
		local sock = get_socket(content)
		close_socket(sock)
		return true
	end
	return true
end

function process_cmd(content,line)
	trace_out("process_cmd \n");	
	local result = false
	local s = line
	local s1--∂‡∂Œ¥¶¿Ì
	repeat 
		result,s1 = process_data(content,s)	
		s = s1
	until result == true
		
end


function do_accept(content,str)
	cs[content] = true
	trace_out("do_accept = " .. str.."\n");
	process_cmd(content,str)
end

function do_recv(content,str)
	trace_out("do_recv = " .. str.."\n");
	process_cmd(content,str)
end

function socket_quit(content)
	--ip,port = hub_addr(content)
end

function on_quit()
	
end

