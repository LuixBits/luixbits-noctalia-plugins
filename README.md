# LuixBits Noctalia Plugins

A collection of Noctalia v5 plugins by LuixBits.

The first plugin is `casio-deck`, an experimental plugin for turning a Casio
ABL-100WE Bluetooth watch into a small Noctalia controller on a Wayland desktop.

If you like Linux desktop customization, Wayland, NixOS, and unusual input
device projects, I document builds like this on the LuixBits YouTube channel.

## Plugins

| Plugin | ID | Status |
| --- | --- | --- |
| Casio Deck | `luixbits/casio-deck` | Experimental ABL-100WE helper |

## Quick Start

Requirements:

- Noctalia v5 on Linux/Wayland.
- BlueZ with `bluetoothctl` available.
- Python 3.12+ with `venv` support, or `uv`, or Nix.
- Optional action tools for some presets: `wpctl` and `wtype`.

Install the source directly from GitHub:

```sh
noctalia msg plugins source add luixbits git https://github.com/LuixBits/luixbits-noctalia-plugins
noctalia msg plugins enable luixbits/casio-deck
```

Or clone it for local development:

```sh
git clone https://github.com/LuixBits/luixbits-noctalia-plugins.git
cd luixbits-noctalia-plugins
```

When using the Settings UI, add this Git source:

```text
https://github.com/LuixBits/luixbits-noctalia-plugins
```

For a local clone, add the full path to the cloned repository root instead.
Do not add the `casio-deck/` subdirectory; Noctalia expects the source root that
contains `catalog.toml`.

Enable `luixbits/casio-deck`, add the `luixbits/casio-deck:status` widget to
your bar, and open the `luixbits/casio-deck:dashboard` desktop widget for setup.

The helper commands can be left empty. When the plugin is loaded from this
source layout, it automatically resolves the bundled helper scripts from the
clone:

- Pair: runs the bundled one-shot ABL-100WE setup flow.
- Listener: runs the bundled background listener.
- Stop: stops the bundled listener process.

On first helper start, the wrapper uses `uv` when installed. Otherwise it uses
`python3 -m venv`, with a Nix fallback on Nix/NixOS. Noctalia-launched helpers
store their environment in the plugin data directory so Git caches and Nix path
sources can remain read-only. The first start needs network access to download
the Python dependencies and can take a little longer.

## Temporary Setup UI

The portable Noctalia v5 plugin lives in `casio-deck/plugin.toml` and the Luau
files. Casio Deck 0.1.1 intentionally uses a `[[desktop_widget]]` setup UI with
tabs for Overview, Connection, Functions, and About.

The older QML prototype is archived under `archive/casio-deck-qml/`. The
shareable plugin path is the v5 `plugin.toml` plus Luau entries.

Current Noctalia versions also support plugin panel entries. A future Casio Deck
release can migrate the same tab structure into a bar-click panel.

## Add This Source

Use either the Git URL or a local clone path as the source location. The source
root is the directory containing `catalog.toml` and `casio-deck/plugin.toml`.

## Repository Layout

```text
.
├── catalog.toml
├── archive/
│   └── casio-deck-qml/
├── docs/
├── scripts/
│   ├── dev/
│   └── helper/
└── casio-deck/
    ├── bin/
    ├── plugin.toml
    ├── entries/
    │   ├── service/
    │   ├── widgets/
    │   └── shortcuts/
    ├── data/
    ├── helper/
    └── translations/
```

## Development

Validate the source structure:

```sh
./scripts/validate.sh
```

Smoke-test the Casio Deck service after Noctalia has loaded and enabled it:

```sh
./scripts/dev/smoke-casio-deck.sh abl100we
```

The smoke script is safe by default and only dispatches model/status IPC. To
also send real press actions for the confirmed ABL triggers, opt in explicitly:

```sh
CASIO_DECK_SMOKE_RUN_ACTIONS=1 ./scripts/dev/smoke-casio-deck.sh abl100we
```

Run the experimental ABL-100WE helper manually:

```sh
./scripts/helper/run-abl100-helper.sh --model abl100we --session-mode action --once --debug
```

Run the background listener used by the plugin:

```sh
./scripts/helper/run-abl100-helper.sh --model abl100we --listener --app-info-profile smart-sync --scan-timeout 60 --connect-timeout 25 --app-init-timeout 25 --reconnect-delay 2 --debug
```

Capture a full ABL-100WE test session with helper logs and optional `btmon`:

```sh
./scripts/dev/capture-abl100-session.sh --seconds 180
```
