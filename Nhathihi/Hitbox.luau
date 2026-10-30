-- PLEASE DO NOT COPY OR CLAIM IT AS YOUR OWN. IF YOU DO COPY, PLEASE INCLUDE CREDIT.

local Players=game:GetService("Players")
local RunService=game:GetService("RunService")
local TweenService=game:GetService("TweenService")
local UserInputService=game:GetService("UserInputService")
local CoreGui=game:GetService("CoreGui")
local Workspace=game:GetService("Workspace")
local LocalPlayer=Players.LocalPlayer

pcall(function()
	local Old=CoreGui:FindFirstChild("PlayerHitboxGui")
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

local SpeedBoostEnabled=false
local WalkSpeedValue=7
local JumpBoostEnabled=false
local DefaultJumpPower=50
local JumpPowerValue=150

local OriginalData={}
local ESPs={}
local Connections={}
local GraphicsBackup={}

local Gui=Instance.new("ScreenGui")
Gui.Name="PlayerHitboxGui"
Gui.ResetOnSpawn=false
Gui.Parent=CoreGui

local Main=Instance.new("Frame",Gui)
Main.Size=UDim2.new(0,220,0,275)
Main.Position=UDim2.new(0.5,-110,0.5,-137)
Main.BackgroundColor3=Color3.fromRGB(18,18,24)
Main.BorderSizePixel=0
Main.ClipsDescendants=true
Main.Active=true
Instance.new("UICorner",Main).CornerRadius=UDim.new(0,9)

local Stroke=Instance.new("UIStroke",Main)
Stroke.Color=Color3.fromRGB(0,170,255)
Stroke.Thickness=1.5

local Title=Instance.new("TextLabel",Main)
Title.Size=UDim2.new(1,-80,0,24)
Title.Position=UDim2.new(0,10,0,2)
Title.BackgroundTransparency=1
Title.Text="HITBOX + ESP"
Title.TextColor3=Color3.fromRGB(100,200,255)
Title.Font=Enum.Font.Cartoon
Title.TextSize=15
Title.TextXAlignment=Enum.TextXAlignment.Left

local SubTitle=Instance.new("TextLabel",Main)
SubTitle.Size=UDim2.new(1,-80,0,16)
SubTitle.Position=UDim2.new(0,11,0,25)
SubTitle.BackgroundTransparency=1
SubTitle.Text="Nhat HiHi"
SubTitle.TextColor3=Color3.fromRGB(130,135,150)
SubTitle.Font=Enum.Font.Cartoon
SubTitle.TextSize=10
SubTitle.TextXAlignment=Enum.TextXAlignment.Left

local Arrow=Instance.new("TextButton",Main)
Arrow.Size=UDim2.new(0,25,0,25)
Arrow.Position=UDim2.new(1,-30,0,4)
Arrow.BackgroundTransparency=1
Arrow.Text="▼"
Arrow.TextColor3=Color3.fromRGB(255,255,255)
Arrow.Font=Enum.Font.Cartoon
Arrow.TextSize=13
Arrow.AutoButtonColor=false
Arrow.ZIndex=5
Instance.new("UICorner",Arrow).CornerRadius=UDim.new(0,6)

local Close=Instance.new("TextButton",Main)
Close.Size=UDim2.new(0,25,0,25)
Close.Position=UDim2.new(1,-60,0,4)
Close.BackgroundTransparency=1
Close.Text="X"
Close.TextColor3=Color3.fromRGB(255,255,255)
Close.Font=Enum.Font.Cartoon
Close.TextSize=15
Close.AutoButtonColor=false
Close.ZIndex=5
Instance.new("UICorner",Close).CornerRadius=UDim.new(0,6)

local Scroll=Instance.new("ScrollingFrame",Main)
Scroll.Size=UDim2.new(0,200,0,225)
Scroll.Position=UDim2.new(0,10,0,45)
Scroll.BackgroundTransparency=1
Scroll.BorderSizePixel=0
Scroll.CanvasSize=UDim2.new(0,0,0,0)
Scroll.AutomaticCanvasSize=Enum.AutomaticSize.Y
Scroll.ScrollBarThickness=3
Scroll.ScrollBarImageColor3=Color3.fromRGB(0,170,255)
Scroll.ScrollBarImageTransparency=0.15
Scroll.ScrollingDirection=Enum.ScrollingDirection.Y
Scroll.Active=true
Scroll.ClipsDescendants=true

local Padding=Instance.new("UIPadding",Scroll)
Padding.PaddingLeft=UDim.new(0,5)
Padding.PaddingRight=UDim.new(0,5)
Padding.PaddingTop=UDim.new(0,2)
Padding.PaddingBottom=UDim.new(0,6)

local Layout=Instance.new("UIListLayout",Scroll)
Layout.Padding=UDim.new(0,6)
Layout.SortOrder=Enum.SortOrder.LayoutOrder

local function SetToggleStyle(Button,Enabled)
	local ToggleStroke=Button:FindFirstChild("ToggleStroke")
	if Enabled then
		if not ToggleStroke then
			ToggleStroke=Instance.new("UIStroke")
			ToggleStroke.Name="ToggleStroke"
			ToggleStroke.Thickness=1.5
			ToggleStroke.Color=Color3.fromRGB(0,170,255)
			ToggleStroke.Parent=Button
		end
		ToggleStroke.Enabled=true
	else
		if ToggleStroke then ToggleStroke.Enabled=false end
	end
end

local function MakeToggle(Text)
	local Button=Instance.new("TextButton",Scroll)
	Button.Size=UDim2.new(1,0,0,28)
	Button.BackgroundColor3=Color3.fromRGB(55,55,65)
	Button.BorderSizePixel=0
	Button.Text=Text
	Button.TextColor3=Color3.fromRGB(255,255,255)
	Button.Font=Enum.Font.Cartoon
	Button.TextSize=13
	Button.AutoButtonColor=false
	Instance.new("UICorner",Button).CornerRadius=UDim.new(0,7)
	SetToggleStyle(Button,false)
	return Button
end

local PlayerToggle=MakeToggle("PLAYER HITBOX")
PlayerToggle.LayoutOrder=1

local MobToggle=MakeToggle("MOB HITBOX")
MobToggle.LayoutOrder=2

local ESPToggle=MakeToggle("ESP PLAYER")
ESPToggle.LayoutOrder=3

--// SPEED BOOST
local SpeedFrame=Instance.new("Frame",Scroll)
SpeedFrame.Size=UDim2.new(1,0,0,62)
SpeedFrame.BackgroundTransparency=1
SpeedFrame.LayoutOrder=4

local SpeedToggle=Instance.new("TextButton",SpeedFrame)
SpeedToggle.Size=UDim2.new(1,0,0,28)
SpeedToggle.Position=UDim2.new(0,0,0,0)
SpeedToggle.BackgroundColor3=Color3.fromRGB(55,55,65)
SpeedToggle.BorderSizePixel=0
SpeedToggle.Text="SPEED BOOST"
SpeedToggle.TextColor3=Color3.fromRGB(255,255,255)
SpeedToggle.Font=Enum.Font.Cartoon
SpeedToggle.TextSize=13
SpeedToggle.AutoButtonColor=false
Instance.new("UICorner",SpeedToggle).CornerRadius=UDim.new(0,7)
SetToggleStyle(SpeedToggle,false)

local SpeedBar=Instance.new("Frame",SpeedFrame)
SpeedBar.Size=UDim2.new(1,-45,0,7)
SpeedBar.Position=UDim2.new(0,0,0,43)
SpeedBar.BackgroundColor3=Color3.fromRGB(55,55,65)
SpeedBar.BorderSizePixel=0
Instance.new("UICorner",SpeedBar).CornerRadius=UDim.new(1,0)

local SpeedBarLabel=Instance.new("TextLabel",SpeedFrame)
SpeedBarLabel.Size=UDim2.new(1,-45,0,16)
SpeedBarLabel.Position=UDim2.new(0,0,0,29)
SpeedBarLabel.BackgroundTransparency=1
SpeedBarLabel.Text="SPEED BOOST"
SpeedBarLabel.TextColor3=Color3.fromRGB(130,135,150)
SpeedBarLabel.Font=Enum.Font.Cartoon
SpeedBarLabel.TextSize=10
SpeedBarLabel.TextXAlignment=Enum.TextXAlignment.Left

local SpeedFill=Instance.new("Frame",SpeedBar)
SpeedFill.Size=UDim2.new((WalkSpeedValue-1)/14,0,1,0)
SpeedFill.BackgroundColor3=Color3.fromRGB(0,170,255)
SpeedFill.BorderSizePixel=0
Instance.new("UICorner",SpeedFill).CornerRadius=UDim.new(1,0)

local SpeedValue=Instance.new("TextBox",SpeedFrame)
SpeedValue.Size=UDim2.new(0,38,0,20)
SpeedValue.Position=UDim2.new(1,-38,0,37)
SpeedValue.BackgroundColor3=Color3.fromRGB(30,35,45)
SpeedValue.BorderSizePixel=0
SpeedValue.Text=tostring(WalkSpeedValue)
SpeedValue.TextColor3=Color3.fromRGB(255,255,255)
SpeedValue.Font=Enum.Font.Cartoon
SpeedValue.TextSize=11
SpeedValue.ClearTextOnFocus=false
Instance.new("UICorner",SpeedValue).CornerRadius=UDim.new(0,5)

local SpeedDragging=false

local function SetSpeed(Value)
	Value=math.clamp(tonumber(Value) or 7,1,15)
	WalkSpeedValue=Value
	SpeedValue.Text=tostring(Value)
	SpeedFill.Size=UDim2.new((Value-1)/14,0,1,0)
end

local function UpdateSpeedFromInput(Input)
	local X=math.clamp(Input.Position.X-SpeedBar.AbsolutePosition.X,0,SpeedBar.AbsoluteSize.X)
	local Percent=X/SpeedBar.AbsoluteSize.X
	local Value=math.floor(1+(Percent*14)+0.5)
	SetSpeed(Value)
end

SpeedToggle.MouseButton1Click:Connect(function()
	SpeedBoostEnabled=not SpeedBoostEnabled
	SetToggleStyle(SpeedToggle,SpeedBoostEnabled)
end)

SpeedBar.InputBegan:Connect(function(Input)
	if Input.UserInputType==Enum.UserInputType.MouseButton1 or Input.UserInputType==Enum.UserInputType.Touch then
		SpeedDragging=true
		UpdateSpeedFromInput(Input)
	end
end)

UserInputService.InputChanged:Connect(function(Input)
	if SpeedDragging and (Input.UserInputType==Enum.UserInputType.MouseMovement or Input.UserInputType==Enum.UserInputType.Touch) then
		UpdateSpeedFromInput(Input)
	end
end)

UserInputService.InputEnded:Connect(function(Input)
	if Input.UserInputType==Enum.UserInputType.MouseButton1 or Input.UserInputType==Enum.UserInputType.Touch then
		SpeedDragging=false
	end
end)

SpeedValue.FocusLost:Connect(function()
	SetSpeed(SpeedValue.Text)
end)

--// JUMP BOOST
local JumpToggle=MakeToggle("JUMP BOOST")
JumpToggle.LayoutOrder=5

local function UpdateJumpBoost()
	local Character=LocalPlayer.Character
	local Humanoid=Character and Character:FindFirstChildOfClass("Humanoid")
	if not Humanoid then return end

	Humanoid.UseJumpPower=true

	if JumpBoostEnabled then
		Humanoid.JumpPower=JumpPowerValue
	else
		Humanoid.JumpPower=DefaultJumpPower
	end
end

JumpToggle.MouseButton1Click:Connect(function()
	JumpBoostEnabled=not JumpBoostEnabled
	SetToggleStyle(JumpToggle,JumpBoostEnabled)
	UpdateJumpBoost()
end)

--// SIZE
local SizeRow=Instance.new("Frame",Scroll)
SizeRow.Size=UDim2.new(1,0,0,30)
SizeRow.BackgroundTransparency=1
SizeRow.LayoutOrder=6

local Box=Instance.new("TextBox",SizeRow)
Box.Size=UDim2.new(0,75,0,27)
Box.Position=UDim2.new(0,0,0,1)
Box.BackgroundColor3=Color3.fromRGB(30,35,45)
Box.BorderSizePixel=0
Box.Text=tostring(HitboxSize)
Box.PlaceholderText="Size"
Box.TextColor3=Color3.fromRGB(255,255,255)
Box.Font=Enum.Font.Cartoon
Box.TextSize=14
Box.ClearTextOnFocus=false
Instance.new("UICorner",Box).CornerRadius=UDim.new(0,6)

local SizeLabel=Instance.new("TextLabel",SizeRow)
SizeLabel.Size=UDim2.new(1,-85,0,27)
SizeLabel.Position=UDim2.new(0,85,0,1)
SizeLabel.BackgroundTransparency=1
SizeLabel.Text="Size Hitbox: "..HitboxSize
SizeLabel.TextColor3=Color3.fromRGB(255,255,255)
SizeLabel.Font=Enum.Font.Cartoon
SizeLabel.TextSize=13
SizeLabel.TextXAlignment=Enum.TextXAlignment.Left

Box.FocusLost:Connect(function()
	local Value=tonumber(Box.Text)

	if Value then
		HitboxSize=math.clamp(Value,1,100)
	end

	Box.Text=tostring(HitboxSize)
	SizeLabel.Text="Size Hitbox: "..HitboxSize

	if PlayerHitboxEnabled then
		UpdatePlayerHitboxes()
	end

	if MobHitboxEnabled then
		UpdateMobHitboxes()
	end
end)

--// LOW CPU
local LowCpuToggle=MakeToggle("TỐI ƯU CPU >")
LowCpuToggle.LayoutOrder=7

--// PLAYER HITBOX
local function ApplyPlayerHitbox(Player)
	if Player==LocalPlayer or not PlayerHitboxEnabled then return end

	local Character=Player.Character
	if not Character then return end

	local Root=Character:FindFirstChild("HumanoidRootPart")
	if not Root then return end

	if not OriginalData[Player] then
		OriginalData[Player]={
			Size=Root.Size,
			Transparency=Root.Transparency,
			CanCollide=Root.CanCollide,
			Massless=Root.Massless
		}
	end

	Root.Size=Vector3.new(HitboxSize,HitboxSize,HitboxSize)
	Root.Transparency=HitboxTransparency
	Root.CanCollide=false
	Root.Massless=true
end

local function RestorePlayerHitbox(Player)
	local Data=OriginalData[Player]
	if not Data then return end

	local Character=Player.Character
	local Root=Character and Character:FindFirstChild("HumanoidRootPart")

	if Root then
		Root.Size=Data.Size
		Root.Transparency=Data.Transparency
		Root.CanCollide=Data.CanCollide
		Root.Massless=Data.Massless
	end

	OriginalData[Player]=nil
end

local function UpdatePlayerHitboxes()
	for _,Player in ipairs(Players:GetPlayers()) do
		if Player~=LocalPlayer then
			if PlayerHitboxEnabled then
				ApplyPlayerHitbox(Player)
			else
				RestorePlayerHitbox(Player)
			end
		end
	end
end

--// MOB HITBOX
local function ApplyMobHitbox(Model)
	if not MobHitboxEnabled then return end

	local Root=Model:FindFirstChild("HumanoidRootPart")
	if not Root or not Root:IsA("BasePart") then return end

	if not OriginalData[Model] then
		OriginalData[Model]={
			Size=Root.Size,
			Transparency=Root.Transparency,
			CanCollide=Root.CanCollide,
			Massless=Root.Massless
		}
	end

	Root.Size=Vector3.new(HitboxSize,HitboxSize,HitboxSize)
	Root.Transparency=HitboxTransparency
	Root.CanCollide=false
	Root.Massless=true
end

local function RestoreMobHitbox(Model)
	local Data=OriginalData[Model]
	if not Data then return end

	local Root=Model:FindFirstChild("HumanoidRootPart")

	if Root then
		Root.Size=Data.Size
		Root.Transparency=Data.Transparency
		Root.CanCollide=Data.CanCollide
		Root.Massless=Data.Massless
	end

	OriginalData[Model]=nil
end

local function UpdateMobHitboxes()
	local Enemies=Workspace:FindFirstChild("Enemies")
	if not Enemies then return end

	for _,Mob in ipairs(Enemies:GetChildren()) do
		if Mob:IsA("Model") and Mob:FindFirstChildOfClass("Humanoid") then
			local Root=Mob:FindFirstChild("HumanoidRootPart")

			if Root then
				if MobHitboxEnabled then
					ApplyMobHitbox(Mob)
				else
					RestoreMobHitbox(Mob)
				end
			end
		end
	end
end

--// ESP
local function GetPlayerColor(Player)
	if Player.Team and Player.Team.TeamColor then
		return Player.Team.TeamColor.Color
	end

	return Color3.fromRGB(255,255,255)
end

local function RemoveESP(Player)
	local Billboard=ESPs[Player]

	if Billboard then
		Billboard:Destroy()
		ESPs[Player]=nil
	end
end

local function CreateESP(Player)
	if Player==LocalPlayer or not ESPEnabled then return end

	local Character=Player.Character
	if not Character then return end

	local Head=Character:FindFirstChild("Head")
	local Humanoid=Character:FindFirstChildOfClass("Humanoid")

	if not Head or not Humanoid then return end

	RemoveESP(Player)

	local Billboard=Instance.new("BillboardGui")
	Billboard.Name="PlayerInfoESP"
	Billboard.Adornee=Head
	Billboard.Size=UDim2.new(0,180,0,55)
	Billboard.StudsOffset=Vector3.new(0,3.2,0)
	Billboard.AlwaysOnTop=true
	Billboard.MaxDistance=math.huge
	Billboard.Parent=Head

	local Text=Instance.new("TextLabel",Billboard)
	Text.Name="Info"
	Text.Size=UDim2.new(1,0,1,0)
	Text.BackgroundTransparency=1
	Text.TextStrokeTransparency=0.25
	Text.Font=Enum.Font.Cartoon
	Text.TextSize=13
	Text.TextWrapped=true
	Text.TextYAlignment=Enum.TextYAlignment.Center

	ESPs[Player]=Billboard

	task.spawn(function()
		while Billboard.Parent and Player.Parent and Character.Parent and ESPEnabled do
			local Health=math.floor(Humanoid.Health+0.5)
			local MaxHealth=math.floor(Humanoid.MaxHealth+0.5)

			local Root=Character:FindFirstChild("HumanoidRootPart")
			local MyCharacter=LocalPlayer.Character
			local MyRoot=MyCharacter and MyCharacter:FindFirstChild("HumanoidRootPart")

			local M=0

			if Root and MyRoot then
				local Distance=(MyRoot.Position-Root.Position).Magnitude
				M=math.floor(Distance/10+0.5)
			end

			Text.Text=Player.DisplayName.." | "..M.."m\nHealth: "..Health.." / "..MaxHealth
			Text.TextColor3=GetPlayerColor(Player)

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

local function UpdateESP()
	for _,Player in ipairs(Players:GetPlayers()) do
		if Player~=LocalPlayer then
			if ESPEnabled then
				CreateESP(Player)
			else
				RemoveESP(Player)
			end
		end
	end
end
--// LOW CPU GRAPHICS
local function SaveGraphics()
	if GraphicsBackup.Saved then return end

	local Lighting=game:GetService("Lighting")
	local Terrain=Workspace.Terrain

	GraphicsBackup.Saved=true
	GraphicsBackup.GlobalShadows=Lighting.GlobalShadows
	GraphicsBackup.FogEnd=Lighting.FogEnd
	GraphicsBackup.Brightness=Lighting.Brightness
	GraphicsBackup.WaterWaveSize=Terrain.WaterWaveSize
	GraphicsBackup.WaterWaveSpeed=Terrain.WaterWaveSpeed
	GraphicsBackup.WaterReflectance=Terrain.WaterReflectance
	GraphicsBackup.WaterTransparency=Terrain.WaterTransparency
	GraphicsBackup.Effects={}
	GraphicsBackup.QualityLevel=nil

	pcall(function()
		GraphicsBackup.QualityLevel=settings().Rendering.QualityLevel
	end)

	for _,Obj in ipairs(Lighting:GetChildren()) do
		if Obj:IsA("BlurEffect")
		or Obj:IsA("SunRaysEffect")
		or Obj:IsA("ColorCorrectionEffect")
		or Obj:IsA("BloomEffect")
		or Obj:IsA("DepthOfFieldEffect") then
			GraphicsBackup.Effects[Obj]=Obj.Enabled
		end
	end
end

local function RestoreGraphics()
	if not GraphicsBackup.Saved then return end

	local Lighting=game:GetService("Lighting")
	local Terrain=Workspace.Terrain

	Lighting.GlobalShadows=GraphicsBackup.GlobalShadows
	Lighting.FogEnd=GraphicsBackup.FogEnd
	Lighting.Brightness=GraphicsBackup.Brightness

	Terrain.WaterWaveSize=GraphicsBackup.WaterWaveSize
	Terrain.WaterWaveSpeed=GraphicsBackup.WaterWaveSpeed
	Terrain.WaterReflectance=GraphicsBackup.WaterReflectance
	Terrain.WaterTransparency=GraphicsBackup.WaterTransparency

	pcall(function()
		if GraphicsBackup.QualityLevel then
			settings().Rendering.QualityLevel=GraphicsBackup.QualityLevel
		end
	end)

	for Obj,Enabled in pairs(GraphicsBackup.Effects or {}) do
		if Obj and Obj.Parent then
			Obj.Enabled=Enabled
		end
	end

	GraphicsBackup={}
end

local function LowCpuSmooth()
	if LowCpuRunning then return end

	LowCpuRunning=true
	SaveGraphics()

	local Lighting=game:GetService("Lighting")
	local Terrain=Workspace.Terrain

	Terrain.WaterWaveSize=0
	Terrain.WaterWaveSpeed=0
	Terrain.WaterReflectance=0
	Terrain.WaterTransparency=0

	Lighting.GlobalShadows=false
	Lighting.FogEnd=9e9
	Lighting.Brightness=0

	pcall(function()
		settings().Rendering.QualityLevel="Level01"
	end)

	for _,Obj in ipairs(Lighting:GetChildren()) do
		if not LowCpuEnabled then break end

		if Obj:IsA("BlurEffect")
		or Obj:IsA("SunRaysEffect")
		or Obj:IsA("ColorCorrectionEffect")
		or Obj:IsA("BloomEffect")
		or Obj:IsA("DepthOfFieldEffect") then
			Obj.Enabled=false
		end

		RunService.Heartbeat:Wait()
	end

	local Descendants=game:GetDescendants()
	local BATCH_SIZE=50

	task.spawn(function()
		for i,Obj in ipairs(Descendants) do
			if not LowCpuEnabled then break end

			if Obj:IsA("Part")
			or Obj:IsA("UnionOperation")
			or Obj:IsA("CornerWedgePart")
			or Obj:IsA("TrussPart") then
				Obj.Material=Enum.Material.Plastic
				Obj.Reflectance=0
			elseif Obj:IsA("Decal")
			or Obj:IsA("Texture") then
				Obj.Transparency=1
			elseif Obj:IsA("ParticleEmitter")
			or Obj:IsA("Trail") then
				Obj.Lifetime=NumberRange.new(0)
			elseif Obj:IsA("Explosion") then
				Obj.BlastPressure=1
				Obj.BlastRadius=1
			elseif Obj:IsA("Fire")
			or Obj:IsA("SpotLight")
			or Obj:IsA("Smoke")
			or Obj:IsA("Sparkles") then
				Obj.Enabled=false
			elseif Obj:IsA("MeshPart") then
				Obj.Material=Enum.Material.Plastic
				Obj.Reflectance=0
				Obj.TextureID="rbxassetid://10385902758728957"
			end

			if i%BATCH_SIZE==0 then
				RunService.Heartbeat:Wait()
			end
		end

		LowCpuRunning=false

		if LowCpuEnabled then
			SetToggleStyle(LowCpuToggle,true)
		end
	end)
end

--// TOGGLES
PlayerToggle.MouseButton1Click:Connect(function()
	PlayerHitboxEnabled=not PlayerHitboxEnabled
	SetToggleStyle(PlayerToggle,PlayerHitboxEnabled)

	if PlayerHitboxEnabled then
		UpdatePlayerHitboxes()
	else
		for _,Player in ipairs(Players:GetPlayers()) do
			if Player~=LocalPlayer then
				RestorePlayerHitbox(Player)
			end
		end
	end
end)

MobToggle.MouseButton1Click:Connect(function()
	MobHitboxEnabled=not MobHitboxEnabled
	SetToggleStyle(MobToggle,MobHitboxEnabled)

	if MobHitboxEnabled then
		UpdateMobHitboxes()
	else
		local Enemies=Workspace:FindFirstChild("Enemies")

		if Enemies then
			for _,Mob in ipairs(Enemies:GetChildren()) do
				if Mob:IsA("Model") then
					RestoreMobHitbox(Mob)
				end
			end
		end
	end
end)

ESPToggle.MouseButton1Click:Connect(function()
	ESPEnabled=not ESPEnabled
	SetToggleStyle(ESPToggle,ESPEnabled)
	UpdateESP()
end)

LowCpuToggle.MouseButton1Click:Connect(function()
	if LowCpuRunning then return end

	LowCpuEnabled=not LowCpuEnabled
	SetToggleStyle(LowCpuToggle,LowCpuEnabled)

	if LowCpuEnabled then
		LowCpuSmooth()
	else
		RestoreGraphics()
	end
end)

--// PLAYER ADDED
Players.PlayerAdded:Connect(function(Player)
	Player.CharacterAdded:Connect(function(Character)
		task.wait(0.5)

		if PlayerHitboxEnabled then
			ApplyPlayerHitbox(Player)
		end

		if ESPEnabled then
			CreateESP(Player)
		end
	end)
end)

Players.PlayerRemoving:Connect(function(Player)
	RestorePlayerHitbox(Player)
	RemoveESP(Player)
	OriginalData[Player]=nil
end)

--// CHARACTER ADDED
LocalPlayer.CharacterAdded:Connect(function(Character)
	task.wait(0.5)

	local Humanoid=Character:FindFirstChildOfClass("Humanoid")

	if Humanoid then
		Humanoid.UseJumpPower=true

		if JumpBoostEnabled then
			Humanoid.JumpPower=JumpPowerValue
		else
			Humanoid.JumpPower=DefaultJumpPower
		end
	end
end)

--// PLAYER CHARACTER CONNECTIONS
for _,Player in ipairs(Players:GetPlayers()) do
	if Player~=LocalPlayer then
		Player.CharacterAdded:Connect(function(Character)
			task.wait(0.5)

			if PlayerHitboxEnabled then
				ApplyPlayerHitbox(Player)
			end

			if ESPEnabled then
				CreateESP(Player)
			end
		end)
	end
end

--// PLAYER HITBOX UPDATE
Connections[#Connections+1]=RunService.Heartbeat:Connect(function()
	if PlayerHitboxEnabled then
		UpdatePlayerHitboxes()
	end
end)

--// MOB HITBOX UPDATE
task.spawn(function()
	while Gui.Parent do
		task.wait(0.15)

		if MobHitboxEnabled then
			UpdateMobHitboxes()
		end
	end
end)

--// ESP UPDATE
task.spawn(function()
	while Gui.Parent do
		task.wait(1)

		if ESPEnabled then
			UpdateESP()
		end
	end
end)

--// SPEED BOOST
Connections[#Connections+1]=RunService.Heartbeat:Connect(function()
	if not SpeedBoostEnabled then return end

	local Character=LocalPlayer.Character
	local Humanoid=Character and Character:FindFirstChildOfClass("Humanoid")
	local Root=Character and Character:FindFirstChild("HumanoidRootPart")

	if Humanoid and Root and not Humanoid.SeatPart and Humanoid.MoveDirection.Magnitude>0 then
		Root.CanCollide=false
		Root.CFrame=Root.CFrame+(Humanoid.MoveDirection*WalkSpeedValue)
	end
end)

--// MINIMIZE
local OpenSize=UDim2.new(0,220,0,275)
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

		TweenService:Create(
			Main,
			TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
			{Size=OpenSize}
		):Play()

		task.delay(0.2,function()
			if not Minimized then
				SetChildrenVisible(true)
			end
		end)
	end
end)

--// CLOSE
Close.MouseButton1Click:Connect(function()
	for _,Connection in ipairs(Connections) do
		pcall(function()
			Connection:Disconnect()
		end)
	end

	LowCpuEnabled=false
	LowCpuRunning=false
	RestoreGraphics()

	for _,Player in ipairs(Players:GetPlayers()) do
		RestorePlayerHitbox(Player)
		RemoveESP(Player)
	end

	for Model,Data in pairs(OriginalData) do
		if typeof(Model)=="Instance" and Model:IsA("Model") then
			RestoreMobHitbox(Model)
		end
	end

	OriginalData={}
	GraphicsBackup={}

	Gui:Destroy()
end)

--// DRAG MOBILE + PC
local Dragging=false
local DragStart
local StartPos

local function UpdateDrag(Input)
	local Delta=Input.Position-DragStart

	Main.Position=UDim2.new(StartPos.X.Scale,StartPos.X.Offset+Delta.X,StartPos.Y.Scale,StartPos.Y.Offset+Delta.Y)
end

Title.InputBegan:Connect(function(Input)
	if Input.UserInputType==Enum.UserInputType.MouseButton1 or Input.UserInputType==Enum.UserInputType.Touch then
		Dragging=true
		DragStart=Input.Position
		StartPos=Main.Position
	end
end)

UserInputService.InputChanged:Connect(function(Input)
	if Dragging and (Input.UserInputType==Enum.UserInputType.MouseMovement or Input.UserInputType==Enum.UserInputType.Touch) then
		UpdateDrag(Input)
	end
end)

UserInputService.InputEnded:Connect(function(Input)
	if Input.UserInputType==Enum.UserInputType.MouseButton1 or Input.UserInputType==Enum.UserInputType.Touch then
		Dragging=false
	end
end)

SetSpeed(7)
