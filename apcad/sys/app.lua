_ENV=module_seeall(...,package.seeall)

local apps_ = {};

local function is_ok(file)
	if not require"sys.api.dir".is_there_file(file..".lua") then return end
	if type(require(file))~="table" then return end
	return true;
end

function cfg()
	local t = require"sys.io".readfile{file="cfg/app.lua"};
	if type(t)~="table" then return end
	apps_ = {};
	for i,v in ipairs(t) do
		if is_ok(v) then table.insert(apps_,v) end
	end
end


function load()
	if type(apps_)~="table" then return end
	for i,v in ipairs(apps_) do
		if require"sys.api.dir".is_there_file(v..".lua") and type(require(v))=="table" and type(require(v).on_load)=="function" then require(v).on_load() end
	end
end

function init()
	if type(apps_)~="table" then return end
	for i,v in ipairs(apps_) do
		if require"sys.api.dir".is_there_file(v..".lua") and type(require(v))=="table" and type(require(v).on_init)=="function" then require(v).on_init() end
	end
end

function esc(sc)
	if type(apps_)~="table" then return end
	for i,v in ipairs(apps_) do
		if require"sys.api.dir".is_there_file(v..".lua") and type(require(v))=="table" and type(require(v).on_esc)=="function" then require(v).on_esc() end
	end
end

function clear(sc)
	if type(apps_)~="table" then return end
	for i,v in ipairs(apps_) do
		if require"sys.api.dir".is_there_file(v..".lua") and type(require(v))=="table" and type(require(v).on_clear)=="function" then require(v).on_clear() end
	end
end
