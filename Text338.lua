-- CONFIG
-- getgenv().ToolCooldown = 5 🔥 cambia esto cuando quieras

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
	[" Decoy"] = true
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
				
				-- usa el getgenv aquí 🔥
				task.wait(getgenv().ToolCooldown or 5)
				
				debounce[child.Name] = false
			end)
			
		end
	end)
end

if player.Character then
	setup(player.Character)
end

player.CharacterAdded:Connect(setup)
