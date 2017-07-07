-- vim: set sw=2 ts=2 expandtab:

Lab = class(Module)

function Lab:Name()
  return "Lab - Manages the Golden Lab"
end

function Lab:Init()
  math.randomseed(os.time())
end

function Lab:UnitCreated(eu)
  if eu:Team() == game:GetTeamID() then
    if eu:Name() == "armlab" then
      eu:Build(game:GetTypeByName("armck"))
    end
  end
end

function Lab:UnitIdle(eu)
  if eu:Name() == "armlab" then
    eu:Build(game:GetTypeByName("armck"))
  end
end

function Lab:UnitDead(eu)
  if eu:Name() == "armlab" then
    Leader.request_lab = true
  end
end
