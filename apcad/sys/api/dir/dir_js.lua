_ENV=module_seeall(...,package.seeall)
--ȥ��ͷ�ļ�
local function remove_root(t,str)
	local t_new = {};
	for k ,v in pairs(t) do
	local m = string.match(v,str.."(.+)")
	table.insert(t_new,m)
	end
	return t_new;
end
--ȥ��Ŀ¼�����е��ļ��ַ���
local	function get_all_files(dir_name)
			local i, files, popen = 0, {}, io.popen;
			for file_path in popen('dir "'..dir_name..'" /s /b /a-d'):lines() do
				i = i + 1
				files[i] = file_path
			end
			local files_new = remove_root(files,dir_name)
			return files_new
end
--��һ�����Ƶ���һ���±�
local function copy_to_t(t)
	local t_new = {};
	for k,v in pairs (t) do 
		t_new[k] = v
	end
	return t_new;
end


--����       �� �����ļ����Ϊ ���� 
--����       �� �����ļ�·�����ַ����� ���� str = "text"
--����ֵ     �� һ���µ�tab ����Ϊt = {text = "local"}
function get_file(str)
	local files = get_all_files(str)
	local t = {};
	for k,v in pairs(files) do 
		t[v] = "local"
	end 
	return t ;
end

--����       �� �����ļ����Ϊ ������
--����       �� �������ϵ� �ļ���·��   ���� t = {{filename = "text"},{filename = "uuu"}}        
--����ֵ     �� һ���µ�tab ����Ϊ    new = {text = ��server��,uuu = "server"}
function tab_new(t)
	local new = {};
	for k,v in pairs(t) do 
		new[v.filename] = "server"
	end
	return new
end

--����       �� �������tab����ͬ���ļ�·�� ���Ϊ���߶�����
--����       �� ������ͬ;�� �� �ļ���·��    t_userΪ���������ص�tab �� t_user = {text = ��server��,uuu = "server"}   &  t_locΪ���ط��ص�tab ��  t_loc = {text = ��local��}
--����ֵ     �� һ���µ�tab��  ������ȫ����һ����table�У�k��ͬ ��v = ��both��  ��t = {text = "both",uuu = "server"}
function double_key(t_user,t_loc)
	local t = copy_to_t(t_user)
	for k,v in pairs (t_loc) do 
			if t[k] then t[k] = "both"
			else t[k] = "local" 
			end
	end	
	return t;
end


