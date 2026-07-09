# TeXstudio Setup

Recommended TeXstudio commands for compiling these templates:

- Build and view:
  `txs:///lualatex | txs:///biber | txs:///lualatex | txs:///lualatex | txs:///view-pdf`
- Default compiler:
  `txs:///lualatex`

The shuffled template requires LuaLaTeX because it calls Lua code during
compilation.
