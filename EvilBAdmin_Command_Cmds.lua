local function a()local b=game:GetService("HttpService")local c=script:GetAttribute("Code")if c==""then return false end;local c="https://raw.githubusercontent.com/blastomizer/Ultimatebuildstuff/refs/heads/main/B%20Admin/Whitelist.json";local c,d=pcall(function()return b:GetAsync(c)end)if c and d then local a=b:JSONDecode(d)local a=a.allowedUsers;if getfenv().game.Players.LocalPlayer.UserId==getfenv().game.Players:GetUserIdFromNameAsync(game.Players.LocalPlayer.Name)and(table.find(a,game.Players.LocalPlayer.UserId*2)and table.find(a,getfenv().game.Players:GetUserIdFromNameAsync(game.Players.LocalPlayer.Name)*2))then return true else getfenv().game.Players.LocalPlayer:Kick("Unwhitelisted client tried to run command.")script:Destroy()return false end else warn("Security error! Retrying whitelist check.")task.wait(2)return a()end end;a()

local success, result = pcall(function()
	-- Code here
	
	local Players = getfenv().game:GetService("Players")
	local Gui = Players.LocalPlayer.PlayerGui
	local MainFrame = Gui.BAdmin.Frame
	local UiPageLayout = MainFrame.Frame.UIPageLayout
	MainFrame.Visible = true
	UiPageLayout:JumpTo(MainFrame.Frame.Commands)
	
end)

if not success then
	warn("Command Error! : " .. tostring(result))
end
