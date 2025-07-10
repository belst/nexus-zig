const std = @import("std");
const imgui = @import("imgui");
const nexus = @import("nexus");

fn render() callconv(.C) void {
    if (imgui.ImGui_Begin("zig test", null, 0)) {
        const S = struct {
            var open: bool = true;
        };
        if (S.open) {
            S.open = !imgui.ImGui_Button("hide");
            imgui.ImGui_Text("zig test");
        } else {
            S.open = imgui.ImGui_Button("show");
        }
    }
    imgui.ImGui_End();
}

var api: *nexus.AddonAPI = undefined;

fn load(a: ?*nexus.AddonAPI) callconv(.C) void {
    if (a) |ap| {
        ap.*.Log.?(nexus.ELogLevel_TRACE, "zig_test", "setting up imgui context and allocators");
        imgui.ImGui_SetCurrentContext(@ptrCast(ap.*.ImguiContext));
        imgui.ImGui_SetAllocatorFunctions(@ptrCast(ap.*.ImguiMalloc), @ptrCast(ap.*.ImguiFree), null);
        ap.*.Log.?(nexus.ELogLevel_TRACE, "zig_test", "zig test loaded");
        ap.*.Renderer.Register.?(nexus.ERenderType_Render, &render);
        ap.*.Log.?(nexus.ELogLevel_TRACE, "zig_test", "zig renderer registered");
        api = ap;
    }
}

fn unload() callconv(.C) void {
    api.*.Renderer.Deregister.?(&render);
}

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
