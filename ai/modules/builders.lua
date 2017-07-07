-- vim: set sw=2 ts=2 expandtab:

Builders = class(Module)

function Builders:Name()
  return "Builders - Manages the builders"
end

function Builders:Init()
  math.randomseed(os.time())
end

function Builders:UnitCreated(eu)
  if eu:Team() == game:GetTeamID() then
    if eu:Name() == "armck" then
      Builders:UnitIdle(eu)
    end
  end
end

function Builders:UnitIdle(eu)
  if Leader.request_leaders and eu:Name() == "armck" then
    Leader.request_leaders = false
    Leader:Register(eu)
  end

  if not Leader:IsLeader(eu) then
    if eu:Name() == "armck" then
      b = BaseMap:GetBase(500)
      p = eu:GetPosition()
      if b then
        p.x = b.x + math.random(499)
        p.z = b.z + math.random(499)
        BaseMap:DecBase(b.i, 200)
        BaseMap:DebugMarker(b.i, p)
      else
        p.x = p.x - 250 + math.random(250)
        p.z = p.z - 250 + math.random(250)
      end

      rndindex = math.random(10)
      rndbuild = {
        "armllt",
        "armllt",
        "armllt",
        "armllt",
        "armllt",
        "armhlt",
        "armhlt",
        "armhlt",
        "armguard",
        "armnanotc"
      }
      eu:Build(game:GetTypeByName(rndbuild[rndindex]), p)
      game:SendToConsole("build "..rndbuild[rndindex])
    end
  end
end

