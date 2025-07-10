const std = @import("std");
const Build = std.Build;

pub fn build(b: *Build, target: Build.ResolvedTarget, optimize: std.builtin.OptimizeMode) *Build.Module {
    const module = b.addModule("imgui", .{
        .root_source_file = b.path("libs/cimgui/src/root.zig"),
        .target = target,
        .optimize = optimize,
    });

    module.addIncludePath(.{ .cwd_relative = "common/imgui" });
    module.addCSourceFile(.{ .file = b.path("common/imgui/imgui.cpp"), .flags = &.{""} });
    module.addCSourceFile(.{ .file = b.path("common/imgui/imgui_widgets.cpp"), .flags = &.{""} });
    module.addCSourceFile(.{ .file = b.path("common/imgui/imgui_tables.cpp"), .flags = &.{""} });
    module.addCSourceFile(.{ .file = b.path("common/imgui/imgui_draw.cpp"), .flags = &.{""} });
    module.addCSourceFile(.{ .file = b.path("common/imgui/imgui_demo.cpp"), .flags = &.{""} });
    module.addCSourceFile(.{ .file = b.path("common/imgui/dcimgui.cpp"), .flags = &.{""} });
    module.addCSourceFile(.{ .file = b.path("common/imgui/dcimgui_internal.cpp"), .flags = &.{""} });
    return module;
}
