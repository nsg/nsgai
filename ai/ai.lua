-- vim: set sw=2 ts=2 expandtab:

--[[
  nsgAI is based on Shard/dev from BA 103.0
  preload is a identical copy from Shard/dev
  modules are inspired but somewhat rewritten

  This is the main file that libSkirmishAI loads,
  this file is just a module loader and all the AI
  logic is hidden inside the modules/ folder.
]]

require "preload/api"

shard_include("modules/load")
shard_include("spothandler")

AI = class(AIBase)

function AI:Init()
  game:SendToConsole("nsgAI loaded - Loading modules")

  MetalSpotHandler:Init()

  self.modules = {}
  for i,m in ipairs(modules) do
    newmodule = m()
    game:SendToConsole("Load: "..newmodule:Name())
    self[i] = newmodule
    table.insert(self.modules,newmodule)

    if newmodule.Init ~= nil then
      newmodule:Init()
    end
  end
end

function AI:Update()
  if self.gameend == true then
    return
  end

  for i,m in ipairs(modules) do
    if m.Update ~= nil then
      m:Update()
    end
  end
end

function AI:GameMessage(text)
  if self.gameend == true then
    return
  end

  for i,m in ipairs(modules) do
    if m.GameMessage ~= nil then
      m:GameMessage(text)
    end
  end
end

function AI:UnitCreated(engineunit)
  if self.gameend == true then
    return
  end

  for i,m in ipairs(modules) do
    if m.UnitCreated ~= nil then
      m:UnitCreated(engineunit)
    end
  end
end

function AI:UnitBuilt(engineunit)
  if self.gameend == true then
    return
  end

  for i,m in ipairs(modules) do
    if m.UnitBuilt ~= nil then
      m:UnitBuilt(engineunit)
    end
  end
end

function AI:UnitDead(engineunit)
  if self.gameend == true then
    return
  end

  for i,m in ipairs(modules) do
    if m.UnitDead ~= nil then
      m:UnitDead(engineunit)
    end
  end
end

function AI:UnitIdle(engineunit)
  if self.gameend == true then
    return
  end

  for i,m in ipairs(modules) do
    if m.UnitIdle ~= nil then
      m:UnitIdle(engineunit)
    end
  end
end

function AI:UnitDamaged(engineunit,engineattacker,enginedamage)
  if self.gameend == true then
    return
  end
  if engineunit == nil then
    return
  end

  for i,m in ipairs(modules) do
    if m.UnitDamaged ~= nil then
      m:UnitDamaged(engineunit,engineattacker,enginedamage)
    end
  end
end

function AI:UnitMoveFailed(engineunit)
  if self.gameend == true then
    return
  end

  for i,m in ipairs(modules) do
    if m.UnitMoveFailed ~= nil then
      m:UnitMoveFailed(engineunit)
    end
  end
end

function AI:GameEnd()
  game:SendToConsole("Game ended")
  self.gameend = true

  for i,m in ipairs(modules) do
    if m.GameEnd ~= nil then
      m:GameEnd()
    end
  end
end

-- create and use an AI
ai = AI()
