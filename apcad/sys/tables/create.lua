_ENV=module_seeall(...,package.seeall)


require "iuplua"
require( "iupluacontrols")

local dlg = nil;
local g_tabs_ = nil;

function create_pages(tabs)	
	--��������
	local model_db = require"sys.tree.model_db".create_model_db();
	model_db:create_db_1();
	--����һҳ
	local page_1 = require"sys.tables.page_tree".create_page();
	page_1:set_name("Model Page");
	page_1:set_model_db(model_db);
		
	
	--��������
	local model_db2 = require"sys.tree.model_db".create_model_db();
	model_db2:create_db_2();
	--����һҳ
	local page_2 = require"sys.tables.page_tree".create_page();
	page_2:set_name("Steel Page");
	page_2:set_model_db(model_db2);
	
	tabs:add(page_1:create());
	--tabs:add(page_2:create());
	
	return tabs:create();
end


function create_tabs()
	g_tabs_ = require"sys.tables.table".create_table();
	
	dlg = iup.dialog{iup.vbox{create_pages(g_tabs_); margin="5x5"};
		BORDER="NO",MAXBOX="NO", MINBOX="NO",
		MENUBOX="NO",CONTROL = "YES",size="200"..'x'}
	iup.SetAttribute(dlg,"NATIVEPARENT",frm_hwnd)
	function dlg:close_cb()
		enablewindow(frm_hwnd,true)
	end
	function dlg:show_cb(status)
		if status == 0 then
		    hdlgtree = iup.GetAttributeData(dlg,"HWND")
			add_dlgtree(frm,hdlgtree)
		end
	end
	dlg:show();
	
	--������ݹ�����Ϣ
	g_tabs_:create_controller();
	
	function dlg:resize_cb()
	
	end
	
end

-- create_tabs();
function get_tables()
	return g_tabs_;
end
function get_dlg()
	return dlg;
end








