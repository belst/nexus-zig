const std = @import("std");
const imgui = @import("imgui");
const nexus = @import("nexus");

fn load(a: ?*nexus.AddonAPI) callconv(.C) void {
    if (a) |ap| {
        ap.*.Log.?(nexus.ELogLevel_TRACE, "zig_test", "zig test loaded");
    }
}

fn unload() callconv(.C) void {}

pub export fn GetAddonDef() callconv(.C) *const nexus.AddonDefinition {
    return &.{
        .Signature = -12341231,
        .APIVersion = nexus.NEXUS_API_VERSION,
        .Name = "zig test",
        .Author = "belst",
        .Description = "zig test",
        .Version = .{
            .Major = 9,
            .Minor = 9,
            .Build = 9,
            .Revision = 9,
        },
        .Load = &load,
        .Unload = &unload,
    };
}
