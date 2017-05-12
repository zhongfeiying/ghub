

--[[
	--���ú���
	get_class() --��ȡ����������ֵ�� Rmenu_
	Rmenu_:new(t) --���ݻ�õ���new��һ���µĶ��󣬷��������
	Rmenu_:set_datas(datas) --���ò˵��е���ʾ��item���ݣ�ע������Ҫ���Ϲ淶
	Rmenu_:show() --�����Ҽ��˵���
--]]
_ENV = module_seeall(...,package.seeall)
local IupRmenu_ = require 'apx.sjy.rmenu.Iupmenu'
local Rmenu_ = {
}

function get_class()
	return Rmenu_
end

function Rmenu_:new(t)
	local t = t or {}
	setmetatable(t,self)
	self.__index = self;
	return t
end

local function table_is_empty(t)
	return _G.next(t) == nil
end

function Rmenu_:get_rmneu()
	return self.Hwnd
end

function Rmenu_:set_datas(datas)
	self.Datas = datas
end

function Rmenu_:get_datas()
	return self.Datas
end

function Rmenu_:add_item(menu,item)
	if not menu or  not item then return end 
	local curitem;
	if type(item) == 'table' then 
		local showrule;
		if type(item.ShowRule) == 'function' then 
			showrule = item.ShowRule()
			if showrule and showrule == 'hide' then return end 
		end 
		curitem = IupRmenu_.create_item{title = item.Title,action = item.Action,active = showrule}
	else 
		curitem = IupRmenu_.separator()
	end 	
	if type(menu) == 'table' then
		table.insert(menu,curitem)
	elseif type(menu) == 'userdata' then
		iup.Append(menu,curitem)
	end
end

function Rmenu_:add_submenu(menu,title,submenu)
	local item = IupRmenu_.create_submenu{
		title = title;
		IupRmenu_.create(submenu);
	}
	table.insert(menu,item)
end

local function init_data(data,menu)
	for k,v in ipairs(data) do 
		if v.Submenu then 
			local submenu = {}
			if type(v.Submenu) == 'table' then 
				init_data(v.Submenu,submenu)
			elseif type(v.Submenu) == 'function' then 
				local t = v.Submenu() or {}
				init_data(t,submenu)
			end 
			Rmenu_:add_submenu(menu,v.Title,submenu)
		else 
			Rmenu_:add_item(menu,v)
		end 
	end 
end

function Rmenu_:init()
	if type(self.Datas) ~= 'table' or table_is_empty(self.Datas) then return end 
	local menu = {}
	init_data(self.Datas,menu)
	self.Hwnd = IupRmenu_.create(menu)
	self.Hwnd.menuclose_cb = function() iup.Destroy(t.Hwnd) t.Hwnd = nil end
	return true
end

function Rmenu_:show()
	if not self:init() then return end 
	if not self.Hwnd then return end 
	iup.Refresh(self.Hwnd)
	self.Hwnd:popup(iup.MOUSEPOS,iup.MOUSEPOS)
end

function get_class()
	return Rmenu_
end