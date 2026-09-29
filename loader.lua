-- ============================================================================
-- NEXT HUB | No-Key Loader
-- Version: v1.0
-- ============================================================================

if not game:IsLoaded() then
	game.Loaded:Wait()
end

local SUPPORTED_PLACE_IDS = {
	[124216119978534] = true,
}

if not SUPPORTED_PLACE_IDS[game.PlaceId] then
	return
end

local GITHUB_OWNER = "realnexthub-source"
local GITHUB_REPOSITORY = "next-hub"
local GITHUB_BRANCH = "main"
local SCRIPT_FILE = "NEXTHUBxRIDEAPET.lua"
local VERSION = "v1.0"

local rawUrl = string.format(
	"https://raw.githubusercontent.com/%s/%s/%s/%s?v=%s",
	GITHUB_OWNER,
	GITHUB_REPOSITORY,
	GITHUB_BRANCH,
	SCRIPT_FILE,
	VERSION
)

local function loadMainScript()
	local ok, source = pcall(function()
		return game:HttpGet(rawUrl)
	end)
	if not ok or type(source) ~= "string" or source == "" then
		warn("[NEXT HUB] Unable to download the current script")
		return
	end

	local compile = loadstring
	if type(compile) ~= "function" then
		warn("[NEXT HUB] This executor does not support loadstring")
		return
	end

	local runOk, runError = pcall(function()
		local chunk = compile(source)
		if type(chunk) ~= "function" then
			error("downloaded script did not compile")
		end
		chunk()
	end)
	if not runOk then
		warn("[NEXT HUB] Script failed: " .. tostring(runError))
	end
end

loadMainScript()
