const hyprland = await Service.import("hyprland")
const audio = await Service.import("audio")
const battery = await Service.import("battery")
const systemtray = await Service.import("systemtray")

const date = Variable("", {
	poll: [1000, 'date +"%a %b %-d"'],
})

const time = Variable("", {
	poll: [1000, 'date +"%-I:%M %p"'],
})

// widgets can be only assigned as a child in one container
// so to make a reuseable widget, make it a function
// then you can simply instantiate one by calling it

function Workspaces() {
	const workspaces = Array(5)
		.fill(() => 0)
		.map((_, index) => {
			const id = index + 1
			return Widget.Button({
				on_clicked: () => hyprland.messageAsync(`dispatch workspace ${id}`),
				child: Widget.Label(`${id}`),
				setup: self => self.hook(hyprland, self => {
					if (id === hyprland.active.workspace.id) self.className = "workspace focused";
					else if (hyprland.getWorkspace(id)?.windows > 0) self.className = "workspace normal"
					else self.className = "workspace empty"
				})
			})
		})

	return Widget.Box({
		className: "workspaces",
		children: workspaces,
	})
}


function ClientTitle() {
	return Widget.Label({
		className: "client-title",
		label: hyprland.active.client.bind("title").as(t => t || "Desktop"),
		maxWidthChars: 70,
		truncate: "end",
	})
}


function Calendar() {
	return Widget.Label({
		className: "calendar",
		label: date.bind(),
	})
}


function Clock() {
	return Widget.Label({
		className: "clock",
		label: time.bind(),
	})
}


function Volume() {
	const icons = {
		101: "overamplified",
		67: "high",
		34: "medium",
		1: "low",
		0: "muted",
	}

	function getIcon() {
		const icon = audio.speaker.is_muted ? 0 : [101, 67, 34, 1, 0].find(
			threshold => threshold <= audio.speaker.volume * 100)

		return `audio-volume-${icons[icon]}-symbolic`
	}

	const icon = Widget.Icon({
		icon: Utils.watch(getIcon(), audio.speaker, getIcon),
	})

	const label = Widget.Label({
		label: audio.speaker.bind("volume").as(v => ` ${Math.round(v * 100)}%`)
	})

	return Widget.Box({
		className: "volume",
		children: [icon, label],
	})
}


function BatteryLabel() {
	const label = battery.bind("percent").as(p => ` ${p}%`)
	const icon = battery.bind("icon_name")

	return Widget.Box({
		className: "battery",
		visible: battery.bind("available"),
		children: [
			Widget.Icon({ icon }),
			Widget.Label({ label }),
		],
	})
}


function SysTray() {
	const items = systemtray.bind("items")
		.as(items => items.map(item => Widget.Button({
			child: Widget.Icon({ icon: item.bind("icon") }),
			on_primary_click: (_, event) => item.activate(event),
			on_secondary_click: (_, event) => item.openMenu(event),
			tooltip_markup: item.bind("tooltip_markup"),
		})))

	return Widget.Box({
		className: items.as(items => items.length > 0 ? "systray" : ""),
		children: items,
	})
}


// layout of the bar
function Left() {
	return Widget.Box({
		spacing: 8,
		children: [
			Workspaces(),
		],
	})
}

function Center() {
	return Widget.Box({
		spacing: 8,
		children: [
			ClientTitle(),
		],
	})
}

function Right() {
	return Widget.Box({
		hpack: "end",
		spacing: 8,
		children: [
			SysTray(),
			Volume(),
			BatteryLabel(),
			Clock(),
			Calendar(),
		],
	})
}

function Bar(monitor = 0) {
	return Widget.Window({
		name: `bar-${monitor}`, // name has to be unique
		className: "bar",
		monitor,
		anchor: ["top", "left", "right"],
		exclusivity: "exclusive",
		child: Widget.CenterBox({
			startWidget: Left(),
			centerWidget: Center(),
			endWidget: Right(),
		}),
	})
}

App.config({
	style: "./style.css",
	windows: [
		Bar(0),
		Bar(1),

		// you can call it, for each monitor
		// Bar(0),
		// Bar(1)
	],
})

export { }
