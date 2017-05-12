
--[[	
	ע�⣺���к����У������������id�ģ���������˲�������Ĭ��id�ǵ�ǰtree��ѡ�е�id
	--���ú���
	get_class() --��ȡ����������ֵ��Tree_
	Tree:new() --���ݻ�õ���new��һ���µĶ��󣬷��������
	Tree:add_branch(name,id) --���ļ��нڵ������һ���µ��ļ��нڵ㡣
	Tree:add_leaf(name,id) --���ļ��нڵ������һ���ļ��ڵ�
	Tree:insert_branch(name,id)--�ڴ������ѡ�нڵ��ͬ��Ŀ¼�����һ���ļ��нڵ�
	Tree:insert_leaf(name,id)--�ڴ������ѡ�нڵ��ͬ��Ŀ¼�����һ���ļ��ڵ�
	Tree:delete_children_nodes(id) --ɾ���������ѡ�нڵ㣨�ļ��нڵ㣩�µ������ӽڵ�
	Tree:delete_selected_nodes(id) --ɾ���������ѡ�нڵ㣬������ļ��нڵ���ô����ɾ�������ӽڵ�
	
	Tree:get_selected_id() --���ѡ����id
	Tree:get_title(id) --��������ڵ�id�Ľڵ���
	Tree:get_attr(id) --��ø����ڵ�id�����ŵ����Ա�user data
	Tree:get_tree() --��ÿؼ�����
	Tree:get_datas() --������õ�����
	Tree:get_depth(id) --��õ�ǰ�ڵ����
	Tree:get_pid(id) --��õ�ǰ�ڵ㸸�ڵ�id
	Tree:get_all_numbers(id) --��ô������ѡ�нڵ������нڵ�ĸ�����
	Tree:get_child_numbers(id) --��ô������ѡ�нڵ����ӽڵ�ĸ�����
	Tree:get_numbers() --�������tree�����еĽڵ����
	Tree:get_kind(id) --��õ�ǰ�ڵ������
	
	Tree:set_title(name,id) --���ýڵ���
	Tree:set_color(color,id) --���ýڵ���ɫ �������ǽڵ�id���Լ�Ҫ���õ���ɫ��ʾ����color = ��0 0 0������ɫ��
	Tree:set_image(image,id) --���ýڵ�ͼ�꣬
	Tree:set_leafimage(image) --��������leaf��ͼ�ꡣ
	Tree:set_tabtitle(str) --���������tabs�ؼ��ı��⡣
	Tree:set_attr(attr,id) --���ø����ڵ�id�����ŵ����Ա�user data
	Tree:set_datas(data) --����Ҫ��ʾ�����ݣ�ע�����ݱ�����Ϲ淶
	Tree:set_state(state,id) --�����ļ��нڵ��Ƿ�չ����stateֵΪ0Ϊ�պϷ���Ϊչ����
	Tree:set_marked(id) --���õ�ǰ���ѡ��tree��λ��
	Tree:set_rootname(name) --����Ĭ�ϵĸ��ڵ����ʾ������
	Tree:set_rastersize(rastersize) --����tree�����صĴ�С

	
	
	Tree:set_lbtn(lbtn) --���������Ӧ�����������Ǻ���
	Tree:set_dlbtn(dlbtn) --����˫�������Ӧ�����������Ǻ���
	Tree:set_rbtn(rbtn) --���õ����Ҽ���Ӧ������һ��������
	Tree:set_rmenu(Rmenu) --�����Ҽ������˵���������һ�������Ҽ����ݵ����ݱ�
	Tree:init_tree_datas(data,id) --�����ڽڵ�id��Ҫ��ʾ�����ݡ�
	--���ݸ�ʽ
	data = {
		[1] = {
			Kind = 'BRANCH';
			--���� ֵΪ��BRANCH����ʾ�����ļ��нڵ㣬���������������keyΪDatas������չ�ӽڵ㣬ֵΪ��LEAF����Ϊ�ļ��ڵ㡣
		--	Color = '255 0 0';--��ɫ
			--Image = ������--ͼƬ
			--Attr = {}--���Ա������ڽڵ��ϵ�����
			--BranchOpen = true --չ�����ļ��нڵ�
			--BranchClose = true --�պϽڵ�
			Title = '';
			Datas = { --��һ�㼶
				[1] = {
					Color = '255 0 0';--��ɫ
					Image = ������-- ͼƬ
					Attr = {}--���Ա������ڽڵ��ϵ�����
					Kind = 'LEAF';
				};
			};
		}
	}
	
	--�򵥵�ʹ�÷�����
	local tree = require'...'.get_class():new()
	tree:show() --ע����������ڶԻ�����߽���û�е���֮ǰ�Ѿ���ֵ����ô����Ҫ�ڵ������������
	
	ע�⣺��Ҫ��ʾtree����ʹ�� tree:get_tree()  ���iup��tree�ؼ�����������Ҫ��Ҫ��ʾ�������С�
--]]


_ENV = module_seeall(...,package.seeall)
local IupTree_ = require 'apx.sjy.tree.iuptree'
Tree = {
}

function get_class()
	return Tree
end

local function create_control(t)
	return IupTree_.create{
		font = "COURIER_NORMAL_10";
		addexpanded = "NO";
		expand="YES";
		showrename = "NO";
		MARKMODE="SINGLE";
		title0 = 'Project';
		IMAGELEAF = "IMGPAPER";
		map_cb =  function() 
			t.Map = true
			t:init_lbtn()
			t:init_dlbtn()
			t:init_rbtn() 
			t:show() 
		end;
	};
end

function Tree:new(t)
	local t = t or {}
	setmetatable(t,self)
	self.__index = self;
	t.Hwnd = create_control(t);
	return t
end

local function table_is_empty(t)
	return _G.next(t) == nil
end

---------------------------------------class op  -------------------

function Tree:warning()
	if not self.Map then iup.Message('Notice','The tree has not been mapped !') return end 
	return true 
end

function Tree:add_branch(name,id)
	if not self:warning() then return end 
	local id = id or self:get_selected_id()
	IupTree_.add_branch(self.Hwnd,id,name)
end

function Tree:add_leaf(name,id)
	if not self:warning() then return end
	local id = id or self:get_selected_id()	
	IupTree_.add_leaf(self.Hwnd,id,name)
end

function Tree:insert_branch(name,id)
	if not self:warning() then return end 
	local id = id or self:get_selected_id()
	IupTree_.insert_branch(self.Hwnd,id,name)
end

function Tree:insert_leaf(name,id)
	if not self:warning() then return end 
	local id = id or self:get_selected_id()
	IupTree_.insert_leaf(self.Hwnd,id,name)
end


function Tree:delete_children_nodes(id)
	if not self:warning() then return end 
	local id = id or self:get_selected_id()
	IupTree_.delete_children_node(self.Hwnd,id)
end

function Tree:delete_selected_nodes(id)
	if not self:warning() then return end 
	local id = id or self:get_selected_id()
	IupTree_.delete_selected_node(self.Hwnd,id)
end

function Tree:get_selected_id()
	return IupTree_.get_selected_nodes(self.Hwnd)[1]
end


function Tree:get_title(id)
	if not self:warning() then return end 
	local id = id or self:get_selected_id()
	return IupTree_.get_title(self.Hwnd,id)
end

function Tree:get_attr(id)
	if not self:warning() then return end 
	local id = id or self:get_selected_id()
	return IupTree_.get_node_attribute(self.Hwnd,id)
end

function Tree:get_tree()
	return self.Hwnd 
end

function Tree:get_datas()
	return self.Datas
end

function Tree:get_depth(id)
	if not self:warning() then return end 
	local id = id or self:get_selected_id()
	return IupTree_.get_node_depth(self.Hwnd,id)
end

function Tree:get_pid(id)
	if not self:warning() then return end 
	local id = id or self:get_selected_id()
	return IupTree_.get_parent_node(self.Hwnd,id)
end

function Tree:get_all_numbers(id)
	if not self:warning() then return end 
	local id = id or self:get_selected_id()
	return IupTree_.get_folder_totalcount(self.Hwnd,id)
end

function Tree:get_child_numbers(id)
	if not self:warning() then return end 
	local id = id or self:get_selected_id()
	return IupTree_.get_folder_count(self.Hwnd,id)
end


function Tree:get_numbers()
	if not self:warning() then return end 
	return IupTree_.get_tree_count(self.Hwnd) 
end

function Tree:get_datas()
	--IupTree_.set_rastersize(self.Hwnd,rastersize)
end

function Tree:get_kind(id)	
	if not self:warning() then return end 
	local id = id or self:get_selected_id()
	return IupTree_.get_node_kind(self.Hwnd,id)
end


--color = '255 255 255'
function Tree:set_color(color,id)
	IupTree_.set_color(self.Hwnd,id,color)
end


function Tree:set_image(image,id)
	local id = id or self:get_selected_id()
	IupTree_.set_image(self.Hwnd,id,image)
end

function Tree:set_image(image,id)
	local id = id or self:get_selected_id()
	IupTree_.set_image(self.Hwnd,id,image)
end

function Tree:set_leafimage(image)
	local image = type(image) == 'string' and image or 'IMGPAPER'
	IupTree_.set_file_image_g(self.Hwnd,image) 
end


function Tree:set_tabtitle(str)
	self.tabtitle = str
	IupTree_.set_tabtitle(self.Hwnd,str)
end

function Tree:set_attr(attr,id)
	IupTree_.set_node_attribute(self.Hwnd,id,attr)
end


function Tree:set_datas(data)
	self.Datas = type(data) == 'table' and data or {}
end

function Tree:set_state(state,id)
	local id = id or self:get_selected_id()
	if state == 0 then 
		IupTree_.set_folder_collapsed(self.Hwnd,id)
	elseif state == 1 then
		IupTree_.set_folder_expanded(self.Hwnd,id)
	end 
end

function Tree:set_title(name,id)
	local id = id or self:get_selected_id()
	IupTree_.set_title(self.Hwnd,id,name)
end

function Tree:set_rootname(name)
	local id = 0
	self:set_title(name,id)
end

function Tree:set_marked(id)
	IupTree_.set_marked(self.Hwnd,id,"yes")
end

function Tree:set_rastersize(rastersize)
	IupTree_.set_rastersize(self.Hwnd,rastersize)
end

----------------------------------------------------------

function Tree:set_lbtn(lbtn)
	self.Lbtn = type(lbtn) == 'function' and lbtn 
end


function Tree:init_lbtn()
	if not self.Hwnd then return error('Please create tree firstly !') end 
	local tree = self.Hwnd
	local function deal_callback(id,number)
		if number == 1 then 
			local t = self:get_attr(id) 
			if type(t) == 'table' and type(t.Lbtn) == 'function' then 
				return t.Lbtn(tree,id)
			end 
			if  type(self.Lbtn) == 'function' then 
				self.Lbtn(tree,id)
			end
		end
	end
	IupTree_.cb_lclick(tree,deal_callback)
end


function Tree:set_dlbtn(dlbtn)
	self.Dlbtn = type(dlbtn) == 'function' and dlbtn 
end

function Tree:init_dlbtn()
	if not self.Hwnd then return error('Please create tree firstly !') end 
	local tree = self.Hwnd
	local function deal_callback(id)
		local id = self:get_selected_id() 
		local t = self:get_attr(id) 
		if type(t) == 'table' and type(t.DLbtn) == 'function' then 
			return t.DLbtn(self)
		end 
		if  type(self.DLbtn) == 'function' then 
			self.DLbtn(tree,id)
		end
	end
	IupTree_.cb_dlclick(tree,deal_callback)
end


function Tree:set_rbtn(rbtn)
	self.Rbtn = type(rbtn) == 'function' and rbtn 
end

function Tree:set_rmenu(Rmenu)
	self.Rmenu = type(Rmenu) == 'table' and Rmenu 
end

-- function Tree:set_rmenu_rule(rule)
	-- if type(rule) == 'function' then 
		-- self.RmenuRule = rule
	-- end
-- end


function Tree:init_rbtn()
	if not self.Hwnd then return error('Please create tree firstly !') end 
	local tree = self.Hwnd
	local function deal_callback(id)
		self:set_marked(id)
		local t = self:get_attr(id) 
		--require 'sys.table'.totrace(t)
		--if not t then return end 
		if  type(t) == 'table' and type(t.Rmenu) == 'table' then 
			local rmenu = require 'apx.sjy.rmenu.rmenu'.get_class():new()
			rmenu:set_datas(t.Rmenu)
			return rmenu:show(tree,id)
		end
		if type(t) == 'table' and type(t.Rbtn) == 'function' then 
			return t.Rbtn(tree,id)
		end 
		if  type(self.Rmenu) == 'table' then 
			local rmenu = require 'apx.sjy.rmenu.rmenu'.get_class():new()
			rmenu:set_datas(self.Rmenu)
			return rmenu:show(tree,id)
		end
		if  type(self.Rbtn) == 'function' then 
			return self.Rbtn(tree,id)
		end
	end
	IupTree_.cb_rclick(tree,deal_callback)
end


function Tree:wait_expanded(id)
	self.BranchOpenNodes = self.BranchOpenNodes or {}
	table.insert(self.BranchOpenNodes,id)
end 

function Tree:expanded_nodes()
	self.BranchOpenNodes = self.BranchOpenNodes or {}
	for k,v in ipairs (self.BranchOpenNodes) do 
		self:set_state(1,v)
	end 
	self.BranchOpenNodes = nil
end 



function Tree:wait_close(id)
	self.BranchCloseNodes = self.BranchCloseNodes or {}
	table.insert(self.BranchCloseNodes,id)
end

function Tree:closed_nodes()
	self.BranchCloseNodes = self.BranchCloseNodes or {}
	for k,v in ipairs (self.BranchCloseNodes) do 
		self:set_state(0,v)
	end 
	self.BranchCloseNodes = nil
end 


function Tree:set_node_status(t,id)
	for k,v in pairs (t) do 
		if k == 'Color' then 
			self:set_color(v,id) 
		elseif k == 'Image' then 
			v = string.gsub(v,'/','\\')
			self:set_image(v,id) 	
		elseif k == 'Attr' then 
			self:set_attr(v,id)	
		elseif k == 'BranchOpen' then 
			self:wait_expanded(id)
		elseif k == 'BranchClose' then 
			self:wait_close(id)
		end
	end 
end
--[[
function Tree:set_tree_data(data,id)
	if type(data) ~= 'table' or #data == 0 then return end
	local tree = self.Hwnd
	if id < 0 then
		local curnodes = 0
		for k,v in ipairs (data) do 
			if k == 1 then 
				local curid = curnodes
				self:set_title(v.Title,curid)
				self:set_tree_data(v.Datas,curid)
				self:set_node_status(v,curid)
			else 	
				if v.Kind == 'BRANCH' then 
					local curid = curnodes
					self:insert_branch(v.Title,curid)	
					curnodes = self:get_numbers() - 1
					self:set_tree_data(v.Datas,curnodes)
				else 
					self:insert_leaf(v.Title,curnodes)
					curnodes = self:get_numbers() - 1
				end
				
				self:set_node_status(v,curnodes)
			end 
		end 
	else 
		trace_out('id = ' .. id .. '\n')
		for i = #data ,1,-1 do 
			if data[i].Kind == 'BRANCH' then
				self:add_branch(data[i].Title,id)
				self:set_tree_data(data[i].Datas,id + 1)
			elseif  data[i].Kind == 'LEAF' then 
				trace_out('data[i].title = ' .. data[i].Title .. '\n')
				self:add_leaf(data[i].Title,id)
			end 
			self:set_node_status(data[i],id + 1)
		end  
	end
end
]]
function Tree:set_tree_data(data,id)
	if type(data) ~= 'table' or #data == 0 then return end
	local cur_id = id < 0 and 0 or id 
	for k,v in ipairs (data) do 
		if k == 1 then
			if id < 0 then 
				self:set_title(v.Title,cur_id)
				self:set_tree_data(v.Datas,cur_id)
			else 
				if v.Kind == 'BRANCH' then 
					self:add_branch(v.Title,cur_id)
					cur_id = cur_id + 1
					self:set_tree_data(v.Datas,cur_id)
				else 
					self:add_leaf(v.Title,id)
					cur_id = cur_id + 1
				end 
			end 
			
		else 
			if v.Kind == 'BRANCH' then 
				self:insert_branch(v.Title,cur_id)	
				cur_id = cur_id + self:get_all_numbers(cur_id) + 1
				self:set_tree_data(v.Datas,cur_id)
			else 
				self:insert_leaf(v.Title,cur_id)
				cur_id = cur_id + self:get_all_numbers(cur_id) + 1
			end
		end
		self:set_node_status(v,cur_id)		
	end
end


function Tree:init_tree_datas(data,id)
	data = type(data) == 'table' and data or {}
	local id = id or -1
	self:delete_children_nodes(id)
	self:set_leafimage()
	self:set_tree_data(data,id)
	self:set_state(1,id < 0 and 0 or id)
	self:expanded_nodes()
	self:closed_nodes()

end 

function Tree:show(data)
	
	local data = type(data) == 'table' and data or self.Datas or {}
	if table_is_empty(data) then return end 
	self:init_tree_datas(data)
end


