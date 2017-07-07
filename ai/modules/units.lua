-- vim: set sw=2 ts=2 expandtab:

Units = class(Module)

function Units:Name()
  return "Units - Manage units"
end

function Units:Init()
  self.units = {}
  self.metal = nil
  self.energy = nil
  Leader:Init()
end

function Units:Update()
  self.metal = game:GetResourceByName("Metal")
  self.energy = game:GetResourceByName("Energy")
end

function Units:MetalLessThan(n)
  if self.metal and (self.metal.income - self.metal.usage) < n then
    return true
  elseif not self.metal then
    return true -- if nil, just assume everything is okay
  else
    return false
  end
end

function Units:EnergyLessThan(n)
  if self.energy and (self.energy.income - self.energy.usage) < n then
    return true
  elseif not self.energy then
    return true -- if nil, just assume everything is okay
  else
    return false
  end
end
