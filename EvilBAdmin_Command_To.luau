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

	for _, plr1 in ipairs(list1) do
		LocalPlayer.Character:MoveTo(plr1.Character.HumanoidRootPart.Position)
	end
		
				end)
			end
		end
	end
end)

if not success then
	warn("Command Error! : " .. tostring(result))
end
