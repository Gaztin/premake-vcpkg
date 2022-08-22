local manifest = dofile("_manifest.lua")
for _,filepath in ipairs(manifest) do
	include(filepath)
end

local p = premake
local m = premake.extensions.vcpkg

function m.getToolVersion(prj)
	return prj.vcpkg_tool_version or m._VCPKG_TOOL_VERSION
end

function m.getInstallDir(prj)
	return prj.vcpkg_install_dir or path.join(_WORKING_DIR, ".vcpkg")
end

function m.isInstalled(prj)
	if m.__cache__.is_installed ~= nil then
		return m.__cache__.is_installed
	end
	local install_dir    = m.getInstallDir(prj)
	local program_path   = path.join(install_dir, "vcpkg.exe")
	local program_exists = os.isfile(program_path)
	local is_installed   = false
	if program_exists then
		local result, exit_code = os.outputof("\""..program_path.."\" version")
		if exit_code == 0 then
			local lines                  = result:explode("\n")
			local major, minor, patch    = lines[1]:match("(%w+)-(%w+)-(%w+)")
			local installed_tool_version = major.."-"..minor.."-"..patch
			local required_tool_version  = m.getToolVersion(prj)
			is_installed                 = (installed_tool_version == required_tool_version)
		else
			is_installed = false
		end
	end
	m.__cache__.is_installed = is_installed
	return is_installed
end

function m.install(prj)
	if m.isInstalled(prj) then
		return
	end
	local install_dir = m.getInstallDir(prj)
	os.mkdir(install_dir)
	local program_path          = path.join(install_dir, "vcpkg.exe")
	local version_date          = m.getToolVersion(prj)
	local url                   = "https://github.com/microsoft/vcpkg-tool/releases/download/"..version_date.."/vcpkg.exe"
	local result, response_code = http.download(url, program_path, {progress = m.downloadProgress})
	io.write("\n")
	if response_code ~= 200 then
		premake.error("Failed to download vcpkg: "..result)
	end
end

function m.downloadProgress(total, current)
	local total_kb   = math.floor(total / 1024)
	local current_kb = math.floor(current / 1024)
	io.write("Downloading vcpkg.exe ("..current_kb.."/"..total_kb.." KB)\r")
end
