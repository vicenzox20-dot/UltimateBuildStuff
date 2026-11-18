local function SendMsg(Input)
	getfenv().game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = "Evil Bad Admin",
		Text = Input,
		Duration = 5
	})
	local sound = getfenv().Instance.new("Sound")
	sound.Parent = getfenv().game:GetService("Players").LocalPlayer.PlayerGui
	sound.SoundId = "rbxassetid://137716148492089"
	sound:Play()
	sound.Name = "dfhguidfghdkg"
	getfenv().game:GetService("Debris"):AddItem(sound, 3)
end

local CurrentVersion = 4.5
SendMsg("Launching Evil Bad Admin (Version " .. CurrentVersion .. ") ")
local HttpService = game:GetService("HttpService")
local Players = getfenv().game:GetService("Players")

function cleanup()
	if Players.LocalPlayer.PlayerGui:FindFirstChild("BAdmin") then
		Players.LocalPlayer.PlayerGui:FindFirstChild("BAdmin"):Destroy()
	end
	for Index, Item in pairs(workspace:GetChildren()) do
		if Item.Name == "ServerInfo" and Item:GetAttribute("Owner") == game.Players.LocalPlayer.UserId then
			if Item:GetAttribute("DisplayName") == "BADMIN_SERVERINFOBLOCK" then
				Item:Destroy()
			end
		elseif Item.Name == "Code" and Item:GetAttribute("Owner") == game.Players.LocalPlayer.UserId then
			local DisplayName = Item:GetAttribute("DisplayName")
			if DisplayName and string.match(DisplayName, "^BADMIN_CODEBLOCK") then
				Item:Destroy()
			end
		end
	end
end

cleanup()

local CodeURL = "https://raw.githubusercontent.com/vicenzox20-dot/UltimateBuildStuff/refs/heads/main/EvilBAdmin_MAINCODE.luau"
local VersionURL = "https://raw.githubusercontent.com/vicenzox20-dot/UltimateBuildStuff/refs/heads/main/EvilBAdmin_Version.json"
local CommandsURL = "https://raw.githubusercontent.com/vicenzox20-dot/UltimateBuildStuff/refs/heads/main/EvilBAdmin_Commands.json"
local function FetchCode()
	local Success, Data = pcall(function()
		return HttpService:GetAsync(CodeURL)
	end)
	if Success then
		return Data
	else
		SendMsg("Error fetching code: " .. Data .. " (Trying again in 10 seconds)")
		task.wait(10)
		return FetchCode()
	end
end
local function FetchCommands()
	local Success, Data = pcall(function()
		return HttpService:JSONDecode(HttpService:GetAsync(CommandsURL))
	end)
	if Success then
		return Data.Commands
	else
		warn("Error fetching commands: " .. Data .. " (Trying again in 10 seconds)")
	end
	task.wait(10)
	return FetchCommands()
end
local function FetchVersion()
	local Success, Data = pcall(function()
		return HttpService:JSONDecode(HttpService:GetAsync(VersionURL))
	end)
	if Success then
		return Data
	else
		SendMsg("Error fetching version: " .. Data .. " (Trying again in 10 seconds)")
		task.wait(10)
		return FetchVersion()
	end
end
local function FetchCommandCode(Url)
	local Success, Data = pcall(function()
		return HttpService:GetAsync(Url)
	end)
	if Success then
		return Data
	else
		warn("Error fetching command code: " .. Data .. " (Trying again in 5 seconds)")
		task.wait(5)
		return FetchCommandCode(Url)
	end
end
local function CheckIfWhitelisted()
	local CurrentCode = script:GetAttribute("Code")
	if CurrentCode == "" then
		return false
	end
	local WhitelistURL = "https://raw.githubusercontent.com/vicenzox20-dot/UltimateBuildStuff/refs/heads/main/EvilBAdmin_Whitelist.json"
local Success, Result = pcall(function()
	return HttpService:GetAsync(WhitelistURL)
end)
if Success and Result then
	local WhitelistData = HttpService:JSONDecode(Result)
	local AllowedList = WhitelistData.allowedUsers
	
	if table.find(AllowedList, game.Players.LocalPlayer.UserId) then
		return true
	else
		SendMsg("User not allowed, TERMINATING!")
		cleanup()
		script:Destroy()
		return false
	end
else
	SendMsg("Security error! Retrying whitelist check.")
	task.wait(2)
	return CheckIfWhitelisted()
end
end

CheckIfWhitelisted()
local RemoteCode = FetchCode()
local RemoteVersion = FetchVersion()
if CurrentVersion < RemoteVersion.Version then
	task.wait(1)
	SendMsg("Updating to version " .. RemoteVersion.Version .. "...")
	task.wait(3)
	SendMsg("Updated! " .. RemoteVersion.Changelog)
	script:SetAttribute("Code", RemoteCode)
end
local Commands = FetchCommands()
for i, v in pairs(Commands) do
	local a = FetchCommandCode(v.Code)
	v.Code = a
end
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local ScreenGuiInstance = getfenv().Instance.new("ScreenGui")
ScreenGuiInstance.Name = "BAdmin"
ScreenGuiInstance.ResetOnSpawn = false
ScreenGuiInstance.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
local CommandBarFrame = getfenv().Instance.new("Frame")
CommandBarFrame.Name = "CommandBarFrame"
CommandBarFrame.AnchorPoint = Vector2.new(1, 1)
CommandBarFrame.BackgroundColor3 = Color3.fromRGB(30, 32, 36)
CommandBarFrame.Position = UDim2.new(1, -20, 1, -20)
CommandBarFrame.Size = UDim2.new(0, 300, 0, 20)
CommandBarFrame.Parent = ScreenGuiInstance
local CommandBarCorner = getfenv().Instance.new("UICorner")
CommandBarCorner.CornerRadius = UDim.new(0, 6)
CommandBarCorner.Parent = CommandBarFrame
local CommandBarStroke = getfenv().Instance.new("UIStroke")
CommandBarStroke.Color = Color3.fromRGB(70, 75, 85)
CommandBarStroke.Thickness = 1
CommandBarStroke.Parent = CommandBarFrame
local CommandBarGradient = getfenv().Instance.new("UIGradient")
CommandBarGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 48, 54)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(22, 23, 26))
})
CommandBarGradient.Rotation = 90
CommandBarGradient.Parent = CommandBarFrame
local CommandInput = getfenv().Instance.new("TextBox")
CommandInput.Name = "CommandInput"
CommandInput.BackgroundTransparency = 1
CommandInput.Position = UDim2.new(0, 10, 0, 0)
CommandInput.Size = UDim2.new(1.5, -20, 1, 0)
CommandInput.Font = Enum.Font.SciFi
CommandInput.PlaceholderText = "Enter command here... ( ; )"
CommandInput.PlaceholderColor3 = Color3.fromRGB(130, 50, 45)
CommandInput.Text = ""
CommandInput.TextColor3 = Color3.fromRGB(255, 255, 255)
CommandInput.TextSize = 16
CommandInput.TextXAlignment = Enum.TextXAlignment.Left
CommandInput.ClearTextOnFocus = false
CommandInput.Parent = CommandBarFrame
local MainFrame = getfenv().Instance.new("Frame")
MainFrame.Name = "Frame"
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(150, 15, 15)
MainFrame.BackgroundTransparency = 0
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0.4, 0, 0.4, 0)
MainFrame.Visible = false
MainFrame.Parent = ScreenGuiInstance
local UiAspectRatioConstraint = getfenv().Instance.new("UIAspectRatioConstraint")
UiAspectRatioConstraint.AspectRatio = 0.7
UiAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Width
UiAspectRatioConstraint.Parent = MainFrame
local UiCorner = getfenv().Instance.new("UICorner")
UiCorner.CornerRadius = UDim.new(0, 2)
UiCorner.Parent = MainFrame
local UiGradient = getfenv().Instance.new("UIGradient")
UiGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 48, 54)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(22, 23, 26))
})
UiGradient.Rotation = -90
UiGradient.Transparency = NumberSequence.new({
	NumberSequenceKeypoint.new(0, 0.25),
	NumberSequenceKeypoint.new(0.5, 0.25),
	NumberSequenceKeypoint.new(1, 0.25)
})
UiGradient.Parent = MainFrame
local ContentFrame = getfenv().Instance.new("Frame")
ContentFrame.Name = "Frame"
ContentFrame.BackgroundTransparency = 1
ContentFrame.Position = UDim2.new(0, 0, 0.08, 0)
ContentFrame.Size = UDim2.new(1, 0, 0.92, 0)
ContentFrame.ClipsDescendants = true
ContentFrame.Parent = MainFrame
local UiPageLayout = getfenv().Instance.new("UIPageLayout")
UiPageLayout.FillDirection = Enum.FillDirection.Horizontal
UiPageLayout.SortOrder = Enum.SortOrder.LayoutOrder
UiPageLayout.Animated = true
UiPageLayout.TweenTime = 0.3
UiPageLayout.Parent = ContentFrame
UiPageLayout.GamepadInputEnabled = false
UiPageLayout.ScrollWheelInputEnabled = false
UiPageLayout.TouchInputEnabled = false
local UiStroke = getfenv().Instance.new("UIStroke")
UiStroke.Color = Color3.fromRGB(70, 75, 85)
UiStroke.Thickness = 1
UiStroke.Parent = MainFrame
local MenuPage = getfenv().Instance.new("Frame")
MenuPage.Name = "Evil Bad Admin"
MenuPage.BackgroundTransparency = 1
MenuPage.Size = UDim2.new(1, 0, 1, 0)
MenuPage.LayoutOrder = 1
MenuPage.Parent = ContentFrame
local WelcomeLabel = getfenv().Instance.new("TextLabel")
WelcomeLabel.Name = "TextLabel"
WelcomeLabel.BackgroundTransparency = 1
WelcomeLabel.Position = UDim2.new(0.05, 0, 0.05, 0)
WelcomeLabel.Size = UDim2.new(0.9, 0, 0.1, 0)
WelcomeLabel.Font = Enum.Font.Fantasy
WelcomeLabel.Text = "<b>Welcome, " .. LocalPlayer.Name .. "</b>"
WelcomeLabel.TextScaled = true
WelcomeLabel.RichText = true
WelcomeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
WelcomeLabel.TextSize = 18
WelcomeLabel.TextXAlignment = Enum.TextXAlignment.Center
WelcomeLabel.Parent = MenuPage
local InfoLabel = getfenv().Instance.new("TextLabel")
InfoLabel.Name = "TextLabel"
InfoLabel.BackgroundTransparency = 1
InfoLabel.Position = UDim2.new(0, 0, 0.18, 0)
InfoLabel.Size = UDim2.new(1, 0, 0.5, 0)
InfoLabel.Font = Enum.Font.SciFi
InfoLabel.TextXAlignment = Enum.TextXAlignment.Center
InfoLabel.Text = "To get started, type in the commant text box <b>cmds</b>.  !WARNING! Please do not power abuse from this admin system to prevent punishment or even worse! (Also loss of the admin system's access)"
InfoLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
InfoLabel.RichText = true
InfoLabel.TextScaled = true
InfoLabel.TextWrapped = true
InfoLabel.TextXAlignment = Enum.TextXAlignment.Left
InfoLabel.TextYAlignment = Enum.TextYAlignment.Top
InfoLabel.Parent = MenuPage
local SendMsgingLabel = getfenv().Instance.new("TextLabel")
SendMsgingLabel.Name = "TextLabel"
SendMsgingLabel.BackgroundTransparency = 1
SendMsgingLabel.Position = UDim2.new(0.05, 0, 0.8, 0)
SendMsgingLabel.Size = UDim2.new(0.9, 0, 0.15, 0)
SendMsgingLabel.Font = Enum.Font.Fantasy
SendMsgingLabel.Text = "THIS IS A EDITED VERSION FROM B ADMIN (Originary made by Blastomizer, all credits to him ;D)"
SendMsgingLabel.TextColor3 = Color3.fromRGB(255, 75, 75)
SendMsgingLabel.TextSize = 12
SendMsgingLabel.TextWrapped = true
SendMsgingLabel.TextXAlignment = Enum.TextXAlignment.Center
SendMsgingLabel.Parent = MenuPage
local CommandsPage = getfenv().Instance.new("ScrollingFrame")
CommandsPage.Name = "Commands"
CommandsPage.BackgroundTransparency = 1
CommandsPage.Size = UDim2.new(1, 0, 1, 0)
CommandsPage.CanvasSize = UDim2.new(0, 0, 0, 0)
CommandsPage.AutomaticCanvasSize = Enum.AutomaticSize.Y
CommandsPage.ScrollBarThickness = 4
CommandsPage.ScrollBarImageColor3 = Color3.fromRGB(100, 105, 115)
CommandsPage.LayoutOrder = 2
CommandsPage.Parent = ContentFrame
local UiListLayout = getfenv().Instance.new("UIListLayout")
UiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UiListLayout.Padding = UDim.new(0, 2)
UiListLayout.Parent = CommandsPage
local CommandTemplate = getfenv().Instance.new("Frame")
CommandTemplate.Name = "Command"
CommandTemplate.BackgroundColor3 = Color3.fromRGB(85, 90, 45)
CommandTemplate.BackgroundTransparency = 0.4
CommandTemplate.Size = UDim2.new(1, 0, 0, 45)
CommandTemplate.Visible = false
local CommandName = getfenv().Instance.new("TextLabel")
CommandName.Name = "CommandName"
CommandName.BackgroundTransparency = 1
CommandName.Position = UDim2.new(0.03, 0, 0, 2)
CommandName.Size = UDim2.new(0.94, 0, 0.45, 0)
CommandName.Font = Enum.Font.Fantasy
CommandName.Text = "tp  "
CommandName.TextColor3 = Color3.fromRGB(240, 240, 240)
CommandName.TextSize = 15
CommandName.TextXAlignment = Enum.TextXAlignment.Left
CommandName.Parent = CommandTemplate
local CommandFunction = getfenv().Instance.new("TextLabel")
CommandFunction.Name = "Function"
CommandFunction.BackgroundTransparency = 1
CommandFunction.Position = UDim2.new(0.03, 0, 0.45, 2)
CommandFunction.Size = UDim2.new(0.94, 0, 0.5, 0)
CommandFunction.Font = Enum.Font.Jura
CommandFunction.Text = "▲ "
CommandFunction.TextColor3 = Color3.fromRGB(210, 210, 210)
CommandFunction.TextSize = 13
CommandFunction.TextXAlignment = Enum.TextXAlignment.Left
CommandFunction.Parent = CommandTemplate
CommandTemplate.Parent = CommandsPage
local DragBar = getfenv().Instance.new("Frame")
DragBar.Name = "DragBar"
DragBar.BackgroundTransparency = 1
DragBar.Position = UDim2.new(0, 0, 0, 0)
DragBar.Size = UDim2.new(0.85, 0, 0.08, 0)
DragBar.Parent = MainFrame
local LogoLabel = getfenv().Instance.new("TextButton")
LogoLabel.Name = "Logo"
LogoLabel.BackgroundTransparency = 1
LogoLabel.Position = UDim2.new(0.04, 0, 0.15, 0)
LogoLabel.Size = UDim2.new(0.1, 0, 0.7, 0)
LogoLabel.Font = Enum.Font.SciFi
LogoLabel.Text = "EBD"
LogoLabel.TextColor3 = Color3.fromRGB(255, 5, 5)
LogoLabel.TextSize = 22
LogoLabel.TextXAlignment = Enum.TextXAlignment.Left
LogoLabel.Parent = DragBar
LogoLabel.Activated:Connect(function()
	UiPageLayout:JumpTo(MenuPage)
end)
local PageNameLabel = getfenv().Instance.new("TextLabel")
PageNameLabel.Name = "PageName"
PageNameLabel.BackgroundTransparency = 1
PageNameLabel.Position = UDim2.new(0.235, 0, 0.15, 0)
PageNameLabel.Size = UDim2.new(0.7, 0, 0.7, 0)
PageNameLabel.Font = Enum.Font.Jura
PageNameLabel.Text = "Commands"
PageNameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
PageNameLabel.TextSize = 20
PageNameLabel.TextXAlignment = Enum.TextXAlignment.Center
PageNameLabel.Parent = DragBar
UiPageLayout:GetPropertyChangedSignal("CurrentPage"):Connect(function() PageNameLabel.Text = "<b>" .. UiPageLayout.CurrentPage.Name .. "</b>" end)
PageNameLabel.RichText = true
local ServerStatsPage = getfenv().Instance.new("ScrollingFrame")
ServerStatsPage.Name = "ServerStats"
ServerStatsPage.BackgroundTransparency = 1
ServerStatsPage.Size = UDim2.new(1, 0, 1, 0)
ServerStatsPage.CanvasSize = UDim2.new(0, 0, 0, 0)
ServerStatsPage.AutomaticCanvasSize = Enum.AutomaticSize.Y
ServerStatsPage.ScrollBarThickness = 4
ServerStatsPage.ScrollBarImageColor3 = Color3.fromRGB(255, 105, 115)
ServerStatsPage.LayoutOrder = 2
ServerStatsPage.Parent = ContentFrame
local UiListLayoutStats = getfenv().Instance.new("UIListLayout")
UiListLayoutStats.SortOrder = Enum.SortOrder.LayoutOrder
UiListLayoutStats.Padding = UDim.new(0, 2)
UiListLayoutStats.Parent = ServerStatsPage
local ServerStatTemplate = getfenv().Instance.new("TextBox")
ServerStatTemplate.Name = "ServerStatTemplate"
ServerStatTemplate.BackgroundTransparency = 1
ServerStatTemplate.Position = UDim2.new(0,0,0)
ServerStatTemplate.Size = UDim2.new(1, 0, 0.05, 0)
ServerStatTemplate.Font = Enum.Font.Fantasy
ServerStatTemplate.TextColor3 = Color3.fromRGB(255, 100, 100)
ServerStatTemplate.TextSize = 15
ServerStatTemplate.TextXAlignment = Enum.TextXAlignment.Left
ServerStatTemplate.Parent = CommandTemplate
ServerStatTemplate.TextEditable = false
ServerStatTemplate.ClearTextOnFocus = false
ServerStatTemplate.RichText = true
ServerStatTemplate.Visible = false
local CloseButton = getfenv().Instance.new("TextButton")
CloseButton.Name = "Close"
CloseButton.BackgroundTransparency = 1
CloseButton.Position = UDim2.new(0.88, 0, 0.015, 0)
CloseButton.Size = UDim2.new(0.08, 0, 0.05, 0)
CloseButton.Font = Enum.Font.SourceSans
CloseButton.Text = "x"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextStrokeColor3 = Color3.fromRGB(255, 0, 0)
CloseButton.TextSize = 18
CloseButton.TextYAlignment = Enum.TextYAlignment.Top
CloseButton.Parent = MainFrame
CloseButton.MouseEnter:Connect(function()	CloseButton.TextStrokeTransparency = 0.6	end)
CloseButton.MouseLeave:Connect(function()	CloseButton.TextStrokeTransparency = 1	end)
ScreenGuiInstance.Parent = PlayerGui
CloseButton.MouseButton1Click:Connect(function()
	MainFrame.Visible = false
end)

local function SetServerStat(Txt, Index, Centered)
	local Stat = nil

	if not ServerStatsPage:FindFirstChild(Index) then
		Stat = ServerStatTemplate:Clone()
		Stat.Name = Index
		Stat.Parent = ServerStatsPage
		Stat.Visible = true
	else
		Stat = ServerStatsPage:FindFirstChild(Index)
	end

	Stat.Text = Index .. ": " .. tostring(Txt)

	if Centered and Centered == true then
		Stat.TextXAlignment = Enum.TextXAlignment.Center
	end
	Stat = nil
end

local function MakeDraggable(FrameToDrag, DragInputHandle)
	local Dragging = false
	local DragInputInstance = nil
	local DragStart = nil
	local StartPosition = nil
	local function UpdateDrag(ActiveInput)
		local Delta = ActiveInput.Position - DragStart
		FrameToDrag.Position = UDim2.new(StartPosition.X.Scale, StartPosition.X.Offset + Delta.X, StartPosition.Y.Scale, StartPosition.Y.Offset + Delta.Y)
	end
	DragInputHandle.InputBegan:Connect(function(InitialInput)
		if InitialInput.UserInputType == Enum.UserInputType.MouseButton1 or InitialInput.UserInputType == Enum.UserInputType.Touch then
			Dragging = true
			DragStart = InitialInput.Position
			StartPosition = FrameToDrag.Position
			InitialInput.Changed:Connect(function()
				if InitialInput.UserInputState == Enum.UserInputState.End then
					Dragging = false
				end
			end)
		end
	end)
	DragInputHandle.InputChanged:Connect(function(ChangedInput)
		if ChangedInput.UserInputType == Enum.UserInputType.MouseMovement or ChangedInput.UserInputType == Enum.UserInputType.Touch then
			DragInputInstance = ChangedInput
		end
	end)
	UserInputService.InputChanged:Connect(function(GlobalInput)
		if GlobalInput == DragInputInstance and Dragging then
			UpdateDrag(GlobalInput)
		end
	end)
end
MakeDraggable(MainFrame, DragBar)
MakeDraggable(CommandBarFrame, CommandBarFrame)
MainFrame.Visible = true
UiPageLayout:JumpTo(MenuPage)
for i, v in pairs(ScreenGuiInstance:GetDescendants()) do
	if v:IsA("TextLabel") or v:IsA("TextButton") then
		v.TextScaled = true
	end
end
for i, v in pairs(Commands) do
	local TemplateClone = CommandTemplate:Clone()
	TemplateClone.Parent = CommandsPage
	TemplateClone.Visible = true
	TemplateClone.CommandName.Text = v.CommandName .. " (" .. table.concat(v.Aliases, ", ") .. ")"
	TemplateClone.Function.Text = "▲ " .. v.Function
end
local function CodeBlockDeleted(fn) end
do
	local conns = {}
	CodeBlockDeleted = function(fn)
		table.insert(conns, fn)
	end
	script.AncestryChanged:Connect(function()
		if getfenv().workspace.Parts:FindFirstChild("local") then return end
		for _, conn in conns do
			task.spawn(conn)
		end
	end)
end
CodeBlockDeleted(function()
	SendMsg("Cleaning up...")
	cleanup()
end)

local function h(str)
	if str:sub(1, 2) == "#M" then
		local hexData = str:sub(3)
		local result = {}

		for pair in hexData:gmatch("%x%x") do
			table.insert(result, string.char(tonumber(pair, 16)))
		end
		return table.concat(result)
	else
		return str
	end
end

local CodeBlockPool = {}
local PoolSize = 3
local CurrentIndex = 1

for Index = 1, PoolSize do -- Make multiple code blocks for running commands at the same time
	local Block = Instance.new("Code")
	Block.Anchored = true
	Block.Position = Vector3.new(1000000, 34574 + Index, 1000000)
	Block.Size = Vector3.one
	Block:SetAttribute("DisplayName", "BADMIN_CODEBLOCK_" .. Index)
	table.insert(CodeBlockPool, Block)
end

CommandInput.FocusLost:Connect(function(EnterPressed, InputObject)
	if EnterPressed then
		local InputText = string.gsub(CommandInput.Text, "^%s+", "")
		if InputText ~= "" then
			local SplitText = string.split(InputText, " ")
			if #SplitText > 0 then
				local TypedCommand = SplitText[1]:lower()
				local CommandFound = false
				for Index, CommandData in pairs(Commands) do
					if TypedCommand == CommandData.CommandName or table.find(CommandData.Aliases, TypedCommand) then
						CommandFound = true
						local RawCode = CommandData.Code
						if RawCode then
							local ExecutableCode = RawCode:gsub("!RAWTEXT!", InputText)
							local CodeBlock = CodeBlockPool[CurrentIndex]
							CodeBlock:SetAttribute("Code", ExecutableCode)
							CurrentIndex = (CurrentIndex % PoolSize) + 1
						else
							warn("Code was unexpectedly not fetched, cannot run command.")
						end
					end
				end
				if not CommandFound then
					SendMsg('Invalid command "' .. InputText .. '".')
				end
			end
		else
			SendMsg("Command bar is empty!")
		end
		CommandInput.Text = ""
	end
end)

local ServerStatIndexes = 
	{
		"Average Fps",
		"Server Fps",
		"Average ping",
		"Gravity",
		"Is private server",
		"Job Id",
		"Lifetime parts",
		"Max players",
		"Memory",
		"Parts",
		"Player count",
		"Private server owner Id",
		"Respawn time",
		"Version"
	}

SetServerStat("", ":--------------------- <b>Client</b> ---------------------", true) task.wait(.1) --Not my best code
SetServerStat("", "FPS") task.wait(.1)
SetServerStat("", "Ping") task.wait(.1)
SetServerStat("", ":--------------------- <b>Server</b> ---------------------", true) task.wait(.1)
SetServerStat("", "Name") task.wait(.1)
SetServerStat("", "Region") task.wait(.1)
SetServerStat("", "Age") task.wait(.1)
SetServerStat("", "Average Fps") task.wait(.1)
SetServerStat("", "Server Fps") task.wait(.1)
SetServerStat("", "Average ping") task.wait(.1)
SetServerStat("", "Gravity") task.wait(.1)
SetServerStat("", "Is private server") task.wait(.1)
SetServerStat("", "Job Id") task.wait(.1)
SetServerStat("", "Lifetime parts") task.wait(.1)
SetServerStat("", "Max players") task.wait(.1)
SetServerStat("", "Memory") task.wait(.1)
SetServerStat("", "Parts") task.wait(.1)
SetServerStat("", "Player count") task.wait(.1)
SetServerStat("", "Players") task.wait(.1)
SetServerStat("", "Private server owner Id") task.wait(.1)
SetServerStat("", "Respawn time") task.wait(.1)
SetServerStat("", "Version") task.wait(.1)

local RunService = getfenv().game:GetService("RunService")
local Stats = getfenv().game:GetService("Stats")

local function GetPing()
	local DataPing = LocalPlayer:GetNetworkPing()
	return math.round(DataPing * 1000 * 10) / 10 .. "ms"
end

task.spawn(function()
	while true do
		local DeltaTime = RunService.RenderStepped:Wait()
		local CurrentFps = 1 / DeltaTime
		SetServerStat(math.round(CurrentFps * 10) / 10, "FPS")
		SetServerStat(GetPing(), "Ping")
		task.wait(10)
	end
end)

local function GetServerRegion()
	local Success, Data = pcall(function()
		return HttpService:JSONDecode(HttpService:GetAsync("http://ip-api.com/json/")) -- Since HTTP requests are server-side, this will get the server's region
	end)
	if Success then
		return Data.regionName .. ", " .. Data.country
	else
		SendMsg("Error fetching server region: " .. Data .. " (Trying again in 10 seconds)")
		return "Error"
	end
end

SetServerStat(getfenv().workspace:GetAttribute("serverName"), "Name") task.wait(.1)
SetServerStat(GetServerRegion(), "Region") task.wait(.1)

local ServerInfoBlock = Instance.new("ServerInfo")
ServerInfoBlock.Anchored = true
ServerInfoBlock.Position = Vector3.new(1000000, 34573, 1000000)
ServerInfoBlock.Size = Vector3.one
ServerInfoBlock:SetAttribute("DisplayName", "BADMIN_SERVERINFOBLOCK")

local function GetServerStat(v)
	ServerInfoBlock:SetAttribute("Index", v)
	task.wait(0.2)
	local Output = ServerInfoBlock:GetAttribute("Output")

	if typeof(Output) == "number" then 
		Output = math.round(Output * 10) / 10
	end
	return Output
end

task.spawn(function()
	while true do
		for i, v in pairs(ServerStatIndexes) do
			if v ~= "Player count" then
				SetServerStat(GetServerStat(v), v)
			else
				SetServerStat(GetServerStat("Player count") .. " / " .. GetServerStat("Max players"), "Players")
			end
		end
		task.wait(5)
	end
end)

task.spawn(function()
	while true do
		SetServerStat(math.round(getfenv().workspace.DistributedGameTime * 10) / 10, "Age")
		task.wait(.1)
	end
end)

local UserInputService = game:GetService("UserInputService")

UserInputService.InputEnded:Connect(function(input, gameProcessed)
	if gameProcessed then return end

	if input.KeyCode == Enum.KeyCode.Semicolon then
		CommandInput:CaptureFocus()
	end
end)
