-- vim: set sw=2 ts=2 expandtab:

Leader = class(Module)

function Leader:Name()
  return "Leaders - Manage the resources"
end

function Leader:Init()
  self.leaders = {}
  math.randomseed(os.time())
  Leader.request_lab = true
end

function Leader:HasLeader()
  for _, leader in pairs(self.leaders) do
    if leader then
      return true
    else
      return false
    end
  end
end

function Leader:Register(leader)
  table.insert(self.leaders, leader)
  for _, leader in pairs(self.leaders) do
    game:SendToConsole("Leaders: ".. leader:Name())
  end
end

function Leader:IsLeader(eu)
  for _, leader in pairs(self.leaders) do
    if leader then
      if leader:ID() == eu:ID() then
        return true
      else
        return false
      end
    else
      return false
    end
  end
end

-- Register the leader
function Leader:UnitCreated(eu)
  if eu:Team() == game:GetTeamID() then
    if not Leader:HasLeader() and eu:CanBuild() then
      Leader:Register(eu)
      eu:Build(game:GetTypeByName("armsolar"))
    elseif Units:EnergyLessThan(5) or Units:MetalLessThan(1) then
      Leader.request_leaders = true
    end
  end
end

-- Give the leader commands
function Leader:UnitIdle(eu)
  if Leader:IsLeader(eu) then
    if Units:EnergyLessThan(20) then
      eu:Build(game:GetTypeByName("armsolar"))
    elseif Units:MetalLessThan(0) then
      p = MetalSpotHandler:ClosestFreeSpot(game:GetTypeByName("armmex"), eu:GetPosition())
      if p then
        eu:Build(game:GetTypeByName("armmex"), p)
      else
        eu:Build(game:GetTypeByName("armmakr"))
      end
    elseif Leader.request_lab then
      Leader.request_lab = false
      eu:Build(game:GetTypeByName("armlab"))
    else
      eu:Build(game:GetTypeByName("armsolar"))
    end
  end
end

function Leader:UnitDead(eu)
  for i, leader in pairs(self.leaders) do
    if leader then
      if leader:ID() == eu:ID() then
        table.remove(self.leaders, i)
      end
    end
  end

  if table.getn(self.leaders) < 2 then
    Leader.request_leaders = true
  end
end
