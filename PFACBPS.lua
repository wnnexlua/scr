-- Phantom forces anti cheat bypass

-- PF silently updated making it so the game is using actor classes to hide critical elements needed for scripts. 
-- (playerinfo, mesh shit and shit like that). 

-- this bypasses multiple AC layers.

--Might get you banned lelllll idk if its detected
--wnnex#0666



-- check2exc
local placeId = game.PlaceId;
if placeId ~= 292439477 and placeId ~= 299659045 then
    print ("CHECK2EXC RAN")
    return;
end

-- VAR
local runService = game:GetService("RunService");
local replicatedFirst = game:GetService("ReplicatedFirst");
print ("Variables loaded")

-- Actor Bypass
replicatedFirst.ChildAdded:Connect(function(instance)
    if instance:IsA("Actor") then
        replicatedFirst.ChildAdded:Wait();

        for _, child in next, instance:GetChildren() do
            child.Parent = replicatedFirst;
        end
    end

end);

-- C.P Bypass
local old;
old = hookmetamethod(runService.Stepped, "__index", function(self, index)
    local indexed = old(self, index);
    if index == "ConnectParallel" and not checkcaller() then
        hookfunction(indexed, newcclosure(function(signal, callback)
            return old(self, "Connect")(signal, function()
                return self:Wait() and callback();
            end);
        end));
    end
    return indexed;
    Print("CP BYP COMPLETE")
end);

-- Destroy Module
task.spawn(function()
    local shared = getrenv().shared;

    repeat task.wait() until shared.close;

    hookfunction(shared.close, function() end);
    print ("DM COMPLETE")
end);
