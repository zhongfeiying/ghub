
--package.cpath = "?53.dll;?.dll;" .. package.cpath -- ����������Ҫȡ��ע��
_ENV = module_seeall(...,package.seeall)     --����������Ҫע�͵�
require "iuplua"
require "iupluacontrols"
require "iupluaimglib"
--[[
�ӿں�����
	create(arg)  ����һ��tree�ľ������������Ϊ����������tree�ĳ�ʼ���ԣ�
	add_branch(tree,tid,name) �ڴ���Ľڵ��´���һ���ļ��нڵ㣻����ýڵ㲻���ļ��нڵ㣬����ڴ���һ�������ļ��нڵ�
	add_leaf(tree,tid,name) �ڴ���Ľڵ��´���һ���ļ��ڵ㣻����ýڵ㲻���ļ��нڵ㣬����ڴ���һ�������ļ��ڵ�
	add_node(tree,tid,name,kind) ����kind��ֵ��ȷ�����������ͣ��ļ������ļ��У���ֻ�е�kind��ֵΪ "folder"ʱ��ӵ����ļ���
	insert_branch(tree,tid,name) �ڴ���Ľڵ�ͬ��Ŀ¼�£����������һ�����ڵ��ļ��нڵ�
	insert_leaf(tree,tid,name)  �ڴ���Ľڵ�ͬ��Ŀ¼�£����������һ�����ڵ��ļ��ڵ�
	insert_node(tree,tid,name,kind)   �ڴ���Ľڵ�ͬ��Ŀ¼�£����������һ�����ڵĽڵ㣬���kind��ֵ����kind��ֵ�ǡ�folder������ӵ����ļ��У�����Ĭ������ļ�
	delete_all_nodes(tree) ɾ���ؼ����нڵ�
	delete_selected_node(tree,tid) ɾ���ؼ��д���Ľڵ�����������ӽڵ�
	delete_children_node(tree,tid) ɾ���ؼ�����Ľڵ������ӽڵ㣬�ýڵ㲻��ɾ��
	delete_marked_nodes(tree) ɾ������mark�Ľڵ�,
	delete_node(tree,tid,state)   ��iup tree�ؼ��и��ݴ���Ĳ������ͽ�����Ӧ��ɾ�������� ��state�����ڻ���ֵ��Ԥ���岻һ��ʱ�����tid������Ĭ���ԡ�SELECTED����ʽɾ�������tid��������Ĭ���ԡ�MARKED����ʽɾ��--
	delete_ids(tree,tids) ɾ������ڵ� ��tids �ڵ㼯�ϣ��ṹ��{id = 1(Ҫɾ���Ľڵ��),state = ���ýڵ���ʲô��ʽɾ����;}
	set_folder_addexpanded(tree,str) �����ļ����Ƿ��ڴ���ʱ��չ����ʾ�ӽڵ㣨ȫ�ֿ��ƣ��������Ƿ����ã�Ĭ��ֵ��Ϊ��yes����
	set_folder_expanded(tree,tid) չ��������ļ��нڵ�(�ֲ�����)
	set_folder_collapsed(tree,tid) �պϴ�����ļ��нڵ�(�ֲ�����)
	set_folder_state(tree,tid,state) 
	set_root(tree,str) ��tree�����ƣ�map��ʱ���Ƿ����һ��û�����ֵ��ļ��з��ڵ�һ���ڵ��ϡ������Ƿ����ã�Ĭ��ֵ��Ϊ��yes����
	set_autoredraw(tree,str) �����Զ����£��������Ҫ�Զ����£�str ֵ����Ϊ ��no��	set_title(tree,tid,name) Ϊһ���ڵ�����title����������
	set_node_attribute(tree,tid,t) ���ýڵ����Ա�
	set_color(tree,tid,color) ���ýڵ����ֵ���ɫ
	set_file_image_g(tree,image)
	set_file_image_l(tree,tid,image)
	set_file_image(tree,tid,image,str)
	set_folder_image_collapsed_l(tree,tid,image)
	set_folder_image_expanded_l(tree,tid,image)
	set_folder_image_collapsed_g(tree,ImageCollapsed )
	set_folder_image_expanded_g(tree,ImageExpand )
	set_folder_image_g(tree,ImageExpand,ImageCollapsed)
	set_folder_image_l(tree,tid,ImageExpand,ImageCollapsed)
	get_selected_nodes(tree) ���tree��ѡ�нڵ��id���ϡ�
	get_folder_count(tree,tid)
	get_folder_totalcount(tree,tid)
	get_tree_count(tree)
	get_count(tree,tid,str)
	get_node_attribute(tree,tid)
	get_parent_node(tree,tid)
	get_node_title(tree,tid)
	get_node_kind(tree,tid)
	get_node_depth(tree,tid)
	get_node_path_ids(tree,tid)
	get_name_id(tree,tid,name) --����ļ�����ĳ�����ֵĽڵ�id
--�ص��Ľӿں���
	cb_lclick(tree,f,args) �������������tree��ĳ���ڵ�ʱ��Ӧ�Ļص���Ϣ,����tree�� ����f������ʱ ���Զ����ú�������ֵ f(id,number) ,ʾ���뿴�·���cb_selection����,args�����������ⲿ���ݱ�
	cb_rclick(tree,f,args) ��������Ҽ����tree��ĳ���ڵ�ʱ���Զ������ĺ���������ʱ�Զ����ú���f(id)��args ���������ⲿ���ݱ�
	cb_dlclick(tree,f,args)
	
	cb_branchopen(tree,f,args)
	cb_dragdrop(tree,f,args)
	
	set_tabtitle(tree,tabtitle)
	
	get_title(tree,id)

--]]


--���ܣ� ����һ��tree�Ŀؼ����������,�����ڴ���ʱΪtree������Ӧ�����ԣ�Ҳ�����ڴ���֮���ֶ����á�
--������ 
--		arg���������ñ�tree����ݱ�����ȷ��key��ֵ�������ã�δ���������Ĭ�ϣ�
--return ��tree 
--ʵ�֣�
function create(arg)
	arg = type(arg) == "table" and arg or {}
	return iup.tree(arg) 
end


--���ܣ� �ڴ�����ļ��нڵ��´���һ���ļ��нڵ㣻����ýڵ㲻���ļ��нڵ㣬����ڴ���һ�������ļ��нڵ�
--������
--		tree���ؼ��������
--		tid���ڵ�id����
--		name��Ҫ��ӵĽڵ����ƣ�

--ʵ�֣�
function add_branch(tree,tid,name)
	if not tree or not tid or not name then error("Missing parameter !") return end 
	tree["ADDBRANCH" .. tid] = name
end 

--���ܣ� �ڴ�����ļ��нڵ��´���һ���ļ��ڵ㣻����ýڵ㲻���ļ��нڵ㣬����ڴ���һ�������ļ��ڵ�
--������
--		tree���ؼ��������
--		tid���ڵ�id����
--		name��Ҫ��ӵĽڵ����ƣ�
--ʵ�֣�
function add_leaf(tree,tid,name)
	if not tree or not tid or not name then error("Missing parameter !") return end 
	tree["ADDLEAF" .. tid] = name
end 

--���ܣ� ����kind��ֵ��ȷ�����������ͣ��ļ������ļ��У���ֻ�е�kind��ֵΪ "folder"ʱ��ӵ����ļ���
--������
--		tree���ؼ��������
--		tid ���ڵ�id����
--		name��Ҫ��ӵĽڵ����ƣ���
--		kind (Ҫ��ӵĽڵ����ͣ��ļ���file��or�ļ���(��folder��),���kindΪnilĬ����������ļ�)
--ʵ�֣�
function add_node(tree,tid,name,kind)
	if not tree or not tid or not name then error("Missing parameter !") return end 
	if kind and kind == "folder" then 
		return add_branch(tree,tid,name)
	else
		return add_leaf(tree,tid,name)
	end
end 

 
 
--���ܣ� �ڴ���Ľڵ�ͬ��Ŀ¼�£����������һ�����ڵ��ļ��нڵ�
--������
--		tree���ؼ��������
--		tid���ڵ�id����
--		name��Ҫ��ӵĽڵ����ƣ�
--ʵ�֣�
function insert_branch(tree,tid,name)
	if not tree or not tid or not name then error("Missing parameter !") return end 
	tree["INSERTBRANCH" .. tid] = name
end 

--���ܣ� �ڴ���Ľڵ�ͬ��Ŀ¼�£����������һ�����ڵ��ļ��ڵ�
--������
--		tree���ؼ��������
--		tid���ڵ�id����
--		name��Ҫ��ӵĽڵ����ƣ�
--return ��true or nil (�ɹ�����ʧ��) 
--ʵ�֣�
function insert_leaf(tree,tid,name)
	if not tree or not tid or not name then error("Missing parameter !") return end 
	tree["INSERTLEAF" .. tid] = name
end 


--���ܣ� �ڴ���Ľڵ�ͬ��Ŀ¼�£����������һ�����ڵ��ļ��ڵ�
--������
--		tree���ؼ��������
--		tid���ڵ�id����
--		name��Ҫ��ӵĽڵ����ƣ�
--		kind��Ҫ��ӵĽڵ����ͣ��ļ���file��or�ļ���(��folder��),���kindΪnilĬ����������ļ���
--ʵ�֣�
function insert_node(tree,tid,name,kind)
	if not tree or not tid or not name then error("Missing parameter !") return end 
	if kind and kind == "folder" then
		return insert_branch(tree,tid,name)
	else
		return insert_leaf(tree,tid,name)
	end
end 


--���ܣ� ɾ���ؼ����нڵ�
--������
--		tree���ؼ��������
--ʵ�֣�
function delete_all_nodes(tree)
	if not tree then error("Missing parameter !") return end 
	tree["DELNODE"] = "ALL"
end

--���ܣ� ɾ���ؼ��д���Ľڵ�����������ӽڵ�
--������
--		tree���ؼ��������
--		tid  ���ڵ�id��;
--ʵ�֣�
function delete_selected_node(tree,tid)
	if not tree or not tid  then error("Missing parameter !") return end 
	tree["DELNODE" .. tid] = "SELECTED"
end


--���ܣ� ɾ���ؼ�����Ľڵ������ӽڵ㣬�ýڵ㲻��ɾ��
--������
--		tree���ؼ��������
--		tid  ���ڵ�id��;
--ʵ�֣�
function delete_children_node(tree,tid)
if not tree or not tid  then error("Missing parameter !") return end 
	tree["DELNODE" .. tid] = "CHILDREN"
end

--���ܣ� ɾ������mark�Ľڵ�,
--������
--		tree���ؼ��������
--ʵ�֣�
function delete_marked_nodes(tree)
if not tree  then error("Missing parameter !") return end 
	tree["DELNODE"] = "MARKED"
end 

--���ܣ� ��iup tree�ؼ��и��ݴ���Ĳ������ͽ�����Ӧ��ɾ�������� ��state�����ڻ���ֵ��Ԥ���岻һ��ʱ�����tid������Ĭ���ԡ�SELECTED����ʽɾ�������tid��������Ĭ���ԡ�MARKED����ʽɾ��--
--����
--		tree ���ؼ������;
--		tid  ���ڵ�id��;
--		state (ɾ���ķ�ʽ);
--state: "MARKED"��"CHILDREN"��"ALL"��"SELECTED" 
--ʵ�֣�
function delete_node(tree,tid,state)
	if not tree  then error("Missing parameter !") return end 
	local delete_node_ = {
		["MARKED"] = delete_marked_nodes,
		["CHILDREN"] = delete_children_node,
		["SELECTED"] = delete_selected_node,
		["ALL"] = delete_all_nodes,
	}
	if state and type(state) == "string" and delete_node_[string.upper(state)]  then
		delete_node_[string.upper(state)](tree,tid)
	else 
		if tid then 
			delete_node_.SELECTED(tree,tid)
		else 
			delete_node_.MARKED(tree)
		end
	end
end


--���ܣ� ɾ�����id���ϵĽڵ�
--������ 
--		tree ���ؼ������������
--		tids ��Ҫɾ���Ľڵ�id���ṹ��{id = 1(Ҫɾ���Ľڵ��),state = ���ýڵ���ʲô��ʽɾ����;}��
--ʵ�֣�
function delete_ids(tree,tids)
	if not tree then error("Missing parameter !") return end 
	if type(tids) == "table" then 
		table.sort(tids,function(a,b) return tonumber(a.id) > tonumber(b.id) end) --ɾ��ʱ��Ҫ�Խڵ���дӴ�С���򣬱��ڴӸ߽ڵ㿪ʼɾ��
		for k,v in ipairs (tids) do 
			delete_node(tree,v.id,v.state)
		end
	end
end


--���ܣ� �����ļ����Ƿ��ڴ���ʱ��չ����ʾ�ӽڵ㣨ȫ�ֿ��ƣ��������Ƿ����ã�Ĭ��ֵ��Ϊ��yes����
--������
--		tree���ؼ��������
--		str�����ͣ���str��ֵ��������ڡ�no������ôȱʡΪ��yes��
--ʵ�֣�
function set_folder_addexpanded(tree,str)
	if not tree  then error("Missing parameter !") return end 
	tree["ADDEXPANDED"] = (type(str) == "string" and string.upper(str) == "NO") and "NO" or "YES"
end


--���ܣ� չ��������ļ��нڵ�(�ֲ�����)
--������
--		tree���ؼ��������
--		tid���ڵ�id����
--ʵ�֣�
function set_folder_expanded(tree,tid)
	if not tree or not tid   then error("Missing parameter !") return end 
	tree["STATE" .. tid] = "EXPANDED"	
end 


--���ܣ� �պϴ�����ļ��нڵ�(�ֲ�����)

--������
--		tree���ؼ��������
--		tid���ڵ�id����

--ʵ�֣�
function set_folder_collapsed(tree,tid)
	if not tree or not tid   then error("Missing parameter !") return end 
	tree["STATE" .. tid] = "COLLAPSED"	
end


--���ܣ� ��iup tree�ؼ���չ��ĳ���ļ��нڵ㣬Ĭ��չ����(�ֲ�����)
--������
--		tree���ؼ��������
--		tid���ڵ�id����
--		state��ȱʡչ����ֻ�е�ֵΪ��COLLAPSED������Сд���ɣ�,ʱ�űպ��ļ��нڵ㣩
--state : "EXPANDED"��"COLLAPSED";
--ʵ�֣�
function set_folder_state(tree,tid,state)
	if not tree or not tid   then error("Missing parameter !") return end 
	local set_state_ = {
			["EXPANDED"] = set_folder_expanded;
			["COLLAPSED"] = set_folder_collapsed
		}
	if  type(state) == "string" and set_state_[string.upper(state)] then 
		tree["STATE" .. tid] = string.upper(state)
	else
		set_state_.EXPANDED(tree,tid)
	end
end 


--���ܣ� ��tree�����ƣ�map��ʱ���Ƿ����һ��û�����ֵ��ļ��з��ڵ�һ���ڵ��ϡ������Ƿ����ã�Ĭ��ֵ��Ϊ��yes����
--������
--		tree���ؼ��������
--		str�����ͣ���str��ֵ��������ڡ�no������ôȱʡΪ��yes��
--ʵ�֣�
function set_root(tree,str) 
	if not tree  then error("Missing parameter !") return end 
	tree["ADDROOT"] = (type(str) == "string" and string.upper(str) == "NO") and "NO" or "YES"
end

--���ܣ� �����Զ�����tree�Ľڵ�䶯�������Ƿ����ã�Ĭ��ֵ��Ϊ��yes����
--������
--		tree���ؼ��������
--		str�����ͣ���str��ֵ��������ڡ�no������ôȱʡΪ��yes��
--ʵ�֣�
function set_autoredraw(tree,str)
	if not tree  then error("Missing parameter !") return end 
	tree["AUTOREDRAW"] =(type(str) == "string" and string.upper(str) == "NO")and "NO"or "YES"
end

function set_marked(tree,tid,kind)
	if not tree or not tid then  error("Missing parameter !")  return end 
	tree["MARKED" .. tid] = kind or "NO"
end


--���ܣ� ��iup tree�ؼ����޸Ľڵ�����
--������
--		tree���ؼ��������
--		tid���ڵ�id����
--		name���޸ĺ�����ƣ�
--ʵ�֣�
function set_title(tree,tid,name)
	if not tree or not tid or not name   then error("Missing parameter !") return end 
	tree["TITLE" .. tid] = name
end


--���ܣ�����tree�е�ǰ�ڵ����Ա�
--������
--		tree���ؼ��������
--		tid  (�ڵ�id)��
--		t    (���Ա�)
--ʵ�֣�
function set_node_attribute(tree,tid,t)
	if not tree or not tid then error("Missing parameter !") return end 
	iup.TreeSetUserId(tree,tid,t)
end

--���ܣ� ��iup tree�ؼ����޸Ľڵ�title����ɫ
--������
--		tree���ؼ��������
--		tid���ڵ�id����
--		color���޸ĺ���ʾ����ɫ��
--color = {r = 0,g = 0,b = 0} or color = "R G B"(iupĬ�ϵ����ַ�����ʽ��ֵ)
--return ��true or nil (�ɹ�����ʧ��) 
--ʵ�֣�
function set_color(tree,tid,color)
	if not tree or not tid or not color  then error("Missing parameter !") return end 
	local r,g,b;
	if type(color) == "table" then 
		r,g,b = color.r ,color.g ,color.b 
	elseif type(color) == "string" then 
		r,g,b = string.match(color,"(%d+)%s+(%d+)%s+(%d+)")
	end
	r,g,b = r or 0 ,g or 0,b or 0
	tree["COLOR" .. tid] = "" .. r .. " " .. g .. " " .. b
end


--���ܣ� ��iup tree�ؼ����޸����е�leaf�ڵ��ͼƬ(ȫ�ֿ���)
--������
--		tree���ؼ��������
--		image ��leaf��ʾ��ͼƬ��
--return ��true or nil (�ɹ�����ʧ��) 
--ע�⣺���ĳ���ڵ㵥���ı�������ĳ��image����������ʱ�Թ������ù��Ľڵ㡣
--ʵ�֣�
function set_file_image_g(tree,image)
	if not tree  then error("Missing parameter !") return end 
	tree.IMAGELEAF = image or "IMGLEAF"
	return true 
end

function set_image(tree,id,image)
	tree["IMAGE" .. id] = image
end


--����ͼƬ���ȿ���ʹ�ñ��ش����ϵ�ͼƬ��Ҳ����ʹ��iup�����ṩ��image����Ҫ������Ӧ�Ŀ⣩(�ֲ�����)
--���ܣ� ��iup tree�ؼ����޸��ļ��ڵ���ʾ��ͼƬ
--������
--		tree���ؼ��������
--		tid���ڵ�id����
--		image���޸ĺ�ڵ��ͼƬ��
--image�������˿��Խ��ձ���·���ļ��������Ե���iup��image�⣨������Ҫ�������õĿ⣩���£�
--	require "iupluaimglib"
--ʵ�֣�
function set_file_image_l(tree,tid,image)
	if not tree or not tid  then error("Missing parameter !") return end 
	if image then tree["IMAGE" .. tid] = image end
end

--����ͼƬ���ȿ���ʹ�ñ��ش����ϵ�ͼƬ��Ҳ����ʹ��iup�����ṩ��image����Ҫ������Ӧ�Ŀ⣩(�ֲ�����)
--���ܣ� ��iup tree�ؼ����޸��ļ��ڵ���ʾ��ͼƬ
--������
--		tree���ؼ��������
--		tid���ڵ�id����
--		image���޸ĺ�ڵ��ͼƬ��
--		str��ֵ���ڲ�������ĸ��g�����ȫ�ֿ���ͼƬ������������þֲ����ƺ�����
--image�������˿��Խ��ձ���·���ļ��������Ե���iup��image�⣨������Ҫ�������õĿ⣩���£�
--	require "iupluaimglib"
--ʵ�֣�
function set_file_image(tree,tid,image,str)
	if not tree then error("Missing parameter !") return end 
	if str and string.sub(string.lower(str),1,1) == "g"  then
		set_file_image_g(tree,image)
	else
		set_file_image_l(tree,tid,image)
	end
end


--����ͼƬ���ȿ���ʹ�ñ��ش����ϵ�ͼƬ��Ҳ����ʹ��iup�����ṩ��image.(�ֲ�����)
--���ܣ� ��iup tree�ؼ����޸��ļ��нڵ�պ�ʱ��ʾ��ͼƬ
--������
--		tree���ؼ��������
--		tid���ڵ�id����
--		image���޸ĺ�ڵ��ͼƬ��
--image�������˿��Խ��ձ���·���ļ��������Ե���iup��image�⣨������Ҫ�������õĿ⣩���£�
--	require "iupluaimglib"
--ʵ�֣�
function set_folder_image_collapsed_l(tree,tid,image)
	if not tree or not tid  then error("Missing parameter !") return end 
	if image then tree["IMAGE" .. tid] = image end
end

--����ͼƬ���ȿ���ʹ�ñ��ش����ϵ�ͼƬ��Ҳ����ʹ��iup�����ṩ��image.(�ֲ�����)
--���ܣ� ��iup tree�ؼ����޸��ļ��ڵ�չ��ʱ��ʾ��ͼƬ
--������
--		tree���ؼ��������
--		tid���ڵ�id����
--		image���޸ĺ�ڵ��ͼƬ��
--image�������˿��Խ��ձ���·���ļ��������Ե���iup��image�⣨������Ҫ�������õĿ⣩���£�
--	require "iupluaimglib"
--ʵ�֣�
function set_folder_image_expanded_l(tree,tid,image)
	if not tree or not tid  then error("Missing parameter !") return end 
	if image then tree["IMAGEEXPANDED" .. tid] = image end
end

--����ͼƬ���ȿ���ʹ�ñ��ش����ϵ�ͼƬ��Ҳ����ʹ��iup�����ṩ��image.(ȫ��Ĭ������)
--���ܣ� ��iup tree�ؼ����޸��ļ��нڵ�պ�ʱ��ʾ��ͼƬ
--������
--		tree���ؼ��������
--		tid���ڵ�id����
--		image���޸ĺ�ڵ��ͼƬ��
--image�������˿��Խ��ձ���·���ļ��������Ե���iup��image�⣨������Ҫ�������õĿ⣩���£�
--	require "iupluaimglib"
--ʵ�֣�
function set_folder_image_collapsed_g(tree,ImageCollapsed )
	if not tree  then error("Missing parameter !") return end 
	tree.IMAGEBRANCHCOLLAPSED = ImageCollapsed or "IMGCOLLAPSED"
end


--����ͼƬ���ȿ���ʹ�ñ��ش����ϵ�ͼƬ��Ҳ����ʹ��iup�����ṩ��image.(ȫ��Ĭ������)
--���ܣ� ��iup tree�ؼ����޸��ļ��ڵ�չ��ʱ��ʾ��ͼƬ
--������
--		tree���ؼ��������
--		tid���ڵ�id����
--		image���޸ĺ�ڵ��ͼƬ��
--image�������˿��Խ��ձ���·���ļ��������Ե���iup��image�⣨������Ҫ�������õĿ⣩���£�
--	require "iupluaimglib"
--ʵ�֣�
function set_folder_image_expanded_g(tree,ImageExpand )
	if not tree  then error("Missing parameter !") return end 
	tree.IMAGEBRANCHEXPANDED = ImageExpand or "IMGEXPANDED"
end


--���ܣ� ��iup tree�ؼ����޸����е�branch�ڵ��ͼƬ
--������
--		tree���ؼ��������
--		ImageExpand��չ��branch�ڵ���ʾ��ͼƬ��
--		ImageCollapsed ���պ�branchʱ��ʾ��ͼƬ��
--return ��true or nil (�ɹ�����ʧ��) 
--ע�⣺���ĳ���ڵ㵥���ı�������ĳ��image����������ʱ�Թ������ù��Ľڵ㡣
--ʵ�֣�
function set_folder_image_g(tree,ImageExpand,ImageCollapsed)
    if not tree  then error("Missing parameter !") return end 
    if ImageExpand then set_folder_image_expanded_g(tree,ImageExpand ) end
    if ImageCollapsed then set_folder_image_collapsed_g(tree,ImageCollapsed) end 
end

--���ܣ� ��iup tree�ؼ����޸����е�branch�ڵ��ͼƬ
--������
--		tree���ؼ��������
--		ImageExpand��չ��branch�ڵ���ʾ��ͼƬ��
--		ImageCollapsed ���պ�branchʱ��ʾ��ͼƬ��
--return ��true or nil (�ɹ�����ʧ��) 
--ע�⣺���ĳ���ڵ㵥���ı�������ĳ��image����������ʱ�Թ������ù��Ľڵ㡣
--ʵ�֣�
function set_folder_image_l(tree,tid,ImageExpand,ImageCollapsed)
    if not tree or not tid  then error("Missing parameter !") return end 
   	if ImageExpand then set_folder_image_expanded_l(tree,tid,ImageExpand ) end
    if ImageCollapsed then set_folder_image_collapsed_l(tree,tid,ImageCollapsed) end 
end


--���ܣ����tree��ѡ�е����нڵ�id
--������
--		tree���ؼ��������
--return ��ids������ֵ��һ��id�����,���磺ids = {1,4,9,...}
--ʵ�֣�
function get_selected_nodes(tree)
	if not tree  then error("Missing parameter !") return end 
	local str = tree.MARKEDNODES
	local ids = {}
	for i = 1,#str do 
		if string.sub(str,i,i) == "+" then
			table.insert(ids,i-1)
		end
	end
	return ids
end

--���ܣ����tree��ѡ���ļ��нڵ���ӽڵ����Ŀ������������㼶��
--������
--		tree���ؼ��������
--		tid  (�ڵ�id)��
--return : ����ֵ��һ��numberֵ���ӽڵ�ĸ����� 
--ʵ�֣�
function get_folder_count(tree,tid)
	if not tree or not tid then error("Missing parameter !") return end 
	return tonumber(tree["childcount" .. tid])
end


--���ܣ����tree��ѡ���ļ��нڵ������ӽڵ����Ŀ����������㼶��
--������
--		tree���ؼ��������
--		tid  (�ڵ�id)��
--return : ����ֵ��һ��numberֵ���ӽڵ�ĸ����� 
--ʵ�֣�
function get_folder_totalcount(tree,tid)
	if not tree or not tid then error("Missing parameter !") return end 
	return tonumber(tree["totalchildcount" .. tid])
end

--���ܣ����tree�нڵ������
--������
--		tree���ؼ��������
--return : ����ֵ��һ��numberֵ���ڵ�ĸ����� 
--ʵ�֣�
function get_tree_count(tree)
	if not tree then error("Missing parameter !") return end 
	return tonumber(tree.count)
end

--���ܣ����tree�и��ݲ�ͬ����ڵ�ĸ���
--������
--		tree���ؼ��������
--return : ����ֵ��һ��numberֵ���ڵ�ĸ����� 
--ʵ�֣�
function get_count(tree,tid,str)
	if not tree then error("Missing parameter !") return end 
	if tid then 
		if str == "total" then 
			return get_folder_totalcount(tree,tid)
		else
			return get_folder_count(tree,tid)
		end
	else 
		return get_tree_count(tree)
	end
end

--���ܣ����tree�е�ǰ�ڵ����Ա�
--������
--		tree���ؼ��������
--		tid  (�ڵ�id)��
--return ���ýڵ�������������Ա�ֵ����Ϊnil����ǰ�ڵ�δ����ֵ������
--ʵ�֣�
function get_node_attribute(tree,tid)
	if not tree or not tid then error("Missing parameter !") return end 
	return iup.TreeGetUserId(tree,tid)
end

function get_parent_node(tree,tid)
	if not tree or not tid then error("Missing parameter !") return end 
	return tonumber(tree["parent" .. tid])
end

function get_node_kind(tree,tid)
	if not tree or not tid then error("Missing parameter !") return end 
	return (tree["KIND" .. tid])
end

function get_node_title(tree,tid)
	if not tree or not tid then error("Missing parameter !") return end 
	return tree["TITLE" .. tid]
end


function get_node_depth(tree,tid)
	return tonumber(tree["DEPTH" .. tid])
end

function get_node_path_ids(tree,tid,ids)
	local ids = ids or {}
	if tonumber(tid) == 0 then 
		table.insert(ids,1,tid)
		return ids
	else 
		table.insert(ids,1,tid)
		return get_node_path_ids(tree,get_parent_node(tree,tid),ids)
	end 
end

function get_name_id(tree,tid,name)
	local nums = get_folder_count(tree,tid)
	local curid = tid + 1
	for i =1,nums do 
		if get_node_title(tree,curid) == name then 
			return curid
		end 
		curid = curid + 1 + get_folder_totalcount(tree,curid)
	end
end

--���ܣ���������������tree��ĳ���ڵ�ʱ���Զ������Ļص�������
--������
--   	tree ���ؼ������
--		f    ���Լ���Ҫ����ĺ�����
--		args   (���ݱ���ص������д�����Ҫ��������ݷ�װ��һ���������д���)
--ע�⣺
--		��Ҫʹ�øú�����Ҫ�ڶԻ��򵯳�ǰ����ʼ�����á�
--		�ú���������������һ����tree���������һ�������������Լ�����ĺ���f
--		����ĺ���f��Ҫ����������������id�����ظ���ѡ�еĽڵ�id����number��ֵ��1 ���� 0��ѡ�кͷ�ѡ��״̬��
--		�ڴ����ص�ʱ�����Զ����ú���f����ֵid��number��
--ʵ�֣�
function cb_lclick(tree,f,args)
	function tree:selection_cb(id,number)
		f(id,number,args);
	end
end

--���ܣ���������Ҽ�����tree��ĳ���ڵ�ʱ���Զ������Ļص�������
--������
--   	tree ���ؼ������
--		f    ���Լ���Ҫ����ĺ�����
--		args   (���ݱ���ص������д�����Ҫ��������ݷ�װ��һ���������д���)
--ע�⣺
--		��Ҫʹ�øú�����Ҫ�ڶԻ��򵯳�ǰ����ʼ�����á�
--		�ú���������������һ����tree���������һ�������������Լ�����ĺ���f
--ʵ�֣�
function cb_rclick(tree,f,args)
	function tree:rightclick_cb(id)
		f(id,args)
	end
end

--���ܣ��������ѡ�нڵ㲢˫��������ʱ�Զ������Ļص�������
--������
--   	tree ���ؼ������
--		f    ���Լ���Ҫ����ĺ�����
--		args   (���ݱ���ص������д�����Ҫ��������ݷ�װ��һ���������д���)
--ע�⣺
--		��Ҫʹ�øú�����Ҫ�ڶԻ��򵯳�ǰ����ʼ�����á�
--		�ú���������������һ����tree���������һ�������������Լ�����ĺ���f
--ʵ�֣�
function cb_dlclick(tree,f,args)
	function tree:button_cb(button,pressed,x,y,str)
		if string.find(str,"1") and string.find(str,"D") then
			f(args)
		end
	end
end




function cb_branchopen(tree,f,args)
	function tree:branchopen_cb(id)
		f(id,args)
	end
end


function cb_dragdrop(tree,f,args)
	function tree:dragdrop_cb(drag_id, drop_id, isshift, iscontrol)
		drag_id = tonumber(drag_id)
		drop_id = tonumber(drop_id)
		f(drag_id,drop_id,args,isshift,iscontrol)
	end
end

--���ݽڵ��title�����ڴ���tid�µĽڵ�idֵ
function get_tree_id(tree,tid,name)

end


function set_tabtitle(tree,tabtitle)
	tree.TABTITLE  = tabtitle
end


function get_title(tree,tid)
	if not tree or not tid   then error("Missing parameter !") return end 
	return tree["TITLE" .. tid]
end

function set_rastersize(tree,rastersize)
	tree.rastersize = rastersize
end



--[[

-- ��������
item_add_ = iup.item{title = "Add"}
item_add_branch_ = iup.item{title = "Add Branch"}
item_add_leaf_ = iup.item{title = "Add Leaf"}
item_insert_ = iup.item{title = "Insert"}
item_insert_branch_ = iup.item{title = "Insert Branch"}
item_insert_leaf_ = iup.item{title = "Insert Leaf"}
item_delete_ = iup.item{title = "Delete"}
item_delete_nodes_ = iup.item{title = "Delete Nodes"}
item_set_title_ = iup.item{title = "Set title"}
item_set_state_ = iup.item{title = "Set state"}
item_color_ = iup.item{title = "Color"}
item_set_image_ = iup.item{title = "Set Image"}
item_set_branches_ = iup.item{title = "set branches image"}
item_set_leaf_ = iup.item{title = "set leaves image"}
--iup.SetAttribute(item_add_, "IMAGE", "IUP_FileNew");
--item_test_ = iup.item{title = "&Test\tCtrl+N"}
item_get_select_nodes_ = iup.item{title = "Get Select Nodes"}
item_get_node_path_ = iup.item{title = "Get Node Path"}
item_get_son_count_ = iup.item{title = "Get Son Count"}
item_get_total_son_count_ = iup.item{title = "Get total Son Count"}
item_get_son_nodes_ = iup.item{title = "Get Son Nodes"}
item_get_total_son_nodes_ = iup.item{title = "Get total Son Nodes"}
menu_ = iup.menu{
	item_add_;
	item_add_branch_;
	item_add_leaf_;
	item_insert_;
	item_insert_branch_;
	item_insert_leaf_;
	iup.separator{};
	item_delete_;
	item_delete_nodes_;
	iup.separator{};
	item_set_title_;
	item_set_state_;
	iup.separator{};
	item_color_;
	iup.separator{};
	item_set_image_;
	item_set_branches_;
	item_set_leaf_;
	iup.separator{};
	item_get_select_nodes_;
	item_get_node_path_;
	iup.separator{};
	item_get_son_count_;
	item_get_total_son_count_;
	item_get_son_nodes_;
	item_get_total_son_nodes_;
--	item_test_;
} 

local tree = iup.tree{rastersize = "200x200"}
tree.title0 = "Test"
tree.MARKMODE="MULTIPLE"
local dlg = iup.dialog{
 		iup.vbox{
			tree;
		};
 }

local save_sel_id = 0
local function rightclick(id)
	menu_:popup(iup.MOUSEPOS,iup.MOUSEPOS)
end
local function deal_select(id,number)
	if number == 1 then
		save_sel_id = id
	end
end

cb_rightclick(tree,rightclick)
cb_selection(tree,deal_select)

function item_add_branch_:action()
	add_branch(tree,save_sel_id,self.title)
end
function item_add_leaf_:action()
	add_leaf(tree,save_sel_id,self.title)
end
function item_insert_leaf_:action()
	insert_leaf(tree,save_sel_id,self.title)
end

function item_insert_branch_:action()
	insert_branch(tree,save_sel_id,self.title)
end
function item_add_:action()
	add_node(tree,save_sel_id,self.title,"BRANCH")
	add_node(tree,save_sel_id,self.title)
end
function item_insert_:action()
	insert_node(tree,save_sel_id,self.title,"BRANCH")
	insert_node(tree,save_sel_id,self.title)
end

function item_delete_:action()
	delete_node(tree,save_sel_id)
end

function item_delete_nodes_:action()
	local t = {}
	local ids = get_select_nodes(tree)
	delete_nodes(tree,ids)
end

function item_set_title_:action()
	set_title(tree,save_sel_id,"Set Title")
end
function item_set_state_:action()
	set_state(tree,save_sel_id,"EXPANDED")
end

function item_color_:action()
	set_color(tree,save_sel_id,"10 200 140")
end

function item_set_image_:action()
	set_image(tree,save_sel_id,"D:\\image\\image\\File.bmp")
end

function item_set_branches_:action()
	set_branch_image(tree,nil,"D:\\image\\image\\folder.bmp")
end

function item_set_leaf_:action()
	--set_leaf_image(tree,"IMGBLANK")
	--set_leaf_image(tree,"IMGPAPER")
	--set_leaf_image(tree,"IUP_FileOpen")
	set_leaf_image(tree,"IUP_EditPaste")
	--set_leaf_image(tree,"D:\\image\\image\\File.bmp")
end


function item_get_select_nodes_:action()
	local ids = get_select_nodes(tree)
	for k,v in ipairs (ids) do
		print(v)
	end
end

function item_get_node_path_:action()
	print(save_sel_id)
	print(get_node_path(tree,save_sel_id,0))
end

function item_get_son_count_:action()
	print(get_son_count(tree,save_sel_id))
end
function item_get_total_son_count_:action()
	print(get_total_son_count(tree,save_sel_id))
end
function item_get_son_nodes_:action()
	local t = get_son_nodes(tree,save_sel_id)
	for k,v in ipairs (t) do 
		print(v)
	end
end
function item_get_total_son_nodes_:action()
	local t = get_total_son_nodes(tree,save_sel_id)
	for k,v in ipairs (t) do 
		print(v)
	end
end
--[==[
function item_test_:action()
	print("here")
end

function dlg:k_any(c)
	if c == iup.K_cN then 
		item_test_:action()
	end
end
--]==]
dlg:popup()
 
--]]
 
 
 
 
 
 
 
