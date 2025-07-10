const std = @import("std");
const imgui = @import("imgui");

pub export fn show_demo_window() void {
    imgui.ImGui_ShowDemoWindow(@constCast(&true));
}
