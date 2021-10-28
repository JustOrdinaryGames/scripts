local script = game:GetObjects("rbxassetid://5893542036")[1]

local killScript = false

coroutine.wrap(
    function()
        while wait() do
            if not game.Players.LocalPlayer.Character or not game.Players.LocalPlayer.Character:FindFirstChild("Dummy") then
                killScript = true
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

local plr = game:service "Players".LocalPlayer

local char = miztgetcharacter()
local hum = char:FindFirstChildOfClass "Humanoid"
local hed = char.Head
local root = char:FindFirstChild "HumanoidRootPart"
local rootj = root.RootJoint
local tors = char.Torso
local ra = char["Right Arm"]
local la = char["Left Arm"]
local rl = char["Right Leg"]
local ll = char["Left Leg"]
local neck = tors["Neck"]
local mouse = plr:GetMouse()
local RootCF = CFrame.fromEulerAnglesXYZ(-1.57, 0, 3.14)
local RHCF = CFrame.fromEulerAnglesXYZ(0, 1.6, 0)
local LHCF = CFrame.fromEulerAnglesXYZ(0, -1.6, 0)
local maincolor = BrickColor.new("Really black")
local disach = false
-------------------------------------------------------
--Start Good Stuff--
-------------------------------------------------------
cam = game.Workspace.CurrentCamera
CF = CFrame.new
angles = CFrame.Angles
attack = false
Euler = CFrame.fromEulerAnglesXYZ
Rad = math.rad
IT = Instance.new
BrickC = BrickColor.new
Cos = math.cos
Acos = math.acos
Sin = math.sin
Asin = math.asin
Abs = math.abs
Mrandom = math.random
Floor = math.floor
-------------------------------------------------------
--End Good Stuff--
-------------------------------------------------------
necko = CF(0, 1, 0, -1, -0, -0, 0, 0, 1, 0, 1, 0)
RSH, LSH = nil, nil
RW = Instance.new("Weld")
LW = Instance.new("Weld")
RH = tors["Right Hip"]
LH = tors["Left Hip"]
RSH = tors["Right Shoulder"]
LSH = tors["Left Shoulder"]
RSH.Parent = nil
LSH.Parent = nil
RW.Name = "RW"
RW.Part0 = tors
RW.C0 = CF(1.5, 0.5, 0)
RW.C1 = CF(0, 0.5, 0)
RW.Part1 = ra
RW.Parent = tors
LW.Name = "LW"
LW.Part0 = tors
LW.C0 = CF(-1.5, 0.5, 0)
LW.C1 = CF(0, 0.5, 0)
LW.Part1 = la
LW.Parent = tors
Effects = {}
newWeld = function(wp0, wp1, wc0x, wc0y, wc0z)
    local wld = Instance.new("Weld", wp1)
    wld.Part0 = wp0
    wld.Part1 = wp1
    wld.C0 = CFrame.new(wc0x, wc0y, wc0z)
end
newWeld(tors, ll, -0.5, -1, 0)
ll.Weld.C1 = CFrame.new(0, 1, 0)
newWeld(tors, rl, 0.5, -1, 0)
rl.Weld.C1 = CFrame.new(0, 1, 0)
-------------------------------------------------------
--Start HeartBeat--
-------------------------------------------------------
ArtificialHB = Instance.new("BindableEvent", script)
ArtificialHB.Name = "Heartbeat"
script:WaitForChild("Heartbeat")

frame = 1 / 60
tf = 0
allowframeloss = false
tossremainder = false

lastframe = tick()
ArtificialHB:Fire()

game:GetService("RunService").Heartbeat:connect(
    function(s, p)
        if killScript then
            return
        end
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
-------------------------------------------------------
--End HeartBeat--
-------------------------------------------------------

-------------------------------------------------------
--Start Important Functions--
-------------------------------------------------------
function swait(num)
    if num == 0 or num == nil then
        game:service("RunService").Stepped:wait(0)
    else
        for i = 0, num do
            game:service("RunService").Stepped:wait(0)
        end
    end
end
function thread(f)
    coroutine.resume(coroutine.create(f))
end
function clerp(a, b, t)
    local qa = {
        QuaternionFromCFrame(a)
    }
    local qb = {
        QuaternionFromCFrame(b)
    }
    local ax, ay, az = a.x, a.y, a.z
    local bx, by, bz = b.x, b.y, b.z
    local _t = 1 - t
    return QuaternionToCFrame(_t * ax + t * bx, _t * ay + t * by, _t * az + t * bz, QuaternionSlerp(qa, qb, t))
end
function QuaternionFromCFrame(cf)
    local mx, my, mz, m00, m01, m02, m10, m11, m12, m20, m21, m22 = cf:components()
    local trace = m00 + m11 + m22
    if trace > 0 then
        local s = math.sqrt(1 + trace)
        local recip = 0.5 / s
        return (m21 - m12) * recip, (m02 - m20) * recip, (m10 - m01) * recip, s * 0.5
    else
        local i = 0
        if m00 < m11 then
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
function QuaternionToCFrame(px, py, pz, x, y, z, w)
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
function QuaternionSlerp(a, b, t)
    local cosTheta = a[1] * b[1] + a[2] * b[2] + a[3] * b[3] + a[4] * b[4]
    local startInterp, finishInterp
    if cosTheta >= 1.0E-4 then
        if 1 - cosTheta > 1.0E-4 then
            local theta = math.acos(cosTheta)
            local invSinTheta = 1 / Sin(theta)
            startInterp = Sin((1 - t) * theta) * invSinTheta
            finishInterp = Sin(t * theta) * invSinTheta
        else
            startInterp = 1 - t
            finishInterp = t
        end
    elseif 1 + cosTheta > 1.0E-4 then
        local theta = math.acos(-cosTheta)
        local invSinTheta = 1 / Sin(theta)
        startInterp = Sin((t - 1) * theta) * invSinTheta
        finishInterp = Sin(t * theta) * invSinTheta
    else
        startInterp = t - 1
        finishInterp = t
    end
    return a[1] * startInterp + b[1] * finishInterp, a[2] * startInterp + b[2] * finishInterp, a[3] * startInterp +
        b[3] * finishInterp, a[4] * startInterp + b[4] * finishInterp
end
function rayCast(Position, Direction, Range, Ignore)
    return game:service("Workspace"):FindPartOnRay(Ray.new(Position, Direction.unit * (Range or 999.999)), Ignore)
end
local RbxUtility = LoadLibrary("RbxUtility").Create
local Create = LoadLibrary("RbxUtility").Create

-------------------------------------------------------
--Start Damage Function--
-------------------------------------------------------
function Damage(Part, hit)
    if hit.Parent == nil then
        return
    end
    local h = hit.Parent:FindFirstChild("Humanoid")
    for _, v in pairs(hit.Parent:children()) do
        if v:IsA("Humanoid") then
            h = v
        end
    end

    local FoundTorso = hit.Parent:FindFirstChild("Torso") or hit.Parent:FindFirstChild("UpperTorso")

    if h and FoundTorso then
        flingTarget = hit.Parent
        coroutine.wrap(
            function()
                wait(1)
                flingTarget = miztgetcharacter()
            end
        )()
        ShowDamage(FoundTorso.Position)
    end
end
-------------------------------------------------------
--End Damage Function--
-------------------------------------------------------

-------------------------------------------------------
--Start Damage Function Customization--
-------------------------------------------------------
function Tween(obj, props, time, easing, direction, repeats, backwards)
    local info =
        TweenInfo.new(
        time or .5,
        easing or Enum.EasingStyle.Quad,
        direction or Enum.EasingDirection.Out,
        repeats or 0,
        backwards or false
    )
    local tween = game.TweenService:Create(obj, info, props)
    tween:Play()
end
function ShowDamage(Pos, Text, Time, Color)
    local Rate = (1 / 30)
    local Pos = (Pos or Vector3.new(0, 0, 0))
    local Text = (Text or "")
    local Time = (Time or 2)
    local Color = (Color or Color3.new(1, 0, 1))
    local EffectPart =
        CFuncs.Part.Create(workspace, "SmoothPlastic", 0, 1, BrickColor.new(Color), "Effect", Vector3.new(0, 0, 0))
    EffectPart.Anchored = true
    local BillboardGui =
        NewInstance(
        "BillboardGui",
        EffectPart,
        {
            Size = UDim2.new(3, 0, 3, 0),
            Adornee = EffectPart
        }
    )
    local TextLabel =
        NewInstance(
        "TextLabel",
        BillboardGui,
        {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            Text = Text,
            Font = "Bodoni",
            TextColor3 = Color,
            TextStrokeColor3 = Color3.new(0, 0, 0),
            TextStrokeTransparency = 0,
            TextScaled = true
        }
    )
    game.Debris:AddItem(EffectPart, (Time))
    EffectPart.Parent = game:GetService("Workspace")
    delay(
        0,
        function()
            Tween(
                EffectPart,
                {CFrame = CF(Pos) * CF(0.5, 0, 0.1)},
                Time,
                Enum.EasingStyle.Elastic,
                Enum.EasingDirection.Out
            )
            local Frames = (Time / Rate)
            for Frame = 1, Frames do
                wait(Rate)
                local Percent = (Frame / Frames)
                EffectPart.CFrame = CFrame.new(Pos) + Vector3.new(0, Percent, 0)
                TextLabel.TextTransparency = Percent
            end
            if EffectPart and EffectPart.Parent then
                EffectPart:Destroy()
            end
        end
    )
end
-------------------------------------------------------
--End Damage Function Customization--
-------------------------------------------------------

function MagniDamage(Part, magni, mindam, maxdam, knock, Type)
    for _, c in pairs(workspace:children()) do
        local hum = c:findFirstChild("Humanoid")
        if hum ~= nil then
            local head = c:findFirstChild("Head")
            if head ~= nil then
                local targ = head.Position - Part.Position
                local mag = targ.magnitude
                if magni >= mag and c.Name ~= plr.Name then
                    Damage(head, head, mindam, maxdam, knock, Type, root, 0.1, "http://www.roblox.com/asset/?id=0", 1.2)
                end
            end
        end
    end
end

CFuncs = {
    Part = {
        Create = function(Parent, Material, Reflectance, Transparency, BColor, Name, Size)
            local Part =
                Create("Part")(
                {
                    Parent = Parent,
                    Reflectance = Reflectance,
                    Transparency = Transparency,
                    CanCollide = false,
                    Locked = true,
                    BrickColor = BrickColor.new(tostring(BColor)),
                    Name = Name,
                    Size = Size,
                    Material = Material
                }
            )
            RemoveOutlines(Part)
            return Part
        end
    },
    Mesh = {
        Create = function(Mesh, Part, MeshType, MeshId, OffSet, Scale)
            local Msh =
                Create(Mesh)(
                {
                    Parent = Part,
                    Offset = OffSet,
                    Scale = Scale
                }
            )
            if Mesh == "SpecialMesh" then
                Msh.MeshType = MeshType
                Msh.MeshId = MeshId
            end
            return Msh
        end
    },
    Mesh = {
        Create = function(Mesh, Part, MeshType, MeshId, OffSet, Scale)
            local Msh =
                Create(Mesh)(
                {
                    Parent = Part,
                    Offset = OffSet,
                    Scale = Scale
                }
            )
            if Mesh == "SpecialMesh" then
                Msh.MeshType = MeshType
                Msh.MeshId = MeshId
            end
            return Msh
        end
    },
    Weld = {
        Create = function(Parent, Part0, Part1, C0, C1)
            local Weld =
                Create("Weld")(
                {
                    Parent = Parent,
                    Part0 = Part0,
                    Part1 = Part1,
                    C0 = C0,
                    C1 = C1
                }
            )
            return Weld
        end
    },
    Sound = {
        Create = function(id, par, vol, pit)
            coroutine.resume(
                coroutine.create(
                    function()
                        local S =
                            Create("Sound")(
                            {
                                Volume = vol,
                                Pitch = pit or 1,
                                SoundId = id,
                                Parent = par or workspace
                            }
                        )
                        wait()
                        S:play()
                        game:GetService("Debris"):AddItem(S, 6)
                    end
                )
            )
        end
    },
    ParticleEmitter = {
        Create = function(
            Parent,
            Color1,
            Color2,
            LightEmission,
            Size,
            Texture,
            Transparency,
            ZOffset,
            Accel,
            Drag,
            LockedToPart,
            VelocityInheritance,
            EmissionDirection,
            Enabled,
            LifeTime,
            Rate,
            Rotation,
            RotSpeed,
            Speed,
            VelocitySpread)
            local fp =
                Create("ParticleEmitter")(
                {
                    Parent = Parent,
                    Color = ColorSequence.new(Color1, Color2),
                    LightEmission = LightEmission,
                    Size = Size,
                    Texture = Texture,
                    Transparency = Transparency,
                    ZOffset = ZOffset,
                    Acceleration = Accel,
                    Drag = Drag,
                    LockedToPart = LockedToPart,
                    VelocityInheritance = VelocityInheritance,
                    EmissionDirection = EmissionDirection,
                    Enabled = Enabled,
                    Lifetime = LifeTime,
                    Rate = Rate,
                    Rotation = Rotation,
                    RotSpeed = RotSpeed,
                    Speed = Speed,
                    VelocitySpread = VelocitySpread
                }
            )
            return fp
        end
    }
}
function RemoveOutlines(part)
    part.TopSurface, part.BottomSurface, part.LeftSurface, part.RightSurface, part.FrontSurface, part.BackSurface =
        10,
        10,
        10,
        10,
        10,
        10
end
function CreatePart(FormFactor, Parent, Material, Reflectance, Transparency, BColor, Name, Size)
    local Part =
        Create("Part")(
        {
            formFactor = FormFactor,
            Parent = Parent,
            Reflectance = Reflectance,
            Transparency = Transparency,
            CanCollide = false,
            Locked = true,
            BrickColor = BrickColor.new(tostring(BColor)),
            Name = Name,
            Size = Size,
            Material = Material
        }
    )
    RemoveOutlines(Part)
    return Part
end
function CreateMesh(Mesh, Part, MeshType, MeshId, OffSet, Scale)
    local Msh =
        Create(Mesh)(
        {
            Parent = Part,
            Offset = OffSet,
            Scale = Scale
        }
    )
    if Mesh == "SpecialMesh" then
        Msh.MeshType = MeshType
        Msh.MeshId = MeshId
    end
    return Msh
end
function CreateWeld(Parent, Part0, Part1, C0, C1)
    local Weld =
        Create("Weld")(
        {
            Parent = Parent,
            Part0 = Part0,
            Part1 = Part1,
            C0 = C0,
            C1 = C1
        }
    )
    return Weld
end

-------------------------------------------------------
--Start Effect Function--
-------------------------------------------------------
EffectModel = Instance.new("Model", char)
Effects = {
    Block = {
        Create = function(brickcolor, cframe, x1, y1, z1, x3, y3, z3, delay, Type)
            local prt = CFuncs.Part.Create(EffectModel, "SmoothPlastic", 0, 0, brickcolor, "Effect", Vector3.new())
            prt.Anchored = true
            prt.CFrame = cframe
            local msh = CFuncs.Mesh.Create("BlockMesh", prt, "", "", Vector3.new(0, 0, 0), Vector3.new(x1, y1, z1))
            game:GetService("Debris"):AddItem(prt, 10)
            if Type == 1 or Type == nil then
                table.insert(
                    Effects,
                    {
                        prt,
                        "Block1",
                        delay,
                        x3,
                        y3,
                        z3,
                        msh
                    }
                )
            elseif Type == 2 then
                table.insert(
                    Effects,
                    {
                        prt,
                        "Block2",
                        delay,
                        x3,
                        y3,
                        z3,
                        msh
                    }
                )
            else
                table.insert(
                    Effects,
                    {
                        prt,
                        "Block3",
                        delay,
                        x3,
                        y3,
                        z3,
                        msh
                    }
                )
            end
        end
    },
    Sphere = {
        Create = function(brickcolor, cframe, x1, y1, z1, x3, y3, z3, delay)
            local prt = CFuncs.Part.Create(EffectModel, "Neon", 0, 0, brickcolor, "Effect", Vector3.new())
            prt.Anchored = true
            prt.CFrame = cframe
            local msh =
                CFuncs.Mesh.Create("SpecialMesh", prt, "Sphere", "", Vector3.new(0, 0, 0), Vector3.new(x1, y1, z1))
            game:GetService("Debris"):AddItem(prt, 10)
            table.insert(
                Effects,
                {
                    prt,
                    "Cylinder",
                    delay,
                    x3,
                    y3,
                    z3,
                    msh
                }
            )
        end
    },
    Cylinder = {
        Create = function(brickcolor, cframe, x1, y1, z1, x3, y3, z3, delay)
            local prt = CFuncs.Part.Create(EffectModel, "SmoothPlastic", 0, 0, brickcolor, "Effect", Vector3.new())
            prt.Anchored = true
            prt.CFrame = cframe
            local msh = CFuncs.Mesh.Create("CylinderMesh", prt, "", "", Vector3.new(0, 0, 0), Vector3.new(x1, y1, z1))
            game:GetService("Debris"):AddItem(prt, 10)
            table.insert(
                Effects,
                {
                    prt,
                    "Cylinder",
                    delay,
                    x3,
                    y3,
                    z3,
                    msh
                }
            )
        end
    },
    Wave = {
        Create = function(brickcolor, cframe, x1, y1, z1, x3, y3, z3, delay)
            local prt = CFuncs.Part.Create(EffectModel, "Neon", 0, 0, brickcolor, "Effect", Vector3.new())
            prt.Anchored = true
            prt.CFrame = cframe
            local msh =
                CFuncs.Mesh.Create(
                "SpecialMesh",
                prt,
                "FileMesh",
                "rbxassetid://20329976",
                Vector3.new(0, 0, 0),
                Vector3.new(x1 / 60, y1 / 60, z1 / 60)
            )
            game:GetService("Debris"):AddItem(prt, 10)
            table.insert(
                Effects,
                {
                    prt,
                    "Cylinder",
                    delay,
                    x3 / 60,
                    y3 / 60,
                    z3 / 60,
                    msh
                }
            )
        end
    },
    Ring = {
        Create = function(brickcolor, cframe, x1, y1, z1, x3, y3, z3, delay)
            local prt = CFuncs.Part.Create(EffectModel, "SmoothPlastic", 0, 0, brickcolor, "Effect", Vector3.new())
            prt.Anchored = true
            prt.CFrame = cframe
            local msh =
                CFuncs.Mesh.Create(
                "SpecialMesh",
                prt,
                "FileMesh",
                "rbxassetid://3270017",
                Vector3.new(0, 0, 0),
                Vector3.new(x1, y1, z1)
            )
            game:GetService("Debris"):AddItem(prt, 10)
            table.insert(
                Effects,
                {
                    prt,
                    "Cylinder",
                    delay,
                    x3,
                    y3,
                    z3,
                    msh
                }
            )
        end
    },
    Break = {
        Create = function(brickcolor, cframe, x1, y1, z1)
            local prt = CFuncs.Part.Create(EffectModel, "Neon", 0, 0, brickcolor, "Effect", Vector3.new(0.5, 0.5, 0.5))
            prt.Anchored = true
            prt.CFrame =
                cframe * CFrame.fromEulerAnglesXYZ(math.random(-50, 50), math.random(-50, 50), math.random(-50, 50))
            local msh =
                CFuncs.Mesh.Create("SpecialMesh", prt, "Sphere", "", Vector3.new(0, 0, 0), Vector3.new(x1, y1, z1))
            local num = math.random(10, 50) / 1000
            game:GetService("Debris"):AddItem(prt, 10)
            table.insert(
                Effects,
                {
                    prt,
                    "Shatter",
                    num,
                    prt.CFrame,
                    math.random() - math.random(),
                    0,
                    math.random(50, 100) / 100
                }
            )
        end
    },
    Spiral = {
        Create = function(brickcolor, cframe, x1, y1, z1, x3, y3, z3, delay)
            local prt = CFuncs.Part.Create(EffectModel, "SmoothPlastic", 0, 0, brickcolor, "Effect", Vector3.new())
            prt.Anchored = true
            prt.CFrame = cframe
            local msh =
                CFuncs.Mesh.Create(
                "SpecialMesh",
                prt,
                "FileMesh",
                "rbxassetid://1051557",
                Vector3.new(0, 0, 0),
                Vector3.new(x1, y1, z1)
            )
            game:GetService("Debris"):AddItem(prt, 10)
            table.insert(
                Effects,
                {
                    prt,
                    "Cylinder",
                    delay,
                    x3,
                    y3,
                    z3,
                    msh
                }
            )
        end
    },
    Push = {
        Create = function(brickcolor, cframe, x1, y1, z1, x3, y3, z3, delay)
            local prt = CFuncs.Part.Create(EffectModel, "SmoothPlastic", 0, 0, brickcolor, "Effect", Vector3.new())
            prt.Anchored = true
            prt.CFrame = cframe
            local msh =
                CFuncs.Mesh.Create(
                "SpecialMesh",
                prt,
                "FileMesh",
                "rbxassetid://437347603",
                Vector3.new(0, 0, 0),
                Vector3.new(x1, y1, z1)
            )
            game:GetService("Debris"):AddItem(prt, 10)
            table.insert(
                Effects,
                {
                    prt,
                    "Cylinder",
                    delay,
                    x3,
                    y3,
                    z3,
                    msh
                }
            )
        end
    }
}
function part(formfactor, parent, reflectance, transparency, brickcolor, name, size)
    local fp = IT("Part")
    fp.formFactor = formfactor
    fp.Parent = parent
    fp.Reflectance = reflectance
    fp.Transparency = transparency
    fp.CanCollide = false
    fp.Locked = true
    fp.BrickColor = brickcolor
    fp.Name = name
    fp.Size = size
    fp.Position = tors.Position
    RemoveOutlines(fp)
    fp.Material = "SmoothPlastic"
    fp:BreakJoints()
    return fp
end

function mesh(Mesh, part, meshtype, meshid, offset, scale)
    local mesh = IT(Mesh)
    mesh.Parent = part
    if Mesh == "SpecialMesh" then
        mesh.MeshType = meshtype
        if meshid ~= "nil" then
            mesh.MeshId = "http://www.roblox.com/asset/?id=" .. meshid
        end
    end
    mesh.Offset = offset
    mesh.Scale = scale
    return mesh
end

function Magic(bonuspeed, type, pos, scale, value, color, MType)
    local type = type
    local rng = Instance.new("Part", char)
    rng.Anchored = true
    rng.BrickColor = color
    rng.CanCollide = false
    rng.FormFactor = 3
    rng.Name = "Ring"
    rng.Material = "Neon"
    rng.Size = Vector3.new(1, 1, 1)
    rng.Transparency = 0
    rng.TopSurface = 0
    rng.BottomSurface = 0
    rng.CFrame = pos
    local rngm = Instance.new("SpecialMesh", rng)
    rngm.MeshType = MType
    rngm.Scale = scale
    local scaler2 = 1
    if type == "Add" then
        scaler2 = 1 * value
    elseif type == "Divide" then
        scaler2 = 1 / value
    end
    coroutine.resume(
        coroutine.create(
            function()
                for i = 0, 10 / bonuspeed, 0.1 do
                    swait()
                    if type == "Add" then
                        scaler2 = scaler2 - 0.01 * value / bonuspeed
                    elseif type == "Divide" then
                        scaler2 = scaler2 - 0.01 / value * bonuspeed
                    end
                    rng.Transparency = rng.Transparency + 0.01 * bonuspeed
                    rngm.Scale = rngm.Scale + Vector3.new(scaler2 * bonuspeed, scaler2 * bonuspeed, scaler2 * bonuspeed)
                end
                rng:Destroy()
            end
        )
    )
end

function ManSlaughter(MAN)
    if MAN then
        local ROOT = MAN:FindFirstChild("HumanoidRootPart")
        if ROOT then
            ROOT:Remove()
        end
        local MANHUM = MAN:FindFirstChildOfClass("Humanoid")
        if MANHUM then
            MANHUM.BreakJointsOnDeath = false
            MANHUM.Health = 0
        end
        if MAN:FindFirstChild("R6Ragdoll") == nil and MAN:FindFirstChild("R15Ragdoll") == nil then
            if MAN:FindFirstChild("UpperTorso") then
                local SCRIPT = script.R15Ragdoll:Clone()
                SCRIPT.Parent = MAN
                SCRIPT.Disabled = false
            else
                local SCRIPT = script.R6Ragdoll:Clone()
                SCRIPT.Parent = MAN
                SCRIPT.Disabled = false
            end
            local TORSO = MAN:FindFirstChild("Torso") or MAN:FindFirstChild("UpperTorso")
            if TORSO then
            --NewSound({ID = 146594648,PARENT = TORSO,VOLUME = 1,PITCH = MRANDOM(8,12)/10,LOOP = false,MAXDISTANCE = 75,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
            end
        end
        MAN:BreakJoints()
        if MAN:FindFirstChild("Slaughtered") == nil then
            local MARK = IT("Folder", MAN)
            MARK.Name = "Slaughtered"
        else
            if MAN:FindFirstChild("Slaughtered") then
                local TORSO = MAN:FindFirstChild("Torso") or MAN:FindFirstChild("UpperTorso")
                if TORSO then
                    TORSO.RotVelocity = Vector3.new(0, Mrandom(-25, 25), 0)
                end
            end
        end
    end
end

function OOFf(dude)
    if dude.Name ~= char then
        --local bgf = IT("BodyGyro", dude.Head or dude.Torso or dude.UpperTorso)
        --bgf.CFrame = bgf.CFrame * CFrame.fromEulerAnglesXYZ(Rad(-90), 0, 0)
        local val = IT("BoolValue", dude)
        val.Name = "IsHit"
        local ds =
            coroutine.wrap(
            function()
                Cso("958257111", dude.Head, 6, 1)
                --Cso("192104941", dude.Torso or dude.UpperTorso, 6, 1)
                wait(0.2)
                target = nil
                coroutine.resume(
                    coroutine.create(
                        function()
                            if dude:FindFirstChild("Head") then
                                Damage(dude, dude.Head)
                            end
                        end
                    )
                )
            end)
        ds()
    end
end

function FindNearestHead(Position, Distance, SinglePlayer)
    if SinglePlayer then
        return Distance > (SinglePlayer.Torso.CFrame.p - Position).magnitude
    end
    local List = {}
    for i, v in pairs(workspace:GetChildren()) do
        if
            v:IsA("Model") and v:findFirstChild("Head") and v ~= char and
                Distance >= (v.Head.Position - Position).magnitude
         then
            table.insert(List, v)
        end
    end
    return List
end

function Aura(bonuspeed, FastSpeed, type, pos, x1, y1, z1, value, color, outerpos, MType)
    local type = type
    local rng = Instance.new("Part", char)
    rng.Anchored = true
    rng.BrickColor = color
    rng.CanCollide = false
    rng.FormFactor = 3
    rng.Name = "Ring"
    rng.Material = "Neon"
    rng.Size = Vector3.new(1, 1, 1)
    rng.Transparency = 0
    rng.TopSurface = 0
    rng.BottomSurface = 0
    rng.CFrame = pos
    rng.CFrame = rng.CFrame + rng.CFrame.lookVector * outerpos
    local rngm = Instance.new("SpecialMesh", rng)
    rngm.MeshType = MType
    rngm.Scale = Vector3.new(x1, y1, z1)
    local scaler2 = 1
    local speeder = FastSpeed
    if type == "Add" then
        scaler2 = 1 * value
    elseif type == "Divide" then
        scaler2 = 1 / value
    end
    coroutine.resume(
        coroutine.create(
            function()
                for i = 0, 10 / bonuspeed, 0.1 do
                    swait()
                    if type == "Add" then
                        scaler2 = scaler2 - 0.01 * value / bonuspeed
                    elseif type == "Divide" then
                        scaler2 = scaler2 - 0.01 / value * bonuspeed
                    end
                    speeder = speeder - 0.01 * FastSpeed * bonuspeed
                    rng.CFrame = rng.CFrame + rng.CFrame.lookVector * speeder * bonuspeed
                    rng.Transparency = rng.Transparency + 0.01 * bonuspeed
                    rngm.Scale = rngm.Scale + Vector3.new(scaler2 * bonuspeed, scaler2 * bonuspeed, 0)
                end
                rng:Destroy()
            end
        )
    )
end
function HitboxFunction(Pose, lifetime, siz1, siz2, siz3, Radie, Min, Max, kb, atype)
    local Hitboxpart = Instance.new("Part", EffectModel)
    RemoveOutlines(Hitboxpart)
    Hitboxpart.Size = Vector3.new(siz1, siz2, siz3)
    Hitboxpart.CanCollide = false
    Hitboxpart.Transparency = 1
    Hitboxpart.Anchored = true
    Hitboxpart.CFrame = Pose
    game:GetService("Debris"):AddItem(Hitboxpart, lifetime)
    MagniDamage(Hitboxpart, Radie, Min, Max, kb, atype)
end
function SoulSteal(dude)
    if dude.Name ~= char then
        local bgf = IT("BodyGyro", dude.Head)
        bgf.CFrame = bgf.CFrame * CFrame.fromEulerAnglesXYZ(Rad(-90), 0, 0)
        local val = IT("BoolValue", dude)
        val.Name = "IsHit"
        local torso =
            (dude:FindFirstChild "Head" or dude:FindFirstChild "Torso" or dude:FindFirstChild "UpperTorso" or
            dude:FindFirstChild "LowerTorso" or
            dude:FindFirstChild "HumanoidRootPart")
        local soulst =
            coroutine.wrap(
            function()
                local soul = Instance.new("Part", dude)
                soul.Size = Vector3.new(1, 1, 1)
                soul.CanCollide = false
                soul.Anchored = false
                soul.Position = torso.Position
                soul.Transparency = 1
                local PartEmmit1 = IT("ParticleEmitter", soul)
                PartEmmit1.LightEmission = 1
                PartEmmit1.Texture = "rbxassetid://569507414"
                PartEmmit1.Color = ColorSequence.new(maincolor.Color)
                PartEmmit1.Rate = 250
                PartEmmit1.Lifetime = NumberRange.new(1.6)
                PartEmmit1.Size =
                    NumberSequence.new(
                    {
                        NumberSequenceKeypoint.new(0, 1, 0),
                        NumberSequenceKeypoint.new(1, 0, 0)
                    }
                )
                PartEmmit1.Transparency =
                    NumberSequence.new(
                    {
                        NumberSequenceKeypoint.new(0, 0, 0),
                        NumberSequenceKeypoint.new(1, 1, 0)
                    }
                )
                PartEmmit1.Speed = NumberRange.new(0, 0)
                PartEmmit1.VelocitySpread = 30000
                PartEmmit1.Rotation = NumberRange.new(-360, 360)
                PartEmmit1.RotSpeed = NumberRange.new(-360, 360)
                local BodPoss = IT("BodyPosition", soul)
                BodPoss.P = 3000
                BodPoss.D = 1000
                BodPoss.maxForce = Vector3.new(50000000000, 50000000000, 50000000000)
                BodPoss.position = torso.Position + Vector3.new(Mrandom(-15, 15), Mrandom(-15, 15), Mrandom(-15, 15))
                wait(1.6)
                soul.Touched:connect(
                    function(hit)
                        if killScript then
                            return
                        end
                        if hit.Parent == char then
                            soul:Destroy()
                        end
                    end
                )
                wait(1.2)
                while soul and not killScript do
                    swait()
                    PartEmmit1.Color = ColorSequence.new(maincolor.Color)
                    BodPoss.Position = tors.Position
                end
            end
        )
        soulst()
    end
end
function FaceMouse()
    local Cam = workspace.CurrentCamera
    return {
        CFrame.new(char.Torso.Position, Vector3.new(mouse.Hit.p.x, char.Torso.Position.y, mouse.Hit.p.z)),
        Vector3.new(mouse.Hit.p.x, mouse.Hit.p.y, mouse.Hit.p.z)
    }
end
Effects = {
    Block = function(cf, partsize, meshstart, meshadd, matr, colour, spin, inverse, factor)
        local p = Instance.new("Part", EffectModel)
        p.BrickColor = BrickColor.new(colour)
        p.Size = partsize
        p.Anchored = true
        p.CanCollide = false
        p.Material = matr
        p.CFrame = cf
        if inverse == true then
            p.Transparency = 1
        else
            p.Transparency = 0
        end
        local m = Instance.new("BlockMesh", p)
        m.Scale = meshstart
        coroutine.wrap(
            function()
                for i = 0, 1, factor do
                    swait()
                    if inverse == true then
                        p.Transparency = 1 - i
                    else
                        p.Transparency = i
                    end
                    m.Scale = m.Scale + meshadd
                    if spin == true then
                        p.CFrame =
                            p.CFrame * CFrame.Angles(math.random(-50, 50), math.random(-50, 50), math.random(-50, 50))
                    end
                end
                p:Destroy()
            end
        )()
        return p
    end,
    Sphere = function(cf, partsize, meshstart, meshadd, matr, colour, inverse, factor)
        local p = Instance.new("Part", EffectModel)
        p.BrickColor = BrickColor.new(colour)
        p.Size = partsize
        p.Anchored = true
        p.CanCollide = false
        p.Material = matr
        p.CFrame = cf
        if inverse == true then
            p.Transparency = 1
        else
            p.Transparency = 0
        end
        local m = Instance.new("SpecialMesh", p)
        m.MeshType = "Sphere"
        m.Scale = meshstart
        coroutine.wrap(
            function()
                for i = 0, 1, factor do
                    swait()
                    if inverse == true then
                        p.Transparency = 1 - i
                    else
                        p.Transparency = i
                    end
                    m.Scale = m.Scale + meshadd
                end
                p:Destroy()
            end
        )()
        return p
    end,
    Cylinder = function(cf, partsize, meshstart, meshadd, matr, colour, inverse, factor)
        local p = Instance.new("Part", EffectModel)
        p.BrickColor = BrickColor.new(colour)
        p.Size = partsize
        p.Anchored = true
        p.CanCollide = false
        p.Material = matr
        p.CFrame = cf
        if inverse == true then
            p.Transparency = 1
        else
            p.Transparency = 0
        end
        local m = Instance.new("CylinderMesh", p)
        m.Scale = meshstart
        coroutine.wrap(
            function()
                for i = 0, 1, factor do
                    swait()
                    if inverse == true then
                        p.Transparency = 1 - i
                    else
                        p.Transparency = i
                    end
                    m.Scale = m.Scale + meshadd
                end
                p:Destroy()
            end
        )()
        return p
    end,
    Wave = function(cf, meshstart, meshadd, colour, spin, inverse, factor)
        local p = Instance.new("Part", EffectModel)
        p.BrickColor = BrickColor.new(colour)
        p.Size = Vector3.new()
        p.Anchored = true
        p.CanCollide = false
        p.CFrame = cf
        if inverse == true then
            p.Transparency = 1
        else
            p.Transparency = 0
        end
        local m = Instance.new("SpecialMesh", p)
        m.MeshId = "rbxassetid://20329976"
        m.Scale = meshstart
        coroutine.wrap(
            function()
                for i = 0, 1, factor do
                    swait()
                    if inverse == true then
                        p.Transparency = 1 - i
                    else
                        p.Transparency = i
                    end
                    m.Scale = m.Scale + meshadd
                    p.CFrame = p.CFrame * CFrame.Angles(0, math.rad(spin), 0)
                end
                p:Destroy()
            end
        )()
        return p
    end,
    Ring = function(cf, meshstart, meshadd, colour, inverse, factor)
        local p = Instance.new("Part", EffectModel)
        p.BrickColor = BrickColor.new(colour)
        p.Size = Vector3.new()
        p.Anchored = true
        p.CanCollide = false
        p.CFrame = cf
        if inverse == true then
            p.Transparency = 1
        else
            p.Transparency = 0
        end
        local m = Instance.new("SpecialMesh", p)
        m.MeshId = "rbxassetid://3270017"
        m.Scale = meshstart
        coroutine.wrap(
            function()
                for i = 0, 1, factor do
                    swait()
                    if inverse == true then
                        p.Transparency = 1 - i
                    else
                        p.Transparency = i
                    end
                    m.Scale = m.Scale + meshadd
                end
                p:Destroy()
            end
        )()
        return p
    end,
    Meshed = function(cf, meshstart, meshadd, colour, meshid, textid, spin, inverse, factor)
        local p = Instance.new("Part", EffectModel)
        p.BrickColor = BrickColor.new(colour)
        p.Size = Vector3.new()
        p.Anchored = true
        p.CanCollide = false
        p.CFrame = cf
        if inverse == true then
            p.Transparency = 1
        else
            p.Transparency = 0
        end
        local m = Instance.new("SpecialMesh", p)
        m.MeshId = meshid
        m.TextureId = textid
        m.Scale = meshstart
        coroutine.wrap(
            function()
                for i = 0, 1, factor do
                    swait()
                    if inverse == true then
                        p.Transparency = 1 - i
                    else
                        p.Transparency = i
                    end
                    m.Scale = m.Scale + meshadd
                    p.CFrame = p.CFrame * CFrame.Angles(0, math.rad(spin), 0)
                end
                p:Destroy()
            end
        )()
        return p
    end,
    Explode = function(cf, partsize, meshstart, meshadd, matr, colour, move, inverse, factor)
        local p = Instance.new("Part", EffectModel)
        p.BrickColor = BrickColor.new(colour)
        p.Size = partsize
        p.Anchored = true
        p.CanCollide = false
        p.Material = matr
        p.CFrame =
            cf *
            CFrame.Angles(
                math.rad(math.random(-360, 360)),
                math.rad(math.random(-360, 360)),
                math.rad(math.random(-360, 360))
            )
        if inverse == true then
            p.Transparency = 1
        else
            p.Transparency = 0
        end
        local m = Instance.new("SpecialMesh", p)
        m.MeshType = "Sphere"
        m.Scale = meshstart
        coroutine.wrap(
            function()
                for i = 0, 1, factor do
                    swait()
                    if inverse == true then
                        p.Transparency = 1 - i
                    else
                        p.Transparency = i
                    end
                    m.Scale = m.Scale + meshadd
                    p.CFrame = p.CFrame * CFrame.new(0, move, 0)
                end
                p:Destroy()
            end
        )()
        return p
    end
}
function PixelBlockX(bonuspeed, FastSpeed, type, pos, x1, y1, z1, value, color, outerpos)
    local type = type
    local rng = Instance.new("Part", char)
    rng.Anchored = true
    rng.BrickColor = color
    rng.CanCollide = false
    rng.FormFactor = 3
    rng.Name = "Ring"
    rng.Material = "Neon"
    rng.Size = Vector3.new(1, 1, 1)
    rng.Transparency = 0
    rng.TopSurface = 0
    rng.BottomSurface = 0
    rng.CFrame = pos
    rng.CFrame = rng.CFrame + rng.CFrame.lookVector * outerpos
    local rngm = Instance.new("SpecialMesh", rng)
    rngm.MeshType = "Brick"
    rngm.Scale = Vector3.new(x1, y1, z1)
    local scaler2 = 1
    local speeder = FastSpeed / 10
    if type == "Add" then
        scaler2 = 1 * value
    elseif type == "Divide" then
        scaler2 = 1 / value
    end
    coroutine.resume(
        coroutine.create(
            function()
                for i = 0, 10 / bonuspeed, 0.1 do
                    swait()
                    if type == "Add" then
                        scaler2 = scaler2 - 0.01 * value / bonuspeed
                    elseif type == "Divide" then
                        scaler2 = scaler2 - 0.01 / value * bonuspeed
                    end
                    speeder = speeder - 0.01 * FastSpeed * bonuspeed / 10
                    rng.CFrame = rng.CFrame + rng.CFrame.lookVector * speeder * bonuspeed
                    rng.Transparency = rng.Transparency + 0.01 * bonuspeed
                    rngm.Scale = rngm.Scale - Vector3.new(scaler2 * bonuspeed, scaler2 * bonuspeed, scaler2 * bonuspeed)
                end
                rng:Destroy()
            end
        )
    )
end
function CrP(FORMFACTOR, PARENT, MATERIAL, REFLECTANCE, TRANSPARENCY, BRICKCOLOR, NAME, SIZE, ANCHOR)
    local NEWPART = IT("Part")
    NEWPART.formFactor = FORMFACTOR
    NEWPART.Reflectance = REFLECTANCE
    NEWPART.Transparency = TRANSPARENCY
    NEWPART.CanCollide = false
    NEWPART.Locked = true
    NEWPART.Anchored = true
    if ANCHOR == false then
        NEWPART.Anchored = false
    end
    NEWPART.BrickColor = BrickC(tostring(BRICKCOLOR))
    NEWPART.Name = NAME
    NEWPART.Size = SIZE
    NEWPART.Position = tors.Position
    NEWPART.Material = MATERIAL
    NEWPART:BreakJoints()
    NEWPART.Parent = PARENT
    return NEWPART
end
function CrM(MESH, PARENT, MESHTYPE, MESHID, TEXTUREID, SCALE, OFFSET)
    local NEWMESH = IT(MESH)
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
local BEGONE_Particle =
    Create("ParticleEmitter") {
    Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.new(1, 1, 1)),
    Transparency = NumberSequence.new(
        {
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(0.1, 0),
            NumberSequenceKeypoint.new(0.3, 0),
            NumberSequenceKeypoint.new(0.5, .2),
            NumberSequenceKeypoint.new(1, 1)
        }
    ),
    Size = NumberSequence.new(
        {
            NumberSequenceKeypoint.new(0, 0),
            NumberSequenceKeypoint.new(.15, 1.5),
            NumberSequenceKeypoint.new(.75, 1.5),
            NumberSequenceKeypoint.new(1, 0)
        }
    ),
    Texture = "rbxassetid://936193661",
    Lifetime = NumberRange.new(1.5),
    Rate = 5,
    VelocitySpread = 0,
    Rotation = NumberRange.new(0),
    RotSpeed = NumberRange.new(-10, 10),
    Speed = NumberRange.new(0),
    LightEmission = .25,
    LockedToPart = true,
    Acceleration = Vector3.new(0, -0, 0),
    EmissionDirection = "Top",
    Drag = 4,
    ZOffset = 1,
    Enabled = false
}
function weld(parent, part0, part1, c0)
    local weld = IT("Weld")
    weld.Parent = parent
    weld.Part0 = part0
    weld.Part1 = part1
    weld.C0 = c0
    return weld
end
local Effs = IT("Folder", char)
Effs.Name = "Effects"
function WACKYEFFECT(Table)
    local TYPE = (Table.EffectType or "Sphere")
    local SIZE = (Table.Size or Vector3.new(1, 1, 1))
    local ENDSIZE = (Table.Size2 or Vector3.new(0, 0, 0))
    local TRANSPARENCY = (Table.Transparency or 0)
    local ENDTRANSPARENCY = (Table.Transparency2 or 1)
    local CFRAME = (Table.CFrame or tors.CFrame)
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
    coroutine.resume(
        coroutine.create(
            function()
                local PLAYSSOUND = false
                local SOUND = nil
                local EFFECT =
                    CrP(3, Effs, MATERIAL, 0, TRANSPARENCY, BrickC("Pearl"), "Effect", Vector3.new(1, 1, 1), true)
                if SOUNDID ~= nil and SOUNDPITCH ~= nil and SOUNDVOLUME ~= nil then
                    PLAYSSOUND = true
                    SOUND = Cso(SOUNDID, EFFECT, SOUNDVOLUME, SOUNDPITCH)
                end
                EFFECT.Color = COLOR
                local MSH = nil
                if TYPE == "Sphere" then
                    MSH = CrM("SpecialMesh", EFFECT, "Sphere", "", "", SIZE, Vector3.new(0, 0, 0))
                elseif TYPE == "Block" or TYPE == "Box" then
                    MSH = IT("BlockMesh", EFFECT)
                    MSH.Scale = SIZE
                elseif TYPE == "Wave" then
                    MSH = CrM("SpecialMesh", EFFECT, "FileMesh", "20329976", "", SIZE, Vector3.new(0, 0, -SIZE.X / 8))
                elseif TYPE == "Ring" then
                    MSH =
                        CrM(
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
                        CrM(
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
                        CrM(
                        "SpecialMesh",
                        EFFECT,
                        "FileMesh",
                        "662585058",
                        "",
                        Vector3.new(SIZE.X / 10, 0, SIZE.X / 10),
                        Vector3.new(0, 0, 0)
                    )
                elseif TYPE == "Swirl" then
                    MSH = CrM("SpecialMesh", EFFECT, "FileMesh", "1051557", "", SIZE, Vector3.new(0, 0, 0))
                elseif TYPE == "Skull" then
                    MSH = CrM("SpecialMesh", EFFECT, "FileMesh", "4770583", "", SIZE, Vector3.new(0, 0, 0))
                elseif TYPE == "Crystal" then
                    MSH = CrM("SpecialMesh", EFFECT, "FileMesh", "9756362", "", SIZE, Vector3.new(0, 0, 0))
                end
                if MSH ~= nil then
                    local MOVESPEED = nil
                    if MOVEDIRECTION ~= nil then
                        MOVESPEED = (CFRAME.p - MOVEDIRECTION).Magnitude / TIME
                    end
                    local GROWTH = SIZE - ENDSIZE
                    local TRANS = TRANSPARENCY - ENDTRANSPARENCY
                    if TYPE == "Block" then
                        EFFECT.CFrame =
                            CFRAME * angles(Rad(Mrandom(0, 360)), Rad(Mrandom(0, 360)), Rad(Mrandom(0, 360)))
                    else
                        EFFECT.CFrame = CFRAME
                    end
                    for LOOP = 1, TIME + 1 do
                        swait()
                        MSH.Scale = MSH.Scale - GROWTH / TIME
                        if TYPE == "Wave" then
                            MSH.Offset = Vector3.new(0, 0, -MSH.Scale.X / 8)
                        end
                        EFFECT.Transparency = EFFECT.Transparency - TRANS / TIME
                        if TYPE == "Block" then
                            EFFECT.CFrame =
                                CFRAME * angles(Rad(Mrandom(0, 360)), Rad(Mrandom(0, 360)), Rad(Mrandom(0, 360)))
                        else
                            EFFECT.CFrame = EFFECT.CFrame * angles(Rad(ROTATION1), Rad(ROTATION2), Rad(ROTATION3))
                        end
                        if MOVEDIRECTION ~= nil then
                            local ORI = EFFECT.Orientation
                            EFFECT.CFrame = CF(EFFECT.Position, MOVEDIRECTION) * CF(0, 0, -MOVESPEED)
                            EFFECT.Orientation = ORI
                        end
                    end
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
-------------------------------------------------------
--End Effect Function--
-------------------------------------------------------
function Cso(ID, PARENT, VOLUME, PITCH)
    local NSound = nil
    coroutine.resume(
        coroutine.create(
            function()
                NSound = IT("Sound", PARENT)
                NSound.Volume = VOLUME
                NSound.Pitch = PITCH
                NSound.SoundId = "http://www.roblox.com/asset/?id=" .. ID
                swait()
                NSound:play()
                game:GetService("Debris"):AddItem(NSound, 10)
            end
        )
    )
    return NSound
end
NewInstance = function(instance, parent, properties)
    local inst = Instance.new(instance)
    inst.Parent = parent
    if (properties) then
        for i, v in next, properties do
            pcall(
                function()
                    inst[i] = v
                end
            )
        end
    end
    return inst
end
New = function(Object, Parent, Name, Data)
    local Object = Instance.new(Object)
    for Index, Value in pairs(Data or {}) do
        Object[Index] = Value
    end
    Object.Parent = Parent
    Object.Name = Name
    return Object
end
function SHAKECAM(POSITION, RANGE, INTENSITY, TIME)
    local CHILDREN = workspace:GetDescendants()
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
    end
end
-------------------------------------------------------
--End Important Functions--
-------------------------------------------------------

-------------------------------------------------------
--Start Customization--
-------------------------------------------------------
----------------------------------------------------------------------------------
local SONG = 2743829704
local SONG2 = 0
----------------------------------------------------------------------------------
local equipped = false
local idle = 0
local change = 1
local val = 0
local toim = 0
local idleanim = 0.4
local sine = 0
local movelegs = false
local FF = Instance.new("ForceField", char)
FF.Visible = false
local Speed = 16
local Jump = 80
local rK = false
local DBT = false
local CurrentS = 0
local Paused = false
----------------------------------------------------------------------------------
hum.Animator.Parent = nil
char.Animate.Parent = nil
hum.MaxHealth = 100
hum.Health = 100
----------------------------------------------------------------------------------
local Weapun = script.Sword
Weapun.Parent = miztgetcharacter()
local WeapunTrail = Weapun.Trail
Weapun.Anchored = false
WeapunTrail.Enabled = false
local WeapunWeld = IT("Weld")
WeapunWeld.Parent = Weapun
WeapunWeld.Part0 = Weapun
WeapunWeld.Part1 = ra
WeapunWeld.C0 = CF(1, 0, -1.3) * angles(Rad(0), Rad(180), Rad(90))
----------------------------------------------------------------------------------
local sODa = script.Sod
sODa.Anchored = false
local SodWeld = IT("Weld")
SodWeld.Parent = sODa
SodWeld.Part0 = sODa
SodWeld.Part1 = ra
SodWeld.C0 = CF(-1, 0, -0) * angles(Rad(90), Rad(0), Rad(90))
----------------------------------------------------------------------------------
--Totally not stolen from jl,,,,,hahhhahahhahhahahahahhhhhhhhhh
local Eye = Instance.new("Part")
Eye.Reflectance = 0
Eye.Transparency = 1
Eye.CanCollide = false
Eye.Locked = true
Eye.Anchored = false
Eye.BrickColor = BrickColor.new("Really blue")
Eye.Name = "BEGONE"
Eye.Size = Vector3.new()
Eye.Material = "SmoothPlastic"
Eye:BreakJoints()
Eye.Parent = char
local NewParticle1 = BEGONE_Particle:Clone()
NewParticle1.Parent = Eye
NewParticle1.Enabled = false
local Eye = weld(Eye, hed, Eye, CF(0.28, 0.7, -0.7))

local Eye = Instance.new("Part")
Eye.Reflectance = 0
Eye.Transparency = 1
Eye.CanCollide = false
Eye.Locked = true
Eye.Anchored = false
Eye.BrickColor = BrickColor.new("Really blue")
Eye.Name = "BEGONE"
Eye.Size = Vector3.new()
Eye.Material = "SmoothPlastic"
Eye:BreakJoints()
Eye.Parent = char
local NewParticle2 = BEGONE_Particle:Clone()
NewParticle2.Parent = Eye
NewParticle2.Enabled = false
local Eye = weld(Eye, hed, Eye, CF(-0.28, 0.7, -0.7))
-------------------------------------------------------
--End Customization--
-------------------------------------------------------

-------------------------------------------------------
--Start Attacks N Stuff--
-------------------------------------------------------
function Land(SR)
    spawn(
        function()
            if DBT == false and attack == true and SR < -15 and rK == false then
                DBT = true
                Speed = Speed / 2
                Jump = 0
                Cso("268933900", root, 6.5, 1)
                for i = 0, 2, 0.1 do
                    swait()
                    rootj.C0 =
                        clerp(
                        rootj.C0,
                        RootCF * CF(0, 0, -1.1 + 0.1 * Cos(sine / 20)) * angles(Rad(10), Rad(0), Rad(0)),
                        0.15
                    )
                    neck.C0 =
                        clerp(
                        neck.C0,
                        necko * CF(0, 0, 0 + ((1) - 1)) * angles(Rad(15 - 2.5 * Sin(sine / 30)), Rad(0), Rad(0)),
                        0.15
                    )
                    rl.Weld.C0 =
                        clerp(
                        rl.Weld.C0,
                        CF(0.5, 0.1 - 0.1 * Cos(sine / 20), -0.3) *
                            angles(Rad(15), Rad(-8 + 1 * Cos(sine / 20)), Rad(0)) *
                            angles(Rad(-3.5), Rad(0), Rad(2)),
                        0.15
                    )
                    ll.Weld.C0 =
                        clerp(
                        ll.Weld.C0,
                        CF(-0.5, 0.1 - 0.1 * Cos(sine / 20), -0.3) *
                            angles(Rad(15), Rad(8 + 1 * Cos(sine / 20)), Rad(0)) *
                            angles(Rad(-3.5), Rad(0), Rad(-2)),
                        0.15
                    )
                    RW.C0 =
                        clerp(
                        RW.C0,
                        CF(1.5, 0.5 + 0.02 * Sin(sine / 20), 0) *
                            angles(Rad(20), Rad(-0.6), Rad(25 + 4.5 * Sin(sine / 20))),
                        0.15
                    )
                    LW.C0 =
                        clerp(
                        LW.C0,
                        CF(-1.5, 0.5 + 0.02 * Sin(sine / 20), 0) *
                            angles(Rad(20), Rad(-0.6), Rad(-25 - 4.5 * Sin(sine / 20))),
                        0.15
                    )
                end
                attack = false
                spawn(
                    function()
                        wait(0.1)
                        Speed = 16
                        Jump = 80
                        DBT = false
                    end
                )
            else
                attack = false
            end
        end
    )
end

function AttackTemplate()
    attack = true
    movelegs = false
    Speed = 16
    for i = 0, 6, 0.1 do
        swait()
        rootj.C0 =
            clerp(rootj.C0, RootCF * CF(0, 0, -0.06 + 0.08 * Cos(sine / 8)) * angles(Rad(0), Rad(0), Rad(0)), 0.05)
        neck.C0 =
            clerp(
            neck.C0,
            necko * CF(0, 0, 0 + ((1) - 1)) *
                angles(Rad(0 - 6 * Cos(sine / 8)), Rad(0 - 10 * Sin(sine / 12)), Rad(-0 + 5 * Cos(sine / 16))),
            0.05
        )
        RW.C0 =
            clerp(
            RW.C0,
            CF(1.5, 0.5 + 0.1 * Cos(sine / 8), -0.0) *
                angles(Rad(0 + 8.5 * Sin(sine / 16)), Rad(0), Rad(10 + 5 * Cos(sine / 8))),
            0.05
        )
        LW.C0 =
            clerp(
            LW.C0,
            CF(-1.5, 0.5 + 0.1 * Cos(sine / 8), -0.0) *
                angles(Rad(0 + 8.5 * Sin(sine / 16)), Rad(-7), Rad(-10 - 5 * Cos(sine / 8))),
            0.05
        )
        rl.Weld.C0 =
            clerp(
            rl.Weld.C0,
            CF(0.5, -1 - 0.08 * Cos(sine / 8), 0.0) * angles(Rad(0), Rad(-6), Rad(0)) * angles(Rad(0), Rad(0), Rad(2)),
            0.05
        )
        ll.Weld.C0 =
            clerp(
            ll.Weld.C0,
            CF(-0.5, -1 - 0.08 * Cos(sine / 8), 0.0) * angles(Rad(0), Rad(10), Rad(0)) * angles(Rad(0), Rad(0), Rad(-2)),
            0.05
        )
    end
    attack = false
    movelegs = false
    Speed = 16
end

function Death()
    local TARGET = mouse.Target
    if TARGET ~= nil then
        if TARGET.Parent:FindFirstChildOfClass("Humanoid") then
            local HUM = TARGET.Parent:FindFirstChildOfClass("Humanoid")
            local ROOT =
                TARGET.Parent:FindFirstChild("HumanoidRootPart") or TARGET.Parent:FindFirstChild("Torso") or
                TARGET.Parent:FindFirstChild("UpperTorso")
            if ROOT and HUM.Health > 0 then
                local FOE = mouse.Target.Parent
                local HEAD = FOE:FindFirstChild("Head")
                if HEAD then
                    attack = true
                    movelegs = false
                    Speed = 0
                    local Perms = Cso("928990573", hed, 6, 1)
                    NewParticle1.Enabled = true
                    NewParticle2.Enabled = true
                    wait(0.1)
                    repeat
                        swait()
                        rootj.C0 =
                            clerp(
                            rootj.C0,
                            RootCF * CF(0, 0, -0.06 + 0.08 * Cos(sine / 8)) * angles(Rad(0), Rad(0), Rad(30)),
                            0.05
                        )
                        neck.C0 =
                            clerp(
                            neck.C0,
                            necko * CF(0, 0, 0 + ((1) - 1)) *
                                angles(
                                    Rad(0 - 6 * Cos(sine / 8)),
                                    Rad(0 - 10 * Sin(sine / 12)),
                                    Rad(-30 + 5 * Cos(sine / 16))
                                ),
                            0.05
                        )
                        RW.C0 =
                            clerp(
                            RW.C0,
                            CF(1.5, 0.5 + 0.1 * Cos(sine / 8), -0.0) *
                                angles(Rad(95 + 8.5 * Sin(sine / 16)), Rad(0), Rad(10 + 5 * Cos(sine / 8))),
                            0.05
                        )
                        LW.C0 =
                            clerp(
                            LW.C0,
                            CF(-1.5, 0.5 + 0.1 * Cos(sine / 8), -0.0) *
                                angles(Rad(0 + 8.5 * Sin(sine / 16)), Rad(-7), Rad(-10 - 5 * Cos(sine / 8))),
                            0.05
                        )
                        rl.Weld.C0 =
                            clerp(
                            rl.Weld.C0,
                            CF(0.5, -1 - 0.08 * Cos(sine / 8), 0.0) * angles(Rad(0), Rad(-6), Rad(0)) *
                                angles(Rad(0), Rad(0), Rad(2)),
                            0.05
                        )
                        ll.Weld.C0 =
                            clerp(
                            ll.Weld.C0,
                            CF(-0.5, -1 - 0.08 * Cos(sine / 8), 0.0) * angles(Rad(0), Rad(10), Rad(0)) *
                                angles(Rad(0), Rad(0), Rad(-2)),
                            0.05
                        )
                    until Perms.Playing == false
                    NewParticle1.Enabled = false
                    NewParticle2.Enabled = false
                    OOFf(FOE)
                    attack = false
                    movelegs = false
                    Speed = 16
                end
            end
        end
    end
end

function Sipper()
    attack = true
    movelegs = false
    Speed = 0
    sODa.Transparency = 0
    local drink = Cso("10722059", sODa, 5.9, 1)
    wait(0.1)
    repeat
        swait()
        rootj.C0 =
            clerp(rootj.C0, RootCF * CF(0, 0, -0.06 + 0.08 * Cos(sine / 8)) * angles(Rad(0), Rad(0), Rad(0)), 0.05)
        neck.C0 = clerp(neck.C0, necko * CF(0, 0, 0 + ((1) - 1)) * angles(Rad(-15), Rad(0), Rad(-0)), 0.05)
        RW.C0 = clerp(RW.C0, CF(1.1, 0.5, -0.5) * angles(Rad(145), Rad(0), Rad(-40)), 0.1)
        LW.C0 =
            clerp(
            LW.C0,
            CF(-1.5, 0.5 + 0.1 * Cos(sine / 8), -0.0) *
                angles(Rad(0 + 8.5 * Sin(sine / 16)), Rad(-7), Rad(-10 - 5 * Cos(sine / 8))),
            0.05
        )
        rl.Weld.C0 =
            clerp(
            rl.Weld.C0,
            CF(0.5, -1 - 0.08 * Cos(sine / 8), 0.0) * angles(Rad(0), Rad(-6), Rad(0)) * angles(Rad(0), Rad(0), Rad(2)),
            0.05
        )
        ll.Weld.C0 =
            clerp(
            ll.Weld.C0,
            CF(-0.5, -1 - 0.08 * Cos(sine / 8), 0.0) * angles(Rad(0), Rad(10), Rad(0)) * angles(Rad(0), Rad(0), Rad(-2)),
            0.05
        )
    until drink.Playing == false
    attack = false
    movelegs = false
    Speed = 16
    sODa.Transparency = 1
end

function Click()
    attack = true
    movelegs = false
    Speed = 8
    for i = 0, 6, 0.1 do
        swait()
        rootj.C0 =
            clerp(rootj.C0, RootCF * CF(0, 0, -0.06 + 0.08 * Cos(sine / 8)) * angles(Rad(0), Rad(0), Rad(0)), 0.1)
        neck.C0 =
            clerp(neck.C0, necko * CF(0, 0, 0 + ((1) - 1)) * angles(Rad(0 - 6 * Cos(sine / 8)), Rad(20), Rad(-0)), 0.1)
        RW.C0 =
            clerp(
            RW.C0,
            CF(1.5, 0.5 + 0.1 * Cos(sine / 8), -0.0) *
                angles(Rad(180 + 8.5 * Sin(sine / 16)), Rad(0), Rad(30 + 5 * Cos(sine / 8))),
            0.1
        )
        LW.C0 =
            clerp(
            LW.C0,
            CF(-1.5, 0.5 + 0.1 * Cos(sine / 8), -0.0) *
                angles(Rad(0 + 8.5 * Sin(sine / 16)), Rad(-7), Rad(-10 - 5 * Cos(sine / 8))),
            0.1
        )
        rl.Weld.C0 =
            clerp(
            rl.Weld.C0,
            CF(0.5, -1 - 0.08 * Cos(sine / 8), 0.0) * angles(Rad(0), Rad(-6), Rad(0)) * angles(Rad(0), Rad(0), Rad(2)),
            0.1
        )
        ll.Weld.C0 =
            clerp(
            ll.Weld.C0,
            CF(-0.5, -1 - 0.08 * Cos(sine / 8), 0.0) * angles(Rad(0), Rad(10), Rad(0)) * angles(Rad(0), Rad(0), Rad(-2)),
            0.1
        )
    end
    local BomB = IT("Explosion", workspace)
    BomB.BlastPressure = 0
    BomB.ExplosionType = Enum.ExplosionType.NoCraters
    BomB.Position = hed.Position
    BomB.BlastRadius = 10
    MagniDamage(hed, 13, 1, 1, 1, 1)
    Cso("440145223", hed, 6, 1.7)
    for i = 0, 3, 0.1 do
        swait()
        rootj.C0 =
            clerp(rootj.C0, RootCF * CF(0, 0, -0.06 + 0.08 * Cos(sine / 8)) * angles(Rad(0), Rad(0), Rad(0)), 0.1)
        neck.C0 =
            clerp(neck.C0, necko * CF(0, 0, 0 + ((1) - 1)) * angles(Rad(0 - 6 * Cos(sine / 8)), Rad(-5), Rad(-0)), 0.5)
        RW.C0 =
            clerp(
            RW.C0,
            CF(1.5, 0.5 + 0.1 * Cos(sine / 8), -0.0) *
                angles(Rad(180 + 8.5 * Sin(sine / 16)), Rad(0), Rad(-20 + 5 * Cos(sine / 8))),
            0.5
        )
        LW.C0 =
            clerp(
            LW.C0,
            CF(-1.5, 0.5 + 0.1 * Cos(sine / 8), -0.0) *
                angles(Rad(0 + 8.5 * Sin(sine / 16)), Rad(-7), Rad(-10 - 5 * Cos(sine / 8))),
            0.1
        )
        rl.Weld.C0 =
            clerp(
            rl.Weld.C0,
            CF(0.5, -1 - 0.08 * Cos(sine / 8), 0.0) * angles(Rad(0), Rad(-6), Rad(0)) * angles(Rad(0), Rad(0), Rad(2)),
            0.1
        )
        ll.Weld.C0 =
            clerp(
            ll.Weld.C0,
            CF(-0.5, -1 - 0.08 * Cos(sine / 8), 0.0) * angles(Rad(0), Rad(10), Rad(0)) * angles(Rad(0), Rad(0), Rad(-2)),
            0.1
        )
    end
    attack = false
    movelegs = false
    Speed = 16
end

function Dangbelikethat()
    attack = true
    Speed = 3
    Cso("164174763", hed, 4.7, 1)
    for i = 0, 5, 0.1 do
        swait()
        rootj.C0 =
            clerp(rootj.C0, RootCF * CF(0, 0, -0.06 + 0.08 * Cos(sine / 8)) * angles(Rad(0), Rad(0), Rad(0)), 0.1)
        neck.C0 =
            clerp(neck.C0, necko * CF(0, 0, 0 + ((1) - 1)) * angles(Rad(-30 - 6 * Cos(sine / 8)), Rad(0), Rad(-0)), 0.1)
        RW.C0 =
            clerp(
            RW.C0,
            CF(1.5, 0.5 + 0.1 * Cos(sine / 8), -0.0) *
                angles(Rad(120 + 8.5 * Sin(sine / 16)), Rad(0), Rad(10 + 5 * Cos(sine / 8))),
            0.1
        )
        LW.C0 =
            clerp(
            LW.C0,
            CF(-1.5, 0.5 + 0.1 * Cos(sine / 8), -0.0) *
                angles(Rad(120 + 8.5 * Sin(sine / 16)), Rad(-7), Rad(-10 - 5 * Cos(sine / 8))),
            0.1
        )
        rl.Weld.C0 =
            clerp(
            rl.Weld.C0,
            CF(0.5, -1 - 0.08 * Cos(sine / 8), 0.0) * angles(Rad(0), Rad(-6), Rad(0)) * angles(Rad(0), Rad(0), Rad(2)),
            0.1
        )
        ll.Weld.C0 =
            clerp(
            ll.Weld.C0,
            CF(-0.5, -1 - 0.08 * Cos(sine / 8), 0.0) * angles(Rad(0), Rad(10), Rad(0)) * angles(Rad(0), Rad(0), Rad(-2)),
            0.1
        )
    end
    for i = 0, 3, 0.1 do
        swait()
        rootj.C0 =
            clerp(rootj.C0, RootCF * CF(0, 0, -0.06 + 0.08 * Cos(sine / 8)) * angles(Rad(0), Rad(0), Rad(0)), 0.1)
        neck.C0 =
            clerp(neck.C0, necko * CF(0, 0, 0 + ((1) - 1)) * angles(Rad(10 - 6 * Cos(sine / 8)), Rad(0), Rad(-0)), 0.1)
        RW.C0 =
            clerp(
            RW.C0,
            CF(1.5, 0.5 + 0.1 * Cos(sine / 8), -0.0) *
                angles(Rad(35 + 8.5 * Sin(sine / 16)), Rad(0), Rad(10 + 5 * Cos(sine / 8))),
            0.1
        )
        LW.C0 =
            clerp(
            LW.C0,
            CF(-1.5, 0.5 + 0.1 * Cos(sine / 8), -0.0) *
                angles(Rad(35 + 8.5 * Sin(sine / 16)), Rad(-7), Rad(-10 - 5 * Cos(sine / 8))),
            0.1
        )
        rl.Weld.C0 =
            clerp(
            rl.Weld.C0,
            CF(0.5, -1 - 0.08 * Cos(sine / 8), 0.0) * angles(Rad(0), Rad(-6), Rad(0)) * angles(Rad(0), Rad(0), Rad(2)),
            0.1
        )
        ll.Weld.C0 =
            clerp(
            ll.Weld.C0,
            CF(-0.5, -1 - 0.08 * Cos(sine / 8), 0.0) * angles(Rad(0), Rad(10), Rad(0)) * angles(Rad(0), Rad(0), Rad(-2)),
            0.1
        )
    end
    attack = false
    Speed = 16
end

function Slash()
    attack = true
    movelegs = true
    Speed = 6
    WeapunTrail.Enabled = true
    Weapun.Transparency = 0
    for i = 0, 1.1, 0.1 do
        swait()
        WeapunWeld.C0 = clerp(WeapunWeld.C0, CF(1, 0, -1.7) * angles(Rad(0), Rad(180), Rad(90)), 0.1)
        rootj.C0 = clerp(rootj.C0, RootCF * CF(0, 0, 0 + 0.05 * Cos(sine / 20)) * angles(Rad(0), Rad(0), Rad(-27)), 0.1)
        neck.C0 =
            clerp(neck.C0, necko * CF(0, 0, 0 + ((1) - 1)) * angles(Rad(-2 - 7 * Cos(sine / 20)), Rad(0), Rad(27)), 0.1)
        rl.Weld.C0 =
            clerp(
            rl.Weld.C0,
            CF(0.5, -1 - 0.05 * Cos(sine / 20), 0) * angles(Rad(-7), Rad(-20), Rad(0)) * angles(Rad(0), Rad(0), Rad(9)),
            0.2
        )
        ll.Weld.C0 =
            clerp(
            ll.Weld.C0,
            CF(-0.5, -1 - 0.05 * Cos(sine / 20), 0) * angles(Rad(2), Rad(9), Rad(0)) * angles(Rad(0), Rad(0), Rad(-3)),
            0.2
        )
        RW.C0 = clerp(RW.C0, CF(1.5, 0.5 + 0.1 * Cos(sine / 20), 0) * angles(Rad(185), Rad(65), Rad(10)), 0.1)
        LW.C0 =
            clerp(
            LW.C0,
            CF(-1.5, 0.5 + 0.1 * Cos(sine / 20), 0) *
                angles(Rad(-20 + 7 * Cos(sine / 26)), Rad(23), Rad(-16 - 9 * Sin(sine / 20))),
            0.1
        )
    end
    Cso("158037267", Weapun, 4.8, Mrandom(8, 13) / 12)
    local NoConstant = false
    local Hitter =
        Weapun.HitBox.Touched:connect(
        function(hit)
            if killScript then
                return
            end
            local HUMA = hit.Parent:FindFirstChildOfClass("Humanoid")
            local TORSO = hit.Parent:FindFirstChild("Torso")
            if HUMA ~= nil and hit.Parent ~= miztgetcharacter() and hit.Parent ~= game.Players.LocalPlayer.Character then
                if NoConstant == false then
                    NoConstant = true
                    Damage(TORSO, TORSO)
                    Cso("935843979", TORSO, 6.8, Mrandom(8, 13) / 12)
                end
            end
        end
    )
    for i = 0, 1.3, 0.1 do
        swait()
        WeapunWeld.C0 = clerp(WeapunWeld.C0, CF(1, 0, -1.7) * angles(Rad(0), Rad(210), Rad(90)), 0.3)
        rootj.C0 = clerp(rootj.C0, RootCF * CF(0, 0, 0 + 0.05 * Cos(sine / 20)) * angles(Rad(9), Rad(0), Rad(47)), 0.3)
        neck.C0 =
            clerp(
            neck.C0,
            necko * CF(0, 0, 0 + ((1) - 1)) * angles(Rad(10 - 7 * Cos(sine / 20)), Rad(10), Rad(-27)),
            0.3
        )
        rl.Weld.C0 =
            clerp(
            rl.Weld.C0,
            CF(0.5, -1 - 0.05 * Cos(sine / 20), 0) * angles(Rad(23), Rad(-20), Rad(0)) * angles(Rad(0), Rad(0), Rad(9)),
            0.2
        )
        ll.Weld.C0 =
            clerp(
            ll.Weld.C0,
            CF(-0.5, -1 - 0.05 * Cos(sine / 20), 0) * angles(Rad(-19), Rad(9), Rad(0)) * angles(Rad(0), Rad(0), Rad(-3)),
            0.2
        )
        RW.C0 = clerp(RW.C0, CF(1.3, 0.4 + 0.1 * Cos(sine / 20), -0.3) * angles(Rad(45), Rad(15), Rad(-10)), 0.3)
        LW.C0 =
            clerp(
            LW.C0,
            CF(-1.5, 0.5 + 0.1 * Cos(sine / 20), 0) *
                angles(Rad(10 + 7 * Cos(sine / 26)), Rad(23), Rad(-16 - 9 * Sin(sine / 20))),
            0.1
        )
    end
    Hitter:Disconnect()
    WeapunTrail.Enabled = false
    Weapun.Transparency = 1
    WeapunWeld.C0 = CF(1, 0, -1.3) * angles(Rad(0), Rad(180), Rad(90))
    attack = false
    movelegs = false
    Speed = 16
end

function Side()
    attack = true
    movelegs = true
    Speed = 6
    WeapunTrail.Enabled = true
    Weapun.Transparency = 0
    for i = 0, 1.4, 0.1 do
        swait()
        WeapunWeld.C0 = clerp(WeapunWeld.C0, CF(1, 0, -1.7) * angles(Rad(-90), Rad(180), Rad(90)), 0.1)
        rootj.C0 = clerp(rootj.C0, RootCF * CF(0, 0, 0 + 0.05 * Cos(sine / 20)) * angles(Rad(0), Rad(0), Rad(77)), 0.1)
        neck.C0 =
            clerp(
            neck.C0,
            necko * CF(0, 0, 0 + ((1) - 1)) * angles(Rad(-15 - 7 * Cos(sine / 20)), Rad(0), Rad(-77)),
            0.1
        )
        rl.Weld.C0 =
            clerp(
            rl.Weld.C0,
            CF(0.5, -1 - 0.05 * Cos(sine / 20), 0) * angles(Rad(-7), Rad(-20), Rad(0)) * angles(Rad(0), Rad(0), Rad(9)),
            0.2
        )
        ll.Weld.C0 =
            clerp(
            ll.Weld.C0,
            CF(-0.5, -1 - 0.05 * Cos(sine / 20), 0) * angles(Rad(2), Rad(9), Rad(0)) * angles(Rad(0), Rad(0), Rad(-3)),
            0.2
        )
        RW.C0 = clerp(RW.C0, CF(1.5, 0.5 + 0.1 * Cos(sine / 20), -0.5) * angles(Rad(65), Rad(5), Rad(-20)), 0.1)
        LW.C0 =
            clerp(
            LW.C0,
            CF(-1.5, 0.5 + 0.1 * Cos(sine / 20), 0) *
                angles(Rad(-20 + 7 * Cos(sine / 26)), Rad(23), Rad(-16 - 9 * Sin(sine / 20))),
            0.1
        )
    end
    Cso("158037267", Weapun, 4.8, Mrandom(8, 13) / 12)
    local NoConstant = false
    local Hitter =
        Weapun.HitBox.Touched:connect(
        function(hit)
            if killScript then
                return
            end
            local HUMA = hit.Parent:FindFirstChildOfClass("Humanoid")
            local TORSO = hit.Parent:FindFirstChild("Torso")
            if HUMA ~= nil and hit.Parent ~= miztgetcharacter() and hit.Parent ~= game.Players.LocalPlayer.Character then
                if NoConstant == false then
                    NoConstant = true
                    Damage(TORSO, TORSO)
                    Cso("935843979", TORSO, 6.8, Mrandom(8, 13) / 12)
                end
            end
        end
    )
    for i = 0, 1.6, 0.1 do
        swait()
        WeapunWeld.C0 = clerp(WeapunWeld.C0, CF(1, 0, -1.7) * angles(Rad(-90), Rad(180), Rad(90)), 0.1)
        rootj.C0 = clerp(rootj.C0, RootCF * CF(0, 0, 0 + 0.05 * Cos(sine / 20)) * angles(Rad(0), Rad(0), Rad(-87)), 0.3)
        neck.C0 =
            clerp(neck.C0, necko * CF(0, 0, 0 + ((1) - 1)) * angles(Rad(2 - 7 * Cos(sine / 20)), Rad(10), Rad(87)), 0.3)
        rl.Weld.C0 =
            clerp(
            rl.Weld.C0,
            CF(0.5, -1 - 0.05 * Cos(sine / 20), 0) * angles(Rad(-7), Rad(-20), Rad(0)) * angles(Rad(0), Rad(0), Rad(9)),
            0.2
        )
        ll.Weld.C0 =
            clerp(
            ll.Weld.C0,
            CF(-0.5, -1 - 0.05 * Cos(sine / 20), 0) * angles(Rad(2), Rad(9), Rad(0)) * angles(Rad(0), Rad(0), Rad(-3)),
            0.2
        )
        RW.C0 = clerp(RW.C0, CF(1.5, 0.5 + 0.1 * Cos(sine / 20), -0.2) * angles(Rad(65), Rad(5), Rad(60)), 0.3)
        LW.C0 =
            clerp(
            LW.C0,
            CF(-1.5, 0.5 + 0.1 * Cos(sine / 20), 0) *
                angles(Rad(-20 + 7 * Cos(sine / 26)), Rad(23), Rad(-16 - 9 * Sin(sine / 20))),
            0.1
        )
    end
    Hitter:Disconnect()
    WeapunTrail.Enabled = false
    Weapun.Transparency = 1
    WeapunWeld.C0 = CF(1, 0, -1.3) * angles(Rad(0), Rad(180), Rad(90))
    attack = false
    movelegs = false
    Speed = 16
end
-------------------------------------------------------
--End Attacks N Stuff--
-------------------------------------------------------

-------------------------------------------------------
--Start KeyBinds--
-------------------------------------------------------
local Combo = 1
mouse.Button1Down:connect(
    function(key)
        if killScript then
            return
        end
        if attack == false then
            if Combo == 1 then
                Slash()
                Combo = 2
            elseif Combo == 2 then
                Side()
                Combo = 1
            end
        end
    end
)

mouse.KeyDown:connect(
    function(key)
        if killScript then
            return
        end
        if attack == false then
            if key == "m" then
                local musiclist = {
                    2743807248,
                    2769681478,
                    2744206083,
                    3114733100,
                    3287259630,
                    2874747644,
                    2874751167,
                    2743784498,
                    3117533716,
                    2769678264,
                    2743829704
                }
                if MUSIC then
                    if CurrentS >= #musiclist then
                        CurrentS = 0
                    end
                    CurrentS = CurrentS + 1
                    SONG = musiclist[CurrentS]
                    MUSIC:Destroy()
                end
            elseif key == "n" and Paused == false then
                Paused = true
                MUSIC:Pause()
            elseif key == "n" and Paused == true then
                Paused = false
                MUSIC:Resume()
            elseif key == "t" then
                Dangbelikethat()
            elseif key == "y" then
                Sipper()
            elseif key == "z" then
                Click()
            elseif key == "x" then
                Death()
            end
        end
    end
)
-------------------------------------------------------
--Start KeyBinds--
-------------------------------------------------------

-------------------------------------------------------
--Start Animations--
-------------------------------------------------------
local forWFB = 0
local forWRL = 0
while true and not killScript do
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
    swait()
    sine = sine + change
    local torvel = (root.Velocity * Vector3.new(1, 0, 1)).magnitude
    local velderp = root.Velocity.y
    hitfloor, posfloor =
        rayCast(root.Position, CFrame.new(root.Position, root.Position - Vector3.new(0, 1, 0)).lookVector, 4, char)
    neartouch =
        game:service("Workspace"):FindPartOnRay(
        Ray.new(root.Position, (CFrame.new(root.Position, root.Position - Vector3.new(0, 1, 0))).lookVector.unit * 6),
        char
    )
    if equipped == true or equipped == false then
        if not root:FindFirstChild("MUSIC") and Paused ~= true then
            MUSIC = Instance.new("Sound", root)
            MUSIC.SoundId = "rbxassetid://" .. SONG
            MUSIC.Name = "MUSIC"
            MUSIC.Volume = 4
            MUSIC.EmitterSize = 10
            MUSIC.Pitch = 1
            MUSIC.Looped = true
            MUSIC:Play()
        end
        local Walking = (math.abs(root.Velocity.x) > 1 or math.abs(root.Velocity.z) > 1)
        local State =
            (hum.PlatformStand and "Paralyzed" or hum.Sit and "Sit" or not hitfloor and root.Velocity.y < -1 and "Fall" or
            not hitfloor and root.Velocity.y > 1 and "Jump" or
            hitfloor and Walking and "Walk" or
            hitfloor and "Idle")
        local WALKSPEEDVALUE = 6 / (hum.WalkSpeed / 16)
        local TiltVelocity = CFrame.new(root.CFrame:vectorToObjectSpace(root.Velocity / 1.6))
        if (not char:FindFirstChildOfClass "Shirt") then
            NewInstance("Shirt", char, {ShirtTemplate = "rbxassetid://131666081"})
        else
            char:FindFirstChildOfClass "Shirt".ShirtTemplate = "rbxassetid://131666081"
        end
        if (not char:FindFirstChildOfClass "Pants") then
            NewInstance("Pants", char, {PantsTemplate = "rbxassetid://131667111"})
        else
            char:FindFirstChildOfClass "Pants".PantsTemplate = "rbxassetid://131667111"
        end
        if (State == "Jump") then
            if attack == false then
                rootj.C0 =
                    clerp(
                    rootj.C0,
                    RootCF * CF(0, 0, -0.1 + 0.1 * Cos(sine / 20)) *
                        angles(Rad(10 + 3 * Cos(sine / 20)), Rad(0), Rad(0)),
                    0.1
                )
                neck.C0 =
                    clerp(
                    neck.C0,
                    necko * CF(0, 0, ((1) - 1)) *
                        angles(Rad(-50 + 6 * Sin(sine / 20)), Rad(0), Rad(0 + 9 * Cos(sine / 38))),
                    0.1
                )
                rl.Weld.C0 =
                    clerp(
                    rl.Weld.C0,
                    CF(0.5, -0.8 - 0.1 * Cos(sine / 20) - Rad(0), -0.3) *
                        angles(Rad(-27 + 3 * Cos(sine / 20)), Rad(-20 + 1 * Cos(sine / 20)), Rad(0)) *
                        angles(Rad(0 + 1 * Cos(sine / 20)), Rad(0), Rad(5)),
                    0.1
                )
                ll.Weld.C0 =
                    clerp(
                    ll.Weld.C0,
                    CF(-0.5, -0.5 - 0.1 * Cos(sine / 20) + Rad(0), -0.7) *
                        angles(Rad(-27 + 3 * Cos(sine / 20)), Rad(20 + 1 * Cos(sine / 20)), Rad(0)) *
                        angles(Rad(0 - 1 * Cos(sine / 20)), Rad(0), Rad(-5)),
                    0.1
                )
                RW.C0 =
                    clerp(
                    RW.C0,
                    CF(1.5, 0.5 + 0.1 * Cos(sine / 20), 0) *
                        angles(Rad(170 + 10 * Cos(sine / 20)), Rad(10), Rad(10 + 6 * Sin(sine / 20))),
                    0.2
                )
                LW.C0 =
                    clerp(
                    LW.C0,
                    CF(-1.5, 0.5 + 0.1 * Cos(sine / 20), 0) *
                        angles(Rad(170 + 10 * Cos(sine / 20)), Rad(-10), Rad(-10 - 6 * Sin(sine / 20))),
                    0.2
                )
            end
        elseif (State == "Fall") then
            if neartouch ~= nil and attack == false then
                attack = true
                Land(root.Velocity.y)
            end
            if attack == false then
                rootj.C0 =
                    clerp(
                    rootj.C0,
                    RootCF * CF(0, 0, -0.1 + 0.1 * Cos(sine / 20)) *
                        angles(Rad(-27 + 3 * Cos(sine / 20)), Rad(0), Rad(0)),
                    0.1
                )
                neck.C0 =
                    clerp(
                    neck.C0,
                    necko * CF(0, 0, ((1) - 1)) *
                        angles(Rad(20 + 6 * Sin(sine / 20)), Rad(0), Rad(0 + 9 * Cos(sine / 38))),
                    0.1
                )
                rl.Weld.C0 =
                    clerp(
                    rl.Weld.C0,
                    CF(0.5, -0.9 - 0.1 * Cos(sine / 20) - Rad(0), 0) *
                        angles(Rad(-27 + 3 * Cos(sine / 20)), Rad(-20 + 1 * Cos(sine / 20)), Rad(0)) *
                        angles(Rad(0 + 1 * Cos(sine / 20)), Rad(0), Rad(5)),
                    0.1
                )
                ll.Weld.C0 =
                    clerp(
                    ll.Weld.C0,
                    CF(-0.5, -0.9 - 0.1 * Cos(sine / 20) + Rad(0), 0) *
                        angles(Rad(-27 + 3 * Cos(sine / 20)), Rad(20 + 1 * Cos(sine / 20)), Rad(0)) *
                        angles(Rad(0 - 1 * Cos(sine / 20)), Rad(0), Rad(-5)),
                    0.1
                )
                RW.C0 =
                    clerp(
                    RW.C0,
                    CF(1.5, 0.5 + 0.1 * Cos(sine / 20), 0) *
                        angles(Rad(100 + 10 * Cos(sine / 20)), Rad(10), Rad(45 + 6 * Sin(sine / 20))),
                    0.1
                )
                LW.C0 =
                    clerp(
                    LW.C0,
                    CF(-1.5, 0.5 + 0.1 * Cos(sine / 20), 0) *
                        angles(Rad(100 + 10 * Cos(sine / 20)), Rad(-10), Rad(-45 - 6 * Sin(sine / 20))),
                    0.1
                )
            end
        elseif (State == "Idle") then
            --local hell = GetClientProperty(MUSIC,'PlaybackLoudness')/15
            change = 0.5 --+ hell/35
            if attack == false then
                rootj.C0 =
                    clerp(
                    rootj.C0,
                    RootCF * CF(0, 0, -0.06 + 0.08 * Cos(sine / 8)) * angles(Rad(0), Rad(0), Rad(0)),
                    0.05
                )
                neck.C0 =
                    clerp(
                    neck.C0,
                    necko * CF(0, 0, 0 + ((1) - 1)) *
                        angles(Rad(0 - 6 * Cos(sine / 8)), Rad(0 - 10 * Sin(sine / 12)), Rad(-0 + 5 * Cos(sine / 16))),
                    0.05
                )
                RW.C0 =
                    clerp(
                    RW.C0,
                    CF(1.5, 0.5 + 0.1 * Cos(sine / 8), -0.0) *
                        angles(Rad(0 + 8.5 * Sin(sine / 16)), Rad(0), Rad(10 + 5 * Cos(sine / 8))),
                    0.05
                )
                LW.C0 =
                    clerp(
                    LW.C0,
                    CF(-1.5, 0.5 + 0.1 * Cos(sine / 8), -0.0) *
                        angles(Rad(0 + 8.5 * Sin(sine / 16)), Rad(-7), Rad(-10 - 5 * Cos(sine / 8))),
                    0.05
                )
                rl.Weld.C0 =
                    clerp(
                    rl.Weld.C0,
                    CF(0.5, -1 - 0.08 * Cos(sine / 8), 0.0) * angles(Rad(0), Rad(-6), Rad(0)) *
                        angles(Rad(0), Rad(0), Rad(2)),
                    0.05
                )
                ll.Weld.C0 =
                    clerp(
                    ll.Weld.C0,
                    CF(-0.5, -1 - 0.08 * Cos(sine / 8), 0.0) * angles(Rad(0), Rad(10), Rad(0)) *
                        angles(Rad(0), Rad(0), Rad(-2)),
                    0.05
                )
            end
        elseif (State == "Walk") then
            change = 0.9
            if attack == false then
                rootj.C0 =
                    clerp(
                    rootj.C0,
                    RootCF * CF(0, 0, 0 - 0.25 * Cos(sine / (WALKSPEEDVALUE / 2))) *
                        angles(
                            Rad(6 + 3 * Sin(sine / (WALKSPEEDVALUE / 2))) - Rad(TiltVelocity.z) * 1,
                            Rad(0) - Rad(TiltVelocity.x) * 0.4,
                            Rad(0 - 4.75 * Cos(sine / WALKSPEEDVALUE)) + root.RotVelocity.Y / 75
                        ),
                    0.1
                )
                neck.C0 =
                    clerp(
                    neck.C0,
                    necko * CF(0, 0, 0 + ((1) - 1)) *
                        angles(Rad(-5 + 5 * Sin(sine / (WALKSPEEDVALUE / 2))), Rad(0), Rad(0) - Rad(TiltVelocity.x) * 3),
                    0.1
                )
                rl.Weld.C0 =
                    clerp(
                    rl.Weld.C0,
                    CF(0.5, -0.9 - 0.35 * Cos(sine / WALKSPEEDVALUE) / 2, -0.2 + 0.6 * Cos(sine / WALKSPEEDVALUE) / 2) *
                        angles(
                            Rad(-5 - 15 * Cos(sine / WALKSPEEDVALUE)) - root.RotVelocity.Y / 75 +
                                -Sin(sine / WALKSPEEDVALUE) / 2.5 * -Rad(TiltVelocity.z) * 10,
                            Rad(0 - 5 * Cos(sine / WALKSPEEDVALUE)),
                            Rad(0)
                        ) *
                        angles(
                            Rad(0 + 2 * Cos(sine / WALKSPEEDVALUE)),
                            Rad(0),
                            Rad(0 + 25 * math.sin(sine / WALKSPEEDVALUE) * -math.rad(TiltVelocity.x) * 5.5)
                        ),
                    0.3
                )
                ll.Weld.C0 =
                    clerp(
                    ll.Weld.C0,
                    CF(-0.5, -0.9 + 0.35 * Cos(sine / WALKSPEEDVALUE) / 2, -0.2 - 0.6 * Cos(sine / WALKSPEEDVALUE) / 2) *
                        angles(
                            Rad(-5 + 15 * Cos(sine / WALKSPEEDVALUE)) + root.RotVelocity.Y / -75 +
                                Sin(sine / WALKSPEEDVALUE) / 2.5 * -Rad(TiltVelocity.z) * 10,
                            Rad(0 - 5 * Cos(sine / WALKSPEEDVALUE)),
                            Rad(0)
                        ) *
                        angles(
                            Rad(0 - 2 * Cos(sine / WALKSPEEDVALUE)),
                            Rad(0),
                            Rad(0 + 25 * math.sin(sine / WALKSPEEDVALUE) * math.rad(TiltVelocity.x) * 5.5)
                        ),
                    0.3
                )
                RW.C0 =
                    clerp(
                    RW.C0,
                    CF(1.5, 0.5 + 0.05 * Sin(sine / WALKSPEEDVALUE), 0 - 0.2 * Cos(sine / WALKSPEEDVALUE)) *
                        angles(
                            Rad(50 * Cos(sine / WALKSPEEDVALUE)) +
                                root.RotVelocity.Y / -75 * -math.rad(TiltVelocity.z) * 10,
                            Rad(10 * Cos(sine / WALKSPEEDVALUE)),
                            Rad(5 - 7 * Sin(sine / (WALKSPEEDVALUE / 2))) - root.RotVelocity.Y / 75
                        ),
                    0.1
                )
                LW.C0 =
                    clerp(
                    LW.C0,
                    CF(-1.5, 0.5 + 0.05 * Sin(sine / WALKSPEEDVALUE), 0 + 0.2 * Cos(sine / WALKSPEEDVALUE)) *
                        angles(
                            Rad(-50 * Cos(sine / WALKSPEEDVALUE)) +
                                root.RotVelocity.Y / 75 * -math.rad(TiltVelocity.z) * 10,
                            Rad(10 * Cos(sine / WALKSPEEDVALUE)),
                            Rad(-5 + 7 * Sin(sine / (WALKSPEEDVALUE / 2))) + root.RotVelocity.Y / -75
                        ),
                    0.1
                )
            elseif attack == true and movelegs == true then
                rl.Weld.C0 =
                    clerp(
                    rl.Weld.C0,
                    CF(0.5, -0.9 - 0.5 * Cos(sine / WALKSPEEDVALUE) / 2, -0.2 + 0.6 * Cos(sine / WALKSPEEDVALUE) / 2) *
                        angles(
                            Rad(-15 - 10 * Cos(sine / WALKSPEEDVALUE)) - root.RotVelocity.Y / 75 +
                                -Sin(sine / WALKSPEEDVALUE) / 2.5 * -Rad(TiltVelocity.z) * 10,
                            Rad(0 - 5 * Cos(sine / WALKSPEEDVALUE)),
                            Rad(0)
                        ) *
                        angles(
                            Rad(0 + 2 * Cos(sine / WALKSPEEDVALUE)),
                            Rad(0),
                            Rad(0 - 25 * math.sin(sine / WALKSPEEDVALUE) * -math.rad(TiltVelocity.x) * 5.5)
                        ),
                    0.3
                )
                ll.Weld.C0 =
                    clerp(
                    ll.Weld.C0,
                    CF(-0.5, -0.9 + 0.5 * Cos(sine / WALKSPEEDVALUE) / 2, -0.2 - 0.6 * Cos(sine / WALKSPEEDVALUE) / 2) *
                        angles(
                            Rad(-15 + 10 * Cos(sine / WALKSPEEDVALUE)) + root.RotVelocity.Y / -75 +
                                Sin(sine / WALKSPEEDVALUE) / 2.5 * -Rad(TiltVelocity.z) * 10,
                            Rad(0 - 5 * Cos(sine / WALKSPEEDVALUE)),
                            Rad(0)
                        ) *
                        angles(
                            Rad(0 - 2 * Cos(sine / WALKSPEEDVALUE)),
                            Rad(0),
                            Rad(0 - 25 * math.sin(sine / WALKSPEEDVALUE) * math.rad(TiltVelocity.x) * 5.5)
                        ),
                    0.3
                )
            end
        elseif (State == "Sit") then
            if attack == false then
                rootj.C0 =
                    clerp(
                    rootj.C0,
                    RootCF * CF(0, 0, -0.1 + 0.1 * Cos(sine / 20)) * angles(Rad(-15), Rad(0), Rad(0)),
                    0.1
                )
                neck.C0 =
                    clerp(
                    tors.Neck.C0,
                    necko * CF(0, 0, 0 + ((1) - 1)) * angles(Rad(25 - 5 * Cos(sine / 20)), Rad(0), Rad(0)),
                    0.1
                )
                rl.Weld.C0 =
                    clerp(
                    rl.Weld.C0,
                    CF(0.5, -0.9 - 0.1 * Cos(sine / 20) - Rad(0), -0.3) * angles(Rad(65), Rad(-5), Rad(0)) *
                        angles(Rad(0 + 1 * Cos(sine / 20)), Rad(0), Rad(8)),
                    0.1
                )
                ll.Weld.C0 =
                    clerp(
                    ll.Weld.C0,
                    CF(-0.5, -0.9 - 0.1 * Cos(sine / 20) + Rad(0), 0) * angles(Rad(65), Rad(5), Rad(0)) *
                        angles(Rad(0 - 1 * Cos(sine / 20)), Rad(0), Rad(-8)),
                    0.1
                )
                RW.C0 =
                    clerp(RW.C0, CF(1.5, 0.4 - 0.1 * Cos(sine / 20), -0.2) * angles(Rad(20), Rad(-15), Rad(10)), 0.1)
                LW.C0 =
                    clerp(LW.C0, CF(-1.5, 0.4 - 0.1 * Cos(sine / 20), -0.2) * angles(Rad(20), Rad(15), Rad(-10)), 0.1)
            end
        end
    end
    hum.WalkSpeed = Speed
    hum.JumpPower = Jump
    if 0 < #Effects then
        for e = 1, #Effects do
            if Effects[e] ~= nil then
                local Thing = Effects[e]
                if Thing ~= nil then
                    local Part = Thing[1]
                    local Mode = Thing[2]
                    local Delay = Thing[3]
                    local IncX = Thing[4]
                    local IncY = Thing[5]
                    local IncZ = Thing[6]
                    if 1 >= Thing[1].Transparency then
                        if Thing[2] == "Block1" then
                            Thing[1].CFrame =
                                Thing[1].CFrame *
                                CFrame.fromEulerAnglesXYZ(
                                    math.random(-50, 50),
                                    math.random(-50, 50),
                                    math.random(-50, 50)
                                )
                            local Mesh = Thing[1].Mesh
                            Mesh.Scale = Mesh.Scale + Vector3.new(Thing[4], Thing[5], Thing[6])
                            Thing[1].Transparency = Thing[1].Transparency + Thing[3]
                        elseif Thing[2] == "Block2" then
                            Thing[1].CFrame = Thing[1].CFrame + Vector3.new(0, 0, 0)
                            local Mesh = Thing[7]
                            Mesh.Scale = Mesh.Scale + Vector3.new(Thing[4], Thing[5], Thing[6])
                            Thing[1].Transparency = Thing[1].Transparency + Thing[3]
                        elseif Thing[2] == "Block3" then
                            Thing[1].CFrame =
                                Thing[1].CFrame *
                                CFrame.fromEulerAnglesXYZ(
                                    math.random(-50, 50),
                                    math.random(-50, 50),
                                    math.random(-50, 50)
                                ) +
                                Vector3.new(0, 0.15, 0)
                            local Mesh = Thing[7]
                            Mesh.Scale = Mesh.Scale + Vector3.new(Thing[4], Thing[5], Thing[6])
                            Thing[1].Transparency = Thing[1].Transparency + Thing[3]
                        elseif Thing[2] == "Cylinder" then
                            local Mesh = Thing[1].Mesh
                            Mesh.Scale = Mesh.Scale + Vector3.new(Thing[4], Thing[5], Thing[6])
                            Thing[1].Transparency = Thing[1].Transparency + Thing[3]
                        elseif Thing[2] == "Blood" then
                            local Mesh = Thing[7]
                            Thing[1].CFrame = Thing[1].CFrame * Vector3.new(0, 0.5, 0)
                            Mesh.Scale = Mesh.Scale + Vector3.new(Thing[4], Thing[5], Thing[6])
                            Thing[1].Transparency = Thing[1].Transparency + Thing[3]
                        elseif Thing[2] == "Elec" then
                            local Mesh = Thing[1].Mesh
                            Mesh.Scale = Mesh.Scale + Vector3.new(Thing[7], Thing[8], Thing[9])
                            Thing[1].Transparency = Thing[1].Transparency + Thing[3]
                        elseif Thing[2] == "Disappear" then
                            Thing[1].Transparency = Thing[1].Transparency + Thing[3]
                        elseif Thing[2] == "Shatter" then
                            Thing[1].Transparency = Thing[1].Transparency + Thing[3]
                            Thing[4] = Thing[4] * CFrame.new(0, Thing[7], 0)
                            Thing[1].CFrame = Thing[4] * CFrame.fromEulerAnglesXYZ(Thing[6], 0, 0)
                            Thing[6] = Thing[6] + Thing[5]
                        end
                    else
                        Part.Parent = nil
                        table.remove(Effects, e)
                    end
                end
            end
        end
    end
end

-------------------------------------------------------
--End Animations And Script--
-------------------------------------------------------
