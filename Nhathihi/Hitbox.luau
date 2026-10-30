local Players=game:GetService("Players")
local RunService=game:GetService("RunService")
local TweenService=game:GetService("TweenService")
local UIS=game:GetService("UserInputService")
local CoreGui=game:GetService("CoreGui")
local Workspace=game:GetService("Workspace")
local LocalPlayer=Players.LocalPlayer

pcall(function()
	local Old=CoreGui:FindFirstChild("PlayerHitboxGui")
	if Old then Old:Destroy() end
end)

pcall(function()
	local Old=LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("PlayerHitboxGui")
	if Old then Old:Destroy() end
end)

local HitboxSize=10
local HitboxTransparency=0.7
local PlayerHitboxEnabled=false
local MobHitboxEnabled=false
local ESPEnabled=false
local LowCpuEnabled=false
local LowCpuRunning=false
local Minimized=false

local HealthThreshold=30
local LerpSpeed=350
local TPLerping=false
local HoldingAltitude=false

local SafeFlyEnabled=false
local SafeFlyHealth=30
local SafeFlySpeed=100
local SafeFlying=false
local SafeFlyTargetY=nil

local DangerDistance=1000
local TargetHeight=1000

local OriginalData={}
local ESPs={}
local Connections={}

local Gui=Instance.new("ScreenGui")
Gui.Name="PlayerHitboxGui"
Gui.ResetOnSpawn=false
Gui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling

pcall(function()
	Gui.Parent=CoreGui
end)

if not Gui.Parent then
	Gui.Parent=LocalPlayer:WaitForChild("PlayerGui")
end

local Main=Instance.new("Frame",Gui)
Main.Name="Main"
Main.Size=UDim2.new(0,220,0,240)
Main.Position=UDim2.new(0.5,-110,0.5,-120)
Main.BackgroundColor3=Color3.fromRGB(18,18,24)
Main.BorderSizePixel=0
Main.ClipsDescendants=true
Main.Active=true

local MainCorner=Instance.new("UICorner",Main)
MainCorner.CornerRadius=UDim.new(0,9)

local MainStroke=Instance.new("UIStroke",Main)
MainStroke.Color=Color3.fromRGB(0,170,255)
MainStroke.Thickness=1.5

local Title=Instance.new("TextLabel",Main)
Title.Name="Title"
Title.Size=UDim2.new(1,-80,0,28)
Title.Position=UDim2.new(0,10,0,3)
Title.BackgroundTransparency=1
Title.Text="HITBOX + ESP"
Title.TextColor3=Color3.fromRGB(100,200,255)
Title.Font=Enum.Font.Cartoon
Title.TextSize=17
Title.TextXAlignment=Enum.TextXAlignment.Left

local SubTitle=Instance.new("TextLabel",Main)
SubTitle.Name="SubTitle"
SubTitle.Size=UDim2.new(1,-80,0,14)
SubTitle.Position=UDim2.new(0,10,0,25)
SubTitle.BackgroundTransparency=1
SubTitle.Text="Nhat HiHi"
SubTitle.TextColor3=Color3.fromRGB(120,120,130)
SubTitle.Font=Enum.Font.Cartoon
SubTitle.TextSize=8
SubTitle.TextXAlignment=Enum.TextXAlignment.Left

local Arrow=Instance.new("TextButton",Main)
Arrow.Name="Arrow"
Arrow.Size=UDim2.new(0,25,0,25)
Arrow.Position=UDim2.new(1,-30,0,4)
Arrow.BackgroundTransparency=1
Arrow.Text="▼"
Arrow.TextColor3=Color3.fromRGB(255,255,255)
Arrow.Font=Enum.Font.Cartoon
Arrow.TextSize=13
Arrow.AutoButtonColor=false
Arrow.ZIndex=5

local Close=Instance.new("TextButton",Main)
Close.Name="Close"
Close.Size=UDim2.new(0,25,0,25)
Close.Position=UDim2.new(1,-60,0,4)
Close.BackgroundTransparency=1
Close.Text="X"
Close.TextColor3=Color3.fromRGB(255,255,255)
Close.Font=Enum.Font.Cartoon
Close.TextSize=15
Close.AutoButtonColor=false
Close.ZIndex=5

local Scroll=Instance.new("ScrollingFrame",Main)
Scroll.Name="Scroll"
Scroll.Size=UDim2.new(1,-20,1,-65)
Scroll.Position=UDim2.new(0,10,0,58)
Scroll.BackgroundTransparency=1
Scroll.BorderSizePixel=0
Scroll.ScrollBarThickness=3
Scroll.ScrollBarImageColor3=Color3.fromRGB(0,170,255)
Scroll.CanvasSize=UDim2.new(0,0,0,0)
Scroll.AutomaticCanvasSize=Enum.AutomaticSize.Y
Scroll.ScrollingDirection=Enum.ScrollingDirection.Y

local Layout=Instance.new("UIListLayout",Scroll)
Layout.Padding=UDim.new(0,5)
Layout.HorizontalAlignment=Enum.HorizontalAlignment.Center
Layout.SortOrder=Enum.SortOrder.LayoutOrder

local Padding=Instance.new("UIPadding",Scroll)
Padding.PaddingBottom=UDim.new(0,8)

local function SetToggleStyle(Button,Enabled)
	local Stroke=Button:FindFirstChild("ToggleStroke")

	if Enabled then
		if not Stroke then
			Stroke=Instance.new("UIStroke")
			Stroke.Name="ToggleStroke"
			Stroke.Thickness=1.5
			Stroke.Color=Color3.fromRGB(0,170,255)
			Stroke.Parent=Button
		end

		Stroke.Enabled=true
	else
		if Stroke then
			Stroke.Enabled=false
		end
	end
end

local function CreateToggle(Text)
	local Button=Instance.new("TextButton")
	Button.Size=UDim2.new(1,0,0,28)
	Button.BackgroundColor3=Color3.fromRGB(55,55,65)
	Button.BorderSizePixel=0
	Button.Text=Text
	Button.TextColor3=Color3.fromRGB(255,255,255)
	Button.TextSize=13
	Button.Font=Enum.Font.Cartoon
	Button.AutoButtonColor=false
	Button.Parent=Scroll

	local Corner=Instance.new("UICorner")
	Corner.CornerRadius=UDim.new(0,7)
	Corner.Parent=Button

	SetToggleStyle(Button,false)
	return Button
end

local function CreateLabel(Text)
	local Label=Instance.new("TextLabel")
	Label.Size=UDim2.new(1,0,0,18)
	Label.BackgroundTransparency=1
	Label.Text=Text
	Label.TextColor3=Color3.fromRGB(180,180,190)
	Label.TextSize=11
	Label.Font=Enum.Font.Cartoon
	Label.TextXAlignment=Enum.TextXAlignment.Left
	Label.Parent=Scroll
	return Label
end

local function CreateBox(Default)
	local Box=Instance.new("TextBox")
	Box.Size=UDim2.new(1,0,0,28)
	Box.BackgroundColor3=Color3.fromRGB(30,35,45)
	Box.BorderSizePixel=0
	Box.Text=tostring(Default)
	Box.PlaceholderText=tostring(Default)
	Box.TextColor3=Color3.fromRGB(255,255,255)
	Box.PlaceholderColor3=Color3.fromRGB(120,120,120)
	Box.TextSize=13
	Box.Font=Enum.Font.Cartoon
	Box.ClearTextOnFocus=false
	Box.Parent=Scroll

	local Corner=Instance.new("UICorner")
	Corner.CornerRadius=UDim.new(0,6)
	Corner.Parent=Box

	return Box
end

local PlayerToggle=CreateToggle("PLAYER HITBOX")
local MobToggle=CreateToggle("MOB HITBOX")
local ESPToggle=CreateToggle("ESP")

CreateLabel("HITBOX SIZE")
local SizeBox=CreateBox(HitboxSize)

local TPNearestButton=CreateToggle("TWEEN NEARBY PLAYERS")

CreateLabel("TWEEN SPEED")

local SpeedFrame=Instance.new("Frame")
SpeedFrame.Size=UDim2.new(1,0,0,38)
SpeedFrame.BackgroundColor3=Color3.fromRGB(30,35,45)
SpeedFrame.BorderSizePixel=0
SpeedFrame.Parent=Scroll

local SpeedCorner=Instance.new("UICorner",SpeedFrame)
SpeedCorner.CornerRadius=UDim.new(0,6)

local SpeedBar=Instance.new("Frame",SpeedFrame)
SpeedBar.Size=UDim2.new(1,-58,0,5)
SpeedBar.Position=UDim2.new(0,8,0.5,-2)
SpeedBar.BackgroundColor3=Color3.fromRGB(55,55,65)
SpeedBar.BorderSizePixel=0

local SpeedFill=Instance.new("Frame",SpeedBar)
SpeedFill.Size=UDim2.new((LerpSpeed-10)/340,0,1,0)
SpeedFill.BackgroundColor3=Color3.fromRGB(0,170,255)
SpeedFill.BorderSizePixel=0

local SpeedFillCorner=Instance.new("UICorner",SpeedFill)
SpeedFillCorner.CornerRadius=UDim.new(1,0)

local SpeedValue=Instance.new("TextBox",SpeedFrame)
SpeedValue.Size=UDim2.new(0,42,0,25)
SpeedValue.Position=UDim2.new(1,-48,0.5,-12)
SpeedValue.BackgroundColor3=Color3.fromRGB(38,40,48)
SpeedValue.BorderSizePixel=0
SpeedValue.Text=tostring(LerpSpeed)
SpeedValue.TextColor3=Color3.fromRGB(255,255,255)
SpeedValue.TextSize=11
SpeedValue.Font=Enum.Font.Cartoon
SpeedValue.ClearTextOnFocus=false

local SpeedValueCorner=Instance.new("UICorner",SpeedValue)
SpeedValueCorner.CornerRadius=UDim.new(0,5)

local SpeedDragging=false

local function SetTweenSpeed(Value)
	LerpSpeed=math.clamp(math.floor(Value+0.5),10,350)
	SpeedFill.Size=UDim2.new((LerpSpeed-10)/340,0,1,0)
	SpeedValue.Text=tostring(LerpSpeed)
end

local function UpdateSpeedFromX(X)
	local StartX=SpeedBar.AbsolutePosition.X
	local Width=SpeedBar.AbsoluteSize.X
	local Percent=math.clamp((X-StartX)/Width,0,1)
	SetTweenSpeed(10+340*Percent)
end

SpeedBar.InputBegan:Connect(function(Input)
	if Input.UserInputType==Enum.UserInputType.MouseButton1 or Input.UserInputType==Enum.UserInputType.Touch then
		SpeedDragging=true
		UpdateSpeedFromX(Input.Position.X)
	end
end)

UIS.InputChanged:Connect(function(Input)
	if SpeedDragging and (Input.UserInputType==Enum.UserInputType.MouseMovement or Input.UserInputType==Enum.UserInputType.Touch) then
		UpdateSpeedFromX(Input.Position.X)
	end
end)

UIS.InputEnded:Connect(function(Input)
	if Input.UserInputType==Enum.UserInputType.MouseButton1 or Input.UserInputType==Enum.UserInputType.Touch then
		SpeedDragging=false
	end
end)

SpeedValue.FocusLost:Connect(function()
	local Number=tonumber(SpeedValue.Text)

	if Number then
		SetTweenSpeed(Number)
	else
		SpeedValue.Text=tostring(LerpSpeed)
	end
end)

SetTweenSpeed(LerpSpeed)

CreateLabel("HEALTH SAFE MODE")

local HealthFrame=Instance.new("Frame")
HealthFrame.Size=UDim2.new(1,0,0,38)
HealthFrame.BackgroundColor3=Color3.fromRGB(30,35,45)
HealthFrame.BorderSizePixel=0
HealthFrame.Parent=Scroll

local HealthCorner=Instance.new("UICorner",HealthFrame)
HealthCorner.CornerRadius=UDim.new(0,6)

local HealthBar=Instance.new("Frame",HealthFrame)
HealthBar.Size=UDim2.new(1,-58,0,5)
HealthBar.Position=UDim2.new(0,8,0.5,-2)
HealthBar.BackgroundColor3=Color3.fromRGB(55,55,65)
HealthBar.BorderSizePixel=0

local HealthFill=Instance.new("Frame",HealthBar)
HealthFill.Size=UDim2.new(HealthThreshold/100,0,1,0)
HealthFill.BackgroundColor3=Color3.fromRGB(0,170,255)
HealthFill.BorderSizePixel=0

local HealthFillCorner=Instance.new("UICorner",HealthFill)
HealthFillCorner.CornerRadius=UDim.new(1,0)

local HealthValue=Instance.new("TextBox",HealthFrame)
HealthValue.Size=UDim2.new(0,42,0,25)
HealthValue.Position=UDim2.new(1,-48,0.5,-12)
HealthValue.BackgroundColor3=Color3.fromRGB(38,40,48)
HealthValue.BorderSizePixel=0
HealthValue.Text=tostring(HealthThreshold)
HealthValue.TextColor3=Color3.fromRGB(255,255,255)
HealthValue.TextSize=11
HealthValue.Font=Enum.Font.Cartoon
HealthValue.ClearTextOnFocus=false

local HealthValueCorner=Instance.new("UICorner",HealthValue)
HealthValueCorner.CornerRadius=UDim.new(0,5)

local HealthDragging=false

local function SetHealthThreshold(Value)
	HealthThreshold=math.clamp(math.floor(Value+0.5),0,100)
	HealthFill.Size=UDim2.new(HealthThreshold/100,0,1,0)
	HealthValue.Text=tostring(HealthThreshold)
end

local function UpdateHealthFromX(X)
	local StartX=HealthBar.AbsolutePosition.X
	local Width=HealthBar.AbsoluteSize.X
	local Percent=math.clamp((X-StartX)/Width,0,1)
	SetHealthThreshold(Percent*100)
end

HealthBar.InputBegan:Connect(function(Input)
	if Input.UserInputType==Enum.UserInputType.MouseButton1 or Input.UserInputType==Enum.UserInputType.Touch then
		HealthDragging=true
		UpdateHealthFromX(Input.Position.X)
	end
end)

UIS.InputChanged:Connect(function(Input)
	if HealthDragging and (Input.UserInputType==Enum.UserInputType.MouseMovement or Input.UserInputType==Enum.UserInputType.Touch) then
		UpdateHealthFromX(Input.Position.X)
	end
end)

UIS.InputEnded:Connect(function(Input)
	if Input.UserInputType==Enum.UserInputType.MouseButton1 or Input.UserInputType==Enum.UserInputType.Touch then
		HealthDragging=false
	end
end)

HealthValue.FocusLost:Connect(function()
	local Number=tonumber(HealthValue.Text)

	if Number then
		SetHealthThreshold(Number)
	else
		HealthValue.Text=tostring(HealthThreshold)
	end
end)

SetHealthThreshold(HealthThreshold)

local SafeFlyButton=CreateToggle("SAFE FLY")

CreateLabel("HEALTH SAFE")

local SafeHealthFrame=Instance.new("Frame")
SafeHealthFrame.Size=UDim2.new(1,0,0,38)
SafeHealthFrame.BackgroundColor3=Color3.fromRGB(30,35,45)
SafeHealthFrame.BorderSizePixel=0
SafeHealthFrame.Parent=Scroll

local SafeHealthCorner=Instance.new("UICorner",SafeHealthFrame)
SafeHealthCorner.CornerRadius=UDim.new(0,6)

local SafeHealthBar=Instance.new("Frame",SafeHealthFrame)
SafeHealthBar.Size=UDim2.new(1,-58,0,5)
SafeHealthBar.Position=UDim2.new(0,8,0.5,-2)
SafeHealthBar.BackgroundColor3=Color3.fromRGB(55,55,65)
SafeHealthBar.BorderSizePixel=0

local SafeHealthFill=Instance.new("Frame",SafeHealthBar)
SafeHealthFill.Size=UDim2.new(SafeFlyHealth/100,0,1,0)
SafeHealthFill.BackgroundColor3=Color3.fromRGB(0,170,255)
SafeHealthFill.BorderSizePixel=0

local SafeHealthFillCorner=Instance.new("UICorner",SafeHealthFill)
SafeHealthFillCorner.CornerRadius=UDim.new(1,0)

local SafeHealthValue=Instance.new("TextBox",SafeHealthFrame)
SafeHealthValue.Size=UDim2.new(0,42,0,25)
SafeHealthValue.Position=UDim2.new(1,-48,0.5,-12)
SafeHealthValue.BackgroundColor3=Color3.fromRGB(38,40,48)
SafeHealthValue.BorderSizePixel=0
SafeHealthValue.Text=tostring(SafeFlyHealth)
SafeHealthValue.TextColor3=Color3.fromRGB(255,255,255)
SafeHealthValue.TextSize=11
SafeHealthValue.Font=Enum.Font.Cartoon
SafeHealthValue.ClearTextOnFocus=false

local SafeHealthValueCorner=Instance.new("UICorner",SafeHealthValue)
SafeHealthValueCorner.CornerRadius=UDim.new(0,5)

local SafeHealthDragging=false

local function SetSafeFlyHealth(Value)
	SafeFlyHealth=math.clamp(math.floor(Value+0.5),0,100)
	SafeHealthFill.Size=UDim2.new(SafeFlyHealth/100,0,1,0)
	SafeHealthValue.Text=tostring(SafeFlyHealth)
end

local function UpdateSafeHealthFromX(X)
	local StartX=SafeHealthBar.AbsolutePosition.X
	local Width=SafeHealthBar.AbsoluteSize.X
	local Percent=math.clamp((X-StartX)/Width,0,1)
	SetSafeFlyHealth(Percent*100)
end

SafeHealthBar.InputBegan:Connect(function(Input)
	if Input.UserInputType==Enum.UserInputType.MouseButton1 or Input.UserInputType==Enum.UserInputType.Touch then
		SafeHealthDragging=true
		UpdateSafeHealthFromX(Input.Position.X)
	end
end)

UIS.InputChanged:Connect(function(Input)
	if SafeHealthDragging and (Input.UserInputType==Enum.UserInputType.MouseMovement or Input.UserInputType==Enum.UserInputType.Touch) then
		UpdateSafeHealthFromX(Input.Position.X)
	end
end)

UIS.InputEnded:Connect(function(Input)
	if Input.UserInputType==Enum.UserInputType.MouseButton1 or Input.UserInputType==Enum.UserInputType.Touch then
		SafeHealthDragging=false
	end
end)

SafeHealthValue.FocusLost:Connect(function()
	local Number=tonumber(SafeHealthValue.Text)

	if Number then
		SetSafeFlyHealth(Number)
	else
		SafeHealthValue.Text=tostring(SafeFlyHealth)
	end
end)

SetSafeFlyHealth(SafeFlyHealth)

CreateLabel("SAFE MODE TWEEN SPEED")

local SafeSpeedFrame=Instance.new("Frame")
SafeSpeedFrame.Size=UDim2.new(1,0,0,38)
SafeSpeedFrame.BackgroundColor3=Color3.fromRGB(30,35,45)
SafeSpeedFrame.BorderSizePixel=0
SafeSpeedFrame.Parent=Scroll

local SafeSpeedCorner=Instance.new("UICorner",SafeSpeedFrame)
SafeSpeedCorner.CornerRadius=UDim.new(0,6)

local SafeSpeedBar=Instance.new("Frame",SafeSpeedFrame)
SafeSpeedBar.Size=UDim2.new(1,-58,0,5)
SafeSpeedBar.Position=UDim2.new(0,8,0.5,-2)
SafeSpeedBar.BackgroundColor3=Color3.fromRGB(55,55,65)
SafeSpeedBar.BorderSizePixel=0

local SafeSpeedFill=Instance.new("Frame",SafeSpeedBar)
SafeSpeedFill.Size=UDim2.new((SafeFlySpeed-100)/400,0,1,0)
SafeSpeedFill.BackgroundColor3=Color3.fromRGB(0,170,255)
SafeSpeedFill.BorderSizePixel=0

local SafeSpeedFillCorner=Instance.new("UICorner",SafeSpeedFill)
SafeSpeedFillCorner.CornerRadius=UDim.new(1,0)

local SafeSpeedValue=Instance.new("TextBox",SafeSpeedFrame)
SafeSpeedValue.Size=UDim2.new(0,42,0,25)
SafeSpeedValue.Position=UDim2.new(1,-48,0.5,-12)
SafeSpeedValue.BackgroundColor3=Color3.fromRGB(38,40,48)
SafeSpeedValue.BorderSizePixel=0
SafeSpeedValue.Text=tostring(SafeFlySpeed)
SafeSpeedValue.TextColor3=Color3.fromRGB(255,255,255)
SafeSpeedValue.TextSize=11
SafeSpeedValue.Font=Enum.Font.Cartoon
SafeSpeedValue.ClearTextOnFocus=false

local SafeSpeedValueCorner=Instance.new("UICorner",SafeSpeedValue)
SafeSpeedValueCorner.CornerRadius=UDim.new(0,5)

local SafeSpeedDragging=false

local function SetSafeFlySpeed(Value)
	SafeFlySpeed=math.clamp(math.floor(Value+0.5),100,500)
	SafeSpeedFill.Size=UDim2.new((SafeFlySpeed-100)/400,0,1,0)
	SafeSpeedValue.Text=tostring(SafeFlySpeed)
end

local function UpdateSafeSpeedFromX(X)
	local StartX=SafeSpeedBar.AbsolutePosition.X
	local Width=SafeSpeedBar.AbsoluteSize.X
	local Percent=math.clamp((X-StartX)/Width,0,1)
	SetSafeFlySpeed(100+400*Percent)
end

SafeSpeedBar.InputBegan:Connect(function(Input)
	if Input.UserInputType==Enum.UserInputType.MouseButton1 or Input.UserInputType==Enum.UserInputType.Touch then
		SafeSpeedDragging=true
		UpdateSafeSpeedFromX(Input.Position.X)
	end
end)

UIS.InputChanged:Connect(function(Input)
	if SafeSpeedDragging and (Input.UserInputType==Enum.UserInputType.MouseMovement or Input.UserInputType==Enum.UserInputType.Touch) then
		UpdateSafeSpeedFromX(Input.Position.X)
	end
end)

UIS.InputEnded:Connect(function(Input)
	if Input.UserInputType==Enum.UserInputType.MouseButton1 or Input.UserInputType==Enum.UserInputType.Touch then
		SafeSpeedDragging=false
	end
end)

SafeSpeedValue.FocusLost:Connect(function()
	local Number=tonumber(SafeSpeedValue.Text)

	if Number then
		SetSafeFlySpeed(Number)
	else
		SafeSpeedValue.Text=tostring(SafeFlySpeed)
	end
end)

SetSafeFlySpeed(SafeFlySpeed)

local LowCpuToggle=CreateToggle("REDUCE CPU LOAD")

local function SaveOriginal(Root)
	if not Root or not Root:IsA("BasePart") then return end
	if OriginalData[Root] then return end

	OriginalData[Root]={
		Size=Root.Size,
		Transparency=Root.Transparency,
		CanCollide=Root.CanCollide,
		CanTouch=Root.CanTouch,
		CanQuery=Root.CanQuery
	}
end

local function RestoreOriginal(Root)
	local Data=OriginalData[Root]

	if Data and Root and Root.Parent then
		Root.Size=Data.Size
		Root.Transparency=Data.Transparency
		Root.CanCollide=Data.CanCollide
		Root.CanTouch=Data.CanTouch
		Root.CanQuery=Data.CanQuery

		local BoxPart=Root.Parent:FindFirstChild("VisibleHitbox")

		if BoxPart then
			BoxPart:Destroy()
		end
	end

	OriginalData[Root]=nil
end

local function ModifyHitbox(Model,Color)
	local Root=Model and Model:FindFirstChild("HumanoidRootPart")

	if not Root or not Root:IsA("BasePart") then return end

	SaveOriginal(Root)

	Root.Size=Vector3.new(HitboxSize,HitboxSize,HitboxSize)
	Root.Transparency=HitboxTransparency
	Root.CanCollide=false
	Root.CanTouch=false
	Root.CanQuery=true

	local BoxPart=Model:FindFirstChild("VisibleHitbox")

	if not BoxPart then
		BoxPart=Instance.new("BoxHandleAdornment")
		BoxPart.Name="VisibleHitbox"
		BoxPart.Adornee=Root
		BoxPart.AlwaysOnTop=true
		BoxPart.ZIndex=5
		BoxPart.Parent=Model
	end

	BoxPart.Size=Vector3.new(HitboxSize,HitboxSize,HitboxSize)
	BoxPart.Color3=Color
	BoxPart.Transparency=HitboxTransparency
end

local function RestoreAllHitboxes()
	for Root in pairs(OriginalData) do
		RestoreOriginal(Root)
	end

	table.clear(OriginalData)
end

local function GetPlayerColor(Player)
	if Player.Team then
		if Player.Team.Name=="Marines" then
			return Color3.fromRGB(0,170,255)
		elseif Player.Team.Name=="Pirates" then
			return Color3.fromRGB(255,60,60)
		end
	end

	return Color3.fromRGB(255,60,60)
end

local function UpdatePlayerHitboxes()
	if not PlayerHitboxEnabled then return end

	for _,Player in ipairs(Players:GetPlayers()) do
		if Player~=LocalPlayer and Player.Character then
			ModifyHitbox(Player.Character,GetPlayerColor(Player))
		end
	end
end

local function UpdateMobHitboxes()
	if not MobHitboxEnabled then return end

	local Enemies=Workspace:FindFirstChild("Enemies")

	if not Enemies then return end

	for _,Mob in ipairs(Enemies:GetChildren()) do
		if Mob:IsA("Model") and Mob:FindFirstChildOfClass("Humanoid") then
			ModifyHitbox(Mob,Color3.fromRGB(255,170,0))
		end
	end
end
local function CreateESP(Player)
	if not ESPEnabled or Player==LocalPlayer then return end

	local Character=Player.Character
	if not Character then return end

	local Head=Character:FindFirstChild("Head")
	local Humanoid=Character:FindFirstChildOfClass("Humanoid")
	local Root=Character:FindFirstChild("HumanoidRootPart")

	if not Head or not Humanoid or not Root then return end

	if ESPs[Player] then
		ESPs[Player]:Destroy()
		ESPs[Player]=nil
	end

	local Billboard=Instance.new("BillboardGui")
	Billboard.Name="PlayerESP"
	Billboard.Adornee=Head
	Billboard.Size=UDim2.new(0,180,0,55)
	Billboard.StudsOffset=Vector3.new(0,3.2,0)
	Billboard.AlwaysOnTop=true
	Billboard.MaxDistance=math.huge
	Billboard.Parent=Head

	local Text=Instance.new("TextLabel",Billboard)
	Text.Size=UDim2.new(1,0,1,0)
	Text.BackgroundTransparency=1
	Text.TextColor3=GetPlayerColor(Player)
	Text.TextStrokeTransparency=0.25
	Text.TextSize=13
	Text.Font=Enum.Font.Cartoon
	Text.TextWrapped=true

	ESPs[Player]=Billboard

	task.spawn(function()
		while ESPEnabled and Billboard.Parent and Player.Parent do
			local MyCharacter=LocalPlayer.Character
			local MyRoot=MyCharacter and MyCharacter:FindFirstChild("HumanoidRootPart")

			if MyRoot and Root.Parent then
				local Distance=(MyRoot.Position-Root.Position).Magnitude
				local Meters=math.floor(Distance/10+0.5)

				local Level="?"

				pcall(function()
					local Data=Player:FindFirstChild("Data")
					local LevelValue=Data and Data:FindFirstChild("Level")

					if LevelValue then
						Level=tostring(LevelValue.Value)
					end
				end)

				Text.Text=
					Player.DisplayName..
					"\n[Lv."..Level.."]"..
					"\nHealth: "..math.floor(Humanoid.Health).." | "..Meters.."m"
			end

			task.wait(0.1)
		end

		if Billboard.Parent then
			Billboard:Destroy()
		end

		if ESPs[Player]==Billboard then
			ESPs[Player]=nil
		end
	end)
end

local function ClearAllESP()
	for Player,GuiObject in pairs(ESPs) do
		if GuiObject then
			GuiObject:Destroy()
		end

		ESPs[Player]=nil
	end
end

local function UpdateAllESP()
	if not ESPEnabled then
		ClearAllESP()
		return
	end

	for _,Player in ipairs(Players:GetPlayers()) do
		if Player~=LocalPlayer then
			CreateESP(Player)
		end
	end
end

PlayerToggle.MouseButton1Click:Connect(function()
	PlayerHitboxEnabled=not PlayerHitboxEnabled
	SetToggleStyle(PlayerToggle,PlayerHitboxEnabled)

	if not PlayerHitboxEnabled then
		RestoreAllHitboxes()
	end
end)

MobToggle.MouseButton1Click:Connect(function()
	MobHitboxEnabled=not MobHitboxEnabled
	SetToggleStyle(MobToggle,MobHitboxEnabled)

	if not MobHitboxEnabled and not PlayerHitboxEnabled then
		RestoreAllHitboxes()
	end
end)

ESPToggle.MouseButton1Click:Connect(function()
	ESPEnabled=not ESPEnabled
	SetToggleStyle(ESPToggle,ESPEnabled)

	if ESPEnabled then
		UpdateAllESP()
	else
		ClearAllESP()
	end
end)

SizeBox.FocusLost:Connect(function()
	local Number=tonumber(SizeBox.Text)

	if Number then
		HitboxSize=math.clamp(Number,1,100)
		SizeBox.Text=tostring(HitboxSize)
	else
		SizeBox.Text=tostring(HitboxSize)
	end

	if PlayerHitboxEnabled then
		UpdatePlayerHitboxes()
	end

	if MobHitboxEnabled then
		UpdateMobHitboxes()
	end
end)

local function GetNearestPlayer()
	local MyCharacter=LocalPlayer.Character
	local MyRoot=MyCharacter and MyCharacter:FindFirstChild("HumanoidRootPart")

	if not MyRoot then return nil end

	local Nearest=nil
	local NearestDistance=math.huge

	for _,Player in ipairs(Players:GetPlayers()) do
		if Player~=LocalPlayer and Player.Character then
			local Root=Player.Character:FindFirstChild("HumanoidRootPart")
			local Humanoid=Player.Character:FindFirstChildOfClass("Humanoid")

			if Root and Humanoid and Humanoid.Health>0 then
				local Distance=(MyRoot.Position-Root.Position).Magnitude

				if Distance<NearestDistance then
					NearestDistance=Distance
					Nearest=Player
				end
			end
		end
	end

	return Nearest
end

local function IsLaggingFPS(Delta)
	return Delta and Delta>0 and (1/Delta)<3
end

local function LerpUp(MyRoot)
	local StartY=MyRoot.Position.Y
	local TargetY=StartY+TargetHeight
	HoldingAltitude=false

	while TPLerping and MyRoot and MyRoot.Parent do
		local Delta=RunService.Heartbeat:Wait()

		if IsLaggingFPS(Delta) then
			continue
		end

		local Current=MyRoot.Position
		local Target=Vector3.new(Current.X,TargetY,Current.Z)
		local Distance=math.abs(Current.Y-TargetY)

		if Distance<=1 then
			MyRoot.CFrame=CFrame.new(Current.X,TargetY,Current.Z)
			HoldingAltitude=true
			break
		end

		local Alpha=math.clamp((LerpSpeed*Delta)/math.max(Distance,1),0,1)

		MyRoot.CFrame=MyRoot.CFrame:Lerp(
			CFrame.new(Current.X,TargetY,Current.Z),
			Alpha
		)
	end

	while TPLerping and HoldingAltitude and MyRoot and MyRoot.Parent do
		RunService.Heartbeat:Wait()

		if not TPLerping then
			break
		end

		local Pos=MyRoot.Position

		MyRoot.CFrame=CFrame.new(Pos.X,TargetY,Pos.Z)
		MyRoot.AssemblyLinearVelocity=Vector3.zero
		MyRoot.AssemblyAngularVelocity=Vector3.zero
	end
end

local function StartLowHealthLerp()
	if TPLerping then return end
	if HealthThreshold<=0 then return end

	local Character=LocalPlayer.Character
	local Humanoid=Character and Character:FindFirstChildOfClass("Humanoid")
	local MyRoot=Character and Character:FindFirstChild("HumanoidRootPart")

	if not Humanoid or not MyRoot or Humanoid.MaxHealth<=0 then return end

	local HealthPercent=(Humanoid.Health/Humanoid.MaxHealth)*100

	if HealthPercent<=HealthThreshold then
		TPLerping=true
		HoldingAltitude=false

		task.spawn(function()
			LerpUp(MyRoot)
		end)
	end
end

local function LerpToNearestPlayer()
	while TPLerping do
		local Delta=RunService.Heartbeat:Wait()

		if IsLaggingFPS(Delta) then
			continue
		end

		local Character=LocalPlayer.Character
		local MyRoot=Character and Character:FindFirstChild("HumanoidRootPart")

		if not MyRoot then
			continue
		end

		local TargetPlayer=GetNearestPlayer()

		if not TargetPlayer or not TargetPlayer.Character then
			continue
		end

		local TargetRoot=TargetPlayer.Character:FindFirstChild("HumanoidRootPart")
		local TargetHumanoid=TargetPlayer.Character:FindFirstChildOfClass("Humanoid")

		if not TargetRoot or not TargetHumanoid or TargetHumanoid.Health<=0 then
			continue
		end

		local Distance=(MyRoot.Position-TargetRoot.Position).Magnitude
		local Speed=Distance<=100 and 1500 or LerpSpeed
		local TargetPosition=TargetRoot.Position-Vector3.new(0,5,0)
		local Alpha=math.clamp((Speed*Delta)/math.max(Distance,1),0,1)

		MyRoot.CFrame=MyRoot.CFrame:Lerp(
			CFrame.new(TargetPosition),
			Alpha
		)
	end
end

TPNearestButton.MouseButton1Click:Connect(function()
	TPLerping=not TPLerping
	HoldingAltitude=false

	SetToggleStyle(TPNearestButton,TPLerping)

	if TPLerping then
		task.spawn(LerpToNearestPlayer)
	end
end)

local function StartSafeFly()
	if SafeFlying then return end
	if not SafeFlyEnabled then return end

	local Character=LocalPlayer.Character
	local Humanoid=Character and Character:FindFirstChildOfClass("Humanoid")
	local HRP=Character and Character:FindFirstChild("HumanoidRootPart")

	if not Humanoid or not HRP or Humanoid.Health<=0 then return end

	SafeFlying=true
	SafeFlyTargetY=HRP.Position.Y+TargetHeight
	Humanoid.PlatformStand=true
end

local function StopSafeFly()
	SafeFlying=false
	SafeFlyTargetY=nil

	local Character=LocalPlayer.Character
	local Humanoid=Character and Character:FindFirstChildOfClass("Humanoid")

	if Humanoid then
		Humanoid.PlatformStand=false
	end
end

local function CheckSafeFly()
	if not SafeFlyEnabled then
		if SafeFlying then
			StopSafeFly()
		end
		return
	end

	local Character=LocalPlayer.Character
	local Humanoid=Character and Character:FindFirstChildOfClass("Humanoid")
	local HRP=Character and Character:FindFirstChild("HumanoidRootPart")

	if not Humanoid or not HRP or Humanoid.Health<=0 then
		if SafeFlying then
			StopSafeFly()
		end
		return
	end

	local HealthPercent=(Humanoid.Health/Humanoid.MaxHealth)*100
	local NeedFly=false

	if SafeFlyHealth>0 and HealthPercent<=SafeFlyHealth then
		NeedFly=true
	end

	if SafeFlyHealth>0 and HealthPercent<=50 then
		for _,Player in ipairs(Players:GetPlayers()) do
			if Player~=LocalPlayer and Player.Character then
				local OtherHRP=Player.Character:FindFirstChild("HumanoidRootPart")
				local OtherHumanoid=Player.Character:FindFirstChildOfClass("Humanoid")

				if OtherHRP and OtherHumanoid and OtherHumanoid.Health>0 then
					local Distance=(HRP.Position-OtherHRP.Position).Magnitude

					if Distance<=DangerDistance then
						NeedFly=true
						break
					end
				end
			end
		end
	end

	if NeedFly then
		if not SafeFlying or not SafeFlyTargetY then
			StartSafeFly()
		end
	else
		if SafeFlying then
			StopSafeFly()
		end
	end
end

SafeFlyButton.MouseButton1Click:Connect(function()
	SafeFlyEnabled=not SafeFlyEnabled
	SetToggleStyle(SafeFlyButton,SafeFlyEnabled)

	if not SafeFlyEnabled then
		StopSafeFly()
	end
end)

Connections.SafeFly=RunService.RenderStepped:Connect(function(Delta)
	CheckSafeFly()

	if SafeFlying and SafeFlyTargetY then
		local Character=LocalPlayer.Character
		local Humanoid=Character and Character:FindFirstChildOfClass("Humanoid")
		local HRP=Character and Character:FindFirstChild("HumanoidRootPart")

		if Humanoid and HRP then
			Humanoid.PlatformStand=true

			local CurrentY=HRP.Position.Y
			local Difference=SafeFlyTargetY-CurrentY

			if math.abs(Difference)<=1 then
				HRP.CFrame=CFrame.new(
					HRP.Position.X,
					SafeFlyTargetY,
					HRP.Position.Z
				)
			else
				local Move=math.min(math.abs(Difference),SafeFlySpeed*Delta)
				local Direction=Difference>0 and 1 or -1

				HRP.CFrame=HRP.CFrame+Vector3.new(0,Move*Direction,0)
			end

			HRP.AssemblyLinearVelocity=Vector3.zero
			HRP.AssemblyAngularVelocity=Vector3.zero
		end
	end
end)

local function LowCpuSmooth()
	if LowCpuRunning then return end

	LowCpuRunning=true

	local Lighting=game:GetService("Lighting")

	pcall(function()
		Workspace.Terrain.WaterWaveSize=0
		Workspace.Terrain.WaterWaveSpeed=0
		Workspace.Terrain.WaterReflectance=0
		Workspace.Terrain.WaterTransparency=0
	end)

	pcall(function()
		Lighting.GlobalShadows=false
		Lighting.FogEnd=9e9
		Lighting.Brightness=0
	end)

	pcall(function()
		settings().Rendering.QualityLevel="Level01"
	end)

	for _,Object in ipairs(Lighting:GetChildren()) do
		if not LowCpuEnabled then
			break
		end

		if Object:IsA("BlurEffect")
		or Object:IsA("SunRaysEffect")
		or Object:IsA("ColorCorrectionEffect")
		or Object:IsA("BloomEffect")
		or Object:IsA("DepthOfFieldEffect") then
			pcall(function()
				Object.Enabled=false
			end)
		end
	end

	local Objects=Workspace:GetDescendants()
	local Batch=50

	for Index,Object in ipairs(Objects) do
		if not LowCpuEnabled then
			break
		end

		pcall(function()
			if Object:IsA("Part")
			or Object:IsA("UnionOperation")
			or Object:IsA("CornerWedgePart")
			or Object:IsA("TrussPart") then
				Object.Material=Enum.Material.Plastic
				Object.Reflectance=0

			elseif Object:IsA("Decal") or Object:IsA("Texture") then
				Object.Transparency=1

			elseif Object:IsA("ParticleEmitter") or Object:IsA("Trail") then
				Object.Lifetime=NumberRange.new(0)

			elseif Object:IsA("Explosion") then
				Object.BlastPressure=1
				Object.BlastRadius=1

			elseif Object:IsA("Fire")
			or Object:IsA("SpotLight")
			or Object:IsA("Smoke")
			or Object:IsA("Sparkles") then
				Object.Enabled=false

			elseif Object:IsA("MeshPart") then
				Object.Material=Enum.Material.Plastic
				Object.Reflectance=0
				Object.TextureID="rbxassetid://10385902758728957"
			end
		end)

		if Index%Batch==0 then
			RunService.Heartbeat:Wait()
		end
	end

	LowCpuRunning=false
end

LowCpuToggle.MouseButton1Click:Connect(function()
	LowCpuEnabled=not LowCpuEnabled
	SetToggleStyle(LowCpuToggle,LowCpuEnabled)

	if LowCpuEnabled then
		task.spawn(LowCpuSmooth)
	end
end)

local OpenSize=UDim2.new(0,220,0,240)
local ClosedSize=UDim2.new(0,40,0,15)

local function SetChildrenVisible(State)
	Title.Visible=State
	SubTitle.Visible=State
	Close.Visible=State
	Scroll.Visible=State
end

Arrow.MouseButton1Click:Connect(function()
	Minimized=not Minimized

	if Minimized then
		Arrow.Text="▲"
		Arrow.Size=UDim2.new(0,20,0,15)
		Arrow.Position=UDim2.new(0,10,0,0)

		SetChildrenVisible(false)

		TweenService:Create(
			Main,
			TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
			{Size=ClosedSize}
		):Play()
	else
		Arrow.Text="▼"
		Arrow.Size=UDim2.new(0,25,0,25)
		Arrow.Position=UDim2.new(1,-30,0,4)

		Scroll.CanvasPosition=Vector2.new(0,0)

		TweenService:Create(
			Main,
			TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
			{Size=OpenSize}
		):Play()

		task.delay(0.2,function()
			if not Minimized and Main.Parent then
				SetChildrenVisible(true)
			end
		end)
	end
end)

local Dragging=false
local DragStart
local StartPos

local function UpdateDrag(Input)
	local Delta=Input.Position-DragStart

	Main.Position=UDim2.new(
		StartPos.X.Scale,
		StartPos.X.Offset+Delta.X,
		StartPos.Y.Scale,
		StartPos.Y.Offset+Delta.Y
	)
end

local function StartDrag(Input)
	if Input.UserInputType==Enum.UserInputType.MouseButton1
	or Input.UserInputType==Enum.UserInputType.Touch then
		Dragging=true
		DragStart=Input.Position
		StartPos=Main.Position

		local Connection
		Connection=Input.Changed:Connect(function()
			if Input.UserInputState==Enum.UserInputState.End then
				Dragging=false
				Connection:Disconnect()
			end
		end)
	end
end

Main.InputBegan:Connect(StartDrag)

UIS.InputChanged:Connect(function(Input)
	if Dragging and (
		Input.UserInputType==Enum.UserInputType.MouseMovement
		or Input.UserInputType==Enum.UserInputType.Touch
	) then
		UpdateDrag(Input)
	end
end)

Connections.HitboxLoop=RunService.Heartbeat:Connect(function()
	if PlayerHitboxEnabled then
		UpdatePlayerHitboxes()
	end

	if MobHitboxEnabled then
		UpdateMobHitboxes()
	end
end)

Connections.ESPLoop=RunService.Heartbeat:Connect(function()
	if ESPEnabled then
		for _,Player in ipairs(Players:GetPlayers()) do
			if Player~=LocalPlayer and Player.Character and not ESPs[Player] then
				CreateESP(Player)
			end
		end
	end
end)

Connections.PlayerAdded=Players.PlayerAdded:Connect(function(Player)
	Player.CharacterAdded:Connect(function(Character)
		task.wait(0.5)

		if PlayerHitboxEnabled then
			ModifyHitbox(Character,GetPlayerColor(Player))
		end

		if ESPEnabled then
			CreateESP(Player)
		end
	end)
end)

for _,Player in ipairs(Players:GetPlayers()) do
	if Player~=LocalPlayer then
		Player.CharacterAdded:Connect(function(Character)
			task.wait(0.5)

			if PlayerHitboxEnabled then
				ModifyHitbox(Character,GetPlayerColor(Player))
			end

			if ESPEnabled then
				CreateESP(Player)
			end
		end)
	end
end

Connections.HealthLoop=RunService.Heartbeat:Connect(function()
	if TPLerping then
		return
	end

	StartLowHealthLerp()
end)

Close.MouseButton1Click:Connect(function()
	TPLerping=false
	HoldingAltitude=false

	SafeFlyEnabled=false
	StopSafeFly()

	RestoreAllHitboxes()
	ClearAllESP()

	for _,Connection in pairs(Connections) do
		pcall(function()
			Connection:Disconnect()
		end)
	end

	table.clear(Connections)

	if Gui then
		Gui:Destroy()
	end
end)

SetToggleStyle(PlayerToggle,false)
SetToggleStyle(MobToggle,false)
SetToggleStyle(ESPToggle,false)
SetToggleStyle(TPNearestButton,false)
SetToggleStyle(SafeFlyButton,false)
SetToggleStyle(LowCpuToggle,false)
