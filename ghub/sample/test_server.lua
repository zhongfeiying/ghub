--[[
share_gid文件内容：
{
	gid="xdfadsfdfdde";
	collaborate_list={};--协同人员名单
	black_list={};--黑名单
	write_list={};--白名单
	permission="";--权限设置	
}
--]]

function cmds.check_rw(content,line)
	local share_id,user,pass = string.match(line,"([^\r\n]-)\r\n([^\r\n]-)\r\n([^\r\n]-)\r\n(.*)")
	--按照规则找到文件存储路径
	local file_path = get_path(share_id);
	local file = loadfile(file_path .. share_id);
	check(file.permission);
	...
end





