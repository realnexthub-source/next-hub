-- ============================================================================
-- NEXT HUB | No-Key Loader v2
-- ============================================================================

local OWNER = "realnexthub-source"
local REPOSITORY = "next-hub"
local BRANCH = "main"
local FILE_NAME = "NEXTHUBxRIDEAPET.lua"
local VERSION = "1"

if not game:IsLoaded() then
	game.Loaded:Wait()
end

local supportedPlaces = {
	[124216119978534] = true,
}

if not supportedPlaces[game.PlaceId] then
	warn("[NEXT HUB] Unsupported PlaceId: " .. tostring(game.PlaceId))
	return
end

if type(loadstring) ~= "function" then
	warn("[NEXT HUB] This executor does not support loadstring")
	return
end

local url = string.format(
	"https://raw.githubusercontent.com/%s/%s/%s/%s?v=%s",
	OWNER,
	REPOSITORY,
	BRANCH,
	FILE_NAME,
	VERSION
)

local okDownload, source = pcall(function()
	return game:HttpGet(url)
end)

if not okDownload then
	warn("[NEXT HUB] Download failed: " .. tostring(source))
	return
end

if type(source) ~= "string" or source == "" then
	warn("[NEXT HUB] Downloaded file is empty")
	return
end

if source:sub(1, 1) == "<" or source:find("404: Not Found", 1, true) then
	warn("[NEXT HUB] GitHub file not found: " .. FILE_NAME)
	return
end

local chunk, compileError = loadstring(source)
if type(chunk) ~= "function" then
	warn("[NEXT HUB] Compile failed: " .. tostring(compileError))
	return
end

local okRun, runError = pcall(chunk)
if not okRun then
	warn("[NEXT HUB] Script failed: " .. tostring(runError))
end
