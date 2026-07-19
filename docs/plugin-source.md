# Plugin Source Notes

Noctalia v5 plugin sources are source roots. A source root contains:

- `catalog.toml`
- one directory per plugin
- each plugin directory contains `plugin.toml`

Example:

```text
luixbits-noctalia-plugins/
  catalog.toml
  casio-deck/
    plugin.toml
```

The plugin id is `author/name`, but the directory name is only `name`.
Therefore `luixbits/casio-deck` lives in:

```text
casio-deck/
```

When adding a local clone in the Noctalia UI, use the repository root:

```text
/path/to/luixbits-noctalia-plugins
```

You can also use the Git URL:

```text
https://github.com/LuixBits/luixbits-noctalia-plugins
```

Do not use:

```text
/path/to/luixbits-noctalia-plugins/casio-deck
```

That path points at the plugin directory, not the source root.
