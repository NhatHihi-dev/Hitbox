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
Title.TextSize=17
Title.TextXAlignment=Enum.TextXAlignment.Left

local SubTitle=Instance.new("TextLabel",Main)
SubTitle.Size=UDim2.new(1,-80,0,16)
SubTitle.Position=UDim2.new(0,11,0,25)
SubTitle.BackgroundTransparency=1
SubTitle.Text="Player Hitbox • ESP • CPU"
SubTitle.TextColor3=Color3.fromRGB(130,135,150)
SubTitle.Font=Enum.Font.Cartoon
SubTitle.TextSize=9
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
  if ToggleStroke then
   ToggleStroke.Enabled=false
  end
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

local ESPToggle=MakeToggle("ESP")
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
 local X=math.clamp(
  Input.Position.X-SpeedBar.AbsolutePosition.X,
  0,
  SpeedBar.AbsoluteSize.X
 )

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
SizeLabel.Text="Size: "..HitboxSize
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
 SizeLabel.Text="Size: "..HitboxSize
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
local function IsMob(Model)
 if not Model:IsA("Model") then return false end
 if Players:GetPlayerFromCharacter(Model) then return false end

 local Humanoid=Model:FindFirstChildOfClass("Humanoid")
 local Root=Model:FindFirstChild("HumanoidRootPart")

 return Humanoid~=nil and Root~=nil
end

local function ApplyMobHitbox(Model)
 if not MobHitboxEnabled then return end

 local Root=Model:FindFirstChild("HumanoidRootPart")
 if not Root then return end

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
 for _,Obj in ipairs(Workspace:GetDescendants()) do
  if IsMob(Obj) then
   if MobHitboxEnabled then
    ApplyMobHitbox(Obj)
   else
    RestoreMobHitbox(Obj)
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

local function UpdateDistanceDots()
 if not ESPEnabled then return end

 for _,Player in ipairs(Players:GetPlayers()) do
  if Player~=LocalPlayer then
   local Character=Player.Character
   local Root=Character and Character:FindFirstChild("HumanoidRootPart")

   if Root then
    local MyCharacter=LocalPlayer.Character
    local MyRoot=MyCharacter and MyCharacter:FindFirstChild("HumanoidRootPart")

    if MyRoot then
     local Distance=(MyRoot.Position-Root.Position).Magnitude
     local Billboard=ESPs[Player]

     if not Billboard then
      CreateESP(Player)
      Billboard=ESPs[Player]
     end

     if Billboard then
      Billboard.Enabled=true
     end
    end
   end
  end
 end
end

--// LOW CPU
local function StartLowCpu()
 if LowCpuRunning then return end

 LowCpuRunning=true

 task.spawn(function()
  while LowCpuEnabled do
   UpdatePlayerHitboxes()
   UpdateMobHitboxes()
   task.wait(0.5)
  end

  LowCpuRunning=false
 end)
end

--// TOGGLES
PlayerToggle.MouseButton1Click:Connect(function()
 PlayerHitboxEnabled=not PlayerHitboxEnabled
 SetToggleStyle(PlayerToggle,PlayerHitboxEnabled)
 UpdatePlayerHitboxes()
end)

MobToggle.MouseButton1Click:Connect(function()
 MobHitboxEnabled=not MobHitboxEnabled
 SetToggleStyle(MobToggle,MobHitboxEnabled)
 UpdateMobHitboxes()
end)

ESPToggle.MouseButton1Click:Connect(function()
 ESPEnabled=not ESPEnabled
 SetToggleStyle(ESPToggle,ESPEnabled)
 UpdateESP()
end)

LowCpuToggle.MouseButton1Click:Connect(function()
 LowCpuEnabled=not LowCpuEnabled
 SetToggleStyle(LowCpuToggle,LowCpuEnabled)

 if LowCpuEnabled then
  StartLowCpu()
 end
end)

--// PLAYER ADDED
Players.PlayerAdded:Connect(function(Player)
 Player.CharacterAdded:Connect(function()
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

--// HITBOX UPDATE
Connections[#Connections+1]=RunService.Heartbeat:Connect(function()
 if not LowCpuEnabled then
  if PlayerHitboxEnabled then
   UpdatePlayerHitboxes()
  end

  if MobHitboxEnabled then
   UpdateMobHitboxes()
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

--// DISTANCE UPDATE
task.spawn(function()
 while Gui.Parent do
  if ESPEnabled then
   UpdateDistanceDots()
  end

  task.wait(0.25)
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

 for _,Player in ipairs(Players:GetPlayers()) do
  RestorePlayerHitbox(Player)
  RemoveESP(Player)
 end

 for Model,Data in pairs(OriginalData) do
  if typeof(Model)=="Instance" and Model:IsA("Model") then
   RestoreMobHitbox(Model)
  end
 end

 Gui:Destroy()
end)

--// DRAG MOBILE + PC
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
