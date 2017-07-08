# nsgai

This is a AI to the game engine [Spring RTS](https://springrts.com/) and the mod [Balanced Annihilation](https://github.com/Balanced-Annihilation/Balanced-Annihilation).

It's based on [Shard](https://github.com/tomjn/Shard), with is a C++/LUA wrapper and a bot framework written in LUA. I have used the wrapper and some select part of the framework.

## How to install

In your spring install you will find this path `$SPRING/engine/103.0/AI/Skirmish/`, this is the location for all our skirmish AIs. Checkout/place the content of the repository there.

```
$SPRING
	engine
		103.0
			AI
				Skirmish
					Shard
						dev
					nsgai
						dev
					KAIK
						0.13
					..
```

Inside `Shard/dev` there is a library file, `libSkirmishAI.so` under Linux and probably a dll under Windows. Copy it (and possible other binaries) to nsgai/dev.

All done!

## Multiple versions

Rename `dev` to something else and update the version string in `AIInfo.lua`.

## Shard

Files borrowed or modified from Shard are:

```
ai/ai.lua (parts of the module loading logic)
ai/spothandler.lua
ai/preload/
```
