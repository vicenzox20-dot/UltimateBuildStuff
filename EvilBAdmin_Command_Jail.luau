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

  local RawText = "!RAWTEXT!"
	local Parameters = string.split(RawText, " ")
	local p1 = Parameters[2]
	local p2 = Parameters[3]
	--print(1)
	local Players = getfenv().game:GetService("Players")
	local LocalPlayer = Players.LocalPlayer
	local function search(input)
		--print(2)
		if not input then return {} end
		local query = string.lower(tostring(input))
		local matches = {}
		if query == "me" then
			if LocalPlayer then
				--warn("me")
				table.insert(matches, LocalPlayer)
			end
		elseif query == "all" then
			matches = Players:GetPlayers()
		elseif query == "others" then
			for _, v in ipairs(Players:GetPlayers()) do
				if v ~= LocalPlayer then
					table.insert(matches, v)
				end
			end
    elseif query == "random" then
      local rngp = math.random(1,#Players:GetChildren())
      for i = 1, #Players:GetChildren() do
          if i == rngp then
              table.insert(matches, Players:GetChildren()[i])
          end
      end
		else
			for _, v in ipairs(Players:GetPlayers()) do
				if string.find(v.Name:lower(), query, 1, true) then
					table.insert(matches, v)
					break
				end
			end
		end
		return matches
	end
	local list1 = search(p1)
	local list2 = {LocalPlayer}
	for _, plr1 in ipairs(list1) do
			if plr1 and plr1.Character:FindFirstChild("HumanoidRootPart") then
				task.spawn(function()
				
					local plr1CFrame = plr1.Character:GetPivot()
					local Base = Instance.new("Part")
					local Celling = Instance.new("Part")
					local WallFront = Instance.new("Part")
					local WallLeft = Instance.new("Part")
					local WallRight = Instance.new("Part")
					local WallBack = Instance.new("Part")
					
					Base.Size = Vector3.new(6, 1, 6)
					Celling.Size = Vector3.new(6,1,6)
					Celling.Material = "SmoothPlastic"
					Base.Material = "SmoothPlastic"
					Base.Color = Color3.fromRGB(50,50,50)
					Celling.Color = Color3.fromRGB(50,50,50)
					WallFront.Size = Vector3.new(1,6.5,6)
					WallFront.Transparency = 0.5
					WallFront.Reflectance = 0.5
					WallBack.Size = Vector3.new(1,6.5,6)
					WallBack.Transparency = 0.5
					WallBack.Reflectance = 0.5
					WallLeft.Size = Vector3.new(5,6.5,1)
					WallLeft.Transparency = 0.5
					WallLeft.Reflectance = 0.5
					WallRight.Size = Vector3.new(5,6.5,1)
					WallRight.Transparency = 0.5
					WallRight.Reflectance = 0.5
													
				
					Base.Anchored = true
					Celling.Anchored = true
					WallFront.Anchored = true
				    WallBack.Anchored = true
					WallLeft.Anchored = true
				    WallRight.Anchored = true
					task.wait(0.1)
					Base.Position = plr1.Character:FindFirstChild("HumanoidRootPart").Position + Vector3.new(0,-2.7,0)
					Celling.Position = plr1.Character:FindFirstChild("HumanoidRootPart").Position + Vector3.new(0,4.7,0)
					WallFront.Position = plr1.Character:FindFirstChild("HumanoidRootPart").Position + Vector3.new(0,0.7,2.5)
					WallBack.Position = plr1.Character:FindFirstChild("HumanoidRootPart").Position + Vector3.new(0,1,-2.5)
					WallLeft.Position = plr1.Character:FindFirstChild("HumanoidRootPart").Position + Vector3.new(-2.5,0.7,0)
					WallRight.Position = plr1.Character:FindFirstChild("HumanoidRootPart").Position + Vector3.new(2.5,0.7,0)

					task.wait(0.25)
						
			end)
		end
	end
end)

if not success then
	warn("Command Error! : " .. tostring(result))
end
