# premake-vcpkg
This extension adds support for the vcpkg package manager in your premake projects.

# Usage
```lua
require "path/to/premake-vcpkg"

workspace "MyWorkspace"
	configurations {"Debug", "Release"}
	platforms {"x64"}

project "MyApp"
	kind "WindowedApp"
```

API

`vcpkg_install_dir` (Optional) Change the destination directory of the vcpkg binary. Defaults to '.vcpkg' inside the working directory.

`vcpkg_tool_version` (Optional) Manually set the vcpkg tool version.

OPTIONS

`vcpkg-fast` Turns on fast mode that tries to invoke vcpkg only when it's absolutely necessary.
