-- vim: set sw=2 ts=2 expandtab:

-- Load all modules here
shard_include("modules/units")
shard_include("modules/leader")
shard_include("modules/lab")
shard_include("modules/builders")
shard_include("modules/basemap")

-- All modules that recieve events from ai.lua
modules = { Units, Leader, Lab, Builders, BaseMap }
