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
	local posSplit = string.split(Parameters[2], ",")
	local Px = posSplit[1]
	local Py = posSplit[2]
	local Pz = posSplit[3]

	if Px and Py and Pz then
		print("Going to position: "..Px..",".."Py..",".."Pz")
		local plr = game.Players.LocalPlayer
		plr:PivotTo(CFrame.new(Vector3.new(tonumber(Px),tonumber(Py),tonumber(Pz)))
	end
end)

if not success then
	warn("Command Error! : " .. tostring(result))
end
