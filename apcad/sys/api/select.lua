_ENV=module_seeall(...,package.seeall);

local drag_ = require"sys.api.drag"
local obj_ = require"sys.api.object";
local mgr_ = require"sys.mgr";

local running_ = nil;
local spt_ = nil;	--  start point
-- local cx_,cy_ = nil,nil;  --  current client x/y

function sc_sel(scene,cx,cy,w,h,single)
	-- trace_out("scene_select(): "..require"tools.dt".date_text().."\n");
	scene_select(scene,cx,cy,w,h,single);
end

local function select(scene,pt1,pt2)
	if not pt1 or not pt2 then return end;
	local x1,y1 = world_2_client(scene,pt1[1],pt1[2],pt1[3]);
	local x2,y2 = world_2_client(scene,pt2[1],pt2[2],pt2[3]);
	local cx,cy = (x1+x2)/2,(y1+y2)/2;
	local w,h = math.abs(x1-x2),math.abs(y1-y2);
	local minsize = 3;
	if w>minsize or h>minsize then
		sc_sel(scene,cx,cy,w,h,0);
	else	
		w,h=minsize,minsize;
		sc_sel(scene,cx,cy,w,h,1);
	end	
	----
	-- statusbar_set_text(frm,1,tostring(require"mgr".curs_count()));
	-- local cur = require"mgr".cur();
	-- if not cur then return end;
	-- local wpt = cur:on_get_center();
	-- local cpt = {world_2_client(scene,wpt:values())};
	-- scene_cen(scene,wpt:values());
	-- move_cen_2_pt(scene,cpt[1],cpt[2]);
end

local function hightlight(scene)
	-- if not mgr_.get_hit() then return end;
	init(scene);
	mgr_.update();
end

function init(scene)
	running_ = nil;
	-- mgr_.init_hit();
	drag_.stop(scene);
end

function start(scene,x,y)
	running_ = true;
	-- mgr_.init_hit();
	spt_ = {client_2_world(scene,x,y)};
	-- select(scene,spt_,spt_);
	-- scene_select(scene,x,y,1,1,0)
	-- hightlight(scene);
end

function stop(scene,x,y)
	if not running_ then return end;
	local pt = {client_2_world(scene,x,y)};
	select(scene,spt_,pt);
	hightlight(scene);
end

-- function set(scene,x,y)
	-- local pt = {client_2_world(scene,x,y)};
	-- mgr_.init_hit();
	-- select(scene,spt_,pt);
	-- if not mgr_.get_hit() then return end;
	-- init();
	-- mgr_.update();
-- end



