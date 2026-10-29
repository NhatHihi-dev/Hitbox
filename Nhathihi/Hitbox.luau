local CoreGui=game:GetService("CoreGui")
local Players=game:GetService("Players")
local RunService=game:GetService("RunService")
local UIS=game:GetService("UserInputService")
local LocalPlayer=Players.LocalPlayer
local Workspace=game:GetService("Workspace")

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
local SafeFlySpeed=350
local SafeFlying=false
local SafeFlyTargetY=nil
local DangerDistance=1000
local TargetHeight=1000

local HealthDragging=false
local SpeedDragging=false
local SafeHealthDragging=false
local SafeSpeedDragging=false

local Gui=Instance.new("ScreenGui")
Gui.Name="PlayerHitboxGui"
Gui.ResetOnSpawn=false
Gui.IgnoreGuiInset=true
Gui.Parent=CoreGui

local Main=Instance.new("Frame",Gui)
Main.Size=UDim2.new(0,220,0,240)
Main.Position=UDim2.new(0.5,-110,0.5,-120)
Main.BackgroundColor3=Color3.fromRGB(18,18,24)
Main.BorderSizePixel=0

local MainCorner=Instance.new("UICorner",Main)
MainCorner.CornerRadius=UDim.new(0,8)

local MainStroke=Instance.new("UIStroke",Main)
MainStroke.Color=Color3.fromRGB(0,170,255)
MainStroke.Thickness=1.5

local Title=Instance.new("TextLabel",Main)
Title.Size=UDim2.new(1,-55,0,35)
Title.Position=UDim2.new(0,10,0,0)
Title.BackgroundTransparency=1
Title.Text="PLAYER HITBOX"
Title.TextColor3=Color3.fromRGB(100,200,255)
Title.Font=Enum.Font.Cartoon
Title.TextSize=18
Title.TextXAlignment=Enum.TextXAlignment.Left

local MinBtn=Instance.new("TextButton",Main)
MinBtn.Size=UDim2.new(0,25,0,25)
MinBtn.Position=UDim2.new(1,-55,0,5)
MinBtn.BackgroundColor3=Color3.fromRGB(25,30,40)
MinBtn.Text="−"
MinBtn.TextColor3=Color3.new(1,1,1)
MinBtn.Font=Enum.Font.Cartoon
MinBtn.TextSize=20
MinBtn.BorderSizePixel=0
Instance.new("UICorner",MinBtn).CornerRadius=UDim.new(0,6)

local CloseBtn=Instance.new("TextButton",Main)
CloseBtn.Size=UDim2.new(0,25,0,25)
CloseBtn.Position=UDim2.new(1,-30,0,5)
CloseBtn.BackgroundColor3=Color3.fromRGB(45,25,30)
CloseBtn.Text="X"
CloseBtn.TextColor3=Color3.fromRGB(255,100,100)
CloseBtn.Font=Enum.Font.Cartoon
CloseBtn.TextSize=16
CloseBtn.BorderSizePixel=0
Instance.new("UICorner",CloseBtn).CornerRadius=UDim.new(0,6)

local Scroll=Instance.new("ScrollingFrame",Main)
Scroll.Size=UDim2.new(1,-10,1,-40)
Scroll.Position=UDim2.new(0,5,0,35)
Scroll.BackgroundTransparency=1
Scroll.BorderSizePixel=0
Scroll.ScrollBarThickness=3
Scroll.ScrollBarImageColor3=Color3.fromRGB(0,170,255)
Scroll.CanvasSize=UDim2.new(0,0,0,560)

local Content=Instance.new("Frame",Scroll)
Content.Size=UDim2.new(1,0,0,560)
Content.BackgroundTransparency=1

local function AddBlueStroke(Object)
	local S=Instance.new("UIStroke",Object)
	S.Name="BlueStroke"
	S.Color=Color3.fromRGB(0,170,255)
	S.Thickness=1.5
	S.Enabled=false
	return S
end

local function SetButtonState(Button,State)
	local S=Button:FindFirstChild("BlueStroke")
	if S then S.Enabled=State end
end

local function MakeButton(Text,Y)
	local B=Instance.new("TextButton",Content)
	B.Size=UDim2.new(1,-10,0,28)
	B.Position=UDim2.new(0,5,0,Y)
	B.BackgroundColor3=Color3.fromRGB(25,30,40)
	B.BorderSizePixel=0
	B.Text=Text
	B.TextColor3=Color3.fromRGB(230,240,255)
	B.Font=Enum.Font.Cartoon
	B.TextSize=14
	Instance.new("UICorner",B).CornerRadius=UDim.new(0,6)
	AddBlueStroke(B)
	return B
end

local PlayerHitboxButton=MakeButton("PLAYER HITBOX",5)
local MobHitboxButton=MakeButton("MOB HITBOX",38)
local ESPButton=MakeButton("ESP",71)
local TPNearestButton=MakeButton("TP NGƯỜI GẦN",137)
local SafeFlyButton=MakeButton("SAFE FLY",170)
local LowCpuButton=MakeButton("TỐI ƯU CPU",400)

local HitboxLabel=Instance.new("TextLabel",Content)
HitboxLabel.Size=UDim2.new(1,-10,0,20)
HitboxLabel.Position=UDim2.new(0,5,0,101)
HitboxLabel.BackgroundTransparency=1
HitboxLabel.Text="Hitbox: 10"
HitboxLabel.TextColor3=Color3.fromRGB(220,230,240)
HitboxLabel.Font=Enum.Font.Cartoon
HitboxLabel.TextSize=13

local HitboxBox=Instance.new("TextBox",Content)
HitboxBox.Size=UDim2.new(0,55,0,24)
HitboxBox.Position=UDim2.new(1,-60,0,99)
HitboxBox.BackgroundColor3=Color3.fromRGB(25,30,40)
HitboxBox.BorderSizePixel=0
HitboxBox.Text="10"
HitboxBox.TextColor3=Color3.new(1,1,1)
HitboxBox.Font=Enum.Font.Cartoon
HitboxBox.TextSize=13
HitboxBox.ClearTextOnFocus=false
Instance.new("UICorner",HitboxBox).CornerRadius=UDim.new(0,5)

local HealthLabel=Instance.new("TextLabel",Content)
HealthLabel.Size=UDim2.new(1,-10,0,20)
HealthLabel.Position=UDim2.new(0,5,0,205)
HealthLabel.BackgroundTransparency=1
HealthLabel.Text="Safe Mode: 30%"
HealthLabel.TextColor3=Color3.fromRGB(220,230,240)
HealthLabel.Font=Enum.Font.Cartoon
HealthLabel.TextSize=13
HealthLabel.TextXAlignment=Enum.TextXAlignment.Left

local HealthBox=Instance.new("TextBox",Content)
HealthBox.Size=UDim2.new(0,45,0,22)
HealthBox.Position=UDim2.new(1,-50,0,204)
HealthBox.BackgroundColor3=Color3.fromRGB(25,30,40)
HealthBox.BorderSizePixel=0
HealthBox.Text="30"
HealthBox.TextColor3=Color3.new(1,1,1)
HealthBox.Font=Enum.Font.Cartoon
HealthBox.TextSize=12
HealthBox.ClearTextOnFocus=false
Instance.new("UICorner",HealthBox).CornerRadius=UDim.new(0,5)

local HealthBarBg=Instance.new("Frame",Content)
HealthBarBg.Size=UDim2.new(1,-10,0,6)
HealthBarBg.Position=UDim2.new(0,5,0,228)
HealthBarBg.BackgroundColor3=Color3.fromRGB(40,45,55)
HealthBarBg.BorderSizePixel=0
Instance.new("UICorner",HealthBarBg).CornerRadius=UDim.new(0,3)

local HealthBar=Instance.new("Frame",HealthBarBg)
HealthBar.Size=UDim2.new(0.3,0,1,0)
HealthBar.BackgroundColor3=Color3.fromRGB(0,170,255)
HealthBar.BorderSizePixel=0
Instance.new("UICorner",HealthBar).CornerRadius=UDim.new(0,3)

local SpeedLabel=Instance.new("TextLabel",Content)
SpeedLabel.Size=UDim2.new(1,-10,0,20)
SpeedLabel.Position=UDim2.new(0,5,0,253)
SpeedLabel.BackgroundTransparency=1
SpeedLabel.Text="Tween Speed: 350/s"
SpeedLabel.TextColor3=Color3.fromRGB(220,230,240)
SpeedLabel.Font=Enum.Font.Cartoon
SpeedLabel.TextSize=13
SpeedLabel.TextXAlignment=Enum.TextXAlignment.Left

local SpeedBox=Instance.new("TextBox",Content)
SpeedBox.Size=UDim2.new(0,45,0,22)
SpeedBox.Position=UDim2.new(1,-50,0,252)
SpeedBox.BackgroundColor3=Color3.fromRGB(25,30,40)
SpeedBox.BorderSizePixel=0
SpeedBox.Text="350"
SpeedBox.TextColor3=Color3.new(1,1,1)
SpeedBox.Font=Enum.Font.Cartoon
SpeedBox.TextSize=12
SpeedBox.ClearTextOnFocus=false
Instance.new("UICorner",SpeedBox).CornerRadius=UDim.new(0,5)

local SpeedBarBg=Instance.new("Frame",Content)
SpeedBarBg.Size=UDim2.new(1,-10,0,6)
SpeedBarBg.Position=UDim2.new(0,5,0,281)
SpeedBarBg.BackgroundColor3=Color3.fromRGB(40,45,55)
SpeedBarBg.BorderSizePixel=0
Instance.new("UICorner",SpeedBarBg).CornerRadius=UDim.new(0,3)

local SpeedBar=Instance.new("Frame",SpeedBarBg)
SpeedBar.Size=UDim2.new(1,0,1,0)
SpeedBar.BackgroundColor3=Color3.fromRGB(0,170,255)
SpeedBar.BorderSizePixel=0
Instance.new("UICorner",SpeedBar).CornerRadius=UDim.new(0,3)

local SafeHealthLabel=Instance.new("TextLabel",Content)
SafeHealthLabel.Size=UDim2.new(1,-10,0,20)
SafeHealthLabel.Position=UDim2.new(0,5,0,302)
SafeHealthLabel.BackgroundTransparency=1
SafeHealthLabel.Text="Safe Mode Health: 30%"
SafeHealthLabel.TextColor3=Color3.fromRGB(220,230,240)
SafeHealthLabel.Font=Enum.Font.Cartoon
SafeHealthLabel.TextSize=13
SafeHealthLabel.TextXAlignment=Enum.TextXAlignment.Left

local SafeHealthBox=Instance.new("TextBox",Content)
SafeHealthBox.Size=UDim2.new(0,45,0,22)
SafeHealthBox.Position=UDim2.new(1,-50,0,301)
SafeHealthBox.BackgroundColor3=Color3.fromRGB(25,30,40)
SafeHealthBox.BorderSizePixel=0
SafeHealthBox.Text="30"
SafeHealthBox.TextColor3=Color3.new(1,1,1)
SafeHealthBox.Font=Enum.Font.Cartoon
SafeHealthBox.TextSize=12
SafeHealthBox.ClearTextOnFocus=false
Instance.new("UICorner",SafeHealthBox).CornerRadius=UDim.new(0,5)

local SafeHealthBarBg=Instance.new("Frame",Content)
SafeHealthBarBg.Size=UDim2.new(1,-10,0,6)
SafeHealthBarBg.Position=UDim2.new(0,5,0,329)
SafeHealthBarBg.BackgroundColor3=Color3.fromRGB(40,45,55)
SafeHealthBarBg.BorderSizePixel=0
Instance.new("UICorner",SafeHealthBarBg).CornerRadius=UDim.new(0,3)

local SafeHealthBar=Instance.new("Frame",SafeHealthBarBg)
SafeHealthBar.Size=UDim2.new(0.3,0,1,0)
SafeHealthBar.BackgroundColor3=Color3.fromRGB(0,170,255)
SafeHealthBar.BorderSizePixel=0
Instance.new("UICorner",SafeHealthBar).CornerRadius=UDim.new(0,3)

local SafeSpeedLabel=Instance.new("TextLabel",Content)
SafeSpeedLabel.Size=UDim2.new(1,-10,0,20)
SafeSpeedLabel.Position=UDim2.new(0,5,0,350)
SafeSpeedLabel.BackgroundTransparency=1
SafeSpeedLabel.Text="Tween Speed Health: 350/s"
SafeSpeedLabel.TextColor3=Color3.fromRGB(220,230,240)
SafeSpeedLabel.Font=Enum.Font.Cartoon
SafeSpeedLabel.TextSize=13
SafeSpeedLabel.TextXAlignment=Enum.TextXAlignment.Left

local SafeSpeedBox=Instance.new("TextBox",Content)
SafeSpeedBox.Size=UDim2.new(0,45,0,22)
SafeSpeedBox.Position=UDim2.new(1,-50,0,349)
SafeSpeedBox.BackgroundColor3=Color3.fromRGB(25,30,40)
SafeSpeedBox.BorderSizePixel=0
SafeSpeedBox.Text="350"
SafeSpeedBox.TextColor3=Color3.new(1,1,1)
SafeSpeedBox.Font=Enum.Font.Cartoon
SafeSpeedBox.TextSize=12
SafeSpeedBox.ClearTextOnFocus=false
Instance.new("UICorner",SafeSpeedBox).CornerRadius=UDim.new(0,5)

local SafeSpeedBarBg=Instance.new("Frame",Content)
SafeSpeedBarBg.Size=UDim2.new(1,-10,0,6)
SafeSpeedBarBg.Position=UDim2.new(0,5,0,378)
SafeSpeedBarBg.BackgroundColor3=Color3.fromRGB(40,45,55)
SafeSpeedBarBg.BorderSizePixel=0
Instance.new("UICorner",SafeSpeedBarBg).CornerRadius=UDim.new(0,3)

local SafeSpeedBar=Instance.new("Frame",SafeSpeedBarBg)
SafeSpeedBar.Size=UDim2.new(1,0,1,0)
SafeSpeedBar.BackgroundColor3=Color3.fromRGB(0,170,255)
SafeSpeedBar.BorderSizePixel=0
Instance.new("UICorner",SafeSpeedBar).CornerRadius=UDim.new(0,3)

local function SetHealthThreshold(Value)
	Value=math.clamp(math.floor(tonumber(Value) or 30),0,100)
	HealthThreshold=Value
	HealthBox.Text=tostring(Value)
	if Value==0 then HealthLabel.Text="Máu kích hoạt: TẮT" else HealthLabel.Text="Máu kích hoạt: "..Value.."%" end
	HealthBar.Size=UDim2.new(Value/100,0,1,0)
end

local function SetLerpSpeed(Value)
	Value=math.clamp(math.floor(tonumber(Value) or 350),10,350)
	LerpSpeed=Value
	SpeedBox.Text=tostring(Value)
	SpeedLabel.Text="Tween Speed: "..Value.."/s"
	SpeedBar.Size=UDim2.new((Value-10)/340,0,1,0)
end

local function SetSafeHealth(Value)
	Value=math.clamp(math.floor(tonumber(Value) or 30),0,100)
	SafeFlyHealth=Value
	SafeHealthBox.Text=tostring(Value)
	if Value==0 then SafeHealthLabel.Text="Safe Fly máu: TẮT" else SafeHealthLabel.Text="Safe Fly máu: "..Value.."%" end
	SafeHealthBar.Size=UDim2.new(Value/100,0,1,0)
end

local function SetSafeSpeed(Value)
	Value=math.clamp(math.floor(tonumber(Value) or 350),10,350)
	SafeFlySpeed=Value
	SafeSpeedBox.Text=tostring(Value)
	SafeSpeedLabel.Text="Tốc độ Safe Fly: "..Value.."/s"
	SafeSpeedBar.Size=UDim2.new((Value-10)/340,0,1,0)
end

HitboxBox.FocusLost:Connect(function()
	local Value=math.clamp(math.floor(tonumber(HitboxBox.Text) or 10),1,100)
	HitboxSize=Value
	HitboxBox.Text=tostring(Value)
	HitboxLabel.Text="Hitbox: "..Value
end)

HealthBox.FocusLost:Connect(function()
	SetHealthThreshold(HealthBox.Text)
end)

SpeedBox.FocusLost:Connect(function()
	SetLerpSpeed(SpeedBox.Text)
end)

SafeHealthBox.FocusLost:Connect(function()
	SetSafeHealth(SafeHealthBox.Text)
end)

SafeSpeedBox.FocusLost:Connect(function()
	SetSafeSpeed(SafeSpeedBox.Text)
end)

UIS.InputChanged:Connect(function(Input)
	if Input.UserInputType~=Enum.UserInputType.MouseMovement and Input.UserInputType~=Enum.UserInputType.Touch then return end
	local X=Input.Position.X

	if HealthDragging then
		local P=math.clamp((X-HealthBarBg.AbsolutePosition.X)/HealthBarBg.AbsoluteSize.X,0,1)
		SetHealthThreshold(P*100)
	elseif SpeedDragging then
		local P=math.clamp((X-SpeedBarBg.AbsolutePosition.X)/SpeedBarBg.AbsoluteSize.X,0,1)
		SetLerpSpeed(10+P*340)
	elseif SafeHealthDragging then
		local P=math.clamp((X-SafeHealthBarBg.AbsolutePosition.X)/SafeHealthBarBg.AbsoluteSize.X,0,1)
		SetSafeHealth(P*100)
	elseif SafeSpeedDragging then
		local P=math.clamp((X-SafeSpeedBarBg.AbsolutePosition.X)/SafeSpeedBarBg.AbsoluteSize.X,0,1)
		SetSafeSpeed(10+P*340)
	end
end)

HealthBarBg.InputBegan:Connect(function(Input)
	if Input.UserInputType==Enum.UserInputType.MouseButton1 or Input.UserInputType==Enum.UserInputType.Touch then
		HealthDragging=true
	end
end)

SpeedBarBg.InputBegan:Connect(function(Input)
	if Input.UserInputType==Enum.UserInputType.MouseButton1 or Input.UserInputType==Enum.UserInputType.Touch then
		SpeedDragging=true
	end
end)

SafeHealthBarBg.InputBegan:Connect(function(Input)
	if Input.UserInputType==Enum.UserInputType.MouseButton1 or Input.UserInputType==Enum.UserInputType.Touch then
		SafeHealthDragging=true
	end
end)

SafeSpeedBarBg.InputBegan:Connect(function(Input)
	if Input.UserInputType==Enum.UserInputType.MouseButton1 or Input.UserInputType==Enum.UserInputType.Touch then
		SafeSpeedDragging=true
	end
end)

UIS.InputEnded:Connect(function(Input)
	if Input.UserInputType==Enum.UserInputType.MouseButton1 or Input.UserInputType==Enum.UserInputType.Touch then
		HealthDragging=false
		SpeedDragging=false
		SafeHealthDragging=false
		SafeSpeedDragging=false
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

local OriginalData={}

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
		if BoxPart then BoxPart:Destroy() end
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

local function UpdatePlayerHitbox()
	if not PlayerHitboxEnabled then return end
	for _,Player in ipairs(Players:GetPlayers()) do
		if Player~=LocalPlayer and Player.Character then
			ModifyHitbox(Player.Character,GetPlayerColor(Player))
		end
	end
end

local function IsMob(Model)
	if not Model or not Model:IsA("Model") then return false end
	if Players:GetPlayerFromCharacter(Model) then return false end
	local Humanoid=Model:FindFirstChildOfClass("Humanoid")
	local Root=Model:FindFirstChild("HumanoidRootPart")
	return Humanoid and Root and Humanoid.Health>0
end

local function UpdateMobHitbox()
	if not MobHitboxEnabled then return end
	for _,Obj in ipairs(Workspace:GetDescendants()) do
		if Obj:IsA("Model") and IsMob(Obj) then
			ModifyHitbox(Obj,Color3.fromRGB(255,170,0))
		end
	end
end

local ESPFolder=Instance.new("Folder",Gui)
ESPFolder.Name="ESPFolder"

local ESPData={}

local function ClearESP()
	for _,Data in pairs(ESPData) do
		if Data.Billboard then Data.Billboard:Destroy() end
	end
	table.clear(ESPData)
end

local function CreateESP(Player)
	if Player==LocalPlayer or not Player.Character then return end
	local Character=Player.Character
	local Root=Character:FindFirstChild("HumanoidRootPart")
	local Humanoid=Character:FindFirstChildOfClass("Humanoid")
	if not Root or not Humanoid then return end
	if ESPData[Player] and ESPData[Player].Billboard and ESPData[Player].Billboard.Parent then return end

	local Billboard=Instance.new("BillboardGui")
	Billboard.Name="ESP_"..Player.Name
	Billboard.Adornee=Root
	Billboard.Size=UDim2.new(0,180,0,55)
	Billboard.StudsOffset=Vector3.new(0,3.2,0)
	Billboard.AlwaysOnTop=true
	Billboard.Parent=ESPFolder

	local Text=Instance.new("TextLabel",Billboard)
	Text.Size=UDim2.new(1,0,1,0)
	Text.BackgroundTransparency=1
	Text.TextColor3=GetPlayerColor(Player)
	Text.TextStrokeTransparency=0.4
	Text.Font=Enum.Font.Cartoon
	Text.TextSize=12
	Text.TextWrapped=true

	ESPData[Player]={Billboard=Billboard,Text=Text}
end

local function UpdateESPText()
	if not ESPEnabled then return end
	local MyCharacter=LocalPlayer.Character
	local MyRoot=MyCharacter and MyCharacter:FindFirstChild("HumanoidRootPart")
	if not MyRoot then return end

	for _,Player in ipairs(Players:GetPlayers()) do
		if Player~=LocalPlayer and Player.Character then
			CreateESP(Player)
			local Data=ESPData[Player]
			local Root=Player.Character:FindFirstChild("HumanoidRootPart")
			local Humanoid=Player.Character:FindFirstChildOfClass("Humanoid")
			if Data and Root and Humanoid then
				local M=math.floor((MyRoot.Position-Root.Position).Magnitude/10+0.5)
				local Health=math.floor(Humanoid.Health+0.5)
				local MaxHealth=math.floor(Humanoid.MaxHealth+0.5)
				Data.Text.Text=Player.DisplayName.." | "..M.."m\nHealth: "..Health.." / "..MaxHealth
				Data.Text.TextColor3=GetPlayerColor(Player)
			end
		end
	end
end

local function LerpUp(MyRoot)
	HoldingAltitude=true
	local TargetY=MyRoot.Position.Y+1000

	while TPLerping and MyRoot.Parent do
		local CurrentPosition=MyRoot.Position
		local Distance=math.abs(TargetY-CurrentPosition.Y)
		if Distance<=1 then
			MyRoot.CFrame=CFrame.new(CurrentPosition.X,TargetY,CurrentPosition.Z)
			break
		end

		local Delta=RunService.Heartbeat:Wait()
		if IsLaggingFPS(Delta) then continue end

		local Alpha=math.clamp((LerpSpeed*Delta)/Distance,0,1)
		local NewY=CurrentPosition.Y+(TargetY-CurrentPosition.Y)*Alpha
		MyRoot.CFrame=CFrame.new(CurrentPosition.X,NewY,CurrentPosition.Z)
	end

	while TPLerping and MyRoot.Parent and HoldingAltitude do
		RunService.Heartbeat:Wait()
		local Position=MyRoot.Position
		MyRoot.CFrame=CFrame.new(Position.X,TargetY,Position.Z)
	end

	HoldingAltitude=false
end

local function StartLowHealthLerp()
	if TPLerping or HealthThreshold<=0 then return end

	local MyCharacter=LocalPlayer.Character
	local MyRoot=MyCharacter and MyCharacter:FindFirstChild("HumanoidRootPart")
	local MyHumanoid=MyCharacter and MyCharacter:FindFirstChildOfClass("Humanoid")

	if not MyRoot or not MyHumanoid or MyHumanoid.MaxHealth<=0 then return end

	local HealthPercent=(MyHumanoid.Health/MyHumanoid.MaxHealth)*100
	if HealthPercent<=HealthThreshold then
		TPLerping=true
		task.spawn(function()
			LerpUp(MyRoot)
			TPLerping=false
			HoldingAltitude=false
		end)
	end
end

local function LerpToNearestPlayer()
	if TPLerping then return end

	local TargetPlayer=GetNearestPlayer()
	if not TargetPlayer then return end

	TPLerping=true
	SetButtonState(TPNearestButton,true)

	task.spawn(function()
		while TPLerping do
			local MyCharacter=LocalPlayer.Character
			local MyRoot=MyCharacter and MyCharacter:FindFirstChild("HumanoidRootPart")
			local MyHumanoid=MyCharacter and MyCharacter:FindFirstChildOfClass("Humanoid")
			local TargetCharacter=TargetPlayer.Character
			local TargetRoot=TargetCharacter and TargetCharacter:FindFirstChild("HumanoidRootPart")
			local TargetHumanoid=TargetCharacter and TargetCharacter:FindFirstChildOfClass("Humanoid")

			if not MyRoot or not MyHumanoid or not TargetRoot or not TargetHumanoid or TargetHumanoid.Health<=0 then
				break
			end

			local TargetPosition=TargetRoot.Position-Vector3.new(0,5,0)
			local CurrentPosition=MyRoot.Position
			local Distance=(TargetPosition-CurrentPosition).Magnitude

			if Distance<=1 then break end

			local Speed=Distance<=100 and 1500 or LerpSpeed
			local Delta=RunService.Heartbeat:Wait()

			if IsLaggingFPS(Delta) then continue end

			local Alpha=math.clamp((Speed*Delta)/Distance,0,1)
			MyRoot.CFrame=CFrame.new(CurrentPosition:Lerp(TargetPosition,Alpha))
		end

		TPLerping=false
		HoldingAltitude=false
		SetButtonState(TPNearestButton,false)
	end)
end

local function StartSafeFly()
	if SafeFlying or not SafeFlyEnabled then return end

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
		if SafeFlying then StopSafeFly() end
		return
	end

	local Character=LocalPlayer.Character
	local Humanoid=Character and Character:FindFirstChildOfClass("Humanoid")
	local HRP=Character and Character:FindFirstChild("HumanoidRootPart")

	if not Humanoid or not HRP or Humanoid.Health<=0 then
		if SafeFlying then StopSafeFly() end
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
					if (HRP.Position-OtherHRP.Position).Magnitude<=DangerDistance then
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
		if SafeFlying then StopSafeFly() end
	end
end

PlayerHitboxButton.MouseButton1Click:Connect(function()
	PlayerHitboxEnabled=not PlayerHitboxEnabled
	SetButtonState(PlayerHitboxButton,PlayerHitboxEnabled)

	if not PlayerHitboxEnabled then
		for Root in pairs(OriginalData) do
			if Root and Root.Parent and Players:GetPlayerFromCharacter(Root.Parent) then
				RestoreOriginal(Root)
			end
		end
	end
end)

MobHitboxButton.MouseButton1Click:Connect(function()
	MobHitboxEnabled=not MobHitboxEnabled
	SetButtonState(MobHitboxButton,MobHitboxEnabled)

	if not MobHitboxEnabled then
		for Root in pairs(OriginalData) do
			if Root and Root.Parent and IsMob(Root.Parent) then
				RestoreOriginal(Root)
			end
		end
	end
end)

ESPButton.MouseButton1Click:Connect(function()
	ESPEnabled=not ESPEnabled
	SetButtonState(ESPButton,ESPEnabled)

	if not ESPEnabled then
		ClearESP()
	end
end)

TPNearestButton.MouseButton1Click:Connect(function()
	if TPLerping then
		TPLerping=false
		HoldingAltitude=false
		SetButtonState(TPNearestButton,false)
	else
		LerpToNearestPlayer()
	end
end)

SafeFlyButton.MouseButton1Click:Connect(function()
	SafeFlyEnabled=not SafeFlyEnabled
	SetButtonState(SafeFlyButton,SafeFlyEnabled)

	if not SafeFlyEnabled then
		StopSafeFly()
	end
end)

LowCpuButton.MouseButton1Click:Connect(function()
	LowCpuEnabled=not LowCpuEnabled
	SetButtonState(LowCpuButton,LowCpuEnabled)

	if LowCpuEnabled and not LowCpuRunning then
		LowCpuRunning=true
		task.spawn(function()
			while LowCpuEnabled and Gui.Parent do
				pcall(function()
					settings().Rendering.QualityLevel=Enum.QualityLevel.Level01
				end)
				task.wait(1)
			end
			LowCpuRunning=false
		end)
	end
end)

local Dragging=false
local DragStart=nil
local StartPos=nil

local function StartDrag(Input)
	Dragging=true
	DragStart=Input.Position
	StartPos=Main.Position
end

local function UpdateDrag(Input)
	if not Dragging then return end
	local Delta=Input.Position-DragStart
	Main.Position=UDim2.new(
		StartPos.X.Scale,
		StartPos.X.Offset+Delta.X,
		StartPos.Y.Scale,
		StartPos.Y.Offset+Delta.Y
	)
end

Title.InputBegan:Connect(function(Input)
	if Input.UserInputType==Enum.UserInputType.MouseButton1 or Input.UserInputType==Enum.UserInputType.Touch then
		StartDrag(Input)
	end
end)

UIS.InputChanged:Connect(function(Input)
	if Input.UserInputType==Enum.UserInputType.MouseMovement or Input.UserInputType==Enum.UserInputType.Touch then
		UpdateDrag(Input)
	end
end)

UIS.InputEnded:Connect(function(Input)
	if Input.UserInputType==Enum.UserInputType.MouseButton1 or Input.UserInputType==Enum.UserInputType.Touch then
		Dragging=false
	end
end)

MinBtn.MouseButton1Click:Connect(function()
	Minimized=not Minimized
	Scroll.Visible=not Minimized

	if Minimized then
		Main.Size=UDim2.new(0,220,0,35)
		MinBtn.Text="+"
	else
		Main.Size=UDim2.new(0,220,0,240)
		MinBtn.Text="−"
	end
end)

local ESPTimer=0

RunService.Heartbeat:Connect(function(dt)
	if PlayerHitboxEnabled then
		UpdatePlayerHitbox()
	end

	if MobHitboxEnabled then
		UpdateMobHitbox()
	end

	if TPLerping==false and HealthThreshold>0 then
		StartLowHealthLerp()
	end

	ESPTimer+=dt
	if ESPTimer>=0.1 then
		ESPTimer=0
		if ESPEnabled then
			UpdateESPText()
		end
	end
end)

local SafeFlyConnection=RunService.RenderStepped:Connect(function(dt)
	CheckSafeFly()

	if not SafeFlyEnabled or not SafeFlying then return end

	local Character=LocalPlayer.Character
	local Humanoid=Character and Character:FindFirstChildOfClass("Humanoid")
	local HRP=Character and Character:FindFirstChild("HumanoidRootPart")

	if not Humanoid or not HRP or not SafeFlyTargetY then
		StopSafeFly()
		return
	end

	local CurrentPos=HRP.Position
	local Distance=math.abs(SafeFlyTargetY-CurrentPos.Y)

	if Distance>1 then
		local Move=SafeFlySpeed*dt
		local NewY=CurrentPos.Y+(SafeFlyTargetY-CurrentPos.Y)*math.clamp(Move/Distance,0,1)
		HRP.CFrame=CFrame.new(CurrentPos.X,NewY,CurrentPos.Z)
	else
		HRP.CFrame=CFrame.new(CurrentPos.X,SafeFlyTargetY,CurrentPos.Z)
	end

	HRP.AssemblyLinearVelocity=Vector3.new(0,0,0)
	HRP.AssemblyAngularVelocity=Vector3.new(0,0,0)
	Humanoid.PlatformStand=true
end)

Players.PlayerRemoving:Connect(function(Player)
	if ESPData[Player] then
		if ESPData[Player].Billboard then
			ESPData[Player].Billboard:Destroy()
		end
		ESPData[Player]=nil
	end
end)

SetHealthThreshold(30)
SetLerpSpeed(350)
SetSafeHealth(30)
SetSafeSpeed(350)
