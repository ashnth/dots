import { App } from "astal/gtk4"
import style from "./style.scss"
import Bar from "./widgets/bar/Bar"

App.start({
    css: style,
    main() {
        App.get_monitors().forEach(monitor => App.add_window(Bar(monitor)))
    },
})