import { App, Astal, Gdk, Widget } from "astal/gtk4"
import WorkspacesModule from "./WorkspacesModule"
import DateTimeModule from "./DateTimeModule"

export default function Bar(gdkmonitor: Gdk.Monitor) {
    const { TOP, LEFT, RIGHT } = Astal.WindowAnchor
    return Widget.Window({
        gdkmonitor: gdkmonitor,
        anchor: TOP | LEFT | RIGHT,
        exclusivity: Astal.Exclusivity.EXCLUSIVE,
        application: App,
        cssClasses: ["bar"],
        visible: true,
        child: Widget.CenterBox({
            start_widget: WorkspacesModule(),
            center_widget: DateTimeModule(),
            end_widget: Widget.Box(), // empty for now
        }),
    })
}