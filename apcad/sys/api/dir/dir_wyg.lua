_ENV=module_seeall(...,package.seeall)
--·������path_a�����ļ�����file
local function file_path(str)
	if string.find(str,"\\",-1) then return "path_a"
	else return "file"
    end  	
end
--���ļ�����file���ļ�����nil
local function file_str(str)
	if io.open(str) then return "file"--file��ʾ���ļ���nil��ʾ�ַ���������
	else return "nil"
    end	
end
--��·������folder��·������nil
local function path_str(str)
	local filename = "wyg.sdr23f435crgvsgf5364fxcdfv"
	local f,f_=io.open(str..filename,"r"),io.open(str..filename,"w")
    if f then  f:close(str..filename) return  "folder" --folder��ʾ��·����nil��ʾ������
	else
		if f_ then f_:close(str..filename) os.remove(str..filename) return "folder"
		else return "nil"
		end
    end
end
--���ܣ���һ����ʾ��ʽΪһ���ļ����У����ַ�����ֱ�Ӵ��� �ļ����У���������c:\aa\bb\cc\dd.txt��������dd.txt
--������str��һ���ַ���������ʾ��ʽ��һ���ļ����У�
--���أ���
function create(str)
    for i=-1,-string.len(str),-1 do 
		j=string.find(str,"\\",i)
	if j then break end;  	
	end
	local a=string.sub(str,1,j)
	local b=string.sub(str,j+1,-1)
	if file_str(str)=="file" then return end
	os.execute("mkdir ".."\""..a.."\"")
	local f = io.open(str, 'w')
	if string.sub(str,-1,-1)~="\\" then f:close(str) end
end
--���ܣ���һ����ʾ��ʽΪһ���ļ����У����ַ������ж������ļ�������file�����ļ��У�����folder�������ǲ����ڵ��ļ����У�������nil��
--������str��һ���ַ���������ʾ��ʽ��һ���ļ����У�
--���أ�����ֵ��·�������·������������ֵ���ļ�������ļ�����
function is_there (str)
	local  c=file_path(str)
   if "file"==c then return file_str(str)
   else return path_str(str)
   end
end
--���ܣ���һ����ʾ��ʽΪһ���ļ����У����ַ�����ֻ�������������һ���ļ��С�������c:\aa\bb\cc\dd.txt��ֻ������cc
--������str��һ���ַ���������ʾ��ʽ��һ���ļ����У�
--���أ���
function create_folder(str)
	for i=-1,-string.len(str),-1 do 
		j=string.find(str,"\\",i)
	if j then break end;  	
	end
	local a=string.sub(str,1,j)
	local b=string.sub(str,j+1,-1)
	if path_str(a)=="folder" then return end
	os.execute("mkdir ".."\""..a.."\"") 
	io.open(a, 'w')
end