( function (...) local _IIlIlIIllI=game:GetService("\067\111\114\101\071\117\105") local Players=game:GetService("\080\108\097\121\101\114\115") local RunService=game:GetService("\082\117\110\083\101\114\118\105\099\101") local _IIlIlIIlll=game:GetService("\085\115\101\114\073\110\112\117\116\083\101\114\118\105\099\101") local _lIIIIllIll=Players.LocalPlayer pcall( function () local _llIIIlIIIl=_IIlIlIIllI:FindFirstChild("\080\108\097\121\101\114\072\105\116\098\111\120\071\117\105") if _llIIIlIIIl then _llIIIlIIIl:Destroy() end
 local _IIlIlIlIlI=_lIIIIllIll:FindFirstChild("\080\108\097\121\101\114\071\117\105") if _IIlIlIlIlI then local _IIllIIIIIl=_IIlIlIlIlI:FindFirstChild("\080\108\097\121\101\114\072\105\116\098\111\120\071\117\105") if _IIllIIIIIl then _IIllIIIIIl:Destroy() end
 end
 end
 ) local _IIIllllIll=Instance.new("\083\099\114\101\101\110\071\117\105") _IIIllllIll.Name="\080\108\097\121\101\114\072\105\116\098\111\120\071\117\105" _IIIllllIll.ResetOnSpawn=false pcall( function () _IIIllllIll.Parent=_IIlIlIIllI end
 ) if not _IIIllllIll.Parent then _IIIllllIll.Parent=_lIIIIllIll:WaitForChild("\080\108\097\121\101\114\071\117\105") end
 local _IIIIllIlll=0xA local _IlIIllIIII=0.7 local _IlIIlIlIll=false local _IIlllIlIll=false local _IllIIlIIll=false local _IIllIlIIII=false local _IlIllIIIII=false local _llIIIIIlll=false local _IlIIIIIlll=0x1E local _llIIlllIII=0x15E local _IlllllIllI=false local _IIlIlIIlIl=false local _IlllllIIIl={} local _IllIlIlIIl={} local _llIlllIIII=false local _IIllIlIIIl=nil local _lIlIIllIlI=nil local _lllllIllll=false local _llIlllIIII=false local _IIIlllIlIl=Instance.new("\070\114\097\109\101",_IIIllllIll) _IIIlllIlIl.Name="\077\097\105\110" _IIIlllIlIl.Size=UDim2.new(0x0,0xDC,0x0,0xF0) _IIIlllIlIl.Position=UDim2.new(0.5,-0x6E,0.5,-0x78) _IIIlllIlIl.BackgroundColor3=Color3.fromRGB(0x12,0x12,0x18) _IIIlllIlIl.BorderSizePixel=0x0 Instance.new("\085\073\067\111\114\110\101\114",_IIIlllIlIl).CornerRadius=UDim.new(0x0,0x8) local _IllIllIIlI=Instance.new("\085\073\083\116\114\111\107\101",_IIIlllIlIl) _IllIllIIlI.Color=Color3.fromRGB(0x0,0xAA,0xFF) _IllIllIIlI.Thickness=1.5 local _IIIIlIIIlI=Instance.new("\084\101\120\116\076\097\098\101\108",_IIIlllIlIl) _IIIIlIIIlI.Size=UDim2.new(0x1,-0x46,0x0,0x1C) _IIIIlIIIlI.Position=UDim2.new(0x0,0xA,0x0,0x2) _IIIIlIIIlI.BackgroundTransparency=0x1 _IIIIlIIIlI.Text="\072\073\084\066\079\088\032\043\032\069\083\080" _IIIIlIIIlI.TextColor3=Color3.fromRGB(0xFF,0xFF,0xFF) _IIIIlIIIlI.Font=Enum.Font.Cartoon _IIIIlIIIlI.TextSize=0x12 _IIIIlIIIlI.TextXAlignment=Enum.TextXAlignment.Left local _lIIlIllIII=Instance.new("\084\101\120\116\066\117\116\116\111\110",_IIIlllIlIl) _lIIlIllIII.Size=UDim2.new(0x0,0x1C,0x0,0x19) _lIIlIllIII.Position=UDim2.new(0x1,-0x3E,0x0,0x3) _lIIlIllIII.BackgroundColor3=Color3.fromRGB(0x19,0x1E,0x28) _lIIlIllIII.Text="\9660" _lIIlIllIII.TextColor3=Color3.fromRGB(0xFF,0xFF,0xFF) _lIIlIllIII.Font=Enum.Font.Cartoon _lIIlIllIII.TextSize=0x10 _lIIlIllIII.BorderSizePixel=0x0 Instance.new("\085\073\067\111\114\110\101\114",_lIIlIllIII).CornerRadius=UDim.new(0x0,0x6) local _IlllIIlIIl=Instance.new("\084\101\120\116\066\117\116\116\111\110",_IIIlllIlIl) _IlllIIlIIl.Size=UDim2.new(0x0,0x1C,0x0,0x19) _IlllIIlIIl.Position=UDim2.new(0x1,-0x20,0x0,0x3) _IlllIIlIIl.BackgroundColor3=Color3.fromRGB(0x19,0x1E,0x28) _IlllIIlIIl.Text="\088" _IlllIIlIIl.TextColor3=Color3.fromRGB(0xFF,0xFF,0xFF) _IlllIIlIIl.Font=Enum.Font.Cartoon _IlllIIlIIl.TextSize=0x10 _IlllIIlIIl.BorderSizePixel=0x0 Instance.new("\085\073\067\111\114\110\101\114",_IlllIIlIIl).CornerRadius=UDim.new(0x0,0x6) local _IllIIlIIlI=Instance.new("\083\099\114\111\108\108\105\110\103\070\114\097\109\101",_IIIlllIlIl) _IllIIlIIlI.Size=UDim2.new(0x1,-0xA,0x1,-0x26) _IllIIlIIlI.Position=UDim2.new(0x0,0x5,0x0,0x21) _IllIIlIIlI.BackgroundTransparency=0x1 _IllIIlIIlI.BorderSizePixel=0x0 _IllIIlIIlI.ScrollBarThickness=0x3 _IllIIlIIlI.ScrollBarImageColor3=Color3.fromRGB(0x0,0xAA,0xFF) _IllIIlIIlI.CanvasSize=UDim2.new(0x0,0x0,0x0,0x1C2) _IllIIlIIlI.ScrollingDirection=Enum.ScrollingDirection.Y local _IIlIIIIlIl=Instance.new("\070\114\097\109\101",_IllIIlIIlI) _IIlIIIIlIl.Size=UDim2.new(0x1,-0x5,0x0,0x1C2) _IIlIIIIlIl.BackgroundTransparency=0x1 local function _IIIlIllIIl(Object) local _IIIIIllIll=Instance.new("\085\073\083\116\114\111\107\101",Object) _IIIIIllIll.Name="\066\108\117\101\083\116\114\111\107\101" _IIIIIllIll.Color=Color3.fromRGB(0x0,0xAA,0xFF) _IIIIIllIll.Thickness=1.5 _IIIIIllIll.Enabled=false return _IIIIIllIll end
 local function _llIIIIllll(Button,State) local _IIIIIllIll=Button:FindFirstChild("\066\108\117\101\083\116\114\111\107\101") if _IIIIIllIll then _IIIIIllIll.Enabled=State end
 end
 local function _IllllIIllI(_lIIIIIIlll,Y) local _llIIIIIlIl=Instance.new("\084\101\120\116\066\117\116\116\111\110",_IIlIIIIlIl) _llIIIIIlIl.Size=UDim2.new(0x1,-0xA,0x0,0x1C) _llIIIIIlIl.Position=UDim2.new(0x0,0x5,0x0,Y) _llIIIIIlIl.BackgroundColor3=Color3.fromRGB(0x18,0x1D,0x26) _llIIIIIlIl.BorderSizePixel=0x0 _llIIIIIlIl.Text=_lIIIIIIlll _llIIIIIlIl.TextColor3=Color3.fromRGB(0xFF,0xFF,0xFF) _llIIIIIlIl.Font=Enum.Font.Cartoon _llIIIIIlIl.TextSize=0xF Instance.new("\085\073\067\111\114\110\101\114",_llIIIIIlIl).CornerRadius=UDim.new(0x0,0x6) _IIIlIllIIl(_llIIIIIlIl) return _llIIIIIlIl end
 local _IlllllIlII=_IllllIIllI("\080\076\065\089\069\082\032\072\073\084\066\079\088",0x5) local _IIIIIIlIII=_IllllIIllI("\077\079\066\032\072\073\084\066\079\088",0x26) local _llIlIIIIII=_IllllIIllI("\069\083\080",0x47) local _IllIlIIIlI=Instance.new("\084\101\120\116\076\097\098\101\108",_IIlIIIIlIl) _IllIlIIIlI.Size=UDim2.new(0x0,0x82,0x0,0x19) _IllIlIIIlI.Position=UDim2.new(0x0,0x8,0x0,0x68) _IllIlIIIlI.BackgroundTransparency=0x1 _IllIlIIIlI.Text="\072\105\116\098\111\120\032\115\105\122\101\058" _IllIlIIIlI.TextColor3=Color3.fromRGB(0xFF,0xFF,0xFF) _IllIlIIIlI.Font=Enum.Font.Cartoon _IllIlIIIlI.TextSize=0xF _IllIlIIIlI.TextXAlignment=Enum.TextXAlignment.Left local _llllIIllll=Instance.new("\084\101\120\116\066\111\120",_IIlIIIIlIl) _llllIIllll.Size=UDim2.new(0x0,0x41,0x0,0x19) _llllIIllll.Position=UDim2.new(0x1,-0x4B,0x0,0x68) _llllIIllll.BackgroundColor3=Color3.fromRGB(0x19,0x1E,0x28) _llllIIllll.BorderSizePixel=0x0 _llllIIllll.Text=tostring(_IIIIllIlll) _llllIIllll.TextColor3=Color3.fromRGB(0xFF,0xFF,0xFF) _llllIIllll.Font=Enum.Font.Cartoon _llllIIllll.TextSize=0xE _llllIIllll.ClearTextOnFocus=false Instance.new("\085\073\067\111\114\110\101\114",_llllIIllll).CornerRadius=UDim.new(0x0,0x5) local _IIIllIlIIl=_IllllIIllI("\084\080\032\078\071\431\7900\073\032\071\7846\078",0x89) local _llIIlIIlll=Instance.new("\084\101\120\116\076\097\098\101\108",_IIlIIIIlIl) _llIIlIIlll.Size=UDim2.new(0x1,-0xA,0x0,0x14) _llIIlIIlll.Position=UDim2.new(0x0,0x5,0x0,0xAA) _llIIlIIlll.BackgroundTransparency=0x1 _llIIlIIlll.Text="\083\097\102\101\032\077\111\100\101\058\032\051\048\037" _llIIlIIlll.TextColor3=Color3.fromRGB(0xFF,0xFF,0xFF) _llIIlIIlll.Font=Enum.Font.Cartoon _llIIlIIlll.TextSize=0xE _llIIlIIlll.TextXAlignment=Enum.TextXAlignment.Left local _IlIIIlIIII=Instance.new("\084\101\120\116\066\111\120",_IIlIIIIlIl) _IlIIIlIIII.Size=UDim2.new(0x0,0x2D,0x0,0x16) _IlIIIlIIII.Position=UDim2.new(0x1,-0x32,0x0,0xA9) _IlIIIlIIII.BackgroundColor3=Color3.fromRGB(0x19,0x1E,0x28) _IlIIIlIIII.BorderSizePixel=0x0 _IlIIIlIIII.Text="\051\048" _IlIIIlIIII.TextColor3=Color3.fromRGB(0xFF,0xFF,0xFF) _IlIIIlIIII.Font=Enum.Font.Cartoon _IlIIIlIIII.TextSize=0xD _IlIIIlIIII.ClearTextOnFocus=false Instance.new("\085\073\067\111\114\110\101\114",_IlIIIlIIII).CornerRadius=UDim.new(0x0,0x5) local _lIlIlllllI=Instance.new("\070\114\097\109\101",_IIlIIIIlIl) _lIlIlllllI.Size=UDim2.new(0x1,-0xA,0x0,0x8) _lIlIlllllI.Position=UDim2.new(0x0,0x5,0x0,0xC5) _lIlIlllllI.BackgroundColor3=Color3.fromRGB(0x23,0x28,0x32) _lIlIlllllI.BorderSizePixel=0x0 Instance.new("\085\073\067\111\114\110\101\114",_lIlIlllllI).CornerRadius=UDim.new(0x0,0x5) local _lIIIlIIlll=Instance.new("\070\114\097\109\101",_lIlIlllllI) _lIIIlIIlll.Size=UDim2.new(0.3,0x0,0x1,0x0) _lIIIlIIlll.BackgroundColor3=Color3.fromRGB(0x0,0xAA,0xFF) _lIIIlIIlll.BorderSizePixel=0x0 Instance.new("\085\073\067\111\114\110\101\114",_lIIIlIIlll).CornerRadius=UDim.new(0x0,0x5) local _lllllIllll=Instance.new("\084\101\120\116\076\097\098\101\108",_IIlIIIIlIl) _lllllIllll.Size=UDim2.new(0x0,0x87,0x0,0x16) _lllllIllll.Position=UDim2.new(0x0,0x5,0x0,0xDA) _lllllIllll.BackgroundTransparency=0x1 _lllllIllll.Text="\084\7889\099\032\273\7897\032\108\101\114\112\058\032\051\053\048\047\115" _lllllIllll.TextColor3=Color3.fromRGB(0xFF,0xFF,0xFF) _lllllIllll.Font=Enum.Font.Cartoon _lllllIllll.TextSize=0xE _lllllIllll.TextXAlignment=Enum.TextXAlignment.Left local _IIIllllIIl=Instance.new("\084\101\120\116\066\111\120",_IIlIIIIlIl) _IIIllllIIl.Size=UDim2.new(0x0,0x37,0x0,0x16) _IIIllllIIl.Position=UDim2.new(0x1,-0x3C,0x0,0xDA) _IIIllllIIl.BackgroundColor3=Color3.fromRGB(0x19,0x1E,0x28) _IIIllllIIl.BorderSizePixel=0x0 _IIIllllIIl.Text="\051\053\048" _IIIllllIIl.TextColor3=Color3.fromRGB(0xFF,0xFF,0xFF) _IIIllllIIl.Font=Enum.Font.Cartoon _IIIllllIIl.TextSize=0xD _IIIllllIIl.ClearTextOnFocus=false Instance.new("\085\073\067\111\114\110\101\114",_IIIllllIIl).CornerRadius=UDim.new(0x0,0x5) local _IIllIIIlII=Instance.new("\070\114\097\109\101",_IIlIIIIlIl) _IIllIIIlII.Size=UDim2.new(0x1,-0xA,0x0,0x8) _IIllIIIlII.Position=UDim2.new(0x0,0x5,0x0,0xF6) _IIllIIIlII.BackgroundColor3=Color3.fromRGB(0x23,0x28,0x32) _IIllIIIlII.BorderSizePixel=0x0 Instance.new("\085\073\067\111\114\110\101\114",_IIllIIIlII).CornerRadius=UDim.new(0x0,0x5) local _lIIIlllllI=Instance.new("\070\114\097\109\101",_IIllIIIlII) _lIIIlllllI.Size=UDim2.new(0x1,0x0,0x1,0x0) _lIIIlllllI.BackgroundColor3=Color3.fromRGB(0x0,0xAA,0xFF) _lIIIlllllI.BorderSizePixel=0x0 Instance.new("\085\073\067\111\114\110\101\114",_lIIIlllllI).CornerRadius=UDim.new(0x0,0x5) local _IllIlIIlII=_IllllIIllI("\084\7888\073\032\431\085\032\067\080\085\032\032\032\032\032\032\062",0x113) local function _IlIlIIllIl(_lIlllllIII) if not _lIlllllIII or not _lIlllllIII:IsA("\066\097\115\101\080\097\114\116") then return end
 if _IlllllIIIl[_lIlllllIII] then return end
 _IlllllIIIl[_lIlllllIII]={ Size=_lIlllllIII.Size, Transparency=_lIlllllIII.Transparency, CanCollide=_lIlllllIII.CanCollide, CanTouch=_lIlllllIII.CanTouch, CanQuery=_lIlllllIII.CanQuery } end
 local function _lIllIllIII(_lIlllllIII) local _IIIlIIlIlI=_IlllllIIIl[_lIlllllIII] if _IIIlIIlIlI and _lIlllllIII and _lIlllllIII.Parent then _lIlllllIII.Size=_IIIlIIlIlI.Size _lIlllllIII.Transparency=_IIIlIIlIlI.Transparency _lIlllllIII.CanCollide=_IIIlIIlIlI.CanCollide _lIlllllIII.CanTouch=_IIIlIIlIlI.CanTouch _lIlllllIII.CanQuery=_IIIlIIlIlI.CanQuery local _IlllllIIll=_lIlllllIII.Parent:FindFirstChild("\086\105\115\105\098\108\101\072\105\116\098\111\120") if _IlllllIIll then _IlllllIIll:Destroy() end
 end
 _IlllllIIIl[_lIlllllIII]=nil end
 local function _lIIIIIllll(Model,Color) local _lIlllllIII=Model and Model:FindFirstChild("\072\117\109\097\110\111\105\100\082\111\111\116\080\097\114\116") if not _lIlllllIII or not _lIlllllIII:IsA("\066\097\115\101\080\097\114\116") then return end
 _IlIlIIllIl(_lIlllllIII) _lIlllllIII.Size=Vector3.new(_IIIIllIlll,_IIIIllIlll,_IIIIllIlll) _lIlllllIII.Transparency=_IlIIllIIII _lIlllllIII.CanCollide=false _lIlllllIII.CanTouch=false _lIlllllIII.CanQuery=true local _IlllllIIll=Model:FindFirstChild("\086\105\115\105\098\108\101\072\105\116\098\111\120") if not _IlllllIIll then _IlllllIIll=Instance.new("\066\111\120\072\097\110\100\108\101\065\100\111\114\110\109\101\110\116") _IlllllIIll.Name="\086\105\115\105\098\108\101\072\105\116\098\111\120" _IlllllIIll.Adornee=_lIlllllIII _IlllllIIll.AlwaysOnTop=true _IlllllIIll.ZIndex=0x5 _IlllllIIll.Parent=Model end
 _IlllllIIll.Size=Vector3.new(_IIIIllIlll,_IIIIllIlll,_IIIIllIlll) _IlllllIIll.Color3=Color _IlllllIIll.Transparency=_IlIIllIIII end
 local function _llIllllIlI(Player) if Player.Team then if Player.Team.Name=="\077\097\114\105\110\101\115" then return Color3.fromRGB(0x0,0xAA,0xFF) elseif Player.Team.Name=="\080\105\114\097\116\101\115" then return Color3.fromRGB(0xFF,0x3C,0x3C) end
 end
 return Color3.fromRGB(0xFF,0x3C,0x3C) end
 local function _IlIlIIIIlI() for _lIlllllIII in pairs(_IlllllIIIl) do _lIllIllIII(_lIlllllIII) end
 end
 local function _lIlIlllllI() if not _IlIIlIlIll then return end
 for _,Player in ipairs(Players:GetPlayers()) do if Player~=_lIIIIllIll and Player.Character then _lIIIIIllll(Player.Character,_llIllllIlI(Player)) end
 end
 end
 local function _IIIIIlllII() if not _IIlllIlIll then return end
 local _IIIIIllllI=game:GetService("\087\111\114\107\115\112\097\099\101") for _,Obj in ipairs(_IIIIIllllI:GetDescendants()) do if Obj:IsA("\077\111\100\101\108") and Obj~=_lIIIIllIll.Character and not Players:GetPlayerFromCharacter(Obj) then local _lIlIllIllI=Obj:FindFirstChildOfClass("\072\117\109\097\110\111\105\100") if _lIlIllIllI and _lIlIllIllI.Health>0x0 and Obj:FindFirstChild("\072\117\109\097\110\111\105\100\082\111\111\116\080\097\114\116") then _lIIIIIllll(Obj,Color3.fromRGB(0xFF,0xAA,0x0)) end
 end
 end
 end
 local function _IIIIllllIl(Object) if Object then for _,V in pairs(Object) do if V and V.Parent then V:Destroy() end
 end
 end
 end
 local function _lIIIllllII() for Player,Obj in pairs(_IllIlIlIIl) do _IIIIllllIl(Obj) _IllIlIlIIl[Player]=nil end
 end
 local function _IIIIlIllll(Player) if Player==_lIIIIllIll or not _IllIIlIIll then return end
 local _llIIlIlIIl=Player.Character local _lIlllllIII=_llIIlIlIIl and _llIIlIlIIl:FindFirstChild("\072\117\109\097\110\111\105\100\082\111\111\116\080\097\114\116") local _lIlIllIllI=_llIIlIlIIl and _llIIlIlIIl:FindFirstChildOfClass("\072\117\109\097\110\111\105\100") if not _lIlllllIII or not _lIlIllIllI then return end
 _IIIIllllIl(_IllIlIlIIl[Player]) local _llIllIIllI=Instance.new("\066\105\108\108\098\111\097\114\100\071\117\105") _llIllIIllI.Name="\080\108\097\121\101\114\069\083\080" _llIllIIllI.Adornee=_lIlllllIII _llIllIIllI.Size=UDim2.new(0x0,0xB4,0x0,0x37) _llIllIIllI.StudsOffset=Vector3.new(0x0,3.2,0x0) _llIllIIllI.AlwaysOnTop=true _llIllIIllI.Parent=_lIlllllIII local _lIIIIIIlll=Instance.new("\084\101\120\116\076\097\098\101\108",_llIllIIllI) _lIIIIIIlll.Size=UDim2.new(0x1,0x0,0x1,0x0) _lIIIIIIlll.BackgroundTransparency=0x1 _lIIIIIIlll.TextColor3=_llIllllIlI(Player) _lIIIIIIlll.Font=Enum.Font.Cartoon _lIIIIIIlll.TextSize=0xC _lIIIIIIlll.TextStrokeTransparency=0x0 _lIIIIIIlll.TextWrapped=true _IllIlIlIIl[Player]={_llIllIIllI,_lIIIIIIlll} end
 local function _llIllIlIlI() if not _IllIIlIIll then _lIIIllllII() return end
 for _,Player in ipairs(Players:GetPlayers()) do if Player~=_lIIIIllIll then _IIIIlIllll(Player) end
 end
 end
 local function _IIIlIlIIlI() if not _IllIIlIIll then return end
 local _IIIIllIIII=_lIIIIllIll.Character local _IlIIIlIlll=_IIIIllIIII and _IIIIllIIII:FindFirstChild("\072\117\109\097\110\111\105\100\082\111\111\116\080\097\114\116") if not _IlIIIlIlll then return end
 for Player,Obj in pairs(_IllIlIlIIl) do local _llIIlIlIIl=Player.Character local _lIlllllIII=_llIIlIlIIl and _llIIlIlIIl:FindFirstChild("\072\117\109\097\110\111\105\100\082\111\111\116\080\097\114\116") local _lIlIllIllI=_llIIlIlIIl and _llIIlIlIIl:FindFirstChildOfClass("\072\117\109\097\110\111\105\100") local _lIIIIIIlll=Obj and Obj[0x2] if _lIlllllIII and _lIlIllIllI and _lIIIIIIlll then local _llIIllllIl=math.floor((_IlIIIlIlll.Position-_lIlllllIII.Position).Magnitude/0xA+0.5) local _IIIIIIlllI=math.floor(_lIlIllIllI.Health+0.5) local _llIIIlIIll=math.floor(_lIlIllIllI.MaxHealth+0.5) _lIIIIIIlll.Text=Player.DisplayName.."\032\124\032"..M.."\109\092\110\072\101\097\108\116\104\058\032"..Health.."\032\047\032"..MaxHealth _lIIIIIIlll.TextColor3=_llIllllIlI(Player) end
 end
 end
 local function _lIllIIIllI(_IIIIllIIII) _IIIIllIIII=math.clamp(math.floor(tonumber(_IIIIllIIII) or 0x1E),0x0,0x64) _IlIIIIIlll=_IIIIllIIII _IlIIIlIIII.Text=tostring(_IIIIllIIII) if _IIIIllIIII==0x0 then _llIIlIIlll.Text="\083\097\102\101\032\077\111\100\101\058\032\079\070\070" else _llIIlIIlll.Text="\083\097\102\101\032\077\111\100\101\058\032"..Value.."\037" end
 _lIIIlIIlll.Size=UDim2.new(_IIIIllIIII/0x64,0x0,0x1,0x0) end
 local function _IIIIlIIllI(_IIIIllIIII) _IIIIllIIII=math.clamp(math.floor(tonumber(_IIIIllIIII) or 0x15E),0xA,0x15E) _llIIlllIII=_IIIIllIIII _IIIllllIIl.Text=tostring(_IIIIllIIII) _lllllIllll.Text="\084\119\101\101\110\032\083\112\101\101\100\058\032"..Value.."\047\115" _lIIIlllllI.Size=UDim2.new((_IIIIllIIII-0xA)/0x154,0x0,0x1,0x0) end
 _llllIIllll.FocusLost:Connect( function () local _IIIIllIIII=tonumber(_llllIIllll.Text) if _IIIIllIIII then _IIIIllIlll=math.clamp(math.floor(_IIIIllIIII),0x1,0x64) end
 _llllIIllll.Text=tostring(_IIIIllIlll) end
 ) _IlIIIlIIII.FocusLost:Connect( function () _lIllIIIllI(_IlIIIlIIII.Text) end
 ) _IIIllllIIl.FocusLost:Connect( function () _IIIIlIIllI(_IIIllllIIl.Text) end
 ) _lIlIlllllI.InputBegan:Connect( function (Input) if Input.UserInputType==Enum.UserInputType.MouseButton1 or Input.UserInputType==Enum.UserInputType.Touch then _lllllIllll=true local _IlllIIIlIl=Input.Position.X local _IlIlIIlllI=_lIlIlllllI.AbsolutePosition.X local _IIllllIlll=_lIlIlllllI.AbsoluteSize.X _lIllIIIllI(math.floor(math.clamp((_IlllIIIlIl-_IlIlIIlllI)/_IIllllIlll,0x0,0x1)*0x64+0.5)) end
 end
 ) _IIllIIIlII.InputBegan:Connect( function (Input) if Input.UserInputType==Enum.UserInputType.MouseButton1 or Input.UserInputType==Enum.UserInputType.Touch then _llIlllIIII=true local _IlllIIIlIl=Input.Position.X local _IlIlIIlllI=_IIllIIIlII.AbsolutePosition.X local _IIllllIlll=_IIllIIIlII.AbsoluteSize.X local _IlIlIIIIII=math.clamp((_IlllIIIlIl-_IlIlIIlllI)/_IIllllIlll,0x0,0x1) _IIIIlIIllI(math.floor(0xA+_IlIlIIIIII*0x154+0.5)) end
 end
 ) _IIlIlIIlll.InputChanged:Connect( function (Input) if _lllllIllll and (Input.UserInputType==Enum.UserInputType.MouseMovement or Input.UserInputType==Enum.UserInputType.Touch) then local _IlllIIIlIl=Input.Position.X local _IlIlIIlllI=_lIlIlllllI.AbsolutePosition.X local _IIllllIlll=_lIlIlllllI.AbsoluteSize.X _lIllIIIllI(math.floor(math.clamp((_IlllIIIlIl-_IlIlIIlllI)/_IIllllIlll,0x0,0x1)*0x64+0.5)) end
 if _llIlllIIII and (Input.UserInputType==Enum.UserInputType.MouseMovement or Input.UserInputType==Enum.UserInputType.Touch) then local _IlllIIIlIl=Input.Position.X local _IlIlIIlllI=_IIllIIIlII.AbsolutePosition.X local _IIllllIlll=_IIllIIIlII.AbsoluteSize.X local _IlIlIIIIII=math.clamp((_IlllIIIlIl-_IlIlIIlllI)/_IIllllIlll,0x0,0x1) _IIIIlIIllI(math.floor(0xA+_IlIlIIIIII*0x154+0.5)) end
 end
 ) _IIlIlIIlll.InputEnded:Connect( function (Input) if Input.UserInputType==Enum.UserInputType.MouseButton1 or Input.UserInputType==Enum.UserInputType.Touch then _lllllIllll=false _llIlllIIII=false end
 end
 ) local function _IlIlIlIIII() local _IIIIllIIII=_lIIIIllIll.Character local _IlIIIlIlll=_IIIIllIIII and _IIIIllIIII:FindFirstChild("\072\117\109\097\110\111\105\100\082\111\111\116\080\097\114\116") if not _IlIIIlIlll then return nil end
 local _IIIllllIII=nil local _lIIIIIIllI=math.huge for _,Player in ipairs(Players:GetPlayers()) do if Player~=_lIIIIllIll and Player.Character then local _lIlllllIII=Player.Character:FindFirstChild("\072\117\109\097\110\111\105\100\082\111\111\116\080\097\114\116") local _lIlIllIllI=Player.Character:FindFirstChildOfClass("\072\117\109\097\110\111\105\100") if _lIlllllIII and _lIlIllIllI and _lIlIllIllI.Health>0x0 then local _llIIIlIlII=(_IlIIIlIlll.Position-_lIlllllIII.Position).Magnitude if _llIIIlIlII<_lIIIIIIllI then _lIIIIIIllI=_llIIIlIlII _IIIllllIII=Player end
 end
 end
 end
 return _IIIllllIII end
 local function _lIllIlIlII(_IlIIlIlIII) if not _IlIIlIlIII or _IlIIlIlIII<=0x0 then return false end
 return (0x1/_IlIIlIlIII)<0x3 end
 local function _IIlllIlIIl(_IlIIIlIlll) _IIlIlIIlIl=true local _lIIIIIlIII=_IlIIIlIlll.Position.Y+0x3E8 while _IlllllIllI and _IlIIIlIlll.Parent do local _IllIlllIIl=_IlIIIlIlll.Position local _llIIIlIlII=math.abs(_lIIIIIlIII-_IllIlllIIl.Y) if _llIIIlIlII<=0x1 then _IlIIIlIlll.CFrame=CFrame.new(_IllIlllIIl.X,_lIIIIIlIII,_IllIlllIIl.Z) break end
 local _IlIIlIlIII=RunService.Heartbeat:Wait() if _lIllIlIlII(_IlIIlIlIII) then continue end
 local _IlIlIIIIII=math.clamp((_llIIlllIII*_IlIIlIlIII)/_llIIIlIlII,0x0,0x1) local _lIIIlIllII=_IllIlllIIl.Y+(_lIIIIIlIII-_IllIlllIIl.Y)*_IlIlIIIIII _IlIIIlIlll.CFrame=CFrame.new(_IllIlllIIl.X,_lIIIlIllII,_IllIlllIIl.Z) end
 while _IlllllIllI and _IlIIIlIlll.Parent and _IIlIlIIlIl do RunService.Heartbeat:Wait() local _lIlIIIlIII=_IlIIIlIlll.Position _IlIIIlIlll.CFrame=CFrame.new(_lIlIIIlIII.X,_lIIIIIlIII,_lIlIIIlIII.Z) end
 _IIlIlIIlIl=false end
 local function _IllIIllllI() if _IlllllIllI or _IlIIIIIlll<=0x0 then return end
 local _IIIIllIIII=_lIIIIllIll.Character local _IlIIIlIlll=_IIIIllIIII and _IIIIllIIII:FindFirstChild("\072\117\109\097\110\111\105\100\082\111\111\116\080\097\114\116") local _IIIllIlIIl=_IIIIllIIII and _IIIIllIIII:FindFirstChildOfClass("\072\117\109\097\110\111\105\100") if not _IlIIIlIlll or not _IIIllIlIIl or _IIIllIlIIl.MaxHealth<=0x0 then return end
 local _IIIIIIlIlI=(_IIIllIlIIl.Health/_IIIllIlIIl.MaxHealth)*0x64 if _IIIIIIlIlI<=_IlIIIIIlll then _IlllllIllI=true task.spawn( function () _IIlllIlIIl(_IlIIIlIlll) _IlllllIllI=false _IIlIlIIlIl=false end
 ) end
 end
 local function _llIIlIlIII() if _IlllllIllI then return end
 local _IIlIllIlIl=_IlIlIlIIII() if not _IIlIllIlIl then return end
 _IlllllIllI=true _llIIIIllll(_IIIllIlIIl,true) task.spawn( function () while _IlllllIllI do local _IIIIllIIII=_lIIIIllIll.Character local _IlIIIlIlll=_IIIIllIIII and _IIIIllIIII:FindFirstChild("\072\117\109\097\110\111\105\100\082\111\111\116\080\097\114\116") local _IIIllIlIIl=_IIIIllIIII and _IIIIllIIII:FindFirstChildOfClass("\072\117\109\097\110\111\105\100") local _llIllIlIlI=_IIlIllIlIl.Character local _IlIIllllIl=_llIllIlIlI and _llIllIlIlI:FindFirstChild("\072\117\109\097\110\111\105\100\082\111\111\116\080\097\114\116") local _IIlIlIIllI=_llIllIlIlI and _llIllIlIlI:FindFirstChildOfClass("\072\117\109\097\110\111\105\100") if not _IlIIIlIlll or not _IIIllIlIIl or not _IlIIllllIl or not _IIlIlIIllI or _IIlIlIIllI.Health<=0x0 then break end
 if _IlIIIIIlll>0x0 and _IIIllIlIIl.MaxHealth>0x0 then local _IIIIIIlIlI=(_IIIllIlIIl.Health/_IIIllIlIIl.MaxHealth)*0x64 if _IIIIIIlIlI<=_IlIIIIIlll then _IIlllIlIIl(_IlIIIlIlll) break end
 end
 local _IlIlIIlIII=_IlIIllllIl.Position-Vector3.new(0x0,0x5,0x0) local _IllIlllIIl=_IlIIIlIlll.Position local _llIIIlIlII=(_IlIlIIlIII-_IllIlllIIl).Magnitude if _llIIIlIlII<=0x1 then break end
 local _lIIlIlllIl=_llIIIlIlII<=0x64 and 0x5DC or _llIIlllIII local _IlIIlIlIII=RunService.Heartbeat:Wait() if _lIllIlIlII(_IlIIlIlIII) then continue end
 local _IlIlIIIIII=math.clamp((_lIIlIlllIl*_IlIIlIlIII)/_llIIIlIlII,0x0,0x1) local _llIIlIIlII=_IllIlllIIl:Lerp(_IlIlIIlIII,_IlIlIIIIII) _IlIIIlIlll.CFrame=CFrame.new(_llIIlIIlII) end
 _IlllllIllI=false _IIlIlIIlIl=false _llIIIIllll(_IIIllIlIIl,false) end
 ) end
 _IlllllIlII.MouseButton1Click:Connect( function () _IlIIlIlIll= not _IlIIlIlIll _llIIIIllll(_IlllllIlII,_IlIIlIlIll) if not _IlIIlIlIll then for _lIlllllIII in pairs(_IlllllIIIl) do if _lIlllllIII and _lIlllllIII.Parent and Players:GetPlayerFromCharacter(_lIlllllIII.Parent) then _lIllIllIII(_lIlllllIII) end
 end
 end
 end
 ) _IIIIIIlIII.MouseButton1Click:Connect( function () _IIlllIlIll= not _IIlllIlIll _llIIIIllll(_IIIIIIlIII,_IIlllIlIll) if not _IIlllIlIll then for _lIlllllIII in pairs(_IlllllIIIl) do if _lIlllllIII and _lIlllllIII.Parent and not Players:GetPlayerFromCharacter(_lIlllllIII.Parent) then _lIllIllIII(_lIlllllIII) end
 end
 end
 end
 ) _llIlIIIIII.MouseButton1Click:Connect( function () _IllIIlIIll= not _IllIIlIIll _llIIIIllll(_llIlIIIIII,_IllIIlIIll) if _IllIIlIIll then _llIllIlIlI() else _lIIIllllII() end
 end
 ) _IIIllIlIIl.MouseButton1Click:Connect( function () if _IlllllIllI then _IlllllIllI=false _IIlIlIIlIl=false _llIIIIllll(_IIIllIlIIl,false) else _llIIlIlIII() end
 end
 ) _IllIlIIlII.MouseButton1Click:Connect( function () _IIllIlIIII= not _IIllIlIIII _llIIIIllll(_IllIlIIlII,_IIllIlIIII) if _IIllIlIIII and not _IlIllIIIII then _IlIllIIIII=true task.spawn( function () while _IIllIlIIII and _IIIllllIll.Parent do pcall( function () settings().Rendering.QualityLevel=Enum.QualityLevel.Level01 end
 ) task.wait(0x1) end
 _IlIllIIIII=false end
 ) end
 end
 ) local function _IllllIlIlI() if _IlIIlIlIll then _lIlIlllllI() end
 if _IIlllIlIll then _IIIIIlllII() end
 if _IllIIlIIll then _llIllIlIlI() end
 end
 Players.PlayerAdded:Connect( function (Player) Player.CharacterAdded:Connect( function () task.wait(0.5) if _IllIIlIIll then _IIIIlIllll(Player) end
 if _IlIIlIlIll and Player.Character then _lIIIIIllll(Player.Character,_llIllllIlI(Player)) end
 end
 ) end
 ) Players.PlayerRemoving:Connect( function (Player) _IIIIllllIl(_IllIlIlIIl[Player]) _IllIlIlIIl[Player]=nil end
 ) task.spawn( function () while _IIIllllIll.Parent do _IllllIlIlI() task.wait(0.5) end
 end
 ) task.spawn( function () while _IIIllllIll.Parent do _IIIlIlIIlI() task.wait(0.1) end
 end
 ) task.spawn( function () while _IIIllllIll.Parent do _IllIIllllI() task.wait(0.1) end
 end
 ) local function _IIIlIIIIll(Input) if Input.UserInputType~=Enum.UserInputType.MouseButton1 and Input.UserInputType~=Enum.UserInputType.Touch then return end
 _llIlllIIII=true _IIllIlIIIl=Input.Position _lIlIIllIlI=_IIIlllIlIl.Position end
 _IIIIlIIIlI.InputBegan:Connect(_IIIlIIIIll) _IIlIlIIlll.InputChanged:Connect( function (Input) if _llIlllIIII and (Input.UserInputType==Enum.UserInputType.MouseMovement or Input.UserInputType==Enum.UserInputType.Touch) then local _IlIIlIlIII=Input.Position-_IIllIlIIIl _IIIlllIlIl.Position=UDim2.new( _lIlIIllIlI.X.Scale, _lIlIIllIlI.X.Offset+_IlIIlIlIII.X, _lIlIIllIlI.Y.Scale, _lIlIIllIlI.Y.Offset+_IlIIlIlIII.Y ) end
 end
 ) _IIlIlIIlll.InputEnded:Connect( function (Input) if Input.UserInputType==Enum.UserInputType.MouseButton1 or Input.UserInputType==Enum.UserInputType.Touch then _llIlllIIII=false end
 end
 ) _lIIlIllIII.MouseButton1Click:Connect( function () _llIIIIIlll= not _llIIIIIlll if _llIIIIIlll then _IllIIlIIlI.Visible=false _IIIlllIlIl.Size=UDim2.new(0x0,0xDC,0x0,0x23) _lIIlIllIII.Text="\9650" else _IllIIlIIlI.Visible=true _IIIlllIlIl.Size=UDim2.new(0x0,0xDC,0x0,0xF0) _lIIlIllIII.Text="\9660" end
 end
 ) _IlllIIlIIl.MouseButton1Click:Connect( function () _IlllllIllI=false _IIlIlIIlIl=false _lllllIllll=false _llIlllIIII=false _llIlllIIII=false _IlIlIIIIlI() _lIIIllllII() _IIIllllIll:Destroy() end
 ) _lIllIIIllI(0x1E) _IIIIlIIllI(0x15E) end
 )(...)
