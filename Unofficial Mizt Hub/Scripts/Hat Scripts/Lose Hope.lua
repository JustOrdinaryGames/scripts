local script = game:GetObjects("rbxassetid://7726418931")[1]

local killScript = false

coroutine.wrap(
    function()
        while wait() do
            if not game.Players.LocalPlayer.Character or not game.Players.LocalPlayer.Character:FindFirstChild("Dummy") then
                killScript = true
                if script:FindFirstChild("Heartbeat") then
                    script:FindFirstChild("Heartbeat"):Destroy()
                end
                print("Stopped Script")
                break
            end
        end
    end
)()

local flingTarget = miztgetcharacter()

--BurgerKingHappy_Meal (BKHM)
--RbxUtility.Create
t = {}
local LoadLibrary = function(Ut)
    if Ut == "RbxUtility" then
        return t
    end
end
t.Create =
    setmetatable(
    {},
    {
        __call = function(tb, ...)
            return Create_PrivImpl(...)
        end
    }
)
Create_PrivImpl = function(objectType)
    if type(objectType) ~= "string" then
        error("Argument of Create must be a string", 2)
    end
    return function(dat)
        dat = dat or {}
        local obj = Instance.new(objectType)
        local parent = nil
        local ctor = nil
        for k, v in pairs(dat) do
            if type(k) == "string" then
                if k == "Parent" then
                    parent = v
                else
                    obj[k] = v
                end
            elseif type(k) == "number" then
                if type(v) ~= "userdata" then
                    error("Bad entry in Create body: Numeric keys must be paired with children, got a: " .. type(v), 2)
                end
                v.Parent = obj
            elseif type(k) == "table" and k.__eventname then
                if type(v) ~= "function" then
                    error(
                        "Bad entry in Create body: Key `[Create.E'" ..
                            k.__eventname .. "']` must have a function value\
					       got: " .. tostring(v),
                        2
                    )
                end
                obj[k.__eventname]:connect(v)
            elseif k == t.Create then
                if type(v) ~= "function" then
                    error(
                        "Bad entry in Create body: Key `[Create]` should be paired with a constructor function, \
					       got: " ..
                            tostring(v),
                        2
                    )
                elseif ctor then
                    error("Bad entry in Create body: Only one constructor function is allowed", 2)
                end
                ctor = v
            else
                error("Bad entry (" .. tostring(k) .. " => " .. tostring(v) .. ") in Create body", 2)
            end
        end
        if ctor then
            ctor(obj)
        end
        if parent then
            obj.Parent = parent
        end
        return obj
    end
end

local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()
local Character = miztgetcharacter()
local Humanoid = Character.Humanoid
local LeftArm = Character["Left Arm"]
local RightArm = Character["Right Arm"]
local LeftLeg = Character["Left Leg"]
local RightLeg = Character["Right Leg"]
local Head = Character.Head
local Torso = Character.Torso
local Camera = game.Workspace.CurrentCamera
local RootPart = Character.HumanoidRootPart
local RootJoint = RootPart.RootJoint
local Neck = Torso["Neck"]
local RightShoulder = Torso["Right Shoulder"]
local LeftShoulder = Torso["Left Shoulder"]
local RightHip = Torso["Right Hip"]
local LeftHip = Torso["Left Hip"]
local attack = false
local Anim = "Idle"
local attacktype = 1
local delays = false
local play = true
local targetted = nil
local Torsovelocity = (RootPart.Velocity * Vector3.new(1, 0, 1)).magnitude
local velocity = RootPart.Velocity.y
local sine = 0
local change = 1
local doe = 0
local Create = LoadLibrary("RbxUtility").Create
local Effects = Instance.new("Folder", Character)
Effects.Name = "Effects"
local walkspeed = 36
Humanoid.WalkSpeed = walkspeed
local function FindHumanoid(Part)
    local humanoid = nil
    if Part.Parent then
        if Part.Parent ~= miztgetcharacter() and Part.Parent:FindFirstChildOfClass("Humanoid") ~= nil then
            humanoid = Part.Parent:FindFirstChildOfClass("Humanoid")
        else
            if Part.Parent.Parent then
                if Part.Parent.Parent:FindFirstChildOfClass("Humanoid") and Part.Parent.Parent ~= miztgetcharacter() then
                    humanoid = Part.Parent.Parent:FindFirstChildOfClass("Humanoid")
                end
            end
        end
    end
    if humanoid == Humanoid then
        humanoid = nil
    end
    return humanoid
end
Humanoid.Animator.Parent = nil
Character.Animate.Parent = nil
local rc0 = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(180))
local nc0 = CFrame.new(0, 1, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(180))
local rscp = CFrame.new(-0.5, 0, 0) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0))
local lscp = CFrame.new(0.5, 0, 0) * CFrame.Angles(math.rad(0), math.rad(-90), math.rad(0))

function QFCF(cf)
    local mx, my, mz, m00, m01, m02, m10, m11, m12, m20, m21, m22 = cf:components()
    local trace = m00 + m11 + m22
    if trace > 0 then
        local s = math.sqrt(1 + trace)
        local recip = 0.5 / s
        return (m21 - m12) * recip, (m02 - m20) * recip, (m10 - m01) * recip, s * 0.5
    else
        local i = 0
        if m11 > m00 then
            i = 1
        end
        if m22 > (i == 0 and m00 or m11) then
            i = 2
        end
        if i == 0 then
            local s = math.sqrt(m00 - m11 - m22 + 1)
            local recip = 0.5 / s
            return 0.5 * s, (m10 + m01) * recip, (m20 + m02) * recip, (m21 - m12) * recip
        elseif i == 1 then
            local s = math.sqrt(m11 - m22 - m00 + 1)
            local recip = 0.5 / s
            return (m01 + m10) * recip, 0.5 * s, (m21 + m12) * recip, (m02 - m20) * recip
        elseif i == 2 then
            local s = math.sqrt(m22 - m00 - m11 + 1)
            local recip = 0.5 / s
            return (m02 + m20) * recip, (m12 + m21) * recip, 0.5 * s, (m10 - m01) * recip
        end
    end
end

function QTCF(px, py, pz, x, y, z, w)
    local xs, ys, zs = x + x, y + y, z + z
    local wx, wy, wz = w * xs, w * ys, w * zs
    local xx = x * xs
    local xy = x * ys
    local xz = x * zs
    local yy = y * ys
    local yz = y * zs
    local zz = z * zs
    return CFrame.new(
        px,
        py,
        pz,
        1 - (yy + zz),
        xy - wz,
        xz + wy,
        xy + wz,
        1 - (xx + zz),
        yz - wx,
        xz - wy,
        yz + wx,
        1 - (xx + yy)
    )
end

function QS(a, b, t)
    local cosTheta = a[1] * b[1] + a[2] * b[2] + a[3] * b[3] + a[4] * b[4]
    local startInterp, finishInterp
    if cosTheta >= 0.0001 then
        if (1 - cosTheta) > 0.0001 then
            local theta = math.acos(cosTheta)
            local invSinTheta = 1 / math.sin(theta)
            startInterp = math.sin((1 - t) * theta) * invSinTheta
            finishInterp = math.sin(t * theta) * invSinTheta
        else
            startInterp = 1 - t
            finishInterp = t
        end
    else
        if (1 + cosTheta) > 0.0001 then
            local theta = math.acos(-cosTheta)
            local invSinTheta = 1 / math.sin(theta)
            startInterp = math.sin((t - 1) * theta) * invSinTheta
            finishInterp = math.sin(t * theta) * invSinTheta
        else
            startInterp = t - 1
            finishInterp = t
        end
    end
    return a[1] * startInterp + b[1] * finishInterp, a[2] * startInterp + b[2] * finishInterp, a[3] * startInterp +
        b[3] * finishInterp, a[4] * startInterp + b[4] * finishInterp
end

function Clerp(a, b, t)
    local qa = {QFCF(a)}
    local qb = {QFCF(b)}
    local ax, ay, az = a.x, a.y, a.z
    local bx, by, bz = b.x, b.y, b.z
    local _t = 1 - t
    return QTCF(_t * ax + t * bx, _t * ay + t * by, _t * az + t * bz, QS(qa, qb, t))
end

if script:FindFirstChild("Heartbeat") then
    script:FindFirstChild("Heartbeat"):Destroy()
end

ArtificialHB =
    Create("BindableEvent", script) {
    Parent = script,
    Name = "Heartbeat"
}

script:WaitForChild("Heartbeat")

frame = 1 / 30
tf = 0
allowframeloss = false
tossremainder = false
lastframe = tick()
ArtificialHB:Fire()

game:GetService("RunService").Heartbeat:connect(
    function(s, p)
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
    end
)

function swait(num)
    if num == 0 or num == nil then
        ArtificialHB.Event:wait()
    else
        for i = 0, num do
            ArtificialHB.Event:wait()
        end
    end
end

function RemoveOutlines(part)
    part.TopSurface, part.BottomSurface, part.LeftSurface, part.RightSurface, part.FrontSurface, part.BackSurface =
        10,
        10,
        10,
        10,
        10,
        10
end

function CreateWeldOrSnapOrMotor(TYPE, PARENT, PART0, PART1, C0, C1)
    local NEWWELD = Instance.new(TYPE)
    NEWWELD.Part0 = PART0
    NEWWELD.Part1 = PART1
    NEWWELD.C0 = C0
    NEWWELD.C1 = C1
    NEWWELD.Parent = PARENT
    return NEWWELD
end

function CreateMesh(MESH, PARENT, MESHTYPE, MESHID, TEXTUREID, SCALE, OFFSET)
    local NEWMESH = Instance.new(MESH)
    if MESH == "SpecialMesh" then
        NEWMESH.MeshType = MESHTYPE
        if MESHID ~= "nil" and MESHID ~= "" then
            NEWMESH.MeshId = "http://www.roblox.com/asset/?id=" .. MESHID
        end
        if TEXTUREID ~= "nil" and TEXTUREID ~= "" then
            NEWMESH.TextureId = "http://www.roblox.com/asset/?id=" .. TEXTUREID
        end
    end
    NEWMESH.Offset = OFFSET or Vector3.new(0, 0, 0)
    NEWMESH.Scale = SCALE
    NEWMESH.Parent = PARENT
    return NEWMESH
end

function CreatePart(FORMFACTOR, PARENT, MATERIAL, REFLECTANCE, TRANSPARENCY, BRICKCOLOR, NAME, SIZE, ANCHOR)
    local NEWPART = Instance.new("Part")
    NEWPART.formFactor = FORMFACTOR
    NEWPART.Reflectance = REFLECTANCE
    NEWPART.Transparency = TRANSPARENCY
    NEWPART.CanCollide = false
    NEWPART.Locked = true
    NEWPART.Anchored = true
    if ANCHOR == false then
        NEWPART.Anchored = false
    end
    NEWPART.BrickColor = BrickColor.new(tostring(BRICKCOLOR))
    NEWPART.Name = NAME
    NEWPART.Size = SIZE
    NEWPART.Position = Torso.Position
    NEWPART.Material = MATERIAL
    NEWPART:BreakJoints()
    NEWPART.Parent = PARENT
    return NEWPART
end

local S = Instance.new("Sound")
function CreateSound(ID, PARENT, VOLUME, PITCH, DOESLOOP)
    local NEWSOUND = nil
    coroutine.resume(
        coroutine.create(
            function()
                NEWSOUND = S:Clone()
                NEWSOUND.Parent = PARENT
                NEWSOUND.Volume = VOLUME
                NEWSOUND.Pitch = PITCH
                NEWSOUND.SoundId = "rbxassetid://" .. ID
                NEWSOUND.PlayOnRemove = true
                NEWSOUND:play()
                if DOESLOOP == true then
                    NEWSOUND.Looped = true
                else
                    NEWSOUND:remove()
                end
            end
        )
    )
    return NEWSOUND
end

local function weldBetween(a, b)
    local weldd = Instance.new("ManualWeld")
    weldd.Part0 = a
    weldd.Part1 = b
    weldd.C0 = CFrame.new()
    weldd.C1 = b.CFrame:inverse() * a.CFrame
    weldd.Parent = a
    return weldd
end

for i = 1, 20 do
    local FACE =
        CreatePart(
        3,
        Head,
        "Fabric",
        0,
        0 + (i - 5) / 10.2,
        "Dark stone grey",
        "FaceGradient",
        Vector3.new(1.01, 0.65, 1.01),
        false
    )
    FACE.Color = Color3.new(0, 0, 0)
    Head:FindFirstChildOfClass("SpecialMesh"):Clone().Parent = FACE
    CreateWeldOrSnapOrMotor("Weld", Head, Head, FACE, CFrame.new(0, 0.25 - (i - 0.55) / 40, 0), CFrame.new(0, 0, 0))
end

local GUN = script.Gun
GUN.Parent = Character
for _, c in pairs(GUN:GetChildren()) do
    if c:IsA("BasePart") then
        c.Transparency = 1
        c.Anchored = false
        c.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
        if c ~= GUN.PrimaryPart then
            weldBetween(GUN.PrimaryPart, c)
        end
        c.Locked = true
    end
end

-- Align Section
local AlignChar = miztgetcharacter()
local Hat = AlignChar:FindFirstChild("Starslayer Railgun")

local Count = 1
function Align(Part0,Part1,Position,Angle)
    local AlignPos = Instance.new('AlignPosition', Part1); AlignPos.Name = "AliP_"..Count
    AlignPos.ApplyAtCenterOfMass = true;
    AlignPos.MaxForce = 5772000--67752;
    AlignPos.MaxVelocity = math.huge/9e110;
    AlignPos.ReactionForceEnabled = false;
    AlignPos.Responsiveness = 200;
    AlignPos.RigidityEnabled = false;
    local AlignOri = Instance.new('AlignOrientation', Part1); AlignOri.Name = "AliO_"..Count
    AlignOri.MaxAngularVelocity = math.huge/9e110;
    AlignOri.MaxTorque = 5772000
    AlignOri.PrimaryAxisOnly = false;
    AlignOri.ReactionTorqueEnabled = false;
    AlignOri.Responsiveness = 200;
    AlignOri.RigidityEnabled = false;
    local AttachmentA=Instance.new('Attachment',Part1); AttachmentA.Name = "AthP_"..Count
    local AttachmentB=Instance.new('Attachment',Part0); AttachmentB.Name = "AthP_"..Count
    local AttachmentC=Instance.new('Attachment',Part1); AttachmentC.Name = "AthO_"..Count
    local AttachmentD=Instance.new('Attachment',Part0); AttachmentD.Name = "AthO_"..Count
    AttachmentC.Orientation = Angle
    AttachmentA.Position = Position
    AlignPos.Attachment1 = AttachmentA;
    AlignPos.Attachment0 = AttachmentB;
    AlignOri.Attachment1 = AttachmentC;
    AlignOri.Attachment0 = AttachmentD;
    Count = Count + 1
    coroutine.wrap(function()
        while wait() and not killScript do
            if AlignPos.Visible then AlignPos.Visible = false else AlignPos.Visible = true end
            if AlignOri.Visible then AlignOri.Visible = false else AlignOri.Visible = true end
        end
    end)()
end
if Hat.Handle:FindFirstChild("AccessoryWeld") then
    Hat.Handle.AccessoryWeld:Destroy()
end
Align(Hat.Handle,GUN.PrimaryPart,Vector3.new(0,0.8,-0.8),Vector3.new(0,90,50))

local GunJoint =
    CreateWeldOrSnapOrMotor("Weld", RightArm, RightArm, GUN.PrimaryPart, CFrame.new(0, -1, 0), CFrame.new(0, 0, 0))
local Hole = GUN.Hole

function rayCast(Position, Direction, Range, Ignore)
    return game:service("Workspace"):FindPartOnRay(Ray.new(Position, Direction.unit * (Range or 999.999)), Ignore)
end

function dmg(dude)
    if dude:FindFirstChild("Torso") or dude:FindFirstChild("UpperTorso") then
        flingTarget = dude
        coroutine.wrap(function() wait(1) flingTarget = miztgetcharacter() end)()
    end
end

function mdmg(Part, Magnitude)
    for index, a in pairs(workspace:GetDescendants()) do
        if a.ClassName == "Model" and a ~= Character and a~= game.Players.LocalPlayer.Character then
            local h = a:FindFirstChildOfClass("Humanoid")
            if h then
                for _, c in pairs(a:GetChildren()) do
                    if c:IsA("BasePart") then
                        if (c.Position - Part).Magnitude <= Magnitude + c.Size.Magnitude then
                            dmg(a)
                            break
                        end
                    end
                end
            end
        end
    end
end

function Effect(Table)
    local TYPE = (Table.EffectType or "Sphere")
    local SIZE = (Table.Size or Vector3.new(1, 1, 1))
    local ENDSIZE = (Table.Size2 or Vector3.new(0, 0, 0))
    local TRANSPARENCY = (Table.Transparency or 0)
    local ENDTRANSPARENCY = (Table.Transparency2 or 1)
    local CFRAME = (Table.CFrame or Torso.CFrame)
    local MOVEDIRECTION = (Table.MoveToPos or nil)
    local ROTATION1 = (Table.RotationX or 0)
    local ROTATION2 = (Table.RotationY or 0)
    local ROTATION3 = (Table.RotationZ or 0)
    local MATERIAL = (Table.Material or "Neon")
    local COLOR = (Table.Color or Color3.new(1, 1, 1))
    local TIME = (Table.Time or 45)
    local SOUNDID = (Table.SoundID or nil)
    local SOUNDPITCH = (Table.SoundPitch or nil)
    local SOUNDVOLUME = (Table.SoundVolume or nil)
    local USEBOOMERANGMATH = (Table.UseBoomerangMath or false)
    local BOOMERANG = (Table.Boomerang or 0)
    local SIZEBOOMERANG = (Table.SizeBoomerang or 0)
    coroutine.resume(
        coroutine.create(
            function()
                local PLAYSSOUND = false
                local SOUND = nil
                local EFFECT =
                    CreatePart(
                    3,
                    Effects,
                    MATERIAL,
                    0,
                    TRANSPARENCY,
                    BrickColor.new("Pearl"),
                    "Effect",
                    Vector3.new(1, 1, 1),
                    true
                )
                if SOUNDID ~= nil and SOUNDPITCH ~= nil and SOUNDVOLUME ~= nil then
                    PLAYSSOUND = true
                    SOUND = CreateSound(SOUNDID, EFFECT, SOUNDVOLUME, SOUNDPITCH, false)
                end
                EFFECT.Color = COLOR
                local MSH = nil
                if TYPE == "Sphere" then
                    MSH = CreateMesh("SpecialMesh", EFFECT, "Sphere", "", "", SIZE, Vector3.new(0, 0, 0))
                elseif TYPE == "Block" or TYPE == "Box" then
                    MSH = Instance.new("BlockMesh", EFFECT)
                    MSH.Scale = SIZE
                elseif TYPE == "Wave" then
                    MSH =
                        CreateMesh(
                        "SpecialMesh",
                        EFFECT,
                        "FileMesh",
                        "20329976",
                        "",
                        SIZE,
                        Vector3.new(0, 0, -SIZE.X / 8)
                    )
                elseif TYPE == "Ring" then
                    MSH =
                        CreateMesh(
                        "SpecialMesh",
                        EFFECT,
                        "FileMesh",
                        "559831844",
                        "",
                        Vector3.new(SIZE.X, SIZE.X, 0.1),
                        Vector3.new(0, 0, 0)
                    )
                elseif TYPE == "Slash" then
                    MSH =
                        CreateMesh(
                        "SpecialMesh",
                        EFFECT,
                        "FileMesh",
                        "662586858",
                        "",
                        Vector3.new(SIZE.X / 10, 0, SIZE.X / 10),
                        Vector3.new(0, 0, 0)
                    )
                elseif TYPE == "Round Slash" then
                    MSH =
                        CreateMesh(
                        "SpecialMesh",
                        EFFECT,
                        "FileMesh",
                        "662585058",
                        "",
                        Vector3.new(SIZE.X / 10, 0, SIZE.X / 10),
                        Vector3.new(0, 0, 0)
                    )
                elseif TYPE == "Swirl" then
                    MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "168892432", "", SIZE, Vector3.new(0, 0, 0))
                elseif TYPE == "Skull" then
                    MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "4770583", "", SIZE, Vector3.new(0, 0, 0))
                elseif TYPE == "Crystal" then
                    MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "9756362", "", SIZE, Vector3.new(0, 0, 0))
                end
                if MSH ~= nil then
                    local BOOMR1 = 1 + BOOMERANG / 50
                    local BOOMR2 = 1 + SIZEBOOMERANG / 50
                    local MOVESPEED = nil
                    if MOVEDIRECTION ~= nil then
                        if USEBOOMERANGMATH == true then
                            MOVESPEED = ((CFRAME.p - MOVEDIRECTION).Magnitude / TIME) * BOOMR1
                        else
                            MOVESPEED = ((CFRAME.p - MOVEDIRECTION).Magnitude / TIME)
                        end
                    end
                    local GROWTH = nil
                    if USEBOOMERANGMATH == true then
                        GROWTH = (SIZE - ENDSIZE) * (BOOMR2 + 1)
                    else
                        GROWTH = (SIZE - ENDSIZE)
                    end
                    local TRANS = TRANSPARENCY - ENDTRANSPARENCY
                    if TYPE == "Block" then
                        EFFECT.CFrame =
                            CFRAME *
                            CFrame.Angles(
                                math.rad(math.random(0, 360)),
                                math.rad(math.random(0, 360)),
                                math.rad(math.random(0, 360))
                            )
                    else
                        EFFECT.CFrame = CFRAME
                    end
                    if USEBOOMERANGMATH == true then
                        for LOOP = 1, TIME + 1 do
                            swait()
                            MSH.Scale =
                                MSH.Scale -
                                (Vector3.new(
                                    (GROWTH.X) * (1 - (LOOP / TIME) * BOOMR2),
                                    (GROWTH.Y) * (1 - (LOOP / TIME) * BOOMR2),
                                    (GROWTH.Z) * (1 - (LOOP / TIME) * BOOMR2)
                                ) *
                                    BOOMR2) /
                                    TIME
                            if TYPE == "Wave" then
                                MSH.Offset = Vector3.new(0, 0, -MSH.Scale.Z / 8)
                            end
                            EFFECT.Transparency = EFFECT.Transparency - TRANS / TIME
                            if TYPE == "Block" then
                                EFFECT.CFrame =
                                    CFRAME *
                                    CFrame.Angles(
                                        math.rad(math.random(0, 360)),
                                        math.rad(math.random(0, 360)),
                                        math.rad(math.random(0, 360))
                                    )
                            else
                                EFFECT.CFrame =
                                    EFFECT.CFrame *
                                    CFrame.Angles(math.rad(ROTATION1), math.rad(ROTATION2), math.rad(ROTATION3))
                            end
                            if MOVEDIRECTION ~= nil then
                                local ORI = EFFECT.Orientation
                                EFFECT.CFrame =
                                    CFrame.new(EFFECT.Position, MOVEDIRECTION) *
                                    CFrame.new(0, 0, -(MOVESPEED) * (1 - (LOOP / TIME) * BOOMR1))
                                EFFECT.Orientation = ORI
                            end
                        end
                    else
                        for LOOP = 1, TIME + 1 do
                            swait()
                            MSH.Scale = MSH.Scale - GROWTH / TIME
                            if TYPE == "Wave" then
                                MSH.Offset = Vector3.new(0, 0, -MSH.Scale.Z / 8)
                            end
                            EFFECT.Transparency = EFFECT.Transparency - TRANS / TIME
                            if TYPE == "Block" then
                                EFFECT.CFrame =
                                    CFRAME *
                                    CFrame.Angles(
                                        math.rad(math.random(0, 360)),
                                        math.rad(math.random(0, 360)),
                                        math.rad(math.random(0, 360))
                                    )
                            else
                                EFFECT.CFrame =
                                    EFFECT.CFrame *
                                    CFrame.Angles(math.rad(ROTATION1), math.rad(ROTATION2), math.rad(ROTATION3))
                            end
                            if MOVEDIRECTION ~= nil then
                                local ORI = EFFECT.Orientation
                                EFFECT.CFrame =
                                    CFrame.new(EFFECT.Position, MOVEDIRECTION) * CFrame.new(0, 0, -MOVESPEED)
                                EFFECT.Orientation = ORI
                            end
                        end
                    end
                    EFFECT.Transparency = 1
                    if PLAYSSOUND == false then
                        EFFECT:remove()
                    else
                        repeat
                            swait()
                        until EFFECT:FindFirstChildOfClass("Sound") == nil
                        EFFECT:remove()
                    end
                else
                    if PLAYSSOUND == false then
                        EFFECT:remove()
                    else
                        repeat
                            swait()
                        until EFFECT:FindFirstChildOfClass("Sound") == nil
                        EFFECT:remove()
                    end
                end
            end
        )
    )
end

function Lightning(Part0, Part1, Times, Offset, Color, Timer, sSize, eSize, Trans, Boomer, sBoomer, slow, stime)
    local magz = (Part0 - Part1).magnitude
    local curpos = Part0
    local trz = {
        -Offset,
        Offset
    }
    for i = 1, Times do
        local li = Instance.new("Part", Effects)
        li.Name = "Lightning"
        li.TopSurface = 0
        li.Material = "Neon"
        li.BottomSurface = 0
        li.Anchored = true
        li.Locked = true
        li.Transparency = 0
        li.BrickColor = Color
        li.formFactor = "Custom"
        li.CanCollide = false
        li.Size = Vector3.new(0.1, 0.1, magz / Times)
        local Offzet = Vector3.new(trz[math.random(1, 2)], trz[math.random(1, 2)], trz[math.random(1, 2)])
        local trolpos = CFrame.new(curpos, Part1) * CFrame.new(0, 0, magz / Times).p + Offzet
        if Times == i then
            local magz2 = (curpos - Part1).magnitude
            li.Size = Vector3.new(0.1, 0.1, magz2)
            li.CFrame = CFrame.new(curpos, Part1) * CFrame.new(0, 0, -magz2 / 2)
        else
            li.CFrame = CFrame.new(curpos, trolpos) * CFrame.new(0, 0, magz / Times / 2)
        end
        curpos = li.CFrame * CFrame.new(0, 0, magz / Times / 2).p
        li:Destroy()
        Effect(
            {
                Time = Timer,
                EffectType = "Box",
                Size = Vector3.new(sSize, sSize, li.Size.Z),
                Size2 = Vector3.new(eSize, eSize, li.Size.Z),
                Transparency = Trans,
                Transparency2 = 1,
                CFrame = li.CFrame,
                MoveToPos = nil,
                RotationX = nil,
                RotationY = nil,
                RotationZ = nil,
                Material = "Neon",
                Color = li.Color,
                SoundID = nil,
                SoundPitch = nil,
                SoundVolume = nil,
                UseBoomerangMath = Boomer,
                Boomerang = 0,
                SizeBoomerang = sBoomer
            }
        )
        if slow == true then
            swait(stime)
        end
    end
end

function SHAKECAM(POSITION, RANGE, INTENSITY, TIME) --
    --[[local CHILDREN = workspace:GetDescendants()
	for index, CHILD in pairs(CHILDREN) do
		if CHILD.ClassName == "Model" then
			local HUM = CHILD:FindFirstChildOfClass("Humanoid")
			if HUM then
				local TORSO = CHILD:FindFirstChild("Torso") or CHILD:FindFirstChild("UpperTorso")
				if TORSO then
					if (TORSO.Position - POSITION).Magnitude <= RANGE then
						local CAMSHAKER = script.CamShake:Clone()
						CAMSHAKER.Shake.Value = INTENSITY
						CAMSHAKER.Timer.Value = TIME
						CAMSHAKER.Parent = CHILD
						CAMSHAKER.Disabled = false
					end
				end
			end
		end
	end]]
end

function FireArc(Part, ToLocation, AmountOfTime, Height, DoesCourontine)
    if DoesCourontine == false then
        local Direction = CFrame.new(Part.Position, ToLocation)
        local Distance = (Part.Position - ToLocation).magnitude
        for i = 1, AmountOfTime do
            swait()
            Part.CFrame =
                Direction *
                CFrame.new(
                    0,
                    (AmountOfTime / 200) + ((AmountOfTime / Height) - ((i * 2) / Height)),
                    -Distance / AmountOfTime
                )
            Direction = Part.CFrame
        end
    elseif DoesCourontine == true then
        coroutine.resume(
            coroutine.create(
                function()
                    local Direction = CFrame.new(Part.Position, ToLocation)
                    local Distance = (Part.Position - ToLocation).magnitude
                    for i = 1, AmountOfTime do
                        swait()
                        Part.CFrame =
                            Direction *
                            CFrame.new(
                                0,
                                (AmountOfTime / 200) + ((AmountOfTime / Height) - ((i * 2) / Height)),
                                -Distance / AmountOfTime
                            )
                        Direction = Part.CFrame
                    end
                end
            )
        )
    end
end

function MakeForm(PART, TYPE)
    if TYPE == "Cyl" then
        local MSH = Instance.new("CylinderMesh", PART)
    elseif TYPE == "Ball" then
        local MSH = Instance.new("SpecialMesh", PART)
        MSH.MeshType = "Sphere"
    elseif TYPE == "Wedge" then
        local MSH = Instance.new("SpecialMesh", PART)
        MSH.MeshType = "Wedge"
    end
end

function AttackGyro()
    local GYRO = Instance.new("BodyGyro", RootPart)
    GYRO.D = 25
    GYRO.P = 20000
    GYRO.MaxTorque = Vector3.new(0, 4000000, 0)
    GYRO.CFrame = CFrame.new(RootPart.Position, Mouse.Hit.p)
    coroutine.resume(
        coroutine.create(
            function()
                repeat
                    swait()
                    GYRO.CFrame = CFrame.new(RootPart.Position, Mouse.Hit.p)
                until attack == false
                GYRO:Remove()
            end
        )
    )
end

function CharacterFade(COLOR, TIMER)
    coroutine.resume(
        coroutine.create(
            function()
                local FADE = Instance.new("Model", Effects)
                FADE.Name = "FadingEffect"
                for _, c in pairs(Character:GetChildren()) do
                    if c.ClassName == "Part" and c ~= RootPart then
                        local FADER = c:Clone()
                        FADER.Color = COLOR
                        FADER.CFrame = c.CFrame
                        FADER.Parent = FADE
                        FADER.Anchored = true
                        FADER.Transparency = 0.25 + c.Transparency
                        FADER:BreakJoints()
                        FADER.Material = "Neon"
                        if FADER.Name == "Head" then
                            FADER:ClearAllChildren()
                            FADER.Size = Vector3.new(1, 1, 1)
                        end
                        if FADER:FindFirstChildOfClass("SpecialMesh") then
                            FADER:remove()
                        end
                        FADER.CanCollide = false
                        FADER:ClearAllChildren()
                    end
                end
                local TRANS = 0.75 / TIMER
                for i = 1, TIMER do
                    swait()
                    for _, c in pairs(FADE:GetChildren()) do
                        if c.ClassName == "Part" then
                            c.Transparency = c.Transparency + TRANS
                        end
                    end
                end
                FADE:remove()
            end
        )
    )
end

function chatfunc(text)
    local chat =
        coroutine.wrap(
        function()
            if Character:FindFirstChild("TalkingBillBoard") ~= nil then
                Character:FindFirstChild("TalkingBillBoard"):destroy()
            end
            local naeeym2 = Instance.new("BillboardGui", Character)
            naeeym2.Size = UDim2.new(0, 100, 0, 40)
            naeeym2.StudsOffset = Vector3.new(0, 3, 0)
            naeeym2.Adornee = Character.Head
            naeeym2.Name = "TalkingBillBoard"
            local tecks2 = Instance.new("TextLabel", naeeym2)
            tecks2.BackgroundTransparency = 1
            tecks2.BorderSizePixel = 0
            tecks2.Text = ""
            tecks2.Font = "Code"
            tecks2.TextSize = 40
            tecks2.TextStrokeTransparency = 0
            tecks2.TextColor3 = Color3.new(.50, .30, .10)
            tecks2.TextStrokeColor3 = Color3.new(0, 0, 0)
            tecks2.Size = UDim2.new(1, 0, 0.5, 0)
            local tecks3 = Instance.new("TextLabel", naeeym2)
            tecks3.BackgroundTransparency = 1
            tecks3.BorderSizePixel = 0
            tecks3.Text = ""
            tecks3.Font = "Code"
            tecks3.TextSize = 40
            tecks3.TextStrokeTransparency = 0
            tecks3.TextColor3 = Color3.new(.70, .50, .30)
            tecks3.TextStrokeColor3 = Color3.new(0, 0, 0)
            tecks3.Size = UDim2.new(1, 0, 0.5, 0)
            coroutine.resume(
                coroutine.create(
                    function()
                        while naeeym2 ~= nil and not killScript do
                            swait()
                            tecks2.Position =
                                UDim2.new(math.random(-.5, .5), math.random(-5, 5), .02, math.random(-5, 5))
                            tecks3.Position =
                                UDim2.new(math.random(-.5, .5), math.random(-5, 5), .02, math.random(-5, 5))
                            tecks2.Rotation = tecks2.Rotation + math.random(-0.5, 0.5)
                            tecks3.Rotation = tecks3.Rotation + math.random(-0.5, 0.5)
                        end
                    end
                )
            )
            for i = 1, string.len(text), 1 do
                CreateSound(565939471, Head, 5, 0.65)
                tecks2.Text = string.sub(text, 1, i)
                tecks3.Text = string.sub(text, 1, i)
                wait(0.015)
            end
            wait(2)
            for i = 1, 50 do
                swait()
                tecks2.Position =
                    tecks2.Position - UDim2.new(math.random(-.5, .5), math.random(-5, 5), .05, math.random(-5, 5))
                tecks3.Position =
                    tecks2.Position - UDim2.new(math.random(-.5, .5), math.random(-5, 5), .05, math.random(-5, 5))
                tecks2.Rotation = tecks2.Rotation + math.random(-2, 2)
                tecks3.Rotation = tecks3.Rotation + math.random(-2, 2)
                tecks2.TextStrokeTransparency = tecks2.TextStrokeTransparency + .02
                tecks2.TextTransparency = tecks2.TextStrokeTransparency + .02
                tecks3.TextStrokeTransparency = tecks3.TextStrokeTransparency + .02
                tecks3.TextTransparency = tecks3.TextStrokeTransparency + .02
            end
            naeeym2:Destroy()
        end
    )
    chat()
end
function onChatted(msg)
    chatfunc(msg)
end
Player.Chatted:connect(onChatted)

abss = Instance.new("BillboardGui", Character)
abss.Size = UDim2.new(10, 0, 10, 0)
abss.Enabled = false
imgl = Instance.new("ImageLabel", abss)
imgl.Position = UDim2.new(0, 0, 0, 0)
imgl.Size = UDim2.new(1, 0, 1, 0)
imgl.Image = "rbxassetid://1490455495"
imgl.BackgroundTransparency = 1
imgl.ImageColor3 = Color3.new(.9, 0, 0)
img2 = Instance.new("ImageLabel", abss)
img2.Position = UDim2.new(0, 0, 0, 0)
img2.Size = UDim2.new(1, 0, 1, 0)
img2.Image = "rbxassetid://1490455495"
img2.BackgroundTransparency = 1
img2.ImageColor3 = Color3.new(.9, 0, 0)

function attackone()
    attack = true
    walkspeed = 24
    if targetted then
        local GYRO = Instance.new("BodyGyro", RootPart)
        GYRO.D = 25
        GYRO.P = 20000
        GYRO.MaxTorque = Vector3.new(0, 4000000, 0)
        GYRO.CFrame = CFrame.new(RootPart.Position, targetted.Head.Position)
        for i = 0, 0.5, 0.05 do
            swait()
            RootJoint.C0 =
                Clerp(
                RootJoint.C0,
                rc0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(30)),
                1 / 3
            )
            Neck.C0 =
                Clerp(
                Neck.C0,
                nc0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(15), math.rad(0), math.rad(-30)),
                1 / 3
            )
            RightShoulder.C0 =
                Clerp(
                RightShoulder.C0,
                CFrame.new(1.5, 0.5, 0) * CFrame.Angles(math.rad(90), math.rad(0), math.rad(30)) * rscp,
                1 / 3
            )
            LeftShoulder.C0 =
                Clerp(
                LeftShoulder.C0,
                CFrame.new(-1.5, 0.5, 0) * CFrame.Angles(math.rad(30), math.rad(0), math.rad(0)) * lscp,
                1 / 3
            )
            RightHip.C0 =
                Clerp(
                RightHip.C0,
                CFrame.new(1, -1, 0) * CFrame.Angles(math.rad(-5), math.rad(80), math.rad(0)) *
                    CFrame.Angles(math.rad(-4), math.rad(0), math.rad(0)),
                1 / 3
            )
            LeftHip.C0 =
                Clerp(
                LeftHip.C0,
                CFrame.new(-1, -1, 0) * CFrame.Angles(math.rad(0), math.rad(-70), math.rad(0)) *
                    CFrame.Angles(math.rad(-5), math.rad(0), math.rad(0)),
                1 / 3
            )
            GunJoint.C0 =
                Clerp(
                GunJoint.C0,
                CFrame.new(0.05, -1, -0.15) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0)),
                1 / 2
            )
        end
        local Torsy = targetted:FindFirstChild("Torso") or targetted:FindFirstChild("UpperTorso")
        if Torsy then
            dmg(targetted)
            Effect(
                {
                    Time = math.random(15, 35),
                    EffectType = "Box",
                    Size = Vector3.new(2, 2, 2),
                    Size2 = Vector3.new(5, 5, 5),
                    Transparency = 0,
                    Transparency2 = 1,
                    CFrame = Hole.CFrame,
                    MoveToPos = nil,
                    RotationX = math.random(-1, 1),
                    RotationY = math.random(-1, 1),
                    RotationZ = math.random(-1, 1),
                    Material = "Neon",
                    Color = Color3.new(1, 0, 0),
                    SoundID = 642890855,
                    SoundPitch = 0.45,
                    SoundVolume = 6,
                    UseBoomerangMath = true,
                    Boomerang = 0,
                    SizeBoomerang = 50
                }
            )
            Effect(
                {
                    Time = math.random(15, 35),
                    EffectType = "Box",
                    Size = Vector3.new(2, 2, 2),
                    Size2 = Vector3.new(5, 5, 5),
                    Transparency = 0,
                    Transparency2 = 1,
                    CFrame = Hole.CFrame,
                    MoveToPos = nil,
                    RotationX = math.random(-1, 1),
                    RotationY = math.random(-1, 1),
                    RotationZ = math.random(-1, 1),
                    Material = "Neon",
                    Color = Color3.new(0, 0, 0),
                    SoundID = nil,
                    SoundPitch = nil,
                    SoundVolume = nil,
                    UseBoomerangMath = true,
                    Boomerang = 0,
                    SizeBoomerang = 50
                }
            )
            Lightning(
                Hole.Position,
                Torsy.Position,
                15,
                3.5,
                BrickColor.new("Really black"),
                math.random(15, 35),
                1,
                3,
                0,
                true,
                55
            )
            Lightning(
                Hole.Position,
                Torsy.Position,
                15,
                3.5,
                BrickColor.new("Really red"),
                math.random(5, 35),
                1,
                3,
                0,
                true,
                55
            )
            for i = 0, 2 do
                Effect(
                    {
                        Time = math.random(25, 50),
                        EffectType = "Round Slash",
                        Size = Vector3.new(0.1, 0.1, 0.1),
                        Size2 = Vector3.new(0.4, 0, 0.4),
                        Transparency = 0,
                        Transparency2 = 1,
                        CFrame = Hole.CFrame *
                            CFrame.Angles(
                                math.rad(math.random(0, 360)),
                                math.rad(math.random(0, 360)),
                                math.rad(math.random(0, 360))
                            ),
                        MoveToPos = nil,
                        RotationX = math.random(-1, 1),
                        RotationY = math.random(-1, 1),
                        RotationZ = math.random(-1, 1),
                        Material = "Neon",
                        Color = Color3.new(1, 0, 0),
                        SoundID = nil,
                        SoundPitch = nil,
                        SoundVolume = nil,
                        UseBoomerangMath = true,
                        Boomerang = 0,
                        SizeBoomerang = 15
                    }
                )
                Effect(
                    {
                        Time = math.random(25, 50),
                        EffectType = "Round Slash",
                        Size = Vector3.new(0.1, 0.1, 0.1),
                        Size2 = Vector3.new(0.4, 0, 0.4),
                        Transparency = 0,
                        Transparency2 = 1,
                        CFrame = Hole.CFrame *
                            CFrame.Angles(
                                math.rad(math.random(0, 360)),
                                math.rad(math.random(0, 360)),
                                math.rad(math.random(0, 360))
                            ),
                        MoveToPos = nil,
                        RotationX = math.random(-1, 1),
                        RotationY = math.random(-1, 1),
                        RotationZ = math.random(-1, 1),
                        Material = "Neon",
                        Color = Color3.new(0, 0, 0),
                        SoundID = nil,
                        SoundPitch = nil,
                        SoundVolume = nil,
                        UseBoomerangMath = true,
                        Boomerang = 0,
                        SizeBoomerang = 15
                    }
                )
            end
            Effect(
                {
                    Time = math.random(15, 35),
                    EffectType = "Box",
                    Size = Vector3.new(2, 2, 2),
                    Size2 = Vector3.new(5, 5, 5),
                    Transparency = 0,
                    Transparency2 = 1,
                    CFrame = Torsy.CFrame,
                    MoveToPos = nil,
                    RotationX = math.random(-1, 1),
                    RotationY = math.random(-1, 1),
                    RotationZ = math.random(-1, 1),
                    Material = "Neon",
                    Color = Color3.new(1, 0, 0),
                    SoundID = 192410089,
                    SoundPitch = .55,
                    SoundVolume = 8,
                    UseBoomerangMath = true,
                    Boomerang = 0,
                    SizeBoomerang = 50
                }
            )
            Effect(
                {
                    Time = math.random(15, 35),
                    EffectType = "Box",
                    Size = Vector3.new(2, 2, 2),
                    Size2 = Vector3.new(5, 5, 5),
                    Transparency = 0,
                    Transparency2 = 1,
                    CFrame = Torsy.CFrame,
                    MoveToPos = nil,
                    RotationX = math.random(-1, 1),
                    RotationY = math.random(-1, 1),
                    RotationZ = math.random(-1, 1),
                    Material = "Neon",
                    Color = Color3.new(0, 0, 0),
                    SoundID = nil,
                    SoundPitch = nil,
                    SoundVolume = nil,
                    UseBoomerangMath = true,
                    Boomerang = 0,
                    SizeBoomerang = 50
                }
            )
            for i = 0, 2 do
                Effect(
                    {
                        Time = math.random(25, 50),
                        EffectType = "Round Slash",
                        Size = Vector3.new(0.1, 0.1, 0.1),
                        Size2 = Vector3.new(0.4, 0, 0.4),
                        Transparency = 0,
                        Transparency2 = 1,
                        CFrame = Torsy.CFrame *
                            CFrame.Angles(
                                math.rad(math.random(0, 360)),
                                math.rad(math.random(0, 360)),
                                math.rad(math.random(0, 360))
                            ),
                        MoveToPos = nil,
                        RotationX = math.random(-1, 1),
                        RotationY = math.random(-1, 1),
                        RotationZ = math.random(-1, 1),
                        Material = "Neon",
                        Color = Color3.new(1, 0, 0),
                        SoundID = nil,
                        SoundPitch = nil,
                        SoundVolume = nil,
                        UseBoomerangMath = true,
                        Boomerang = 0,
                        SizeBoomerang = 15
                    }
                )
                Effect(
                    {
                        Time = math.random(25, 50),
                        EffectType = "Round Slash",
                        Size = Vector3.new(0.1, 0.1, 0.1),
                        Size2 = Vector3.new(0.4, 0, 0.4),
                        Transparency = 0,
                        Transparency2 = 1,
                        CFrame = Torsy.CFrame *
                            CFrame.Angles(
                                math.rad(math.random(0, 360)),
                                math.rad(math.random(0, 360)),
                                math.rad(math.random(0, 360))
                            ),
                        MoveToPos = nil,
                        RotationX = math.random(-1, 1),
                        RotationY = math.random(-1, 1),
                        RotationZ = math.random(-1, 1),
                        Material = "Neon",
                        Color = Color3.new(0, 0, 0),
                        SoundID = nil,
                        SoundPitch = nil,
                        SoundVolume = nil,
                        UseBoomerangMath = true,
                        Boomerang = 0,
                        SizeBoomerang = 15
                    }
                )
            end
            SHAKECAM(Hole.Position, 43, 23, 23)
            SHAKECAM(Torsy.Position, 31, 15, 15)
        end
        for i = 0, 0.5, 0.075 do
            swait()
            RootJoint.C0 =
                Clerp(
                RootJoint.C0,
                rc0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-5), math.rad(0), math.rad(60)),
                1 / 3
            )
            Neck.C0 =
                Clerp(
                Neck.C0,
                nc0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(10), math.rad(0), math.rad(-60)),
                1 / 3
            )
            RightShoulder.C0 =
                Clerp(
                RightShoulder.C0,
                CFrame.new(1.5, 0.5, 0) * CFrame.Angles(math.rad(160), math.rad(-20), math.rad(60)) * rscp,
                1 / 3
            )
            LeftShoulder.C0 =
                Clerp(
                LeftShoulder.C0,
                CFrame.new(-1.5, 0.5, 0) * CFrame.Angles(math.rad(40), math.rad(5), math.rad(5)) * lscp,
                1 / 3
            )
            RightHip.C0 =
                Clerp(
                RightHip.C0,
                CFrame.new(1, -1, 0) * CFrame.Angles(math.rad(-5), math.rad(75), math.rad(0)) *
                    CFrame.Angles(math.rad(-4), math.rad(0), math.rad(0)),
                1 / 3
            )
            LeftHip.C0 =
                Clerp(
                LeftHip.C0,
                CFrame.new(-1, -1, 0) * CFrame.Angles(math.rad(0), math.rad(-65), math.rad(0)) *
                    CFrame.Angles(math.rad(-5), math.rad(0), math.rad(0)),
                1 / 3
            )
            GunJoint.C0 =
                Clerp(
                GunJoint.C0,
                CFrame.new(0.05, -1, -0.15) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0)),
                1 / 2
            )
        end
        GYRO:Remove()
    else
        AttackGyro()
        for i = 0, 0.5, 0.05 do
            swait()
            RootJoint.C0 =
                Clerp(
                RootJoint.C0,
                rc0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(30)),
                1 / 3
            )
            Neck.C0 =
                Clerp(
                Neck.C0,
                nc0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(15), math.rad(0), math.rad(-30)),
                1 / 3
            )
            RightShoulder.C0 =
                Clerp(
                RightShoulder.C0,
                CFrame.new(1.5, 0.5, 0) * CFrame.Angles(math.rad(90), math.rad(0), math.rad(30)) * rscp,
                1 / 3
            )
            LeftShoulder.C0 =
                Clerp(
                LeftShoulder.C0,
                CFrame.new(-1.5, 0.5, 0) * CFrame.Angles(math.rad(30), math.rad(0), math.rad(0)) * lscp,
                1 / 3
            )
            RightHip.C0 =
                Clerp(
                RightHip.C0,
                CFrame.new(1, -1, 0) * CFrame.Angles(math.rad(-5), math.rad(80), math.rad(0)) *
                    CFrame.Angles(math.rad(-4), math.rad(0), math.rad(0)),
                1 / 3
            )
            LeftHip.C0 =
                Clerp(
                LeftHip.C0,
                CFrame.new(-1, -1, 0) * CFrame.Angles(math.rad(0), math.rad(-70), math.rad(0)) *
                    CFrame.Angles(math.rad(-5), math.rad(0), math.rad(0)),
                1 / 3
            )
            GunJoint.C0 =
                Clerp(
                GunJoint.C0,
                CFrame.new(0.05, -1, -0.15) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0)),
                1 / 2
            )
        end
        mdmg(Mouse.Hit.p, 9)
        Effect(
            {
                Time = math.random(15, 35),
                EffectType = "Box",
                Size = Vector3.new(2, 2, 2),
                Size2 = Vector3.new(5, 5, 5),
                Transparency = 0,
                Transparency2 = 1,
                CFrame = Hole.CFrame,
                MoveToPos = nil,
                RotationX = math.random(-1, 1),
                RotationY = math.random(-1, 1),
                RotationZ = math.random(-1, 1),
                Material = "Neon",
                Color = Color3.new(1, 0, 0),
                SoundID = 642890855,
                SoundPitch = 0.45,
                SoundVolume = 6,
                UseBoomerangMath = true,
                Boomerang = 0,
                SizeBoomerang = 50
            }
        )
        Effect(
            {
                Time = math.random(15, 35),
                EffectType = "Box",
                Size = Vector3.new(2, 2, 2),
                Size2 = Vector3.new(5, 5, 5),
                Transparency = 0,
                Transparency2 = 1,
                CFrame = Hole.CFrame,
                MoveToPos = nil,
                RotationX = math.random(-1, 1),
                RotationY = math.random(-1, 1),
                RotationZ = math.random(-1, 1),
                Material = "Neon",
                Color = Color3.new(0, 0, 0),
                SoundID = nil,
                SoundPitch = nil,
                SoundVolume = nil,
                UseBoomerangMath = true,
                Boomerang = 0,
                SizeBoomerang = 50
            }
        )
        Lightning(
            Hole.Position,
            Mouse.Hit.p,
            15,
            3.5,
            BrickColor.new("Really black"),
            math.random(15, 35),
            1,
            3,
            0,
            true,
            55
        )
        Lightning(
            Hole.Position,
            Mouse.Hit.p,
            15,
            3.5,
            BrickColor.new("Really red"),
            math.random(15, 35),
            1,
            3,
            0,
            true,
            55
        )
        for i = 0, 2 do
            Effect(
                {
                    Time = math.random(25, 50),
                    EffectType = "Round Slash",
                    Size = Vector3.new(0.1, 0.1, 0.1),
                    Size2 = Vector3.new(0.4, 0, 0.4),
                    Transparency = 0,
                    Transparency2 = 1,
                    CFrame = Hole.CFrame *
                        CFrame.Angles(
                            math.rad(math.random(0, 360)),
                            math.rad(math.random(0, 360)),
                            math.rad(math.random(0, 360))
                        ),
                    MoveToPos = nil,
                    RotationX = math.random(-1, 1),
                    RotationY = math.random(-1, 1),
                    RotationZ = math.random(-1, 1),
                    Material = "Neon",
                    Color = Color3.new(1, 0, 0),
                    SoundID = nil,
                    SoundPitch = nil,
                    SoundVolume = nil,
                    UseBoomerangMath = true,
                    Boomerang = 0,
                    SizeBoomerang = 15
                }
            )
            Effect(
                {
                    Time = math.random(25, 50),
                    EffectType = "Round Slash",
                    Size = Vector3.new(0.1, 0.1, 0.1),
                    Size2 = Vector3.new(0.4, 0, 0.4),
                    Transparency = 0,
                    Transparency2 = 1,
                    CFrame = Hole.CFrame *
                        CFrame.Angles(
                            math.rad(math.random(0, 360)),
                            math.rad(math.random(0, 360)),
                            math.rad(math.random(0, 360))
                        ),
                    MoveToPos = nil,
                    RotationX = math.random(-1, 1),
                    RotationY = math.random(-1, 1),
                    RotationZ = math.random(-1, 1),
                    Material = "Neon",
                    Color = Color3.new(0, 0, 0),
                    SoundID = nil,
                    SoundPitch = nil,
                    SoundVolume = nil,
                    UseBoomerangMath = true,
                    Boomerang = 0,
                    SizeBoomerang = 15
                }
            )
        end
        Effect(
            {
                Time = math.random(15, 35),
                EffectType = "Box",
                Size = Vector3.new(2, 2, 2),
                Size2 = Vector3.new(5, 5, 5),
                Transparency = 0,
                Transparency2 = 1,
                CFrame = Mouse.Hit,
                MoveToPos = nil,
                RotationX = math.random(-1, 1),
                RotationY = math.random(-1, 1),
                RotationZ = math.random(-1, 1),
                Material = "Neon",
                Color = Color3.new(1, 0, 0),
                SoundID = 192410089,
                SoundPitch = .55,
                SoundVolume = 8,
                UseBoomerangMath = true,
                Boomerang = 0,
                SizeBoomerang = 50
            }
        )
        Effect(
            {
                Time = math.random(15, 35),
                EffectType = "Box",
                Size = Vector3.new(2, 2, 2),
                Size2 = Vector3.new(5, 5, 5),
                Transparency = 0,
                Transparency2 = 1,
                CFrame = Mouse.Hit,
                MoveToPos = nil,
                RotationX = math.random(-1, 1),
                RotationY = math.random(-1, 1),
                RotationZ = math.random(-1, 1),
                Material = "Neon",
                Color = Color3.new(0, 0, 0),
                SoundID = nil,
                SoundPitch = nil,
                SoundVolume = nil,
                UseBoomerangMath = true,
                Boomerang = 0,
                SizeBoomerang = 50
            }
        )
        for i = 0, 2 do
            Effect(
                {
                    Time = math.random(25, 50),
                    EffectType = "Round Slash",
                    Size = Vector3.new(0.1, 0.1, 0.1),
                    Size2 = Vector3.new(0.4, 0, 0.4),
                    Transparency = 0,
                    Transparency2 = 1,
                    CFrame = Mouse.Hit *
                        CFrame.Angles(
                            math.rad(math.random(0, 360)),
                            math.rad(math.random(0, 360)),
                            math.rad(math.random(0, 360))
                        ),
                    MoveToPos = nil,
                    RotationX = math.random(-1, 1),
                    RotationY = math.random(-1, 1),
                    RotationZ = math.random(-1, 1),
                    Material = "Neon",
                    Color = Color3.new(1, 0, 0),
                    SoundID = nil,
                    SoundPitch = nil,
                    SoundVolume = nil,
                    UseBoomerangMath = true,
                    Boomerang = 0,
                    SizeBoomerang = 15
                }
            )
            Effect(
                {
                    Time = math.random(25, 50),
                    EffectType = "Round Slash",
                    Size = Vector3.new(0.1, 0.1, 0.1),
                    Size2 = Vector3.new(0.4, 0, 0.4),
                    Transparency = 0,
                    Transparency2 = 1,
                    CFrame = Mouse.Hit *
                        CFrame.Angles(
                            math.rad(math.random(0, 360)),
                            math.rad(math.random(0, 360)),
                            math.rad(math.random(0, 360))
                        ),
                    MoveToPos = nil,
                    RotationX = math.random(-1, 1),
                    RotationY = math.random(-1, 1),
                    RotationZ = math.random(-1, 1),
                    Material = "Neon",
                    Color = Color3.new(0, 0, 0),
                    SoundID = nil,
                    SoundPitch = nil,
                    SoundVolume = nil,
                    UseBoomerangMath = true,
                    Boomerang = 0,
                    SizeBoomerang = 15
                }
            )
        end
        SHAKECAM(Hole.Position, 43, 23, 23)
        SHAKECAM(Mouse.Hit.p, 31, 15, 15)
        for i = 0, 0.5, 0.075 do
            swait()
            RootJoint.C0 =
                Clerp(
                RootJoint.C0,
                rc0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-5), math.rad(0), math.rad(60)),
                1 / 3
            )
            Neck.C0 =
                Clerp(
                Neck.C0,
                nc0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(10), math.rad(0), math.rad(-60)),
                1 / 3
            )
            RightShoulder.C0 =
                Clerp(
                RightShoulder.C0,
                CFrame.new(1.5, 0.5, 0) * CFrame.Angles(math.rad(160), math.rad(-20), math.rad(60)) * rscp,
                1 / 3
            )
            LeftShoulder.C0 =
                Clerp(
                LeftShoulder.C0,
                CFrame.new(-1.5, 0.5, 0) * CFrame.Angles(math.rad(40), math.rad(5), math.rad(5)) * lscp,
                1 / 3
            )
            RightHip.C0 =
                Clerp(
                RightHip.C0,
                CFrame.new(1, -1, 0) * CFrame.Angles(math.rad(-5), math.rad(75), math.rad(0)) *
                    CFrame.Angles(math.rad(-4), math.rad(0), math.rad(0)),
                1 / 3
            )
            LeftHip.C0 =
                Clerp(
                LeftHip.C0,
                CFrame.new(-1, -1, 0) * CFrame.Angles(math.rad(0), math.rad(-65), math.rad(0)) *
                    CFrame.Angles(math.rad(-5), math.rad(0), math.rad(0)),
                1 / 3
            )
            GunJoint.C0 =
                Clerp(
                GunJoint.C0,
                CFrame.new(0.05, -1, -0.15) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0)),
                1 / 2
            )
        end
    end
    walkspeed = 36
    attack = false
end

function MagicBalls()
    attack = true
    walkspeed = 12
    AttackGyro()
    local gBullet = CreatePart(3, Effects, "Neon", 0, 0, "Really red", "BullyFuck", Vector3.new(0, 0, 0))
    MakeForm(gBullet, "Ball")
    gBullet.CFrame = LeftArm.CFrame * CFrame.new(0, -1.5, 0)
    CreateSound(2785493, gBullet, 2, 0.8)
    for i = 0, 1.25, 0.025 do
        swait()
        SHAKECAM(gBullet.Position, 23, 17, 17)
        Effect(
            {
                Time = math.random(35, 55),
                EffectType = "Sphere",
                Size = Vector3.new(0.5, 0.5, 0.5),
                Size2 = Vector3.new(1, 1, 1),
                Transparency = 0,
                Transparency2 = 1,
                CFrame = LeftArm.CFrame * CFrame.new(0, -1.5, 0),
                MoveToPos = LeftArm.CFrame * CFrame.new(0, -1.5, 0) *
                    CFrame.new(math.random(-10, 10), math.random(-10, 10), math.random(-10, 10)).p,
                RotationX = nil,
                RotationY = nil,
                RotationZ = nil,
                Material = "Neon",
                Color = Color3.new(1, 0, 0),
                SoundID = nil,
                SoundPitch = nil,
                SoundVolume = nil,
                UseBoomerangMath = true,
                Boomerang = 50,
                SizeBoomerang = 50
            }
        )
        gBullet.Size = gBullet.Size * 1.085
        gBullet.CFrame = LeftArm.CFrame * CFrame.new(0, -1.5, 0)
        RootJoint.C0 =
            Clerp(
            RootJoint.C0,
            rc0 * CFrame.new(0, 0, 0 + 0.05 * math.cos(sine / 12)) *
                CFrame.Angles(math.rad(5), math.rad(0), math.rad(-50)),
            1 / 3
        )
        Neck.C0 =
            Clerp(
            Neck.C0,
            nc0 * CFrame.new(0, 0, 0 + ((1) - 1)) *
                CFrame.Angles(math.rad(-5 - 3 * math.cos(sine / 12)), math.rad(0), math.rad(50)),
            1 / 3
        )
        RightShoulder.C0 =
            Clerp(
            RightShoulder.C0,
            CFrame.new(1.5, 0.5, 0) *
                CFrame.Angles(math.rad(-62.5), math.rad(0 - 5 * math.cos(sine / 12)), math.rad(50)) *
                rscp,
            1 / 3
        )
        LeftShoulder.C0 =
            Clerp(
            LeftShoulder.C0,
            CFrame.new(-1.5, 0.5 + 0.1 * math.cos(sine / 12), -0) *
                CFrame.Angles(
                    math.rad(90 - 1.5 * math.cos(sine / 12)),
                    math.rad(0 - 6 * math.cos(sine / 12)),
                    math.rad(-50 - 6 * math.cos(sine / 12))
                ) *
                lscp,
            1 / 3
        )
        RightHip.C0 =
            Clerp(
            RightHip.C0,
            CFrame.new(1, -1 - 0.075 * math.cos(sine / 12), 0) * CFrame.Angles(math.rad(5), math.rad(80), math.rad(0)) *
                CFrame.Angles(math.rad(-4), math.rad(0), math.rad(0)),
            1 / 3
        )
        LeftHip.C0 =
            Clerp(
            LeftHip.C0,
            CFrame.new(-1, -1 - 0.075 * math.cos(sine / 12), 0) * CFrame.Angles(math.rad(0), math.rad(-70), math.rad(0)) *
                CFrame.Angles(math.rad(-5), math.rad(0), math.rad(0)),
            1 / 3
        )
        GunJoint.C0 =
            Clerp(
            GunJoint.C0,
            CFrame.new(0.05, -1, -0.15) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0)),
            1 / 2
        )
    end
    local bullets = {}
    for i = 1, math.random(27, 41) do
        swait()
        local Bullet = CreatePart(3, Effects, "Neon", 0, 0, "Really red", "BulletFuck", Vector3.new(0.6, 0.6, 0.6))
        MakeForm(Bullet, "Ball")
        Bullet.CFrame = gBullet.CFrame
        Effect(
            {
                Time = math.random(15, 20),
                EffectType = "Sphere",
                Size = Vector3.new(3, 3, 3) * math.random(0.05, 2),
                Size2 = Vector3.new(6, 6, 6) * math.random(0.05, 2),
                Transparency = 0.4,
                Transparency2 = 1,
                CFrame = Bullet.CFrame,
                MoveToPos = nil,
                RotationX = nil,
                RotationY = nil,
                RotationZ = nil,
                Material = "Neon",
                Color = Color3.new(1, 0, 0),
                SoundID = nil,
                SoundPitch = nil,
                SoundVolume = nil,
                UseBoomerangMath = true,
                Boomerang = 0,
                SizeBoomerang = 25
            }
        )
        SHAKECAM(Bullet.Position, 11, 5, 5)
        table.insert(bullets, Bullet)
    end
    for b = 1, #bullets do
        swait(.25)
        local part, pos =
            rayCast(
            LeftArm.CFrame * CFrame.new(0, -1.5, 0).p,
            ((Mouse.Hit.p + Vector3.new(math.random(-15, 15), math.random(-3, 3), math.random(-15, 15))) -
                LeftArm.CFrame * CFrame.new(0, -1.5, 0).p),
            500,
            Character
        )
        coroutine.resume(
            coroutine.create(
                function()
                    FireArc(bullets[b], pos, math.random(17, 31), math.random(9, 15), false)
                    Effect(
                        {
                            Time = math.random(25, 35),
                            EffectType = "Sphere",
                            Size = Vector3.new(0.6, 0.6, 0.6),
                            Size2 = Vector3.new(1.6, 1.6, 1.6),
                            Transparency = 0,
                            Transparency2 = 1,
                            CFrame = bullets[b].CFrame,
                            MoveToPos = nil,
                            RotationX = nil,
                            RotationY = nil,
                            RotationZ = nil,
                            Material = "Neon",
                            Color = Color3.new(1, 0, 0),
                            SoundID = nil,
                            SoundPitch = nil,
                            SoundVolume = nil,
                            UseBoomerangMath = true,
                            Boomerang = 0,
                            SizeBoomerang = 25
                        }
                    )
                    swait(math.random(50, 65))
                    mdmg(bullets[b].Position, 5)
                    for i = 1, 3 do
                        Effect(
                            {
                                Time = math.random(45, 65),
                                EffectType = "Sphere",
                                Size = Vector3.new(0.6, 6, 0.6) * math.random(1.05, 1.25),
                                Size2 = Vector3.new(1.6, 16, 1.6) * math.random(1.05, 1.25),
                                Transparency = 0,
                                Transparency2 = 1,
                                CFrame = bullets[b].CFrame *
                                    CFrame.Angles(
                                        math.rad(math.random(0, 360)),
                                        math.rad(math.random(0, 360)),
                                        math.rad(math.random(0, 360))
                                    ),
                                MoveToPos = nil,
                                RotationX = nil,
                                RotationY = nil,
                                RotationZ = nil,
                                Material = "Neon",
                                Color = Color3.new(1, 0, 0),
                                SoundID = nil,
                                SoundPitch = nil,
                                SoundVolume = nil,
                                UseBoomerangMath = true,
                                Boomerang = 20,
                                SizeBoomerang = 35
                            }
                        )
                    end
                    Effect(
                        {
                            Time = math.random(45, 65),
                            EffectType = "Sphere",
                            Size = Vector3.new(1, 1, 1),
                            Size2 = Vector3.new(12, 12, 12),
                            Transparency = 0.6,
                            Transparency2 = 1,
                            CFrame = bullets[b].CFrame,
                            MoveToPos = nil,
                            RotationX = nil,
                            RotationY = nil,
                            RotationZ = nil,
                            Material = "Neon",
                            Color = Color3.new(1, 0, 0),
                            SoundID = nil,
                            SoundPitch = nil,
                            SoundVolume = nil,
                            UseBoomerangMath = true,
                            Boomerang = 0,
                            SizeBoomerang = 55
                        }
                    )
                    for i = 0, 10 do
                        swait()
                        bullets[b].Transparency = bullets[b].Transparency + 0.1
                    end
                    SHAKECAM(bullets[b].Position, 29, 11, 11)
                    CreateSound(168513088, bullets[b], 3.5, 1.1, false)
                    bullets[b]:Destroy()
                end
            )
        )
    end
    for i = 0, 10 do
        swait()
        gBullet.Transparency = gBullet.Transparency + 0.1
    end
    gBullet:Destroy()
    walkspeed = 36
    attack = false
end

local Grabbed = false
function hedshoot()
    attack = true
    walkspeed = 26
    CreateSound(235097614, RootPart, 6, 1.5, false)
    for i = 0, 0.5, 0.05 do
        swait()
        RootJoint.C0 =
            Clerp(
            RootJoint.C0,
            rc0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(-60)),
            1 / 3
        )
        Neck.C0 =
            Clerp(Neck.C0, nc0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(60)), 1 / 3)
        RightShoulder.C0 =
            Clerp(
            RightShoulder.C0,
            CFrame.new(1.5, 0.5, 0) * CFrame.Angles(math.rad(90), math.rad(0), math.rad(-60)) * rscp,
            1 / 3
        )
        LeftShoulder.C0 =
            Clerp(
            LeftShoulder.C0,
            CFrame.new(-1.5, 0.5, 0) * CFrame.Angles(math.rad(40), math.rad(5), math.rad(5)) * lscp,
            1 / 3
        )
        RightHip.C0 =
            Clerp(
            RightHip.C0,
            CFrame.new(1, -1, 0) * CFrame.Angles(math.rad(-5), math.rad(75), math.rad(0)) *
                CFrame.Angles(math.rad(-4), math.rad(0), math.rad(0)),
            1 / 3
        )
        LeftHip.C0 =
            Clerp(
            LeftHip.C0,
            CFrame.new(-1, -1, 0) * CFrame.Angles(math.rad(0), math.rad(-65), math.rad(0)) *
                CFrame.Angles(math.rad(-5), math.rad(0), math.rad(0)),
            1 / 3
        )
        GunJoint.C0 =
            Clerp(
            GunJoint.C0,
            CFrame.new(0.05, -1, -0.15) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0)),
            1 / 2
        )
    end
    mdmg(RootPart.Position, 14)
    Effect(
        {
            Time = math.random(15, 35),
            EffectType = "Box",
            Size = Vector3.new(2, 2, 2),
            Size2 = Vector3.new(5, 5, 5),
            Transparency = 0,
            Transparency2 = 1,
            CFrame = RootPart.CFrame,
            MoveToPos = nil,
            RotationX = math.random(-1, 1),
            RotationY = math.random(-1, 1),
            RotationZ = math.random(-1, 1),
            Material = "Neon",
            Color = Color3.new(1, 0, 0),
            SoundID = 642890855,
            SoundPitch = 0.45,
            SoundVolume = 6,
            UseBoomerangMath = true,
            Boomerang = 0,
            SizeBoomerang = 50
        }
    )
    Effect(
        {
            Time = math.random(15, 35),
            EffectType = "Box",
            Size = Vector3.new(2, 2, 2),
            Size2 = Vector3.new(5, 5, 5),
            Transparency = 0,
            Transparency2 = 1,
            CFrame = RootPart.CFrame,
            MoveToPos = nil,
            RotationX = math.random(-1, 1),
            RotationY = math.random(-1, 1),
            RotationZ = math.random(-1, 1),
            Material = "Neon",
            Color = Color3.new(0, 0, 0),
            SoundID = nil,
            SoundPitch = nil,
            SoundVolume = nil,
            UseBoomerangMath = true,
            Boomerang = 0,
            SizeBoomerang = 50
        }
    )
    Effect(
        {
            Time = math.random(25, 45),
            EffectType = "Sphere",
            Size = Vector3.new(2, 100, 2),
            Size2 = Vector3.new(6, 100, 6),
            Transparency = 0,
            Transparency2 = 1,
            CFrame = RootPart.CFrame * CFrame.new(math.random(-1, 1), math.random(-1, 1), -50) *
                CFrame.Angles(math.rad(math.random(89, 91)), math.rad(math.random(-1, 1)), math.rad(math.random(-1, 1))),
            MoveToPos = nil,
            RotationX = nil,
            RotationY = nil,
            RotationZ = nil,
            Material = "Neon",
            Color = Color3.new(1, 0, 0),
            SoundID = nil,
            SoundPitch = nil,
            SoundVolume = nil,
            UseBoomerangMath = true,
            Boomerang = 0,
            SizeBoomerang = 45
        }
    )
    Effect(
        {
            Time = math.random(25, 45),
            EffectType = "Sphere",
            Size = Vector3.new(3, 100, 3),
            Size2 = Vector3.new(9, 100, 9),
            Transparency = 0,
            Transparency2 = 1,
            CFrame = RootPart.CFrame * CFrame.new(math.random(-1, 1), math.random(-1, 1), -50) *
                CFrame.Angles(math.rad(math.random(89, 91)), math.rad(math.random(-1, 1)), math.rad(math.random(-1, 1))),
            MoveToPos = nil,
            RotationX = nil,
            RotationY = nil,
            RotationZ = nil,
            Material = "Neon",
            Color = Color3.new(0, 0, 0),
            SoundID = nil,
            SoundPitch = nil,
            SoundVolume = nil,
            UseBoomerangMath = true,
            Boomerang = 0,
            SizeBoomerang = 45
        }
    )
    SHAKECAM(RootPart.Position, 14, 11, 18)
    for i = 1, 4 do
        RootPart.CFrame = RootPart.CFrame * CFrame.new(0, 0, -25)
        mdmg(RootPart.Position, 14)
        SHAKECAM(RootPart.Position, 14, 11, 18)
        Lightning(
            RootPart.CFrame * CFrame.new(math.random(-2.5, 2.5), math.random(-5, 5), math.random(-15, 15)).p,
            RootPart.CFrame * CFrame.new(math.random(-2.5, 2.5), math.random(-5, 5), math.random(-15, 15)).p,
            6,
            25,
            BrickColor.new("Really black"),
            math.random(30, 45),
            0.5,
            1.5,
            0,
            true,
            60
        )
        Lightning(
            RootPart.CFrame * CFrame.new(math.random(-2.5, 2.5), math.random(-5, 5), math.random(-15, 15)).p,
            RootPart.CFrame * CFrame.new(math.random(-2.5, 2.5), math.random(-5, 5), math.random(-15, 15)).p,
            6,
            25,
            BrickColor.new("Really red"),
            math.random(30, 45),
            0.5,
            1.5,
            0,
            true,
            60
        )
    end
    Effect(
        {
            Time = math.random(15, 35),
            EffectType = "Box",
            Size = Vector3.new(2, 2, 2),
            Size2 = Vector3.new(5, 5, 5),
            Transparency = 0,
            Transparency2 = 1,
            CFrame = RootPart.CFrame,
            MoveToPos = nil,
            RotationX = math.random(-1, 1),
            RotationY = math.random(-1, 1),
            RotationZ = math.random(-1, 1),
            Material = "Neon",
            Color = Color3.new(1, 0, 0),
            SoundID = nil,
            SoundPitch = nil,
            SoundVolume = nil,
            UseBoomerangMath = true,
            Boomerang = 0,
            SizeBoomerang = 50
        }
    )
    Effect(
        {
            Time = math.random(15, 35),
            EffectType = "Box",
            Size = Vector3.new(2, 2, 2),
            Size2 = Vector3.new(5, 5, 5),
            Transparency = 0,
            Transparency2 = 1,
            CFrame = RootPart.CFrame,
            MoveToPos = nil,
            RotationX = math.random(-1, 1),
            RotationY = math.random(-1, 1),
            RotationZ = math.random(-1, 1),
            Material = "Neon",
            Color = Color3.new(0, 0, 0),
            SoundID = nil,
            SoundPitch = nil,
            SoundVolume = nil,
            UseBoomerangMath = true,
            Boomerang = 0,
            SizeBoomerang = 50
        }
    )
    for i = 0, 0.5, 0.1 do
        swait()
        RootJoint.C0 =
            Clerp(
            RootJoint.C0,
            rc0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(90)),
            1 / 3
        )
        Neck.C0 =
            Clerp(Neck.C0, nc0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(-90)), 1 / 3)
        RightShoulder.C0 =
            Clerp(
            RightShoulder.C0,
            CFrame.new(1.5, 0.5, 0) * CFrame.Angles(math.rad(90), math.rad(0), math.rad(90)) * rscp,
            1 / 3
        )
        LeftShoulder.C0 =
            Clerp(
            LeftShoulder.C0,
            CFrame.new(-1.5, 0.5, 0) * CFrame.Angles(math.rad(40), math.rad(5), math.rad(5)) * lscp,
            1 / 3
        )
        RightHip.C0 =
            Clerp(
            RightHip.C0,
            CFrame.new(1, -1, 0) * CFrame.Angles(math.rad(-5), math.rad(75), math.rad(0)) *
                CFrame.Angles(math.rad(-4), math.rad(0), math.rad(0)),
            1 / 3
        )
        LeftHip.C0 =
            Clerp(
            LeftHip.C0,
            CFrame.new(-1, -1, 0) * CFrame.Angles(math.rad(0), math.rad(-65), math.rad(0)) *
                CFrame.Angles(math.rad(-5), math.rad(0), math.rad(0)),
            1 / 3
        )
        GunJoint.C0 =
            Clerp(
            GunJoint.C0,
            CFrame.new(0.05, -1, -0.15) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0)),
            1 / 2
        )
    end
    attack = false
    walkspeed = 36
end

function moarblood()
    attack = true
    walkspeed = 22
    if targetted then
        local h = targetted:FindFirstChild("Humanoid")
        if h then
            local torsy =
                h.Parent:FindFirstChild("Head") or h.Parent:FindFirstChild("HumanoidRootPart") or
                h.Parent:FindFirstChild("Torso") or
                h.Parent:FindFirstChild("UpperToso")
            if torsy then
                local GYRO = Instance.new("BodyGyro", RootPart)
                GYRO.D = 25
                GYRO.P = 20000
                GYRO.MaxTorque = Vector3.new(0, 4000000, 0)
                GYRO.CFrame = CFrame.new(RootPart.Position, targetted.Head.Position)
                for i = 0, 0.75, 0.075 do
                    swait()
                    RootJoint.C0 =
                        Clerp(
                        RootJoint.C0,
                        rc0 * CFrame.new(0, 0, 0 + 0.05 * math.cos(sine / 12)) *
                            CFrame.Angles(math.rad(5), math.rad(0), math.rad(-30)),
                        1 / 3
                    )
                    Neck.C0 =
                        Clerp(
                        Neck.C0,
                        nc0 * CFrame.new(0, 0, 0 + ((1) - 1)) *
                            CFrame.Angles(math.rad(-5 - 3 * math.cos(sine / 12)), math.rad(0), math.rad(30)),
                        1 / 3
                    )
                    RightShoulder.C0 =
                        Clerp(
                        RightShoulder.C0,
                        CFrame.new(1.5, 0.5, 0) *
                            CFrame.Angles(math.rad(-62.5), math.rad(0 - 5 * math.cos(sine / 12)), math.rad(30)) *
                            rscp,
                        1 / 3
                    )
                    LeftShoulder.C0 =
                        Clerp(
                        LeftShoulder.C0,
                        CFrame.new(-1.5, 0.5 + 0.1 * math.cos(sine / 12), -0) *
                            CFrame.Angles(
                                math.rad(90 - 1.5 * math.cos(sine / 12)),
                                math.rad(0 - 6 * math.cos(sine / 12)),
                                math.rad(-30 - 6 * math.cos(sine / 12))
                            ) *
                            lscp,
                        1 / 3
                    )
                    RightHip.C0 =
                        Clerp(
                        RightHip.C0,
                        CFrame.new(1, -1 - 0.075 * math.cos(sine / 12), 0) *
                            CFrame.Angles(math.rad(5), math.rad(80), math.rad(0)) *
                            CFrame.Angles(math.rad(-4), math.rad(0), math.rad(0)),
                        1 / 3
                    )
                    LeftHip.C0 =
                        Clerp(
                        LeftHip.C0,
                        CFrame.new(-1, -1 - 0.075 * math.cos(sine / 12), 0) *
                            CFrame.Angles(math.rad(0), math.rad(-70), math.rad(0)) *
                            CFrame.Angles(math.rad(-5), math.rad(0), math.rad(0)),
                        1 / 3
                    )
                    GunJoint.C0 =
                        Clerp(
                        GunJoint.C0,
                        CFrame.new(0.05, -1, -0.15) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0)),
                        1 / 2
                    )
                end
                dmg(targetted)
                Effect(
                    {
                        Time = math.random(15, 35),
                        EffectType = "Box",
                        Size = Vector3.new(2, 2, 2),
                        Size2 = Vector3.new(5, 5, 5),
                        Transparency = 0,
                        Transparency2 = 1,
                        CFrame = LeftArm.CFrame * CFrame.new(0, -1.5, 0),
                        MoveToPos = nil,
                        RotationX = math.random(-1, 1),
                        RotationY = math.random(-1, 1),
                        RotationZ = math.random(-1, 1),
                        Material = "Neon",
                        Color = Color3.new(1, 0, 0),
                        SoundID = 199978087,
                        SoundPitch = 0.65,
                        SoundVolume = 6,
                        UseBoomerangMath = true,
                        Boomerang = 0,
                        SizeBoomerang = 50
                    }
                )
                Effect(
                    {
                        Time = math.random(15, 35),
                        EffectType = "Box",
                        Size = Vector3.new(2, 2, 2),
                        Size2 = Vector3.new(5, 5, 5),
                        Transparency = 0,
                        Transparency2 = 1,
                        CFrame = LeftArm.CFrame * CFrame.new(0, -1.5, 0),
                        MoveToPos = nil,
                        RotationX = math.random(-1, 1),
                        RotationY = math.random(-1, 1),
                        RotationZ = math.random(-1, 1),
                        Material = "Neon",
                        Color = Color3.new(0, 0, 0),
                        SoundID = nil,
                        SoundPitch = nil,
                        SoundVolume = nil,
                        UseBoomerangMath = true,
                        Boomerang = 0,
                        SizeBoomerang = 50
                    }
                )
                Lightning(
                    LeftArm.CFrame * CFrame.new(0, -1.5, 0).p,
                    targetted.Head.Position,
                    7,
                    1.75,
                    BrickColor.new("Really black"),
                    math.random(15, 35),
                    0.5,
                    1.5,
                    0,
                    true,
                    55
                )
                Lightning(
                    LeftArm.CFrame * CFrame.new(0, -1.5, 0).p,
                    targetted.Head.Position,
                    7,
                    1.75,
                    BrickColor.new("Really red"),
                    math.random(15, 35),
                    0.5,
                    1.5,
                    0,
                    true,
                    55
                )
                Effect(
                    {
                        Time = math.random(15, 35),
                        EffectType = "Box",
                        Size = Vector3.new(2, 2, 2),
                        Size2 = Vector3.new(5, 5, 5),
                        Transparency = 0,
                        Transparency2 = 1,
                        CFrame = targetted.Head.CFrame,
                        MoveToPos = nil,
                        RotationX = math.random(-1, 1),
                        RotationY = math.random(-1, 1),
                        RotationZ = math.random(-1, 1),
                        Material = "Neon",
                        Color = Color3.new(1, 0, 0),
                        SoundID = nil,
                        SoundPitch = nil,
                        SoundVolume = nil,
                        UseBoomerangMath = true,
                        Boomerang = 0,
                        SizeBoomerang = 50
                    }
                )
                Effect(
                    {
                        Time = math.random(15, 35),
                        EffectType = "Box",
                        Size = Vector3.new(2, 2, 2),
                        Size2 = Vector3.new(5, 5, 5),
                        Transparency = 0,
                        Transparency2 = 1,
                        CFrame = targetted.Head.CFrame,
                        MoveToPos = nil,
                        RotationX = math.random(-1, 1),
                        RotationY = math.random(-1, 1),
                        RotationZ = math.random(-1, 1),
                        Material = "Neon",
                        Color = Color3.new(0, 0, 0),
                        SoundID = nil,
                        SoundPitch = nil,
                        SoundVolume = nil,
                        UseBoomerangMath = true,
                        Boomerang = 0,
                        SizeBoomerang = 50
                    }
                )
                SHAKECAM(LeftArm.Position, 35, 19, 25)
                SHAKECAM(torsy.Position, 27, 23, 14)
                for i = 0, 0.75, 0.1 do
                    swait()
                    RootJoint.C0 =
                        Clerp(
                        RootJoint.C0,
                        rc0 * CFrame.new(0, 0, 0 + 0.05 * math.cos(sine / 12)) *
                            CFrame.Angles(math.rad(5), math.rad(0), math.rad(-20)),
                        1 / 3
                    )
                    Neck.C0 =
                        Clerp(
                        Neck.C0,
                        nc0 * CFrame.new(0, 0, 0 + ((1) - 1)) *
                            CFrame.Angles(math.rad(-5 - 3 * math.cos(sine / 12)), math.rad(0), math.rad(20)),
                        1 / 3
                    )
                    RightShoulder.C0 =
                        Clerp(
                        RightShoulder.C0,
                        CFrame.new(1.5, 0.5, 0) *
                            CFrame.Angles(math.rad(-62.5), math.rad(0 - 5 * math.cos(sine / 12)), math.rad(20)) *
                            rscp,
                        1 / 3
                    )
                    LeftShoulder.C0 =
                        Clerp(
                        LeftShoulder.C0,
                        CFrame.new(-1.5, 0.5 + 0.1 * math.cos(sine / 12), -0) *
                            CFrame.Angles(
                                math.rad(115 - 1.5 * math.cos(sine / 12)),
                                math.rad(0 - 6 * math.cos(sine / 12)),
                                math.rad(-20 - 6 * math.cos(sine / 12))
                            ) *
                            lscp,
                        1 / 3
                    )
                    RightHip.C0 =
                        Clerp(
                        RightHip.C0,
                        CFrame.new(1, -1 - 0.075 * math.cos(sine / 12), 0) *
                            CFrame.Angles(math.rad(5), math.rad(80), math.rad(0)) *
                            CFrame.Angles(math.rad(-4), math.rad(0), math.rad(0)),
                        1 / 3
                    )
                    LeftHip.C0 =
                        Clerp(
                        LeftHip.C0,
                        CFrame.new(-1, -1 - 0.075 * math.cos(sine / 12), 0) *
                            CFrame.Angles(math.rad(0), math.rad(-70), math.rad(0)) *
                            CFrame.Angles(math.rad(-5), math.rad(0), math.rad(0)),
                        1 / 3
                    )
                    GunJoint.C0 =
                        Clerp(
                        GunJoint.C0,
                        CFrame.new(0.05, -1, -0.15) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0)),
                        1 / 2
                    )
                end
                GYRO:Remove()
            end
        end
    else
        if Mouse.Target ~= nil then
            local h = FindHumanoid(Mouse.Target)
            if h then
                local torsy =
                    h.Parent:FindFirstChild("Head") or h.Parent:FindFirstChild("HumanoidRootPart") or
                    h.Parent:FindFirstChild("Torso") or
                    h.Parent:FindFirstChild("UpperToso")
                if torsy and 100 >= (torsy.Position - RootPart.Position).Magnitude then
                    local GYRO = Instance.new("BodyGyro", RootPart)
                    GYRO.D = 25
                    GYRO.P = 20000
                    GYRO.MaxTorque = Vector3.new(0, 4000000, 0)
                    GYRO.CFrame = CFrame.new(RootPart.Position, h.Parent.Head.Position)
                    for i = 0, 0.75, 0.075 do
                        swait()
                        RootJoint.C0 =
                            Clerp(
                            RootJoint.C0,
                            rc0 * CFrame.new(0, 0, 0 + 0.05 * math.cos(sine / 12)) *
                                CFrame.Angles(math.rad(5), math.rad(0), math.rad(-30)),
                            1 / 3
                        )
                        Neck.C0 =
                            Clerp(
                            Neck.C0,
                            nc0 * CFrame.new(0, 0, 0 + ((1) - 1)) *
                                CFrame.Angles(math.rad(-5 - 3 * math.cos(sine / 12)), math.rad(0), math.rad(30)),
                            1 / 3
                        )
                        RightShoulder.C0 =
                            Clerp(
                            RightShoulder.C0,
                            CFrame.new(1.5, 0.5, 0) *
                                CFrame.Angles(math.rad(-62.5), math.rad(0 - 5 * math.cos(sine / 12)), math.rad(30)) *
                                rscp,
                            1 / 3
                        )
                        LeftShoulder.C0 =
                            Clerp(
                            LeftShoulder.C0,
                            CFrame.new(-1.5, 0.5 + 0.1 * math.cos(sine / 12), -0) *
                                CFrame.Angles(
                                    math.rad(85 - 1.5 * math.cos(sine / 12)),
                                    math.rad(0 - 6 * math.cos(sine / 12)),
                                    math.rad(-30 - 6 * math.cos(sine / 12))
                                ) *
                                lscp,
                            1 / 3
                        )
                        RightHip.C0 =
                            Clerp(
                            RightHip.C0,
                            CFrame.new(1, -1 - 0.075 * math.cos(sine / 12), 0) *
                                CFrame.Angles(math.rad(5), math.rad(80), math.rad(0)) *
                                CFrame.Angles(math.rad(-4), math.rad(0), math.rad(0)),
                            1 / 3
                        )
                        LeftHip.C0 =
                            Clerp(
                            LeftHip.C0,
                            CFrame.new(-1, -1 - 0.075 * math.cos(sine / 12), 0) *
                                CFrame.Angles(math.rad(0), math.rad(-70), math.rad(0)) *
                                CFrame.Angles(math.rad(-5), math.rad(0), math.rad(0)),
                            1 / 3
                        )
                        GunJoint.C0 =
                            Clerp(
                            GunJoint.C0,
                            CFrame.new(0.05, -1, -0.15) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0)),
                            1 / 2
                        )
                    end
                    dmg(h.Parent)
                    Effect(
                        {
                            Time = math.random(15, 35),
                            EffectType = "Box",
                            Size = Vector3.new(2, 2, 2),
                            Size2 = Vector3.new(5, 5, 5),
                            Transparency = 0,
                            Transparency2 = 1,
                            CFrame = LeftArm.CFrame * CFrame.new(0, -1.5, 0),
                            MoveToPos = nil,
                            RotationX = math.random(-1, 1),
                            RotationY = math.random(-1, 1),
                            RotationZ = math.random(-1, 1),
                            Material = "Neon",
                            Color = Color3.new(1, 0, 0),
                            SoundID = 199978087,
                            SoundPitch = 0.65,
                            SoundVolume = 6,
                            UseBoomerangMath = true,
                            Boomerang = 0,
                            SizeBoomerang = 50
                        }
                    )
                    Effect(
                        {
                            Time = math.random(15, 35),
                            EffectType = "Box",
                            Size = Vector3.new(2, 2, 2),
                            Size2 = Vector3.new(5, 5, 5),
                            Transparency = 0,
                            Transparency2 = 1,
                            CFrame = LeftArm.CFrame * CFrame.new(0, -1.5, 0),
                            MoveToPos = nil,
                            RotationX = math.random(-1, 1),
                            RotationY = math.random(-1, 1),
                            RotationZ = math.random(-1, 1),
                            Material = "Neon",
                            Color = Color3.new(0, 0, 0),
                            SoundID = nil,
                            SoundPitch = nil,
                            SoundVolume = nil,
                            UseBoomerangMath = true,
                            Boomerang = 0,
                            SizeBoomerang = 50
                        }
                    )
                    Lightning(
                        LeftArm.CFrame * CFrame.new(0, -1.5, 0).p,
                        h.Parent.Head.Position,
                        7,
                        1.75,
                        BrickColor.new("Really black"),
                        math.random(15, 35),
                        0.5,
                        1.5,
                        0,
                        true,
                        55
                    )
                    Lightning(
                        LeftArm.CFrame * CFrame.new(0, -1.5, 0).p,
                        h.Parent.Head.Position,
                        7,
                        1.75,
                        BrickColor.new("Really red"),
                        math.random(15, 35),
                        0.5,
                        1.5,
                        0,
                        true,
                        55
                    )
                    Effect(
                        {
                            Time = math.random(15, 35),
                            EffectType = "Box",
                            Size = Vector3.new(2, 2, 2),
                            Size2 = Vector3.new(5, 5, 5),
                            Transparency = 0,
                            Transparency2 = 1,
                            CFrame = h.Parent.Head.CFrame,
                            MoveToPos = nil,
                            RotationX = math.random(-1, 1),
                            RotationY = math.random(-1, 1),
                            RotationZ = math.random(-1, 1),
                            Material = "Neon",
                            Color = Color3.new(1, 0, 0),
                            SoundID = nil,
                            SoundPitch = nil,
                            SoundVolume = nil,
                            UseBoomerangMath = true,
                            Boomerang = 0,
                            SizeBoomerang = 50
                        }
                    )
                    Effect(
                        {
                            Time = math.random(15, 35),
                            EffectType = "Box",
                            Size = Vector3.new(2, 2, 2),
                            Size2 = Vector3.new(5, 5, 5),
                            Transparency = 0,
                            Transparency2 = 1,
                            CFrame = h.Parent.Head.CFrame,
                            MoveToPos = nil,
                            RotationX = math.random(-1, 1),
                            RotationY = math.random(-1, 1),
                            RotationZ = math.random(-1, 1),
                            Material = "Neon",
                            Color = Color3.new(0, 0, 0),
                            SoundID = nil,
                            SoundPitch = nil,
                            SoundVolume = nil,
                            UseBoomerangMath = true,
                            Boomerang = 0,
                            SizeBoomerang = 50
                        }
                    )
                    SHAKECAM(LeftArm.Position, 35, 19, 25)
                    SHAKECAM(torsy.Position, 27, 23, 14)
                    for i = 0, 0.75, 0.1 do
                        swait()
                        RootJoint.C0 =
                            Clerp(
                            RootJoint.C0,
                            rc0 * CFrame.new(0, 0, 0 + 0.05 * math.cos(sine / 12)) *
                                CFrame.Angles(math.rad(5), math.rad(0), math.rad(-20)),
                            1 / 3
                        )
                        Neck.C0 =
                            Clerp(
                            Neck.C0,
                            nc0 * CFrame.new(0, 0, 0 + ((1) - 1)) *
                                CFrame.Angles(math.rad(-5 - 3 * math.cos(sine / 12)), math.rad(0), math.rad(20)),
                            1 / 3
                        )
                        RightShoulder.C0 =
                            Clerp(
                            RightShoulder.C0,
                            CFrame.new(1.5, 0.5, 0) *
                                CFrame.Angles(math.rad(-62.5), math.rad(0 - 5 * math.cos(sine / 12)), math.rad(20)) *
                                rscp,
                            1 / 3
                        )
                        LeftShoulder.C0 =
                            Clerp(
                            LeftShoulder.C0,
                            CFrame.new(-1.5, 0.5 + 0.1 * math.cos(sine / 12), -0) *
                                CFrame.Angles(
                                    math.rad(115 - 1.5 * math.cos(sine / 12)),
                                    math.rad(0 - 6 * math.cos(sine / 12)),
                                    math.rad(-20 - 6 * math.cos(sine / 12))
                                ) *
                                lscp,
                            1 / 3
                        )
                        RightHip.C0 =
                            Clerp(
                            RightHip.C0,
                            CFrame.new(1, -1 - 0.075 * math.cos(sine / 12), 0) *
                                CFrame.Angles(math.rad(5), math.rad(80), math.rad(0)) *
                                CFrame.Angles(math.rad(-4), math.rad(0), math.rad(0)),
                            1 / 3
                        )
                        LeftHip.C0 =
                            Clerp(
                            LeftHip.C0,
                            CFrame.new(-1, -1 - 0.075 * math.cos(sine / 12), 0) *
                                CFrame.Angles(math.rad(0), math.rad(-70), math.rad(0)) *
                                CFrame.Angles(math.rad(-5), math.rad(0), math.rad(0)),
                            1 / 3
                        )
                        GunJoint.C0 =
                            Clerp(
                            GunJoint.C0,
                            CFrame.new(0.05, -1, -0.15) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0)),
                            1 / 2
                        )
                    end
                    GYRO:Remove()
                end
            end
        end
    end
    attack = false
    walkspeed = 36
end

function painlessrain()
    attack = true
    walkspeed = 18
    coroutine.wrap(
        function()
            for i = 0, 2 do
                wait(.2)
                CreateSound(199145095, GUN, 6, 1)
            end
        end
    )()
    for i = 0, 2, 0.1 do
        swait()
        RootJoint.C0 =
            Clerp(
            RootJoint.C0,
            rc0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(-10)),
            1 / 3
        )
        Neck.C0 =
            Clerp(
            Neck.C0,
            nc0 * CFrame.new(0, 0, 0 + ((1) - 1)) * CFrame.Angles(math.rad(25), math.rad(0), math.rad(-20)),
            1 / 3
        )
        RightShoulder.C0 =
            Clerp(
            RightShoulder.C0,
            CFrame.new(1.5, 0.5, 0) * CFrame.Angles(math.rad(35), math.rad(-35), math.rad(20)) * rscp,
            1 / 3
        )
        LeftShoulder.C0 =
            Clerp(
            LeftShoulder.C0,
            CFrame.new(-1.5, 0.5, 0) * CFrame.Angles(math.rad(-20), math.rad(-5), math.rad(-10)) * lscp,
            1 / 3
        )
        RightHip.C0 =
            Clerp(
            RightHip.C0,
            CFrame.new(1, -1, 0) * CFrame.Angles(math.rad(-5), math.rad(80), math.rad(0)) *
                CFrame.Angles(math.rad(-4), math.rad(0), math.rad(0)),
            1 / 3
        )
        LeftHip.C0 =
            Clerp(
            LeftHip.C0,
            CFrame.new(-1, -1, 0) * CFrame.Angles(math.rad(0), math.rad(-70), math.rad(0)) *
                CFrame.Angles(math.rad(-5), math.rad(0), math.rad(0)),
            1 / 3
        )
        GunJoint.C0 =
            Clerp(
            GunJoint.C0,
            CFrame.new(0.05, -1, -0.15) * CFrame.Angles(math.rad(doe * 22), math.rad(0), math.rad(0)),
            1 / 2
        )
    end
    for i = 0, 1.5, 0.1 do
        swait()
        RootJoint.C0 =
            Clerp(
            RootJoint.C0,
            rc0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(-5)),
            1 / 3
        )
        Neck.C0 =
            Clerp(
            Neck.C0,
            nc0 * CFrame.new(0, 0, 0 + ((1) - 1)) * CFrame.Angles(math.rad(15), math.rad(0), math.rad(-5)),
            1 / 3
        )
        RightShoulder.C0 =
            Clerp(
            RightShoulder.C0,
            CFrame.new(1.5, 0.5, 0) * CFrame.Angles(math.rad(175), math.rad(-10), math.rad(10)) * rscp,
            1 / 3
        )
        LeftShoulder.C0 =
            Clerp(
            LeftShoulder.C0,
            CFrame.new(-1.5, 0.5, 0) * CFrame.Angles(math.rad(-10), math.rad(-10), math.rad(-5)) * lscp,
            1 / 3
        )
        RightHip.C0 =
            Clerp(
            RightHip.C0,
            CFrame.new(1, -1, 0) * CFrame.Angles(math.rad(-5), math.rad(80), math.rad(0)) *
                CFrame.Angles(math.rad(-4), math.rad(0), math.rad(0)),
            1 / 3
        )
        LeftHip.C0 =
            Clerp(
            LeftHip.C0,
            CFrame.new(-1, -1, 0) * CFrame.Angles(math.rad(0), math.rad(-70), math.rad(0)) *
                CFrame.Angles(math.rad(-5), math.rad(0), math.rad(0)),
            1 / 3
        )
        GunJoint.C0 =
            Clerp(
            GunJoint.C0,
            CFrame.new(0.05, -1, -0.15) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0)),
            1 / 2
        )
    end
    local Hole2 = Hole.CFrame * CFrame.new(-1000, 0, 0)
    Effect(
        {
            Time = math.random(15, 35),
            EffectType = "Box",
            Size = Vector3.new(2, 2, 2),
            Size2 = Vector3.new(5, 5, 5),
            Transparency = 0,
            Transparency2 = 1,
            CFrame = Hole.CFrame,
            MoveToPos = nil,
            RotationX = math.random(-1, 1),
            RotationY = math.random(-1, 1),
            RotationZ = math.random(-1, 1),
            Material = "Neon",
            Color = Color3.new(1, 0, 0),
            SoundID = 642890855,
            SoundPitch = 0.45,
            SoundVolume = 6,
            UseBoomerangMath = true,
            Boomerang = 0,
            SizeBoomerang = 50
        }
    )
    Effect(
        {
            Time = math.random(15, 35),
            EffectType = "Box",
            Size = Vector3.new(2, 2, 2),
            Size2 = Vector3.new(5, 5, 5),
            Transparency = 0,
            Transparency2 = 1,
            CFrame = Hole.CFrame,
            MoveToPos = nil,
            RotationX = math.random(-1, 1),
            RotationY = math.random(-1, 1),
            RotationZ = math.random(-1, 1),
            Material = "Neon",
            Color = Color3.new(0, 0, 0),
            SoundID = nil,
            SoundPitch = nil,
            SoundVolume = nil,
            UseBoomerangMath = true,
            Boomerang = 0,
            SizeBoomerang = 50
        }
    )
    Lightning(Hole.Position, Hole2.p, 15, 3.5, BrickColor.new("Really black"), math.random(15, 35), 1, 3, 0, true, 55)
    Lightning(Hole.Position, Hole2.p, 15, 3.5, BrickColor.new("Really red"), math.random(15, 35), 1, 3, 0, true, 55)
    for i = 0, 2 do
        Effect(
            {
                Time = math.random(25, 50),
                EffectType = "Round Slash",
                Size = Vector3.new(0.1, 0.1, 0.1),
                Size2 = Vector3.new(0.4, 0, 0.4),
                Transparency = 0,
                Transparency2 = 1,
                CFrame = Hole.CFrame *
                    CFrame.Angles(
                        math.rad(math.random(0, 360)),
                        math.rad(math.random(0, 360)),
                        math.rad(math.random(0, 360))
                    ),
                MoveToPos = nil,
                RotationX = math.random(-1, 1),
                RotationY = math.random(-1, 1),
                RotationZ = math.random(-1, 1),
                Material = "Neon",
                Color = Color3.new(1, 0, 0),
                SoundID = nil,
                SoundPitch = nil,
                SoundVolume = nil,
                UseBoomerangMath = true,
                Boomerang = 0,
                SizeBoomerang = 15
            }
        )
        Effect(
            {
                Time = math.random(25, 50),
                EffectType = "Round Slash",
                Size = Vector3.new(0.1, 0.1, 0.1),
                Size2 = Vector3.new(0.4, 0, 0.4),
                Transparency = 0,
                Transparency2 = 1,
                CFrame = Hole.CFrame *
                    CFrame.Angles(
                        math.rad(math.random(0, 360)),
                        math.rad(math.random(0, 360)),
                        math.rad(math.random(0, 360))
                    ),
                MoveToPos = nil,
                RotationX = math.random(-1, 1),
                RotationY = math.random(-1, 1),
                RotationZ = math.random(-1, 1),
                Material = "Neon",
                Color = Color3.new(0, 0, 0),
                SoundID = nil,
                SoundPitch = nil,
                SoundVolume = nil,
                UseBoomerangMath = true,
                Boomerang = 0,
                SizeBoomerang = 15
            }
        )
    end
    SHAKECAM(Hole.Position, 43, 23, 23)
    for i = 0, .5, 0.1 do
        swait()
        RootJoint.C0 =
            Clerp(
            RootJoint.C0,
            rc0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(-5)),
            1 / 3
        )
        Neck.C0 =
            Clerp(
            Neck.C0,
            nc0 * CFrame.new(0, 0, 0 + ((1) - 1)) * CFrame.Angles(math.rad(15), math.rad(0), math.rad(-5)),
            1 / 3
        )
        RightShoulder.C0 =
            Clerp(
            RightShoulder.C0,
            CFrame.new(1.5, 0.5, 0) * CFrame.Angles(math.rad(225), math.rad(-20), math.rad(20)) * rscp,
            1 / 3
        )
        LeftShoulder.C0 =
            Clerp(
            LeftShoulder.C0,
            CFrame.new(-1.5, 0.5, 0) * CFrame.Angles(math.rad(-5), math.rad(-5), math.rad(0)) * lscp,
            1 / 3
        )
        RightHip.C0 =
            Clerp(
            RightHip.C0,
            CFrame.new(1, -1, 0) * CFrame.Angles(math.rad(-5), math.rad(80), math.rad(0)) *
                CFrame.Angles(math.rad(-4), math.rad(0), math.rad(0)),
            1 / 3
        )
        LeftHip.C0 =
            Clerp(
            LeftHip.C0,
            CFrame.new(-1, -1, 0) * CFrame.Angles(math.rad(0), math.rad(-70), math.rad(0)) *
                CFrame.Angles(math.rad(-5), math.rad(0), math.rad(0)),
            1 / 3
        )
        GunJoint.C0 =
            Clerp(
            GunJoint.C0,
            CFrame.new(0.05, -1, -0.15) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0)),
            1 / 2
        )
    end
    for i = 0, .5, 0.1 do
        swait()
        RootJoint.C0 =
            Clerp(
            RootJoint.C0,
            rc0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(-5)),
            1 / 3
        )
        Neck.C0 =
            Clerp(
            Neck.C0,
            nc0 * CFrame.new(0, 0, 0 + ((1) - 1)) * CFrame.Angles(math.rad(15), math.rad(0), math.rad(-5)),
            1 / 3
        )
        RightShoulder.C0 =
            Clerp(
            RightShoulder.C0,
            CFrame.new(1.5, 0.5, 0) * CFrame.Angles(math.rad(175), math.rad(-10), math.rad(10)) * rscp,
            1 / 3
        )
        LeftShoulder.C0 =
            Clerp(
            LeftShoulder.C0,
            CFrame.new(-1.5, 0.5, 0) * CFrame.Angles(math.rad(-5), math.rad(-5), math.rad(0)) * lscp,
            1 / 3
        )
        RightHip.C0 =
            Clerp(
            RightHip.C0,
            CFrame.new(1, -1, 0) * CFrame.Angles(math.rad(-5), math.rad(80), math.rad(0)) *
                CFrame.Angles(math.rad(-4), math.rad(0), math.rad(0)),
            1 / 3
        )
        LeftHip.C0 =
            Clerp(
            LeftHip.C0,
            CFrame.new(-1, -1, 0) * CFrame.Angles(math.rad(0), math.rad(-70), math.rad(0)) *
                CFrame.Angles(math.rad(-5), math.rad(0), math.rad(0)),
            1 / 3
        )
        GunJoint.C0 =
            Clerp(
            GunJoint.C0,
            CFrame.new(0.05, -1, -0.15) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0)),
            1 / 2
        )
    end
    attack = false
    walkspeed = 36
    wait(.6)
    for i = 1, 50 do
        local Sky = Mouse.Hit * CFrame.new(0, 1000, 0)
        local MoPos = Mouse.Hit * CFrame.new(math.random(-18, 18), 0, math.random(-18, 18)).p
        local DISTANCE = (Sky.p - MoPos).Magnitude
        mdmg(MoPos, 12)
        Lightning(Sky.p, MoPos, 35, 7, BrickColor.new("Bright violet"), math.random(15, 35), 2, 4, 0, true, 55)
        Effect(
            {
                Time = math.random(15, 35),
                EffectType = "Box",
                Size = Vector3.new(1, 1, DISTANCE),
                Size2 = Vector3.new(2, 2, DISTANCE),
                Transparency = 0,
                Transparency2 = 1,
                CFrame = CFrame.new(Sky.p, MoPos) * CFrame.new(0, 0, -DISTANCE / 2),
                MoveToPos = nil,
                RotationX = nil,
                RotationY = nil,
                RotationZ = nil,
                Material = "Neon",
                Color = Color3.new(0, 0, 0),
                SoundID = nil,
                SoundPitch = nil,
                SoundVolume = nil,
                UseBoomerangMath = true,
                Boomerang = 0,
                SizeBoomerang = 50
            }
        )
        Effect(
            {
                Time = math.random(15, 35),
                EffectType = "Box",
                Size = Vector3.new(2, 2, 2),
                Size2 = Vector3.new(5, 5, 5),
                Transparency = 0,
                Transparency2 = 1,
                CFrame = CFrame.new(MoPos),
                MoveToPos = nil,
                RotationX = math.random(-1, 1),
                RotationY = math.random(-1, 1),
                RotationZ = math.random(-1, 1),
                Material = "Neon",
                Color = BrickColor.new("Bright violet").Color,
                SoundID = 192410089,
                SoundPitch = .55,
                SoundVolume = 8,
                UseBoomerangMath = true,
                Boomerang = 0,
                SizeBoomerang = 50
            }
        )
        Effect(
            {
                Time = math.random(15, 35),
                EffectType = "Box",
                Size = Vector3.new(2, 2, 2),
                Size2 = Vector3.new(5, 5, 5),
                Transparency = 0,
                Transparency2 = 1,
                CFrame = CFrame.new(MoPos),
                MoveToPos = nil,
                RotationX = math.random(-1, 1),
                RotationY = math.random(-1, 1),
                RotationZ = math.random(-1, 1),
                Material = "Neon",
                Color = Color3.new(0, 0, 0),
                SoundID = nil,
                SoundPitch = nil,
                SoundVolume = nil,
                UseBoomerangMath = true,
                Boomerang = 0,
                SizeBoomerang = 50
            }
        )
        local a = math.random(1, 2)
        if a == 1 then
            Effect(
                {
                    Time = math.random(25, 50),
                    EffectType = "Round Slash",
                    Size = Vector3.new(0.1, 0.1, 0.1),
                    Size2 = Vector3.new(0.3, 0, 0.3),
                    Transparency = 0,
                    Transparency2 = 1,
                    CFrame = CFrame.new(MoPos) *
                        CFrame.Angles(
                            math.rad(math.random(0, 360)),
                            math.rad(math.random(0, 360)),
                            math.rad(math.random(0, 360))
                        ),
                    MoveToPos = nil,
                    RotationX = math.random(-1, 1),
                    RotationY = math.random(-1, 1),
                    RotationZ = math.random(-1, 1),
                    Material = "Neon",
                    Color = BrickColor.new("Bright violet").Color,
                    SoundID = nil,
                    SoundPitch = nil,
                    SoundVolume = nil,
                    UseBoomerangMath = true,
                    Boomerang = 0,
                    SizeBoomerang = 15
                }
            )
        else
            Effect(
                {
                    Time = math.random(25, 50),
                    EffectType = "Round Slash",
                    Size = Vector3.new(0.1, 0.1, 0.1),
                    Size2 = Vector3.new(0.3, 0, 0.3),
                    Transparency = 0,
                    Transparency2 = 1,
                    CFrame = CFrame.new(MoPos) *
                        CFrame.Angles(
                            math.rad(math.random(0, 360)),
                            math.rad(math.random(0, 360)),
                            math.rad(math.random(0, 360))
                        ),
                    MoveToPos = nil,
                    RotationX = math.random(-1, 1),
                    RotationY = math.random(-1, 1),
                    RotationZ = math.random(-1, 1),
                    Material = "Neon",
                    Color = Color3.new(0, 0, 0),
                    SoundID = nil,
                    SoundPitch = nil,
                    SoundVolume = nil,
                    UseBoomerangMath = true,
                    Boomerang = 0,
                    SizeBoomerang = 15
                }
            )
        end
        SHAKECAM(MoPos, 27, 11, 11)
        swait(5)
    end
end

function LightningBullets()
    attack = true
    walkspeed = 22
    AttackGyro()
    CreateSound(2785493, Hole, 4, 0.6)
    for i = 0, 1.25, 0.025 do
        swait()
        SHAKECAM(Hole.Position, 31, 35, 35)
        Effect(
            {
                Time = math.random(35, 55),
                EffectType = "Sphere",
                Size = Vector3.new(0.7, 0.7, 0.7),
                Size2 = Vector3.new(0.3, 0.3, 0.3),
                Transparency = 0,
                Transparency2 = 1,
                CFrame = Hole.CFrame * CFrame.new(math.random(-10, 10), math.random(-10, 10), math.random(-10, 10)),
                MoveToPos = Hole.Position,
                RotationX = nil,
                RotationY = nil,
                RotationZ = nil,
                Material = "Neon",
                Color = Color3.new(1, 0, 0),
                SoundID = nil,
                SoundPitch = nil,
                SoundVolume = nil,
                UseBoomerangMath = true,
                Boomerang = 0,
                SizeBoomerang = 50
            }
        )
        Effect(
            {
                Time = math.random(15, 20),
                EffectType = "Sphere",
                Size = Vector3.new(8, 8, 8) * math.random(0.05, 2),
                Size2 = Vector3.new(2, 2, 2) * math.random(0.05, 2),
                Transparency = 0.4,
                Transparency2 = 1,
                CFrame = Hole.CFrame,
                MoveToPos = nil,
                RotationX = nil,
                RotationY = nil,
                RotationZ = nil,
                Material = "Neon",
                Color = Color3.new(1, 0, 0),
                SoundID = nil,
                SoundPitch = nil,
                SoundVolume = nil,
                UseBoomerangMath = true,
                Boomerang = 0,
                SizeBoomerang = 25
            }
        )
        RootJoint.C0 =
            Clerp(
            RootJoint.C0,
            rc0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(30)),
            1 / 3
        )
        Neck.C0 =
            Clerp(Neck.C0, nc0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(15), math.rad(0), math.rad(-30)), 1 / 3)
        RightShoulder.C0 =
            Clerp(
            RightShoulder.C0,
            CFrame.new(1.5, 0.5, 0) * CFrame.Angles(math.rad(90), math.rad(0), math.rad(30)) * rscp,
            1 / 3
        )
        LeftShoulder.C0 =
            Clerp(
            LeftShoulder.C0,
            CFrame.new(-1.5, 0.5, 0) * CFrame.Angles(math.rad(30), math.rad(0), math.rad(0)) * lscp,
            1 / 3
        )
        RightHip.C0 =
            Clerp(
            RightHip.C0,
            CFrame.new(1, -1, 0) * CFrame.Angles(math.rad(-5), math.rad(80), math.rad(0)) *
                CFrame.Angles(math.rad(-4), math.rad(0), math.rad(0)),
            1 / 3
        )
        LeftHip.C0 =
            Clerp(
            LeftHip.C0,
            CFrame.new(-1, -1, 0) * CFrame.Angles(math.rad(0), math.rad(-70), math.rad(0)) *
                CFrame.Angles(math.rad(-5), math.rad(0), math.rad(0)),
            1 / 3
        )
        GunJoint.C0 =
            Clerp(
            GunJoint.C0,
            CFrame.new(0.05, -1, -0.15) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0)),
            1 / 2
        )
    end
    for i = 1, math.random(3, 7) do
        for i = 0, 0.5, 0.05 do
            swait()
            RootJoint.C0 =
                Clerp(
                RootJoint.C0,
                rc0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(20)),
                1 / 3
            )
            Neck.C0 =
                Clerp(
                Neck.C0,
                nc0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(15), math.rad(0), math.rad(-20)),
                1 / 3
            )
            RightShoulder.C0 =
                Clerp(
                RightShoulder.C0,
                CFrame.new(1.5, 0.5, 0) * CFrame.Angles(math.rad(90), math.rad(0), math.rad(20)) * rscp,
                1 / 3
            )
            LeftShoulder.C0 =
                Clerp(
                LeftShoulder.C0,
                CFrame.new(-1.5, 0.5, 0) * CFrame.Angles(math.rad(10), math.rad(0), math.rad(0)) * lscp,
                1 / 3
            )
            RightHip.C0 =
                Clerp(
                RightHip.C0,
                CFrame.new(1, -1, 0) * CFrame.Angles(math.rad(-5), math.rad(80), math.rad(0)) *
                    CFrame.Angles(math.rad(-4), math.rad(0), math.rad(0)),
                1 / 3
            )
            LeftHip.C0 =
                Clerp(
                LeftHip.C0,
                CFrame.new(-1, -1, 0) * CFrame.Angles(math.rad(0), math.rad(-70), math.rad(0)) *
                    CFrame.Angles(math.rad(-5), math.rad(0), math.rad(0)),
                1 / 3
            )
            GunJoint.C0 =
                Clerp(
                GunJoint.C0,
                CFrame.new(0.05, -1, -0.15) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0)),
                1 / 2
            )
        end
        coroutine.resume(
            coroutine.create(
                function()
                    local Mause = Mouse.Hit.p
                    local Chose = math.random(1, 2)
                    local Col = nil
                    local Col2 = nil
                    if Chose == 1 then
                        Col = BrickColor.new("Really red")
                        Col2 = BrickColor.new("Really black")
                    else
                        Col = BrickColor.new("Really black")
                        Col2 = BrickColor.new("Really red")
                    end
                    Lightning(
                        Hole.Position,
                        Mause,
                        math.random(13, 19),
                        math.random(1, 7),
                        Col,
                        math.random(25, 40),
                        0.5,
                        3,
                        0,
                        true,
                        50,
                        true,
                        math.random(1, 3)
                    )
                    mdmg(Mause, 15)
                    SHAKECAM(Mause, 33, 41, 41)
                    Effect(
                        {
                            Time = math.random(35, 80),
                            EffectType = "Sphere",
                            Size = Vector3.new(15, 25, 15),
                            Size2 = Vector3.new(5, 75, 5),
                            Transparency = 0,
                            Transparency2 = 1,
                            CFrame = CFrame.new(Mause) *
                                CFrame.Angles(
                                    math.rad(math.random(-20, 20)),
                                    math.rad(math.random(-20, 20)),
                                    math.rad(math.random(-20, 20))
                                ),
                            MoveToPos = nil,
                            RotationX = math.random(-0.5, 0.5),
                            RotationY = math.random(-0.5, 0.5),
                            RotationZ = math.random(-0.5, 0.5),
                            Material = "Neon",
                            Color = Col.Color,
                            SoundID = 168513088,
                            SoundPitch = 0.8,
                            SoundVolume = 2,
                            UseBoomerangMath = true,
                            Boomerang = 0,
                            SizeBoomerang = 15
                        }
                    )
                    Effect(
                        {
                            Time = math.random(35, 80),
                            EffectType = "Sphere",
                            Size = Vector3.new(15, 25, 15),
                            Size2 = Vector3.new(5, 75, 5),
                            Transparency = 0,
                            Transparency2 = 1,
                            CFrame = CFrame.new(Mause) *
                                CFrame.Angles(
                                    math.rad(math.random(-20, 20)),
                                    math.rad(math.random(-20, 20)),
                                    math.rad(math.random(70, 90))
                                ),
                            MoveToPos = nil,
                            RotationX = math.random(-0.5, 0.5),
                            RotationY = math.random(-0.5, 0.5),
                            RotationZ = math.random(-0.5, 0.5),
                            Material = "Neon",
                            Color = Col.Color,
                            SoundID = 168513088,
                            SoundPitch = 0.9,
                            SoundVolume = 3,
                            UseBoomerangMath = true,
                            Boomerang = 0,
                            SizeBoomerang = 15
                        }
                    )
                    Effect(
                        {
                            Time = math.random(35, 80),
                            EffectType = "Sphere",
                            Size = Vector3.new(15, 25, 15),
                            Size2 = Vector3.new(5, 75, 5),
                            Transparency = 0,
                            Transparency2 = 1,
                            CFrame = CFrame.new(Mause) *
                                CFrame.Angles(
                                    math.rad(math.random(70, 90)),
                                    math.rad(math.random(-20, 20)),
                                    math.rad(math.random(-20, 20))
                                ),
                            MoveToPos = nil,
                            RotationX = math.random(-0.5, 0.5),
                            RotationY = math.random(-0.5, 0.5),
                            RotationZ = math.random(-0.5, 0.5),
                            Material = "Neon",
                            Color = Col.Color,
                            SoundID = 168513088,
                            SoundPitch = 1,
                            SoundVolume = 4,
                            UseBoomerangMath = true,
                            Boomerang = 0,
                            SizeBoomerang = 15
                        }
                    )
                    Effect(
                        {
                            Time = math.random(35, 80),
                            EffectType = "Sphere",
                            Size = Vector3.new(15, 15, 15),
                            Size2 = Vector3.new(65, 65, 65),
                            Transparency = 0.4,
                            Transparency2 = 1,
                            CFrame = CFrame.new(Mause),
                            MoveToPos = nil,
                            RotationX = nil,
                            RotationY = nil,
                            RotationZ = nil,
                            Material = "Neon",
                            Color = Col.Color,
                            SoundID = nil,
                            SoundPitch = nil,
                            SoundVolume = nil,
                            UseBoomerangMath = true,
                            Boomerang = 0,
                            SizeBoomerang = 40
                        }
                    )
                end
            )
        )
        Effect(
            {
                Time = math.random(15, 35),
                EffectType = "Box",
                Size = Vector3.new(6, 6, 6),
                Size2 = Vector3.new(15, 15, 15),
                Transparency = 0,
                Transparency2 = 1,
                CFrame = Hole.CFrame,
                MoveToPos = nil,
                RotationX = math.random(-1, 1),
                RotationY = math.random(-1, 1),
                RotationZ = math.random(-1, 1),
                Material = "Neon",
                Color = Color3.new(1, 0, 0),
                SoundID = 642890855,
                SoundPitch = 0.25,
                SoundVolume = 8,
                UseBoomerangMath = true,
                Boomerang = 0,
                SizeBoomerang = 50
            }
        )
        Effect(
            {
                Time = math.random(15, 35),
                EffectType = "Box",
                Size = Vector3.new(6, 6, 6),
                Size2 = Vector3.new(15, 15, 15),
                Transparency = 0,
                Transparency2 = 1,
                CFrame = Hole.CFrame,
                MoveToPos = nil,
                RotationX = math.random(-1, 1),
                RotationY = math.random(-1, 1),
                RotationZ = math.random(-1, 1),
                Material = "Neon",
                Color = Color3.new(0, 0, 0),
                SoundID = nil,
                SoundPitch = nil,
                SoundVolume = nil,
                UseBoomerangMath = true,
                Boomerang = 0,
                SizeBoomerang = 50
            }
        )
        for i = 0, 2 do
            Effect(
                {
                    Time = math.random(25, 50),
                    EffectType = "Round Slash",
                    Size = Vector3.new(0.1, 0.1, 0.1),
                    Size2 = Vector3.new(0.3, 0, 0.3),
                    Transparency = 0,
                    Transparency2 = 1,
                    CFrame = Hole.CFrame *
                        CFrame.Angles(
                            math.rad(math.random(0, 360)),
                            math.rad(math.random(0, 360)),
                            math.rad(math.random(0, 360))
                        ),
                    MoveToPos = nil,
                    RotationX = math.random(-1, 1),
                    RotationY = math.random(-1, 1),
                    RotationZ = math.random(-1, 1),
                    Material = "Neon",
                    Color = Color3.new(1, 0, 0),
                    SoundID = nil,
                    SoundPitch = nil,
                    SoundVolume = nil,
                    UseBoomerangMath = true,
                    Boomerang = 0,
                    SizeBoomerang = 15
                }
            )
            Effect(
                {
                    Time = math.random(25, 50),
                    EffectType = "Round Slash",
                    Size = Vector3.new(0.1, 0.1, 0.1),
                    Size2 = Vector3.new(0.3, 0, 0.3),
                    Transparency = 0,
                    Transparency2 = 1,
                    CFrame = Hole.CFrame *
                        CFrame.Angles(
                            math.rad(math.random(0, 360)),
                            math.rad(math.random(0, 360)),
                            math.rad(math.random(0, 360))
                        ),
                    MoveToPos = nil,
                    RotationX = math.random(-1, 1),
                    RotationY = math.random(-1, 1),
                    RotationZ = math.random(-1, 1),
                    Material = "Neon",
                    Color = Color3.new(0, 0, 0),
                    SoundID = nil,
                    SoundPitch = nil,
                    SoundVolume = nil,
                    UseBoomerangMath = true,
                    Boomerang = 0,
                    SizeBoomerang = 15
                }
            )
        end
        SHAKECAM(Hole.Position, 43, 51, 51)
        for i = 0, 0.5, 0.075 do
            swait()
            RootJoint.C0 =
                Clerp(
                RootJoint.C0,
                rc0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-5), math.rad(0), math.rad(80)),
                1 / 3
            )
            Neck.C0 =
                Clerp(
                Neck.C0,
                nc0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(10), math.rad(0), math.rad(-80)),
                1 / 3
            )
            RightShoulder.C0 =
                Clerp(
                RightShoulder.C0,
                CFrame.new(1.5, 0.5, 0) * CFrame.Angles(math.rad(180), math.rad(-20), math.rad(80)) * rscp,
                1 / 3
            )
            LeftShoulder.C0 =
                Clerp(
                LeftShoulder.C0,
                CFrame.new(-1.5, 0.5, 0) * CFrame.Angles(math.rad(50), math.rad(10), math.rad(20)) * lscp,
                1 / 3
            )
            RightHip.C0 =
                Clerp(
                RightHip.C0,
                CFrame.new(1, -1, 0) * CFrame.Angles(math.rad(-5), math.rad(75), math.rad(0)) *
                    CFrame.Angles(math.rad(-4), math.rad(0), math.rad(0)),
                1 / 3
            )
            LeftHip.C0 =
                Clerp(
                LeftHip.C0,
                CFrame.new(-1, -1, 0) * CFrame.Angles(math.rad(0), math.rad(-65), math.rad(0)) *
                    CFrame.Angles(math.rad(-5), math.rad(0), math.rad(0)),
                1 / 3
            )
            GunJoint.C0 =
                Clerp(
                GunJoint.C0,
                CFrame.new(0.05, -1, -0.15) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0)),
                1 / 2
            )
        end
        swait(math.random(4, 9))
    end
    attack = false
    walkspeed = 36
end

function Blink()
    local where, Mause = rayCast(RootPart.Position, (Mouse.Hit.p - RootPart.Position), 150, Character)
    Effect(
        {
            Time = math.random(35, 55),
            EffectType = "Sphere",
            Size = Vector3.new(15, 15, 15),
            Size2 = Vector3.new(20, 20, 20),
            Transparency = 0,
            Transparency2 = 1,
            CFrame = RootPart.CFrame,
            MoveToPos = nil,
            RotationX = nil,
            RotationY = nil,
            RotationZ = nil,
            Material = "Neon",
            Color = BrickColor.new("Bright violet").Color,
            SoundID = nil,
            SoundPitch = nil,
            SoundVolume = nil,
            UseBoomerangMath = true,
            Boomerang = 0,
            SizeBoomerang = 45
        }
    )
    CharacterFade(BrickColor.new("Bright violet").Color, math.random(35, 55))
    CreateSound(199978087, RootPart, 2, 0.7)
    Lightning(
        RootPart.Position,
        Mause,
        math.random(4, 6),
        15,
        BrickColor.new("Bright violet"),
        math.random(35, 55),
        0.5,
        3,
        0,
        true,
        50,
        true,
        1
    )
    RootPart.CFrame = CFrame.new(Mause) * CFrame.new(0, 3, 0)
    CreateSound(199978087, RootPart, 2, 0.7)
    CharacterFade(BrickColor.new("Bright violet").Color, math.random(35, 55))
    Effect(
        {
            Time = math.random(35, 55),
            EffectType = "Sphere",
            Size = Vector3.new(15, 15, 15),
            Size2 = Vector3.new(20, 20, 20),
            Transparency = 0,
            Transparency2 = 1,
            CFrame = CFrame.new(Mause),
            MoveToPos = nil,
            RotationX = nil,
            RotationY = nil,
            RotationZ = nil,
            Material = "Neon",
            Color = BrickColor.new("Bright violet").Color,
            SoundID = nil,
            SoundPitch = nil,
            SoundVolume = nil,
            UseBoomerangMath = true,
            Boomerang = 0,
            SizeBoomerang = 45
        }
    )
end

function TargetSelect(person)
    local dd =
        coroutine.wrap(
        function()
            if targetted ~= person then
                targetted = person
                img2.Size = UDim2.new(1, 0, 1, 0)
                img2.ImageTransparency = 0
                img2.Position = UDim2.new(0, 0, 0, 0)
                for i = 0, 7, 0.35 do
                    swait()
                    img2.Size = img2.Size + UDim2.new(.075, 0, .075, 0)
                    img2.Position = img2.Position + UDim2.new(-.0375, 0, -.0375, 0)
                    img2.ImageTransparency = img2.ImageTransparency + 0.05
                end
            end
        end
    )
    dd()
end

function LockOn()
    if Mouse.Target ~= nil then
        local h = FindHumanoid(Mouse.Target)
        if h then
            local torsy =
                h.Parent:FindFirstChild("Head") or h.Parent:FindFirstChild("HumanoidRootPart") or
                h.Parent:FindFirstChild("Torso") or
                h.Parent:FindFirstChild("UpperToso")
            if torsy then
                TargetSelect(h.Parent)
                CreateSound(743521450, Head, 4, .65, false)
                Effect(
                    {
                        Time = math.random(10, 20),
                        EffectType = "Sphere",
                        Size = Vector3.new(1, 1, 1),
                        Size2 = Vector3.new(0, 5, 0),
                        Transparency = 0.15,
                        Transparency2 = 1,
                        CFrame = Head.CFrame * CFrame.new(0.2, 0.2, -0.55),
                        MoveToPos = nil,
                        RotationX = math.random(-1, 1),
                        RotationY = math.random(-1, 1),
                        RotationZ = math.random(-1, 1),
                        Material = "Neon",
                        Color = Color3.new(0.8, 0, 0),
                        SoundID = nil,
                        SoundPitch = nil,
                        SoundVolume = nil,
                        UseBoomerangMath = false,
                        Boomerang = 0,
                        SizeBoomerang = 0
                    }
                )
                Effect(
                    {
                        Time = math.random(10, 20),
                        EffectType = "Sphere",
                        Size = Vector3.new(1, 1, 1),
                        Size2 = Vector3.new(0, 5, 0),
                        Transparency = 0.15,
                        Transparency2 = 1,
                        CFrame = Head.CFrame * CFrame.new(0.2, 0.2, -0.55) *
                            CFrame.Angles(math.rad(0), math.rad(0), math.rad(90)),
                        MoveToPos = nil,
                        RotationX = math.random(-1, 1),
                        RotationY = math.random(-1, 1),
                        RotationZ = math.random(-1, 1),
                        Material = "Neon",
                        Color = Color3.new(0.8, 0, 0),
                        SoundID = nil,
                        SoundPitch = nil,
                        SoundVolume = nil,
                        UseBoomerangMath = false,
                        Boomerang = 0,
                        SizeBoomerang = 0
                    }
                )
                Effect(
                    {
                        Time = math.random(20, 40),
                        EffectType = "Sphere",
                        Size = Vector3.new(1, 1, 1),
                        Size2 = Vector3.new(0, 10, 0),
                        Transparency = 0.05,
                        Transparency2 = 1,
                        CFrame = Head.CFrame * CFrame.new(0.2, 0.2, -0.55) *
                            CFrame.Angles(math.rad(0), math.rad(0), math.rad(-45)),
                        MoveToPos = nil,
                        RotationX = math.random(-1, 1),
                        RotationY = math.random(-1, 1),
                        RotationZ = math.random(-1, 1),
                        Material = "Neon",
                        Color = Color3.new(0.8, 0, 0),
                        SoundID = nil,
                        SoundPitch = nil,
                        SoundVolume = nil,
                        UseBoomerangMath = false,
                        Boomerang = 0,
                        SizeBoomerang = 0
                    }
                )
                Effect(
                    {
                        Time = math.random(20, 40),
                        EffectType = "Sphere",
                        Size = Vector3.new(1, 1, 1),
                        Size2 = Vector3.new(0, 10, 0),
                        Transparency = 0.05,
                        Transparency2 = 1,
                        CFrame = Head.CFrame * CFrame.new(0.2, 0.2, -0.55) *
                            CFrame.Angles(math.rad(0), math.rad(0), math.rad(45)),
                        MoveToPos = nil,
                        RotationX = math.random(-1, 1),
                        RotationY = math.random(-1, 1),
                        RotationZ = math.random(-1, 1),
                        Material = "Neon",
                        Color = Color3.new(0.8, 0, 0),
                        SoundID = nil,
                        SoundPitch = nil,
                        SoundVolume = nil,
                        UseBoomerangMath = false,
                        Boomerang = 0,
                        SizeBoomerang = 0
                    }
                )
            end
        end
    end
end

function ofmoosic() -- 2 lazi hoh
    delays = true
    while wait() and kkk and kkk.Volume >= 0.02 and not killScript do
        kkk.Volume = kkk.Volume - 0.05
    end
    wait(0.1)
    kkk.Pitch = 0
    kkk.PlaybackSpeed = 0
    kkk.Volume = 0
    play = false
    delays = false
end
function onmoosic()
    delays = true
    kkk.Pitch = .6
    kkk.PlaybackSpeed = .6
    while wait() and kkk and kkk.Volume <= 1.5 and not killScript do
        kkk.Volume = kkk.Volume + 0.05
    end
    wait(0.1)
    kkk.Volume = 3
    play = true
    delays = false
end
Mouse.Button1Down:connect(
    function()
        if killScript then return end
        if attack == false then
            attackone()
        end
    end
)

Mouse.KeyDown:connect(
    function(k)
        if killScript then return end
        k = k:lower()
        if attack == false and k == "q" then
            if targetted == nil then
                LockOn()
            else
                targetted = nil
            end
        end
        if k == "z" and attack == false then
            hedshoot()
        elseif k == "x" and attack == false then
            moarblood()
        elseif k == "c" and attack == false then
            painlessrain()
        elseif k == "v" and attack == false then
            MagicBalls()
        elseif k == "f" and attack == false then
            LightningBullets()
        elseif k == "e" and attack == false then
            Blink()
        elseif k == "m" then
            if kkk.IsPlaying == true then
                kkk:Pause()
            else
                kkk:Resume()
            end
        end
    end
)

kkk = Instance.new("Sound", Character)
kkk.Volume = 1
kkk.PlaybackSpeed = 1
kkk.Pitch = 0.9
kkk.SoundId = "rbxassetid://866334508"
kkk:Play()
kkk.Name = "kkk"
kkk.Looped = true

spawn(
    function()
        local bb = Instance.new("BillboardGui", Head)
        bb.AlwaysOnTop = true
        bb.Size = UDim2.new(1, 0, 1, 0)
        bb.StudsOffset = Vector3.new(0, 4.5, 0)
        local t2 = Instance.new("TextLabel", bb)
        t2.Size = UDim2.new(1, 0, 1, 0)
        t2.Text = "Lose Hope"
        t2.TextColor3 = Color3.new(.50, .30, .10)
        t2.TextStrokeTransparency = 0
        t2.BackgroundTransparency = 1
        t2.TextSize = 40
        t2.Font = "Code"
        t2.Rotation = -6
        local t = Instance.new("TextLabel", bb)
        t.Size = UDim2.new(1, 0, 1, 0)
        t.Text = "Lose Hope"
        t.TextColor3 = Color3.new(.70, .50, .30)
        t.TextStrokeTransparency = 0
        t.BackgroundTransparency = 1
        t.TextSize = 40
        t.Font = "Code"
        t.Rotation = -6
        while wait() and not killScript do
            bb.StudsOffset =
                Vector3.new(math.random(-30, 30) / 15, 4.5 + math.random(-30, 30) / 15, math.random(-30, 30) / 15)
            t.Rotation = t.Rotation + math.random(-1, 1)
            t2.Rotation = t2.Rotation + math.random(-1.5, 1.5)
        end
    end
)

local BODY = {}
for _, c in pairs(Character:GetDescendants()) do
    if c:IsA("BasePart") and c.Name ~= "Handle" then
        if
            c ~= RootPart and c ~= Torso and c ~= Head and c ~= RightArm and c ~= LeftArm and c ~= RightLeg and
                c ~= LeftLeg
         then
            c.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
        end
        table.insert(BODY, {c, c.Parent, c.Material, c.Color, c.Transparency, c.Size, c.Name})
    elseif c:IsA("JointInstance") then
        table.insert(BODY, {c, c.Parent, nil, nil, nil, nil, nil})
    end
end

local kkktime = 0
local fix = false
coroutine.wrap(
    function()
        while 1 and not killScript do
            swait()
            if doe <= 360 then
                doe = doe + 2
            else
                doe = 0
            end
        end
    end
)()
while true and not killScript do
    swait()
    for i, v in pairs(Character:GetChildren()) do
        if v:IsA("Part") then
            v.Material = "SmoothPlastic"
        elseif v:IsA("Accessory") then
            v:WaitForChild("Handle").Material = "SmoothPlastic"
        end
    end
    while true and not killScript do
        swait()
        coroutine.resume(
            coroutine.create(
                function()
                    if math.random(1, 15) == 1 then
                        swait()
                        Effect(
                            {
                                Time = math.random(25, 35),
                                EffectType = "Sphere",
                                Size = Vector3.new(0.4, 0.4, 0.4),
                                Size2 = Vector3.new(0.8, 0.8, 0.8) * math.random(1.05, 1.15),
                                Transparency = 0,
                                Transparency2 = 1,
                                CFrame = Hole.CFrame,
                                MoveToPos = nil,
                                RotationX = nil,
                                RotationY = nil,
                                RotationZ = nil,
                                Material = "Neon",
                                Color = Color3.new(1, 0, 0),
                                SoundID = nil,
                                SoundPitch = nil,
                                SoundVolume = nil,
                                UseBoomerangMath = true,
                                Boomerang = 0,
                                SizeBoomerang = 65
                            }
                        )
                        Effect(
                            {
                                Time = math.random(25, 35),
                                EffectType = "Sphere",
                                Size = Vector3.new(0.4, 0.4, 0.4),
                                Size2 = Vector3.new(0.8, 0.8, 0.8) * math.random(1.05, 1.15),
                                Transparency = 0,
                                Transparency2 = 1,
                                CFrame = Hole.CFrame,
                                MoveToPos = nil,
                                RotationX = nil,
                                RotationY = nil,
                                RotationZ = nil,
                                Material = "Neon",
                                Color = Color3.new(0, 0, 0),
                                SoundID = nil,
                                SoundPitch = nil,
                                SoundVolume = nil,
                                UseBoomerangMath = true,
                                Boomerang = 0,
                                SizeBoomerang = 65
                            }
                        )
                        Lightning(
                            Hole.Position,
                            GUN.sDarkness.Position,
                            3,
                            15,
                            BrickColor.new("Really black"),
                            math.random(15, 35),
                            0.15,
                            0.25,
                            0,
                            true,
                            55
                        )
                        Lightning(
                            Hole.Position,
                            GUN.sDarkness.Position,
                            3,
                            15,
                            BrickColor.new("Really red"),
                            math.random(15, 35),
                            0.15,
                            0.25,
                            0,
                            true,
                            55
                        )
                    end
                end
            )
        )
        if Character:FindFirstChild("Shield") == nil then
            Shield = Instance.new("MeshPart", Character)
            Shield.Name = "Shield"
            Shield.CanCollide = false
            Shield.Transparency = 1
            Shield.Material = "Neon"
            Shield.BrickColor = BrickColor.new("Really red")
            Shield.Size = Vector3.new(7, 7, 7)
            Shield.Massless = true
            Shield.CFrame = Torso.CFrame
            local Wed = Instance.new("Weld", Shield)
            Wed.Part0 = Shield
            Wed.Part1 = Torso
        end
        if Character:FindFirstChild("Shield2") == nil then
            Shield2 = Instance.new("MeshPart", Character)
            Shield2.Name = "Shield2"
            Shield2.CanCollide = false
            Shield2.Transparency = 1
            Shield2.Material = "Neon"
            Shield2.BrickColor = BrickColor.new("Really red")
            Shield2.Size = Vector3.new(6, 6, 6)
            Shield2.Massless = true
            Shield2.CFrame = Torso.CFrame
            local Wed = Instance.new("Weld", Shield2)
            Wed.Part0 = Shield2
            Wed.Part1 = Torso
        end
        for _, c in pairs(Character:GetChildren()) do
            if c:IsA("BasePart") and c ~= RootPart then
                c.Anchored = false
            end
        end
        if
            Player == nil or Humanoid == nil or Character == nil or RootPart == nil or Torso == nil or Head == nil or
                RightArm == nil or
                LeftArm == nil or
                GUN == nil
         then
            for i, v in pairs(Humanoid:GetChildren()) do
                for i, p in pairs(v:GetChildren()) do
                    if p.ClassName == "BodyVelocity" or p.ClassName == "BodyGyro" then
                        p:destroy()
                    end
                end
            end
        end
        Humanoid.DisplayDistanceType = "None"
        if kkk == nil or kkk.Parent ~= Character then
            kkk = Instance.new("Sound", Character)
            kkk.Volume = 1
            kkk.PlaybackSpeed = 1
            kkk.Pitch = 0.9
            kkk.SoundId = "rbxassetid://866334508"
            kkk:Play()
            kkk.Name = "kkk"
            kkk.Looped = true
            kkk.TimePosition = kkktime
        elseif fix == false then
            kkktime = kkk.TimePosition
        else
            fix = false
        end
        imgl.Rotation = imgl.Rotation + 12
        img2.Rotation = img2.Rotation + 32
        if targetted ~= nil then
            abss.Adornee =
                targetted:FindFirstChild("Torso") or targetted:FindFirstChild("UpperTorso") or
                targetted:FindFirstChild("HumanoidRootPart")
            abss.Enabled = true
        elseif targetted == nil then
            abss.Adornee = nil
            abss.Enabled = false
        end

        while true and imgl.Rotation >= 360 and not killScript do
            imgl.Rotation = 0
            img2.Rotation = 0
        end
        Torsovelocity = (RootPart.Velocity * Vector3.new(1, 0, 1)).magnitude
        velocity = RootPart.Velocity.y
        sine = sine + change
        Humanoid.WalkSpeed = walkspeed
        local hit, pos =
            rayCast(
            RootPart.Position,
            (CFrame.new(RootPart.Position, RootPart.Position - Vector3.new(0, 1, 0))).lookVector,
            4,
            Character
        )
        miztfling(
            {
                Method = "CFrame", -- This method will visualized like a teleporting root.
                Args = {
                    flingTarget, -- Change this to other player character.
                    2, -- Max amount of time.
                    60 -- Max lerp per fling.
                }
            }
        )
        if Anim == "Walk" and Torsovelocity > 1 then
            RootJoint.C1 =
                Clerp(
                RootJoint.C1,
                rc0 * CFrame.new(0, 0, 0.1 + 0.05 * math.cos(sine / (8 / 2))) *
                    CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)),
                2 * (Humanoid.WalkSpeed / 16) / 3
            )
            Neck.C1 =
                Clerp(
                Neck.C1,
                CFrame.new(0, -0.5, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(180)) *
                    CFrame.Angles(math.rad(0), math.rad(0), math.rad(0) - Head.RotVelocity.Y / 30),
                0.2 * (Humanoid.WalkSpeed / 16) / 3
            )
            RightHip.C1 =
                Clerp(
                RightHip.C1,
                CFrame.new(
                    0.5,
                    1 - 0.125 * math.sin(sine / 8) - 0.15 * math.cos(sine / 8 * 2),
                    0.25 * math.sin(sine / 8)
                ) *
                    CFrame.Angles(math.rad(-5), math.rad(90), math.rad(0)) *
                    CFrame.Angles(math.rad(0), math.rad(0), math.rad(0 + 25 * math.cos(sine / 8))),
                0.6 / 3
            )
            LeftHip.C1 =
                Clerp(
                LeftHip.C1,
                CFrame.new(
                    -0.5,
                    1 + 0.125 * math.sin(sine / 8) - 0.15 * math.cos(sine / 8 * 2),
                    -0.25 * math.sin(sine / 8)
                ) *
                    CFrame.Angles(math.rad(-5), math.rad(-90), math.rad(0)) *
                    CFrame.Angles(math.rad(0), math.rad(0), math.rad(0 + 25 * math.cos(sine / 8))),
                0.6 / 3
            )
        elseif (Anim ~= "Walk") or (Torsovelocity < 1) then
            RootJoint.C1 =
                Clerp(
                RootJoint.C1,
                rc0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)),
                0.2 / 3
            )
            Neck.C1 =
                Clerp(
                Neck.C1,
                CFrame.new(0, -0.5, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(180)) *
                    CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)),
                0.2 / 3
            )
            RightHip.C1 =
                Clerp(
                RightHip.C1,
                CFrame.new(0.5, 1, 0) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0)) *
                    CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)),
                0.7 / 3
            )
            LeftHip.C1 =
                Clerp(
                LeftHip.C1,
                CFrame.new(-0.5, 1, 0) * CFrame.Angles(math.rad(0), math.rad(-90), math.rad(0)) *
                    CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)),
                0.7 / 3
            )
        end
        if RootPart.Velocity.y > 1 and hit == nil then
            Anim = "Jump"
            if attack == false then
                RootJoint.C0 =
                    Clerp(
                    RootJoint.C0,
                    rc0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-5), math.rad(0), math.rad(0)),
                    1 / 3
                )
                Neck.C0 =
                    Clerp(
                    Neck.C0,
                    nc0 * CFrame.new(0, 0, 0 + ((1) - 1)) * CFrame.Angles(math.rad(-25), math.rad(0), math.rad(10)),
                    1 / 3
                )
                RightShoulder.C0 =
                    Clerp(
                    RightShoulder.C0,
                    CFrame.new(1.5, 0.5, 0) *
                        CFrame.Angles(math.rad(-65), math.rad(0), math.rad(0 + 10 * math.cos(sine / 12))) *
                        rscp,
                    1 / 3
                )
                LeftShoulder.C0 =
                    Clerp(
                    LeftShoulder.C0,
                    CFrame.new(-1.5, 0.5, 0) *
                        CFrame.Angles(math.rad(50), math.rad(0), math.rad(-25 - 10 * math.cos(sine / 12))) *
                        lscp,
                    1 / 3
                )
                RightHip.C0 =
                    Clerp(
                    RightHip.C0,
                    CFrame.new(1, -0.4, -0.6) * CFrame.Angles(math.rad(1), math.rad(90), math.rad(0)) *
                        CFrame.Angles(math.rad(-1 * math.sin(sine / 6)), math.rad(0), math.rad(0)),
                    1 / 3
                )
                LeftHip.C0 =
                    Clerp(
                    LeftHip.C0,
                    CFrame.new(-1, -1, 0) * CFrame.Angles(math.rad(0), math.rad(-85), math.rad(0)) *
                        CFrame.Angles(math.rad(-1 * math.sin(sine / 6)), math.rad(0), math.rad(0)),
                    1 / 3
                )
                GunJoint.C0 =
                    Clerp(
                    GunJoint.C0,
                    CFrame.new(0.05, -1, -0.15) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0)),
                    1 / 2
                )
            end
        elseif RootPart.Velocity.y < -1 and hit == nil then
            Anim = "Fall"
            if attack == false then
                RootJoint.C0 =
                    Clerp(
                    RootJoint.C0,
                    rc0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(15), math.rad(0), math.rad(0)),
                    1 / 3
                )
                Neck.C0 =
                    Clerp(
                    Neck.C0,
                    nc0 * CFrame.new(0, 0, 0 + ((1) - 1)) *
                        CFrame.Angles(math.rad(-15), math.rad(2.5), math.rad(5 + 5 * math.cos(sine / 12))),
                    1 / 3
                )
                RightShoulder.C0 =
                    Clerp(
                    RightShoulder.C0,
                    CFrame.new(1.5, 0.5, 0) *
                        CFrame.Angles(
                            math.rad(-70 - 4 * math.cos(sine / 6)),
                            math.rad(0),
                            math.rad(0 + 10 * math.cos(sine / 12))
                        ) *
                        rscp,
                    1 / 3
                )
                LeftShoulder.C0 =
                    Clerp(
                    LeftShoulder.C0,
                    CFrame.new(-1.5, 0.5, 0) *
                        CFrame.Angles(
                            math.rad(35 - 4 * math.cos(sine / 6)),
                            math.rad(0),
                            math.rad(-45 - 10 * math.cos(sine / 12))
                        ) *
                        lscp,
                    1 / 3
                )
                RightHip.C0 =
                    Clerp(
                    RightHip.C0,
                    CFrame.new(1, -0.3, -0.7) *
                        CFrame.Angles(math.rad(-25 + 5 * math.sin(sine / 12)), math.rad(90), math.rad(0)) *
                        CFrame.Angles(math.rad(-1 * math.sin(sine / 6)), math.rad(0), math.rad(0)),
                    1 / 3
                )
                LeftHip.C0 =
                    Clerp(
                    LeftHip.C0,
                    CFrame.new(-1, -0.8, -0.3) * CFrame.Angles(math.rad(-10), math.rad(-80), math.rad(0)) *
                        CFrame.Angles(math.rad(-1 * math.sin(sine / 6)), math.rad(0), math.rad(0)),
                    1 / 3
                )
                GunJoint.C0 =
                    Clerp(
                    GunJoint.C0,
                    CFrame.new(0.05, -1, -0.15) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0)),
                    1 / 2
                )
            end
        elseif Torsovelocity < 1 and hit ~= nil then
            Anim = "Idle"
            if attack == false then
                change = 1
                RootJoint.C0 =
                    Clerp(
                    RootJoint.C0,
                    rc0 * CFrame.new(0, 0, 0 + 0.05 * math.cos(sine / 12)) *
                        CFrame.Angles(math.rad(15), math.rad(0), math.rad(0)),
                    1 / 3
                )
                Neck.C0 =
                    Clerp(
                    Neck.C0,
                    nc0 * CFrame.new(0, 0, 0 + ((1) - 1)) *
                        CFrame.Angles(math.rad(-15 - 3 * math.cos(sine / 12)), math.rad(5), math.rad(0)),
                    1 / 3
                )
                RightShoulder.C0 =
                    Clerp(
                    RightShoulder.C0,
                    CFrame.new(1.5, 0.5 + 0.1 * math.cos(sine / 12), 0) *
                        CFrame.Angles(math.rad(-53.75 + 1.75 * math.cos(sine / 12)), math.rad(0), math.rad(5)) *
                        rscp,
                    1 / 3
                )
                LeftShoulder.C0 =
                    Clerp(
                    LeftShoulder.C0,
                    CFrame.new(-1.5, 0.5 + 0.1 * math.cos(sine / 12), -0) *
                        CFrame.Angles(
                            math.rad(15 - 1.5 * math.cos(sine / 12)),
                            math.rad(0 - 6 * math.cos(sine / 12)),
                            math.rad(0 - 6 * math.cos(sine / 12))
                        ) *
                        lscp,
                    1 / 3
                )
                RightHip.C0 =
                    Clerp(
                    RightHip.C0,
                    CFrame.new(1, -1.1 - 0.05 * math.cos(sine / 12), 0) *
                        CFrame.Angles(math.rad(15), math.rad(80), math.rad(0)) *
                        CFrame.Angles(math.rad(-4), math.rad(0), math.rad(0)),
                    1 / 3
                )
                LeftHip.C0 =
                    Clerp(
                    LeftHip.C0,
                    CFrame.new(-1, -1.1 - 0.05 * math.cos(sine / 12), 0) *
                        CFrame.Angles(math.rad(10), math.rad(-70), math.rad(0)) *
                        CFrame.Angles(math.rad(-5), math.rad(0), math.rad(0)),
                    1 / 3
                )
                GunJoint.C0 =
                    Clerp(
                    GunJoint.C0,
                    CFrame.new(0.05, -1, -0.15) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0)),
                    1 / 2
                )
            end
        elseif Torsovelocity > 2 and hit ~= nil then
            Anim = "Walk"
            if attack == false then
                RootJoint.C0 =
                    Clerp(
                    RootJoint.C0,
                    rc0 * CFrame.new(0, 0, 0 + 0.05 * math.cos(sine / 12)) *
                        CFrame.Angles(
                            math.rad(20),
                            math.rad(0 + 2.5 * math.cos(sine / 12)),
                            math.rad(0 - 2.5 * math.cos(sine / 12))
                        ),
                    1 / 3
                )
                Neck.C0 =
                    Clerp(
                    Neck.C0,
                    nc0 * CFrame.new(0, 0, 0 + ((1) - 1)) *
                        CFrame.Angles(
                            math.rad(-20 - 3 * math.cos(sine / 12)),
                            math.rad(0 - 2.5 * math.cos(sine / 12)),
                            math.rad(0 - 2.5 * math.cos(sine / 12))
                        ),
                    1 / 3
                )
                RightShoulder.C0 =
                    Clerp(
                    RightShoulder.C0,
                    CFrame.new(1.5, 0.5, 0) *
                        CFrame.Angles(
                            math.rad(-70 - 5 * math.cos(sine / 12)),
                            math.rad(0 - 2.5 * math.cos(sine / 12)),
                            math.rad(5 + 2.5 * math.cos(sine / 12))
                        ) *
                        rscp,
                    1 / 3
                )
                LeftShoulder.C0 =
                    Clerp(
                    LeftShoulder.C0,
                    CFrame.new(-1.5, 0.5, 0 - 0.2 * math.cos(sine / 12)) *
                        CFrame.Angles(
                            math.rad(20 + 45 * math.cos(sine / 12)),
                            math.rad(0 - 10 * math.cos(sine / 12)),
                            math.rad(0 + 2.5 * math.cos(sine / 12))
                        ) *
                        lscp,
                    1 / 3
                )
                RightHip.C0 =
                    Clerp(
                    RightHip.C0,
                    CFrame.new(1, -1, 0) * CFrame.Angles(math.rad(0), math.rad(85), math.rad(0)) *
                        CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)),
                    1 / 3
                )
                LeftHip.C0 =
                    Clerp(
                    LeftHip.C0,
                    CFrame.new(-1, -1, 0) * CFrame.Angles(math.rad(0), math.rad(-85), math.rad(0)) *
                        CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)),
                    1 / 3
                )
                GunJoint.C0 =
                    Clerp(
                    GunJoint.C0,
                    CFrame.new(0.05, -1, -0.15) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0)),
                    1 / 2
                )
            end
        end
    end
end
