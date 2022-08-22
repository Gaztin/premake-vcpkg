local p = premake
local m = p.extensions.vcpkg

function m.bakeFiles(base, prj)
	m.install(prj)
	return base(prj)
end

p.override(p.oven, "bakeFiles", m.bakeFiles)
