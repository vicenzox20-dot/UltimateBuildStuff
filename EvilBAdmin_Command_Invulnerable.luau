local function a()
	local b=game:GetService("HttpService")
	local c=script:GetAttribute("Code")
	if c==""then 
		return false 
	end
    local c="https://raw.githubusercontent.com/vicenzox20-dot/UltimateBuildStuff/refs/heads/main/EvilBAdmin_Whitelist.json"
	local c, d = pcall(function()
		return b:GetAsync(c)
	end)
	if c and d then
		local a=b:JSONDecode(d)
		local a=a.allowedUsers
		if table.find(a, game.Players.LocalPlayer.UserId) then 
			return true 
		else 
			getfenv().game.Players.LocalPlayer:Kick("Opsies! Unwhitelisted client tried to run command.")
			script:Destroy()
			return false 
		end 
	else 
		warn("Security error! Retrying whitelist check.")
		task.wait(2)
		return a()
	end 
end

a()

local success, result = pcall(function()
  local rn = game:GetService("RunService")
  local plr = game.Players.LocalPlayer
  local char = plr.Character
  local hum = char:WaitForChild("Humanoid",999)
  if hum then
  local rnHb = rn.Heartbeat:Connect(function()
      if char ~= nil then
             hum.MaxHealth = 100000000000
             hum.Health = 100000000000
      else
            rnHb:Disconnect()
      end
  end)
      
  end
  
end)

if not success then
	warn("Command Error! : " .. tostring(result))
end
