--module(...,package.seeall)
_ENV = module_seeall(...,package.seeall)
local dock_new_ = require "sys.api.dock"
local dlg = nil
function get_tabs()
	return dock_new_.get_tabs()
end

function add_page(hwnd)
	
	dock_new_.add_page(hwnd)
	if dlg then  dlg:destroy() dlg = nil end
end



function del_page(hwnd)
	dock_new_.del_page(hwnd)
end

function create()
	--tabs = iup.tabs()
	if dock_new_.get_dlg() then return end 
	dlg = iup.dialog{BORDER="NO",MAXBOX="NO", MINBOX="NO", MENUBOX="NO",CONTROL = "YES",size = "0x0"}
	iup.SetAttribute(dlg,"NATIVEPARENT",frm_hwnd)
	function dlg:close_cb()
		iup.MainLoop()
	end
	function dlg:show_cb(status)
		if status == 0 then
		    hdlgtree = iup.GetAttributeData(dlg,"HWND")
			add_dlgtree(frm,hdlgtree)
			
		end
	end
	dlg:show()
end

--������name �������ǩҳ�����֣�
--����ֵ��true�������ǩҳ�ɹ���
function set_cur_tab(name)
	if not name then return end 
	local tabs = get_tabs()
	local num = tabs.COUNT
	for i = 1,num do
		local title = tabs["TABTITLE" .. (i-1)]
		if title == name then 
			tabs.VALUEPOS = i-1
			return true 
		end
	end
end
function active_page(hwnd)
	add_page(hwnd);
	set_cur_tab(hwnd.tabtitle);
end
