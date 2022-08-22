local p = premake
p.extensions.vcpkg = p.extensions.vcpkg or {
	__cache__           = {},
	_VERSION            = "1.0.0",
	_VCPKG_TOOL_VERSION = "2022-07-21",
}
local m = p.extensions.vcpkg

p.api.register {
	name   = "vcpkg_tool_version",
	scope  = "project",
	kind   = "string",
	tokens = true,
}

p.api.register {
	name   = "vcpkg_install_dir",
	scope  = "project",
	kind   = "directory",
	tokens = true,
}
