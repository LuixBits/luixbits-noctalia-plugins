# Archived Casio Deck QML UI

This directory is an archived local QML prototype. It is not part of the
portable Noctalia v5 Luau plugin that users install from this repo.

The QML track gives us:

- a real bar item
- left-click panel opening through `pluginApi.openPanel(...)`
- tabs for Overview, Watch, Functions, and Settings
- local mock trigger buttons
- optional helper command start/stop controls

The active plugin lives in `../../casio-deck/` and uses `plugin.toml`,
`bridge.luau`, `dashboard.luau`, `status.luau`, and `shortcut.luau`.

Install locally with:

```sh
/path/to/luixbits-noctalia-plugins/archive/casio-deck-qml/install-qml-casio-deck.sh
```

That creates this symlink:

```text
~/.config/noctalia/plugins/casio-deck -> /path/to/luixbits-noctalia-plugins/archive/casio-deck-qml
```
