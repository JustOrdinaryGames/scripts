local killScript = false

coroutine.wrap(function()
    while wait() do
		if not game.Players.LocalPlayer.Character or not game.Players.LocalPlayer.Character:FindFirstChild("Dummy") then
			killScript = true
			if script:FindFirstChild("ArtificialHB") then
				script:FindFirstChild("ArtificialHB"):Destroy()
			end
            print("Stopped Script")
			break
		end
	end
end)()

local script = game:GetObjects("rbxassetid://7772120123")[1]

--// SHORTCUTS \\--
local RNG = (function()
    local RNG = Random.new();
    return function(min,max,int)
        return int and RNG:NextInteger(min,max) or RNG:NextNumber(min,max)
    end;
end)();
local S = setmetatable({},{__index = function(s,i) return game:service(i) end})
local CF = {
	N=CFrame.new;
	A=CFrame.Angles;
	fEA=CFrame.fromEulerAnglesXYZ;
}
local C3 = {
	N=Color3.new;
	RGB=Color3.fromRGB;
	HSV=function(...)local data={...}if(typeof(data)=='Color3')then return Color3.toHSV(...)else return Color3.fromHSV(...)end;end;
}
local V3 = {
	N=Vector3.new;
	FNI=Vector3.FromNormalId;
	A=Vector3.FromAxis;
}
local M = {
	C=math.cos;
	R=math.rad;
	S=math.sin;
	T=math.tan;
	AT=math.atan;
	AT2=math.atan2;
	AS=math.asin;
	AC=math.acos;
	A=math.abs;
	F=math.floor;
	CE=math.ceil;
	P=math.pi;
	RNG=RNG;
	H=math.huge;
	RRNG=function(...) return math.rad(RNG(...)) end
}
local R3 = Region3.new
local De = S.Debris
local WS = workspace
local Lght = S.Lighting
local RepS = S.ReplicatedStorage
local IN = Instance.new
local Plrs = S.Players

--// INITIALIZATION \\--
local Plr = Plrs.LocalPlayer
local Char = miztgetcharacter()
local Hum = Char:FindFirstChildOfClass'Humanoid'
assert(Hum and Hum.RigType==Enum.HumanoidRigType.R6,"You need to have a valid Humanoid instance! (Exising and R6)")
local Head = Char.Head
local RArm = Char["Right Arm"]
local LArm = Char["Left Arm"]
local RLeg = Char["Right Leg"]
local LLeg = Char["Left Leg"]	
local Torso= Char.Torso
local Root = Char.HumanoidRootPart
local NeutralAnims = true
local Attack = false
local legAnims = true
local Mouse = Plr:GetMouse()
local EffectFolder=Instance.new("Folder")
EffectFolder.Name='Effects'
EffectFolder.Parent=Char
local Pickaxes = script:WaitForChild'Pickaxes'
Pickaxes.Parent=nil
local snowC4s = {}

local Movement = 40
local Sine = 0;
local Change = 1;
local wsVal = 6


--// INSTANCE CREATORS \\--
local baseSound = IN("Sound")
function Sound(parent,id,pitch,volume,looped,effect,autoPlay)
	local Sound = baseSound:Clone()
	Sound.SoundId = "rbxassetid://".. tostring(id or 0)
	Sound.Pitch = pitch or 1
	Sound.Volume = volume or 1
	Sound.Looped = looped or false
	if(autoPlay)then
		coroutine.wrap(function()
			repeat wait() until Sound.IsLoaded
			Sound.Playing = autoPlay or false
		end)()
	end
	if(not looped and effect)then
		Sound.Stopped:connect(function()
			Sound.Volume = 0
			Sound:destroy()
		end)
	elseif(effect)then
		warn("Sound can't be looped and a sound effect!")
	end
	Sound.Parent =parent or workspace
	return Sound
end
function Part(parent,color,material,size,cframe,anchored,cancollide)
	local part = IN("Part")
	part[typeof(color) == 'BrickColor' and 'BrickColor' or 'Color'] = color or C3.N(0,0,0)
	part.Material = material or Enum.Material.SmoothPlastic
	part.TopSurface,part.BottomSurface=10,10
	part.Size = size or V3.N(1,1,1)
	part.CFrame = cframe or CF.N(0,0,0)
	part.CanCollide = cancollide or false
	part.Anchored = anchored or false
	part.Parent = parent
	return part
end

function Weld(part0,part1,c0,c1)
	local weld = IN("Weld")
	weld.Part0 = part0
	weld.Part1 = part1
	weld.C0 = c0 or CF.N()
	weld.C1 = c1 or CF.N()
	weld.Parent = part0
	return weld
end

function Mesh(parent,meshtype,meshid,textid,scale,offset)
	local part = IN("SpecialMesh")
	part.MeshId = meshid or ""
	part.TextureId = textid or ""
	part.Scale = scale or V3.N(1,1,1)
	part.Offset = offset or V3.N(0,0,0)
	part.MeshType = meshtype or Enum.MeshType.Sphere
	part.Parent = parent
	return part
end

function SoundPart(id,pitch,volume,looped,effect,autoPlay,cf,par)
	local soundPart = Part(par or EffectFolder,C3.N(1,1,1),Enum.Material.SmoothPlastic,V3.N(.05,.05,.05),cf,true,false)
	soundPart.Transparency=1
	local Sound = IN("Sound")
	Sound.SoundId = "rbxassetid://".. tostring(id or 0)
	Sound.Pitch = pitch or 1
	Sound.Volume = volume or 1
	Sound.Looped = looped or false
	if(autoPlay)then
		coroutine.wrap(function()
			repeat wait() until Sound.IsLoaded
			Sound.Playing = autoPlay or false
		end)()
	end
	if(not looped and effect)then
		Sound.Stopped:connect(function()
			Sound.Volume = 0
			soundPart:destroy()
		end)
		Sound.Ended:connect(function()
			Sound.Volume = 0
			soundPart:destroy()
		end)
		S.Debris:AddItem(soundPart,(Sound.TimeLength>0 and Sound.TimeLength+3 or 30))
	elseif(effect)then
		warn("Sound can't be looped and a sound effect!")
	end
	Sound.Parent = soundPart
	return Sound
end

function Joint(name,part0,part1,c0,c1,type)
	local joint = IN(type or "Motor6D")
	joint.Part0 = part0
	joint.Part1 = part1
	joint.C0 = c0 or CF.N()
	joint.C1 = c1 or CF.N()
	joint.Parent=part0
	joint.Name=name or part0.." to "..part1.." "..joint.ClassName
	return joint
end

function Animate(joint,c0,timer,style,dir)
	local info = TweenInfo.new(timer or 1,style or Enum.EasingStyle.Linear,dir or Enum.EasingDirection.Out,0,false,0)
	local tween = S.TweenService:Create(joint,info,{C0=c0})
	tween:Play();
	return tween;
end

function NewInstance(instance,parent,properties)if(properties.Parent)then properties.Parent=parent end;local new = IN(instance)if(properties)then for prop,val in next, properties do pcall(function() new[prop]=val end)end;end;new.Parent=parent;return new;end

function GetAdjacentParts(part)
	local function createLargerHitbox(part)
		local n = 0.2
		local clone = part:Clone()
		
		clone.Transparency = .8
		clone.BrickColor = BrickColor.Red()
		clone.Size = clone.Size + Vector3.new(n, n, n)
		clone.Name = "hitbox"
		clone.CFrame = part.CFrame
		clone.Anchored=true
		clone.CanCollide=true
		
		if (clone:IsA("WedgePart")) then
			clone.Size = clone.Size + Vector3.new(0, n, n)
			clone.CFrame = part.CFrame * CFrame.new(0, n / 2, -n /2)
		end
		
		if (clone:IsA("CornerWedgePart")) then
			clone.Size = clone.Size + Vector3.new(n, n, n)
			clone.CFrame = part.CFrame * CFrame.new(-n / 2, n / 2, n / 2)
		end
		clone.Parent = part
		
		return clone
	end
	
	local hitbox = createLargerHitbox(part)
	local touchingParts = hitbox:getTouchingParts()
	hitbox:Destroy()
	
	return (function()
		local adjacent={}
		for _,v in next, touchingParts do if(v~=part)then table.insert(adjacent,v)end;end
		return adjacent;
	end)()
end
--// CUSTOMIZABLE VARIABLES \\--

local DamageColor = BrickColor.new'Really red';
local IDTable = {239549571,197890111,624694140,3219503353,3154135282,3020745718,1608310113,1846557334,749899851,1197560109,249425793,664608757,1131322323,743953262,490036657,1297446180}
local IdList = 1
local MusicData = {Parent=Torso,ID=IDTable[1];Pitch=1;Volume=2;}
local God = false
local WalkSpeed = 36

local Music = Sound(MusicData.Parent,MusicData.ID,MusicData.Pitch,MusicData.Volume,true,false,true)
Music.Name = 'Music'


--// JOINTS \\--

local RJ = Joint("RootJoint",Root,Torso,CF.N(),CF.N())
local NK = Joint("Neck",Torso,Head,CF.N(0,1.5,0),CF.N())
local LS = Joint("Left Shoulder",Torso,LArm,CF.N(-1.5,.5,0),CF.N(0,.5,0))
local RS = Joint("Right Shoulder",Torso,RArm,CF.N(1.5,.5,0),CF.N(0,.5,0))
local LH = Joint("Left Hip",Torso,LLeg,CF.N(-.5,-1,0),CF.N(0,1,0))
local RH = Joint("Right Hip",Torso,RLeg,CF.N(.5,-1,0),CF.N(0,1,0))

local PK1 = Joint("RPick",RArm,Pickaxes.WeldA,CF.N(),CF.N())
local PK2 = Joint("LPick",LArm,Pickaxes.WeldB,CF.N(),CF.N())

local LSC0 = LS.C0
local RSC0 = RS.C0
local NKC0 = NK.C0
local LHC0 = LH.C0
local RHC0 = RH.C0
local RJC0 = RJ.C0

--// Artificial HB \\--

local ArtificialHB = IN("BindableEvent", script)
ArtificialHB.Name = "Heartbeat"

script:WaitForChild("Heartbeat")

local tf = 0
local allowframeloss = false
local tossremainder = false
local lastframe = tick()
local frame = 1/60
ArtificialHB:Fire()

game:GetService("RunService").Heartbeat:connect(function(s, p)
    if killScript then return end
	tf = tf + s
	if tf >= frame then
		if allowframeloss then
			ArtificialHB:Fire()
			lastframe = tick()
		else
			for i = 1, math.floor(tf / frame) do
				ArtificialHB:Fire()
			end
			lastframe = tick()
		end
		if tossremainder then
			tf = 0
		else
			tf = tf - frame * math.floor(tf / frame)
		end
	end
end)

function swait(num)
	if num == 0 or num == nil then
		ArtificialHB.Event:wait()
	else
		for i = 0, num do
			ArtificialHB.Event:wait()
		end
	end
end

--// STOP ANIMATIONS \\--
for _,v in next, Hum:GetPlayingAnimationTracks() do
	v:Stop();
end

pcall(game.Destroy,Char:FindFirstChild'Animate')
pcall(game.Destroy,Hum:FindFirstChild'Animator')

--// EFFECT FUNCTIONS \\--
--
-- Adapted from
-- Tweener's easing functions (Penner's Easing Equations)
-- and http://code.google.com/p/tweener/ (jstweener javascript version)
--

--[[
Disclaimer for Robert Penner's Easing Equations license:

TERMS OF USE - EASING EQUATIONS

Open source under the BSD License.

Copyright © 2001 Robert Penner
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
    * Neither the name of the author nor the names of contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
]]

-- For all easing functions:
-- t = elapsed time
-- b = begin
-- c = change == ending - beginning
-- d = duration (total time)

local pow = math.pow
local sin = math.sin
local cos = math.cos
local pi = math.pi
local sqrt = math.sqrt
local abs = math.abs
local asin  = math.asin

local function linear(t, b, c, d)
	return c * t / d + b
end

local function inQuad(t, b, c, d)
	t = t / d
	return c * pow(t, 2) + b
end

local function outQuad(t, b, c, d)
	t = t / d
	return -c * t * (t - 2) + b
end

local function inOutQuad(t, b, c, d)
	t = t / d * 2
	if t < 1 then
		return c / 2 * pow(t, 2) + b
	else
		return -c / 2 * ((t - 1) * (t - 3) - 1) + b
	end
end

local function outInQuad(t, b, c, d)
	if t < d / 2 then
		return outQuad (t * 2, b, c / 2, d)
	else
		return inQuad((t * 2) - d, b + c / 2, c / 2, d)
	end
end

local function inCubic (t, b, c, d)
	t = t / d
	return c * pow(t, 3) + b
end

local function outCubic(t, b, c, d)
	t = t / d - 1
	return c * (pow(t, 3) + 1) + b
end

local function inOutCubic(t, b, c, d)
	t = t / d * 2
	if t < 1 then
		return c / 2 * t * t * t + b
	else
		t = t - 2
		return c / 2 * (t * t * t + 2) + b
	end
end

local function outInCubic(t, b, c, d)
	if t < d / 2 then
		return outCubic(t * 2, b, c / 2, d)
	else
		return inCubic((t * 2) - d, b + c / 2, c / 2, d)
	end
end

local function inQuart(t, b, c, d)
	t = t / d
	return c * pow(t, 4) + b
end

local function outQuart(t, b, c, d)
	t = t / d - 1
	return -c * (pow(t, 4) - 1) + b
end

local function inOutQuart(t, b, c, d)
	t = t / d * 2
	if t < 1 then
		return c / 2 * pow(t, 4) + b
	else
		t = t - 2
		return -c / 2 * (pow(t, 4) - 2) + b
	end
end

local function outInQuart(t, b, c, d)
	if t < d / 2 then
		return outQuart(t * 2, b, c / 2, d)
	else
		return inQuart((t * 2) - d, b + c / 2, c / 2, d)
	end
end

local function inQuint(t, b, c, d)
	t = t / d
	return c * pow(t, 5) + b
end

local function outQuint(t, b, c, d)
	t = t / d - 1
	return c * (pow(t, 5) + 1) + b
end

local function inOutQuint(t, b, c, d)
	t = t / d * 2
	if t < 1 then
		return c / 2 * pow(t, 5) + b
	else
		t = t - 2
		return c / 2 * (pow(t, 5) + 2) + b
	end
end

local function outInQuint(t, b, c, d)
	if t < d / 2 then
		return outQuint(t * 2, b, c / 2, d)
	else
		return inQuint((t * 2) - d, b + c / 2, c / 2, d)
	end
end

local function inSine(t, b, c, d)
	return -c * cos(t / d * (pi / 2)) + c + b
end

local function outSine(t, b, c, d)
	return c * sin(t / d * (pi / 2)) + b
end

local function inOutSine(t, b, c, d)
	return -c / 2 * (cos(pi * t / d) - 1) + b
end

local function outInSine(t, b, c, d)
	if t < d / 2 then
		return outSine(t * 2, b, c / 2, d)
	else
		return inSine((t * 2) -d, b + c / 2, c / 2, d)
	end
end

local function inExpo(t, b, c, d)
	if t == 0 then
		return b
	else
		return c * pow(2, 10 * (t / d - 1)) + b - c * 0.001
	end
end

local function outExpo(t, b, c, d)
	if t == d then
		return b + c
	else
		return c * 1.001 * (-pow(2, -10 * t / d) + 1) + b
	end
end

local function inOutExpo(t, b, c, d)
	if t == 0 then return b end
	if t == d then return b + c end
	t = t / d * 2
	if t < 1 then
		return c / 2 * pow(2, 10 * (t - 1)) + b - c * 0.0005
	else
		t = t - 1
		return c / 2 * 1.0005 * (-pow(2, -10 * t) + 2) + b
	end
end

local function outInExpo(t, b, c, d)
	if t < d / 2 then
		return outExpo(t * 2, b, c / 2, d)
	else
		return inExpo((t * 2) - d, b + c / 2, c / 2, d)
	end
end

local function inCirc(t, b, c, d)
	t = t / d
	return(-c * (sqrt(1 - pow(t, 2)) - 1) + b)
end

local function outCirc(t, b, c, d)
	t = t / d - 1
	return(c * sqrt(1 - pow(t, 2)) + b)
end

local function inOutCirc(t, b, c, d)
	t = t / d * 2
	if t < 1 then
		return -c / 2 * (sqrt(1 - t * t) - 1) + b
	else
		t = t - 2
		return c / 2 * (sqrt(1 - t * t) + 1) + b
	end
end

local function outInCirc(t, b, c, d)
	if t < d / 2 then
		return outCirc(t * 2, b, c / 2, d)
	else
		return inCirc((t * 2) - d, b + c / 2, c / 2, d)
	end
end

local function inElastic(t, b, c, d, a, p)
	if t == 0 then return b end

	t = t / d

	if t == 1  then return b + c end

	if not p then p = d * 0.3 end

	local s

	if not a or a < abs(c) then
		a = c
		s = p / 4
	else
		s = p / (2 * pi) * asin(c/a)
	end

	t = t - 1

	return -(a * pow(2, 10 * t) * sin((t * d - s) * (2 * pi) / p)) + b
end

-- a: amplitud
-- p: period
local function outElastic(t, b, c, d, a, p)
	if t == 0 then return b end

	t = t / d

	if t == 1 then return b + c end

	if not p then p = d * 0.3 end

	local s

	if not a or a < abs(c) then
		a = c
		s = p / 4
	else
		s = p / (2 * pi) * asin(c/a)
	end

	return a * pow(2, -10 * t) * sin((t * d - s) * (2 * pi) / p) + c + b
end

-- p = period
-- a = amplitud
local function inOutElastic(t, b, c, d, a, p)
	if t == 0 then return b end

	t = t / d * 2

	if t == 2 then return b + c end

	if not p then p = d * (0.3 * 1.5) end
	if not a then a = 0 end

	local s

	if not a or a < abs(c) then
		a = c
		s = p / 4
	else
		s = p / (2 * pi) * asin(c / a)
	end

	if t < 1 then
		t = t - 1
		return -0.5 * (a * pow(2, 10 * t) * sin((t * d - s) * (2 * pi) / p)) + b
	else
		t = t - 1
		return a * pow(2, -10 * t) * sin((t * d - s) * (2 * pi) / p ) * 0.5 + c + b
	end
end

-- a: amplitud
-- p: period
local function outInElastic(t, b, c, d, a, p)
	if t < d / 2 then
		return outElastic(t * 2, b, c / 2, d, a, p)
	else
		return inElastic((t * 2) - d, b + c / 2, c / 2, d, a, p)
	end
end

local function inBack(t, b, c, d, s)
	if not s then s = 1.70158 end
	t = t / d
	return c * t * t * ((s + 1) * t - s) + b
end

local function outBack(t, b, c, d, s)
	if not s then s = 1.70158 end
	t = t / d - 1
	return c * (t * t * ((s + 1) * t + s) + 1) + b
end

local function inOutBack(t, b, c, d, s)
	if not s then s = 1.70158 end
	s = s * 1.525
	t = t / d * 2
	if t < 1 then
		return c / 2 * (t * t * ((s + 1) * t - s)) + b
	else
		t = t - 2
		return c / 2 * (t * t * ((s + 1) * t + s) + 2) + b
	end
end

local function outInBack(t, b, c, d, s)
	if t < d / 2 then
		return outBack(t * 2, b, c / 2, d, s)
	else
		return inBack((t * 2) - d, b + c / 2, c / 2, d, s)
	end
end

local function outBounce(t, b, c, d)
	t = t / d
	if t < 1 / 2.75 then
		return c * (7.5625 * t * t) + b
	elseif t < 2 / 2.75 then
		t = t - (1.5 / 2.75)
		return c * (7.5625 * t * t + 0.75) + b
	elseif t < 2.5 / 2.75 then
		t = t - (2.25 / 2.75)
		return c * (7.5625 * t * t + 0.9375) + b
	else
		t = t - (2.625 / 2.75)
		return c * (7.5625 * t * t + 0.984375) + b
	end
end

local function inBounce(t, b, c, d)
	return c - outBounce(d - t, 0, c, d) + b
end

local function inOutBounce(t, b, c, d)
	if t < d / 2 then
		return inBounce(t * 2, 0, c, d) * 0.5 + b
	else
		return outBounce(t * 2 - d, 0, c, d) * 0.5 + c * .5 + b
	end
end

local function outInBounce(t, b, c, d)
	if t < d / 2 then
		return outBounce(t * 2, b, c / 2, d)
	else
		return inBounce((t * 2) - d, b + c / 2, c / 2, d)
	end
end


local fromaxisangle = function(x, y, z) -- credit to phantom forces devs
	if not y then
		x, y, z = x.x, x.y, x.z
	end
	local m = (x * x + y * y + z * z) ^ 0.5
	if m > 1.0E-5 then
		local si = math.sin(m / 2) / m
		return CFrame.new(0, 0, 0, si * x, si * y, si * z, math.cos(m / 2))
	else
		return CFrame.new()
	end
end

function fakePhysics(elapsed,cframe,velocity,rotation,acceleration)
	local pos = cframe.p
	local matrix = cframe-pos
	return fromaxisangle(elapsed*rotation)*matrix+pos+elapsed*velocity+elapsed*elapsed*acceleration
end

function CastRay(startPos,endPos,range,ignoreList)
	local ray = Ray.new(startPos,(endPos-startPos).unit*range)
	local part,pos,norm = workspace:FindPartOnRayWithIgnoreList(ray,ignoreList or {},false,true)
	return part,pos,norm,(pos and (startPos-pos).magnitude)
end

function GetTorso(char)
	return char:FindFirstChild'Torso' or char:FindFirstChild'UpperTorso' or char:FindFirstChild'LowerTorso' or char:FindFirstChild'HumanoidRootPart'
end

function Projectile(data)
	local Size = data.Size or 1;
	local Origin = data.Origin or CFrame.new();
	local Velocity = data.Velocity or Vector3.new(0,100,0);
	local Gravity = data.Gravity or workspace.Gravity;
	local Color = data.Color or Color3.new(.7,0,0);
	local Lifetime = data.Lifetime or 1;
	local Material = data.Material or Enum.Material.Glass;
	local ignore = data.Ignorelist or {Char};
	local Init = data.Init;
	local Update = data.Update;
	local HitFunc = data.Hit;
	local ShouldCollide = data.BeforeCollision;
	local DeleteOnHit = data.DeleteOnHit==nil and true or not not data.DeleteOnHit
	local ProjectilePart = data.Projectile or nil;
	local Look = data.AimAtPos or false;
	local drop = ProjectilePart or Part(nil,Color,Material,Vector3.new(Size,Size,Size),Origin,true,false)
	local StartTravel = tick()
	local currCF = data.Origin
	if(not ProjectilePart)then
		Mesh(drop,Enum.MeshType.Sphere)
		drop.Parent=EffectFolder
	end
	drop.Material = Material
	drop.Color = Color
	drop.CFrame=Origin
	local object=setmetatable({Part=drop},{
		__newindex=function(s,i,v)
			if(i=='Gravity')then StartTravel = tick() data.Origin = currCF Origin=currCF data.Gravity = v Gravity=v
			elseif(i=='Velocity')then StartTravel = tick() data.Origin = currCF Origin=currCF data.Velocity = v Velocity=v
			elseif(i=='Lifetime')then data.Lifetime = v Lifetime=v 
			elseif(i=='Ignorelist')then data.Ignorelist = v ignore=v
			elseif(i=='DeleteOnHit')then data.DeleteOnHit = v DeleteOnHit=v 
			else
				pcall(function()
					drop[i]=v
				end)
			end
		end;
		__index=data;
	})
	
	
	if(Init)then
		Init(drop)
	end
	local startTick = tick();
	coroutine.wrap(function()
		while true and not killScript do
			local elapsed = tick()-startTick
			local trElapsed = tick()-StartTravel
			if(elapsed>Lifetime)then
				drop:destroy();
				break
			end
			local newCF = fakePhysics(trElapsed,Origin,Velocity,Vector3.new(),Vector3.new(0,-Gravity,0))
			local nextCF = fakePhysics(trElapsed+.05,Origin,Velocity,Vector3.new(),Vector3.new(0,-Gravity,0))
			local dist = (drop.Position-newCF.p).magnitude
			local hit,pos,norm = CastRay(drop.Position,newCF.p,dist,ignore)
			currCF=newCF
			local doCollide = hit and (not ShouldCollide or ShouldCollide(hit))
			if(hit and not doCollide)then table.insert(ignore,hit) print('ignored '..hit.Name) end
			if(Look)then
				drop.CFrame = CFrame.new(newCF.p,nextCF.p)
			else
				drop.CFrame = CFrame.new(newCF.p)
			end
			if(Update)then Update(drop,object,elapsed) end
			if(doCollide)then
				if(DeleteOnHit or not HitFunc)then drop:destroy() end
				if(HitFunc)then if(HitFunc(hit,pos,norm,object,drop))then break end end
			end
			if(not drop.Parent)then
				break
			end
			swait()
		end
	end)()
	return object
end
	
function Chat(txt,timer,clr)
	if(Head:FindFirstChild'Chattie' and Head.Chattie:FindFirstChild'Killchat')then
		Head.Chattie.Killchat.Value=true
	elseif(Head:FindFirstChild'Chattie')then
		Head.Chattie:destroy()
	end
	local nig = V3.N(0,0,0)
	local clr = (typeof(clr)=='BrickColor' and clr.Color or typeof(clr)=='Color3' and clr or C3.N(1,1,1))
	local bg = NewInstance("BillboardGui",Head,{
		Name='Chattie';
		Adornee=Head;
		LightInfluence=0;
		Size=UDim2.new(4,0,2,0);
	})
	local dismiss = NewInstance("BoolValue",bg,{
		Name='Killchat';
	})
	
	local text = NewInstance("TextLabel",bg,{
		BackgroundTransparency=1;
		Size=UDim2.new(1,0,1,0);
		Font=Enum.Font.Fantasy;
		Text=txt;
		TextColor3=clr;
		TextStrokeColor3=C3.N(0,0,0);
		TextScaled=true;
		TextTransparency=0;
		TextStrokeTransparency=.5;
	})
	coroutine.wrap(function()
		for i = 1, 0, -.02 do
			bg.StudsOffsetWorldSpace=nig:lerp(nig+V3.N(0,3,0),outBack(1-i,0,1,1,6))
			if(dismiss.Value)then break end
			swait()
		end
		local start = tick()
		nig=bg.StudsOffsetWorldSpace
		repeat swait() until dismiss.Value or tick()-start>=timer
		bg.Name='DismissingChat'
		for i = 0, 1, .05 do
			bg.StudsOffsetWorldSpace=nig:lerp(nig+V3.N(0,2,0),linear(i,0,1,1))
			text.TextTransparency=i;
			text.TextStrokeTransparency=.5+.2;
			swait()
		end
		bg:destroy()
	end)()
end

function ShowDamage(pos,txt,timer,clr)
	local nig = typeof(pos)=='Vector3' and CF.N(pos) or pos
	local part = Part(EffectFolder,clr,Enum.Material.SmoothPlastic,V3.N(.05,.05,.05),nig,true,false)
	part.Transparency=1
	local bg = NewInstance("BillboardGui",part,{
		Adornee=part;
		LightInfluence=0;
		Size=UDim2.new(2,0,1,0);
	})
	local text = NewInstance("TextLabel",bg,{
		BackgroundTransparency=1;
		Size=UDim2.new(1,0,1,0);
		Font=Enum.Font.Fantasy;
		Text=txt;
		TextColor3=part.Color;
		TextStrokeColor3=C3.N(0,0,0);
		TextScaled=true;
		TextTransparency=1;
		TextStrokeTransparency=1;
	})
	coroutine.wrap(function()
		for i = 1, 0, -.02 do
			part.CFrame=nig:lerp(nig+V3.N(0,3,0),outBack(1-i,0,1,1,6))
			text.TextTransparency=i;
			text.TextTransparency=text.TextTransparency-.02;
			text.TextStrokeTransparency=text.TextStrokeTransparency-.01;
			swait()
		end
		local start = tick()
		repeat swait() until tick()-start>=timer
		local endRot=M.RNG(-25,25)
		for i = 0, 1, .02 do
			part.CFrame=(nig+V3.N(0,3,0)):lerp(nig+V3.N(0,-10,0),inBack(i,0,1,1,6))
			text.TextTransparency=i;
			text.TextTransparency=text.TextTransparency+.02;
			text.TextStrokeTransparency=text.TextStrokeTransparency+.01;
			swait()
		end
		part:destroy()
	end)()
end

function Tween(object,properties,time,style,dir,repeats,reverse,delay)
	local info = TweenInfo.new(time or 1,style or Enum.EasingStyle.Linear,dir or Enum.EasingDirection.Out,repeats or 0,reverse or false,delay or 0)
	local tween = S.TweenService:Create(object,info,properties)
	tween:Play()
	return tween;
end

local function numLerp(Start,Finish,Alpha)
    return Start + (Finish- Start) * Alpha
end
function IsValidEnum(val,enum,def)
	local enum = Enum[tostring(enum)]
	local succ,err=pcall(function() return enum[val.Name] end)
	if(not err)then
		return val
	else
		return def
	end
end

function IsValid(val,type,def)
	if(typeof(type)=='string')then
		return (typeof(val)==type and val or def)
	elseif(typeof(type)=='table')then
		for i,v in next, type do
			if(typeof(val)==v)then
				return val
			end
		end
	end
	return def
end

local FXInformation = {}

function GetKeyframe(sequence,currentTime,lifeTime)
	local scale = currentTime/lifeTime
	for i = 1,#sequence.Keypoints do
		local keyframe = sequence.Keypoints[i]
		local nframe = sequence.Keypoints[i+1]
		if(not nframe or keyframe.Time>=scale and keyframe.Time<nframe.Time)then
			return keyframe
		end
	end
	return sequence.Keypoints[1];
end;

coroutine.wrap(function()
	while true and not killScript do
		swait()
		local queue={}
		for i,dat in next, FXInformation do
			local part,mesh,lifetime,created,csq,ssq,tsq,cfq,rot,ucf,upd = 
																	dat.Part,
																	dat.Mesh,
																	dat.Lifetime,
																	dat.Create,
																	dat.ColorSeq,
																	dat.SizeSeq,
																	dat.TranSeq,
																	dat.CFSeq,
																	dat.Rotation,
																	dat.UpdateCF,
																	dat.OnUpdate;
			local current = tick();
			local elapsed = tick()-created
			local currentcpoint = GetKeyframe(csq,elapsed,lifetime)
			local currentspoint = GetKeyframe(ssq,elapsed,lifetime)
			local currenttpoint = GetKeyframe(tsq,elapsed,lifetime)
			local currentcfpoint = GetKeyframe(cfq,elapsed,lifetime)
			
			local currentcolor = currentcpoint.Value
			local currenttrans = currenttpoint.Value
			local currentsize = currentspoint.Value
			local currentcf = currentcfpoint.Value
			
			if(currentcpoint~=dat.ColorPoint)then
				Tween(part,{Color=currentcolor},(currentcpoint.Time-dat.ColorPoint.Time)*lifetime)
				dat.ColorPoint=currentcpoint
			end
			if(currenttpoint~=dat.TranPoint)then
				Tween(part,{Transparency=currenttrans},(currenttpoint.Time-dat.TranPoint.Time)*lifetime)
				dat.TranPoint=currenttpoint
			end
			if(currentspoint~=dat.SizePoint)then
				if(mesh)then
					Tween(mesh,{Scale=currentsize},(currentspoint.Time-dat.SizePoint.Time)*lifetime)
				else
					Tween(part,{Size=currentsize},(currentspoint.Time-dat.SizePoint.Time)*lifetime)
				end
				
				dat.SizePoint=currentspoint
			end
			local newRot={0,0,0}
			if(rot=='random')then
				dat.CurrRot = CFrame.Angles(math.rad(Random.new():NextInteger(0,360)),math.rad(Random.new():NextInteger(0,360)),math.rad(Random.new():NextInteger(0,360)))
			elseif(typeof(rot)=='table')then
				dat.CurrRot = dat.CurrRot*CFrame.Angles(math.rad(rot[1]),math.rad(rot[2]),math.rad(rot[3]))
			end
			if(ucf and typeof(ucf)=='function')then
				part.CFrame=ucf(dat)
			elseif(#cfq.Keypoints==2)then
				part.CFrame=cfq.Keypoints[1].Value:lerp(cfq.Keypoints[2].Value,elapsed/lifetime)*dat.CurrRot
			else
				if(currentcfpoint~=dat.CFPoint)then
					Tween(part,{CFrame=currentcf},(currentcfpoint.Time-dat.CFPoint.Time)*lifetime)
					dat.CFPoint=currentcfpoint
				end
			end
			if(typeof(upd)=='function')then upd(dat) end
			if(not part or not part.Parent)then
				table.insert(queue,tostring(i))
			end
			if(elapsed>=lifetime)then
				part:destroy()
			end
		end
		for _,v in next, queue do FXInformation[tonumber(v)]=nil; end
	end
end)()

function Slash(data) -- Credit to Kyu for the basic idea behind it
	local Parent = IsValid(data.Parent,'Instance',workspace)
	local Color = IsValid(data.Color,{'Color3','BrickColor'},Color3.new(1,1,1))
	local Width = IsValid(data.Width,'number',2);
	local EndWidth = IsValid(data.EndWidth,'number',0);
	local Length = IsValid(data.Length,'number',1);
	local EndLength = IsValid(data.EndLength,'number',Length*2);
	local Curve = IsValid(data.Curve,"number",2);
	local EndCurve = IsValid(data.EndCurve,"number",Curve*2);
	local SCFrame = IsValid(data.CFrame,'CFrame',CFrame.new(0,10,0))
	local Lifetime = IsValid(data.Lifetime,'number',.25)
	local Offset = IsValid(data.Offset,'CFrame',CFrame.new())
	local Style = IsValidEnum(IsValid(data.EasingStyle,'EnumItem',Enum.EasingStyle.Quad),Enum.EasingStyle,Enum.EasingStyle.Quad)
	local Direction = IsValidEnum(IsValid(data.EasingDirection,'EnumItem',Enum.EasingDirection.Out),Enum.EasingDirection,Enum.EasingDirection.Out)
	local Delay = IsValid(data.Delay,'number',0)
	local BeamProperties = IsValid(data.BeamProps,'table',{})
	local FadeAway = IsValid(data.Fades,'boolean',false)
	local FadeStyle = IsValidEnum(IsValid(data.FadeStyle,'EnumItem',Enum.EasingStyle.Linear),Enum.EasingStyle,Enum.EasingStyle.Linear)
	local FadeDir = IsValidEnum(IsValid(data.FadeDirection,'EnumItem',Enum.EasingDirection.Out),Enum.EasingDirection,Enum.EasingDirection.Out)
	local CSQ;
	local TSQ;
	if(typeof(Color)=='ColorSequence')then
		CSQ = Color
	elseif(typeof(Color)=='Color3')then
		CSQ = ColorSequence.new(Color)
	elseif(typeof(Color)=='BrickColor')then
		CSQ = ColorSequence.new(Color.Color)
	else
		CSQ = ColorSequence.new(Color3.new(1,1,1))
	end
	
	local P = Part(Parent,Color,Enum.Material.SmoothPlastic,Vector3.new(0,0,0),SCFrame,true,false)
	P.Transparency = 1
	local A0 = Instance.new("Attachment")
	local A1 = Instance.new("Attachment")
	A0.Position = Vector3.new(0,0,Length)
	A1.Position = Vector3.new(0,0,-Length)
	A0.Parent=P
	A1.Parent=P
	local Beam = Instance.new("Beam")
	Beam.Attachment0=A0
	Beam.Attachment1=A1
	Beam.FaceCamera=true
	Beam.LightInfluence=BeamProperties.LightInfluence or 0
	Beam.LightEmission=BeamProperties.LightEmission or 1
	for i,v in next, BeamProperties do
		pcall(function() Beam[i]=v end)
	end
	Beam.Color = CSQ
	Beam.CurveSize0 = Curve
	Beam.CurveSize1 = -Curve
	Beam.Width0=Width
	Beam.Width1=Width
	Beam.Parent=P
	local ti = {Lifetime,Style,Direction,0,false,Delay}
	Tween(P,{CFrame = SCFrame*Offset},unpack(ti))
	Tween(Beam,{Width0=EndWidth,Width1=EndWidth,CurveSize0=EndCurve,CurveSize1=-EndCurve},unpack(ti))
	Tween(A0,{Position=Vector3.new(0,0,EndLength)},unpack(ti))
	Tween(A1,{Position=Vector3.new(0,0,-EndLength)},unpack(ti)).Completed:connect(function() if killScript then return end P:destroy() end)
	if(FadeAway)then
		local part = Instance.new("Part")
		part.Transparency = Beam.Transparency.Keypoints[1].Value or 0
		Tween(part,{Transparency=1},Lifetime,FadeStyle,FadeDir,0,false,Delay)
		repeat swait()
			Beam.Transparency=NumberSequence.new(part.Transparency)
		until not P.Parent
	end
end

local EffectInfo={}

coroutine.wrap(function()
	while true and not killScript do
		swait()
		for i,v in next, EffectInfo do
			local start,lifetime,t0,transTween,sizeTween,moveTween,accelTween,color,transparency,size,part,mesh,rotation,acceleration,endpos,cframe,reverse,startacc=unpack(v)
			local elapsed = tick()-start
			local left = elapsed/lifetime
			local dt = tick()-t0
			t0 = tick()
			if(mesh)then
				mesh.Scale = size[1]:lerp(size[2],(sizeTween and sizeTween(elapsed,0,1,lifetime) or left))
			else
				part.Size = size[1]:lerp(size[2],(sizeTween and sizeTween(elapsed,0,1,lifetime) or left))
			end
			part.Transparency = numLerp(transparency[1],transparency[2],(transTween and transTween(elapsed,0,1,lifetime) or left))
			
			local newRot={0,0,0}
			if(rotation=='random')then
				newRot={math.rad(Random.new():NextInteger(0,360)),math.rad(Random.new():NextInteger(0,360)),math.rad(Random.new():NextInteger(0,360))}
			elseif(typeof(rotation)=='table')then
				local x,y,z=math.rad(rotation[1]),math.rad(rotation[2]),math.rad(rotation[3])
				if(rotation[1]==0)then x=0 end
				if(rotation[2]==0)then y=0 end
				if(rotation[3]==0)then z=0 end
				newRot={x,y,z}
			end
			
			local accelMult=(accelTween and 1-accelTween(elapsed,0,1,lifetime) or 1)

			local accel=(acceleration*dt)
			if(endpos)then
				part.CFrame = cframe:lerp(endpos,(moveTween and moveTween(elapsed,0,1,lifetime) or left))
			elseif(accel and (accel.x~=0 or accel.y~=0 or accel.z~=0))then
				part.CFrame = part.CFrame*CFrame.Angles(unpack(newRot))+(accel*accelMult)
			elseif(newRot and (newRot[1]~=0 or newRot[2]~=0 or newRot[3]~=0))then
				part.CFrame = part.CFrame*CFrame.Angles(unpack(newRot))
			end
			if(reverse>0)then
				acceleration=acceleration-Vector3.new(
					0.05*startacc.x/(reverse/1.5),
					0.05*startacc.y/(reverse/1.5),
					0.05*startacc.z/(reverse/1.5)
				)
			end
			if(elapsed>lifetime)then
				part:destroy()
				EffectInfo[i]=nil
			else
				EffectInfo[i]={start,lifetime,t0,transTween,sizeTween,moveTween,accelTween,color,transparency,size,part,mesh,rotation,acceleration,endpos,cframe,reverse,startacc}
			end
		end
	end
end)()
 
--// MISCELLANEOUS FUNCTIONS \\--
function GetTorso(char)
	return char:FindFirstChild'Torso' or char:FindFirstChild'UpperTorso' or char:FindFirstChild'LowerTorso' or char:FindFirstChild'HumanoidRootPart'
end

function CastRay(startPos,endPos,range,ignoreList)
	local ray = Ray.new(startPos,(endPos-startPos).unit*range)
	local part,pos,norm = workspace:FindPartOnRayWithIgnoreList(ray,ignoreList or {Char},false,true)
	return part,pos,norm,(pos and (startPos-pos).magnitude)
end

function getRegion(point,range,ignore)
    return workspace:FindPartsInRegion3WithIgnoreList(R3(point-V3.N(1,1,1)*range/2,point+V3.N(1,1,1)*range/2),ignore,100)
end

--// DAMAGE, AOE, AND ATTACK FUNCTIONS \\--

function DealDamage(data)
	local Who = data.Who;
	local MinDam = data.MinimumDamage or 15;
	local MaxDam = data.MaximumDamage or 30;
	local MaxHP = data.MaxHP or 1e5; 
	local DamageIsPercentage = data.PercentageDamage or true
	
	local DB = data.Debounce or .2;
	
	local CritData = data.Crit or {}
	local CritChance = CritData.Chance or 0;
	local CritMultiplier = CritData.Multiplier or 1;
	
	
	local OnHitFunc = data.OnHit
	
	assert(Who,"Specify someone to damage!")	
	
	local Humanoid = Who:FindFirstChildOfClass'Humanoid'
	local Critical = M.RNG(1,100,true) <= CritChance
	local DoneDamage = M.RNG(MinDam,MaxDam,true) * (Critical and CritMultiplier or 1)
	
	local canHit = true
	if(Humanoid)then
		if(canHit)then
			local HitTorso = GetTorso(Who)
			local player = S.Players:GetPlayerFromCharacter(Who)
			
			if(miztgetcharacter() ~= Who and game.Players.LocalPlayer.Character ~= Who)then
				if(Humanoid.MaxHealth >= MaxHP and Humanoid.Health > 0)then
					Who:BreakJoints();
				else
					local  c = Instance.new("ObjectValue",Hum)
					c.Name = "creator"
					c.Value = Plr
					S.Debris:AddItem(c,0.35)	
					if(Who:FindFirstChild'Head' and Humanoid.Health > 0)then
						ShowDamage((Who.Head.CFrame * CF.N(0, 0, (Who.Head.Size.Z / 2)).p+V3.N(0,1.5,0)+V3.N(M.RNG(-2,2),0,M.RNG(-2,2))), DoneDamage, 1.5, DamageColor)
						Sound(Who.Head,880159023,1,10,false,false,true)
					end
					local DoneDamage = DoneDamage*(DamageIsPercentage and Humanoid.MaxHealth/100 or 1)
					if(OnHitFunc)then
						OnHitFunc(Who,HitTorso)
					end
				end
			end
		end
	end		
end

function AoE(where,range,func,ignoreList)
	local hit = {}
	for _,v in next, getRegion(where,range,ignoreList or {Char}) do
		local hum = (v.Parent and v.Parent:FindFirstChildOfClass'Humanoid')
		if(hum and not hit[v.Parent] or not hum and not hit[v])then
			hit[hum and v.Parent or v] = true
			func((hum and v.Parent or v),hum)
		end
	end
	return hit
end

function AoEDamage(where,range,data)
	AoE(where,range,function(c,h)
		data.Who=c
		DealDamage(data)
	end)
end

--// EVERYTHING ELSE \\--

function Knockback(velocity,decay)
	return function(w,t)
		local BV = IN("BodyVelocity")
		BV.P=20000
		BV.MaxForce=V3.N(M.H,M.H,M.H)
		BV.Velocity=velocity or V3.N(0,25,0)+(Root.CFrame.lookVector*25)
		BV.Parent=t
		S.Debris:AddItem(BV,decay or .5)
	end
end

local ToEndInput = false

function ChangeSong(Num)
IdList = IdList + Num
print(IdList)
if IdList == 0 then
IdList = #IDTable
end
if IdList == #IDTable + 1 then
IdList = 1
end
MusicData.ID = IDTable[IdList]
Music:Play()
end

function S_P_E_E_D_O_P_H_I_L_E()
ToEndInput  = true
local Bruh = Sound(Head,314568939,1,2,false,false,true)
local BruhTheSecond = Sound(Head,2403368354,1,2,true,false,true)
wsVal = 3
Movement = 40
WalkSpeed = 50
Pickaxes.Parent = Char
repeat
swait()
AoE(Torso.Position,5,function(c,h)
	if(h)then
		if(c~=Char)then
			DealDamage{
				Who=c;
				MinimumDamage=h.MaxHealth;
				MaximumDamage=h.MaxHealth;
			}
		end
	end
end)
until ToEndInput == false
wsVal = 6
Movement = 40
WalkSpeed = 36
Pickaxes.Parent = nil
BruhTheSecond:Destroy()
Bruh:Destroy()
end


S.UserInputService.InputBegan:connect(function(io,gpe)
    if killScript then return end
	if(gpe or Attack)then return end
	if(io.UserInputType==Enum.UserInputType.MouseButton1)then	 
	elseif(io.KeyCode==Enum.KeyCode.LeftShift)then
		S_P_E_E_D_O_P_H_I_L_E() 
	elseif(io.KeyCode==Enum.KeyCode.RightBracket)then
		ChangeSong(1)
	elseif(io.KeyCode==Enum.KeyCode.LeftBracket)then
		ChangeSong(-1)
	end
end)

S.UserInputService.InputEnded:connect(function(io,gpe)
    if killScript then return end
	if(gpe or Attack)then return end
	if(io.KeyCode==Enum.KeyCode.LeftShift)then
		ToEndInput = false 
	end
end)



while true and not killScript do
	swait()
	Sine=Sine+Change
	if(not Music or not Music.Parent)then
		local tp = (Music and Music.TimePosition)
		Music = Sound(MusicData.Parent,MusicData.ID,MusicData.Pitch,MusicData.Volume,true,false,true)
		Music.Name = 'Music'
		Music.TimePosition = tp
	end
	Music.SoundId = "rbxassetid://"..MusicData.ID
	Music.Parent = MusicData.Parent
	Music.Pitch = MusicData.Pitch
	Music.Volume = MusicData.Volume
	
	
	local Hit,Pos = CastRay(Root.Position,Root.Position-V3.N(0,1,0),4)
	local Walking = Hum.MoveDirection.magnitude>0
	local State = (not Hit and Root.Velocity.Y<-1 and 'Fall' or not Hit and Root.Velocity.Y>1 and 'Jump' or Walking and "Walk" or "Idle")
	if(not EffectFolder or EffectFolder.Parent~=Char)then
		EffectFolder=Instance.new("Folder")
		EffectFolder.Name='Effects'
		EffectFolder.Parent=Char
	end
	
	--I know this looks like jl's
	--It's more inspired by my old one which is a modified ver of Kyu's, but replacing Root.Velocity with Hum.MoveDirection and removing the clamp
	local FwdDir = (Walking and Hum.MoveDirection*Root.CFrame.lookVector or V3.N())
	local RigDir = (Walking and Hum.MoveDirection*Root.CFrame.rightVector or V3.N())
	local Vec = {
		X=RigDir.X+RigDir.Z,
		Z=FwdDir.X+FwdDir.Z
	};
	local Divide = 1
	if(Vec.Z<0)then
		Divide=math.clamp(-(1.25*Vec.Z),1,2)
	end
	Vec.Z = Vec.Z/Divide
	Vec.X = Vec.X/Divide
	Hum.WalkSpeed = WalkSpeed/Divide
	local Value = Movement/10
	if(legAnims)then
		if(State=='Walk')then
			Change=1
			Animate(LH,CF.N(-.5,-.8-.5*Value*M.S(Sine/wsVal)/2,(-.3*Value*M.C(Sine/wsVal)/2)*Vec.Z)*CF.A((M.R(-5+45*Value*M.C(Sine/wsVal))+M.S(Sine/wsVal)/2.5)*Vec.Z,M.R(0),(M.R(-5+45*Value*M.C(Sine/wsVal))+M.S(Sine/wsVal)/2.5)*Vec.X)*CF.A(M.R(0-2.5*Value*M.C(Sine/wsVal))*Vec.Z,M.R(0),M.R(0-2.5*Value*M.C(Sine/wsVal))),.1)
			Animate(RH,CF.N(.5,-.8+.5*Value*M.S(Sine/wsVal)/2,(.3*Value*M.C(Sine/wsVal)/2)*Vec.Z)*CF.A((M.R(-5-45*Value*M.C(Sine/wsVal))-M.S(Sine/wsVal)/2.5)*Vec.Z,M.R(0),(M.R(-5-45*Value*M.C(Sine/wsVal))-M.S(Sine/wsVal)/2.5)*Vec.X)*CF.A(M.R(0+2.5*Value*M.C(Sine/wsVal))*Vec.Z,M.R(0),M.R(0+2.5*Value*M.C(Sine/wsVal))),.1)
		elseif(State=='Idle')then
			Change=1
			if(not NeutralAnims)then
				Animate(LH,CF.N(-0.5,-1,0)*CF.A(M.R(0),M.R(5.6),M.R(0)),.2)
				Animate(RH,CF.N(0.5,-1,0)*CF.A(M.R(0),M.R(-5.6),M.R(0)),.2)
			end
		elseif(State=='Jump' or State=='Fall')then
			Animate(LH,LHC0*CF.A(0,0,M.R(-5)),.1)
			Animate(RH,RHC0*CF.N(0,1,-1)*CF.A(M.R(-5),0,M.R(5)),.1)
		end
	end
	if(NeutralAnims)then	
		if(State == 'Idle')then
			local Timer = .1
		  Animate(RJ,CF.A(math.rad(0),math.rad(0 + 30 * math.cos(Sine/5)),math.rad(0 - 30 * math.sin(Sine/5)))*CF.N(0,0 + 2 * math.cos(Sine/2.5),0),Timer)
		  Animate(LS,CF.N(-1.5,0.5,0)*CF.A(math.rad(0 + 45  * math.sin(Sine/2.5)),math.rad(0),math.rad(0 - 30  * math.cos(Sine/5))),Timer)
		  Animate(RS,CF.N(1.5,0.5,0)*CF.A(math.rad(0 + 45  * math.sin(Sine/2.5)),math.rad(0),math.rad(0 + 30  * math.cos(Sine/5))),Timer)
		  Animate(NK,CF.N(0,1.5,0)*CF.A(math.rad(0),math.rad(0),math.rad(0)),Timer)
		  Animate(LH,CF.N(-0.5,-1,0)*CF.A(math.rad(0),math.rad(0),math.rad(0 + 60 * math.sin(Sine/5))),Timer)
		  Animate(RH,CF.N(0.5,-1,0)*CF.A(math.rad(0),math.rad(0),math.rad(0 + 60 * math.sin(Sine/5))),Timer)
		elseif(State == 'Walk')then
			local Alpha = .1
			Animate(RJ,RJC0*CF.N(.4*Value*Vec.X,-.175+.1*Value*M.C(Sine/(wsVal/2)),-.4*Value*Vec.Z)*CF.A(M.R(-10-3*Value*M.C(Sine/(wsVal/2)))*Vec.Z,M.R(0-5*Value*M.C(Sine/wsVal)),M.R(-10*Value*Vec.X)+M.R(0-1*Value*M.C(Sine/wsVal))),Alpha)
			Animate(NK,NKC0*CF.A(M.R(0-7*Value*M.C(Sine/(wsVal/2)))*Vec.Z,M.R(0+10*Value*M.S(Sine/wsVal))*Vec.Z,0),Alpha)
			Animate(RS,RSC0*CF.N(0,0,(0-.7*Value*M.C(Sine/wsVal))*Vec.Z)*CF.A((M.R(0+55*Value*M.C(Sine/wsVal))*Vec.Z)+M.R(5*Value*Vec.X),0,M.R(5*Value)+M.R(10*Value*Vec.X)),Alpha)
			Animate(LS,LSC0*CF.N(0,0,(0+.7*Value*M.C(Sine/wsVal))*Vec.Z)*CF.A((M.R(0-55*Value*M.C(Sine/wsVal))*Vec.Z)+M.R(5*Value*Vec.X),0,M.R(-5*Value)+M.R(10*Value*Vec.X)),Alpha)
		elseif(State == 'Jump')then
			local Alpha = .1
			local idk = math.min(math.max(Root.Velocity.Y/50,-M.R(90)),M.R(90))
			Animate(LS,LSC0*CF.A(M.R(-5),0,M.R(-90)),Alpha)
			Animate(RS,RSC0*CF.A(M.R(-5),0,M.R(90)),Alpha)
			Animate(RJ,RJC0*CF.A(math.min(math.max(Root.Velocity.Y/100,-M.R(45)),M.R(45)),0,0),Alpha)
			Animate(NK,NKC0*CF.A(math.min(math.max(Root.Velocity.Y/100,-M.R(45)),M.R(45)),0,0),Alpha)
		elseif(State == 'Fall')then
			local Alpha = .1
			local idk = math.min(math.max(Root.Velocity.Y/50,-M.R(90)),M.R(90))
			Animate(LS,LSC0*CF.A(M.R(-5),0,M.R(-90)+idk),Alpha)
			Animate(RS,RSC0*CF.A(M.R(-5),0,M.R(90)-idk),Alpha)
			Animate(RJ,RJC0*CF.A(math.min(math.max(Root.Velocity.Y/100,-M.R(45)),M.R(45)),0,0),Alpha)
			Animate(NK,NKC0*CF.A(math.min(math.max(Root.Velocity.Y/100,-M.R(45)),M.R(45)),0,0),Alpha)
		end
	end

end