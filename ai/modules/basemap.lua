-- vim: set sw=2 ts=2 expandtab:

BaseMap = class(Module)

function BaseMap:Name()
  return "BaseMap manager"
end

function BaseMap:Init()
  BaseMap.base_map = {}
end

function BaseMap:Cell(x, z, v)
  return { x = x, z = z, v = v, i = x + (z * 100000) }
end

function BaseMap:IncBase(index, n)
  table.insert(BaseMap.base_map, index, BaseMap:Cell(base_x, base_z, BaseMap.base_map[index].v + n))
end

function BaseMap:DecBase(index, n)
  table.insert(BaseMap.base_map, index, BaseMap:Cell(base_x, base_z, BaseMap.base_map[index].v - n))
end

function BaseMap:SetBase(index, n)
  table.insert(BaseMap.base_map, index, BaseMap:Cell(base_x, base_z, n))
end

function BaseMap:GetBase(n)
  for _, b in pairs(BaseMap.base_map) do
    if b.v > n then
      return b
    end
  end

  return nil
end

function BaseMap:DebugMarker(index, p)
  if BaseMap.base_map[index].v > 1 then
    p.x = BaseMap.base_map[index].x + 250
    p.z = BaseMap.base_map[index].z + 250
    game:AddMarker(p, BaseMap.base_map[index].v)
  end
end

function BaseMap:UnitCreated(eu)
  p = eu:GetPosition()
  base_x = math.floor(p.x / 500) * 500
  base_z = math.floor(p.z / 500) * 500

  index = base_x + (base_z * 100000)

  if BaseMap.base_map[index] then
    BaseMap:IncBase(index, 100)
  else
    BaseMap:SetBase(index, 100)
  end

  BaseMap:DebugMarker(index, p)
end

function BaseMap:UnitDead(eu)
  p = eu:GetPosition()
  base_x = math.floor(p.x / 500) * 500
  base_z = math.floor(p.z / 500) * 500
  index = base_x + (base_z * 100000)
  if eu:CanBuild() then
    if BaseMap.base_map[index] then
      BaseMap:DecBase(index, 100)
    else
      BaseMap:SetBase(index, 100)
    end
  else
    if BaseMap.base_map[index] then
      BaseMap:IncBase(index, 100)
    else
      BaseMap:SetBase(index, 100)
    end
  end
  BaseMap:DebugMarker(index, p)
end
