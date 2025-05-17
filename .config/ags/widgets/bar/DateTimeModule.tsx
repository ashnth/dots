import { GLib, Variable} from "astal";
import { Widget } from "astal/gtk4";

const time = Variable(GLib.DateTime.new_now_local()).poll(1000, () =>
  GLib.DateTime.new_now_local()
);

export default function DateTimeModule() {
  return Widget.Label({
    label: time((t) => t.format("%H:%M")!),
    cssClasses: ["datetime"],
  });
}