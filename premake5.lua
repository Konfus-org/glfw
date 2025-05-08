project "GLFW"
    kind "SharedLib"
    language "C"

    if OutputIntermediateDir == nil or OutputTargetDir == nil then
        targetdir ("Build/bin/%{prj.name}/")
        objdir    ("Build/obj/%{prj.name}/")

    else
        targetdir ("../../../" .. OutputTargetDir .. "")
        objdir    ("../../../" .. OutputIntermediateDir .. "")
    end

    files
    {
        "src/*.c",
        "include/GLFW/*.h",
        "./**.md",
        "./**.lua"
    }

    includedirs
    {
        "include"
    }

    defines
    {
        "_GLFW_BUILD_DLL" -- Required to export GLFW symbols when building a shared library
    }

    filter "configurations:Debug"
        runtime "Debug"
        buildoptions { "/MDd" } 
        symbols "On"

    filter "configurations:Optimized"
        runtime "Release"
        buildoptions { "/MDd" } 
        optimize "On"

    filter "configurations:Release"
        runtime "Release"
        optimize "On"
        buildoptions { "/MD" } 
        symbols "Off"

    filter "system:windows"
        systemversion "latest"
        defines
        {
            "_GLFW_WIN32", -- Platform-specific define
            "_CRT_SECURE_NO_WARNINGS"
        }

        files
        {
            "src/win32_*.c",
            "src/wgl_context.c",
            "src/egl_context.c",
            "src/osmesa_context.c"
        }

    filter "system:linux"
        defines
        {
            "_GLFW_X11"
        }

        files
        {
            "src/x11_*.c",
            "src/xkb_unicode.c",
            "src/posix_*.c",
            "src/glx_context.c",
            "src/egl_context.c",
            "src/osmesa_context.c"
        }

        links
        {
            "dl",       -- Dynamic linking library
            "pthread",  -- POSIX threads
            "X11"       -- X11 for windowing
        }

    filter "system:macosx"
        defines
        {
            "_GLFW_COCOA"
        }

        files
        {
            "src/cocoa_*.m",
            "src/posix_thread.c",
            "src/nsgl_context.c",
            "src/egl_context.c",
            "src/osmesa_context.c"
        }

        links
        {
            "Cocoa.framework",
            "IOKit.framework",
            "CoreFoundation.framework"
        }
