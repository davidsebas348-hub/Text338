repeat task.wait() until game:IsLoaded()

if CloneActivated then
    return
end
CloneActivated = true

local args = {[1] = "Decoy"}
game:GetService("ReplicatedStorage"):WaitForChild("ActivateGear"):FireServer(unpack(args))
