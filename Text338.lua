-- CONFIG DESDE FUERA 🔥
getgenv().ToolCooldowns = getgenv().ToolCooldowns or {
	Decoy = 30,
	Trap = 20,
	Speed = 60,
	Break = 40,
	Ghost = 60
}

-- SERVICIOS
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer

local debounce = {}

-- tools con espacio
local validTools = {
	[" Speed"] = true,
	[" Break"] = true,
	[" Trap"] = true,
	[" Decoy"] = true,
	[" Ghost"] = true,
}

local function setup(character)
	character.ChildAdded:Connect(function(child)
		if child:IsA("Tool") and validTools[child.Name] then
			
			child.Activated:Connect(function()
				
				if debounce[child.Name] then return end
				debounce[child.Name] = true
				
				-- quitar espacio
				local cleanName = child.Name:gsub("^%s+", "")
				
				ReplicatedStorage:WaitForChild("ActivateGear"):FireServer(cleanName)
				
				-- 🔥 cooldown dinámico desde getgenv
				local cd = (getgenv().ToolCooldowns and getgenv().ToolCooldowns[cleanName]) or 5
				
				task.wait(cd)
				debounce[child.Name] = false
			end)
			
		end
	end)
end

if player.Character then
	setup(player.Character)
end

player.CharacterAdded:Connect(setup)
