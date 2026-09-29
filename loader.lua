if not game:IsLoaded() then
	game.Loaded:Wait()
end

local BASE = "https://raw.githubusercontent.com/realnexthub-source/next-hub/main/"

local places = {
	[124216119978534] = "NEXTHUBxRIDEAPET.lua",
}

local file = places[game.PlaceId]
if not file then
	return
end

local ok, source = pcall(function()
	return game:HttpGet(BASE .. file .. "?v=3")
end)
if not ok or type(source) ~= "string" or source == "" then
	return
end

local chunk = loadstring(source)
if type(chunk) ~= "function" then
	return
end

pcall(chunk)
