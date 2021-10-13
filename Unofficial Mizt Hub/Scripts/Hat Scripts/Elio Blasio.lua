local killScript = false

coroutine.wrap(function()
    while wait() do
		if not game.Players.LocalPlayer.Character or not game.Players.LocalPlayer.Character:FindFirstChild("Dummy") then
			killScript = true
            print("Stopped Script")
			break
		end
	end
end)()

-----------//Elio Blasio\\-----------
--[[Movelist
E = Equip/Unequip, click to shoot, hold to spray
T = Taunt
---------]]
--Credits to Shackluster for the refit/anti-breakjoints function, he's a cool guy/great scripter.--
--Ayy i'm not dead yet, take that haters, if i even had any to begin with.--
--Keeping this script small since big ones will cause major lag & exceed script limits--
--Using a FE converter because i'm way too lazy to create remotes for it--

local flingTarget = miztgetcharacter()

owner = game:GetService("Players").LocalPlayer
Player = game.Players.LocalPlayer
Character = miztgetcharacter()
hum = Character.Humanoid
LeftArm = Character["Left Arm"]
LeftLeg = Character["Left Leg"]
RightArm = Character["Right Arm"]
RightLeg = Character["Right Leg"]
Root = Character["HumanoidRootPart"]
Head = Character["Head"]
Torso = Character["Torso"]
Neck = Torso["Neck"]
mouse = Player:GetMouse()
walking = false
jumping = false
attacking = false
firsttime = false
tauntdebounce = false
position = nil
MseGuide = true
running = false
settime = 0
sine = 0
t = 0
ws = 18
change = 1
combo1 = true
equip = false
dgs = 75
combo2 = false
switch1 = true
switch2 = false
firsttime2 = false
combo3 = false
gunallowance = false
shooting = false
RunSrv = game:GetService("RunService")
RenderStepped = game:GetService("RunService").RenderStepped
removeuseless = game:GetService("Debris")

screenGui = Instance.new("ScreenGui")
screenGui.Parent = script.Parent

local HEADLERP = Instance.new("ManualWeld")
HEADLERP.Parent = Head
HEADLERP.Part0 = Head
HEADLERP.Part1 = Head
HEADLERP.C0 = CFrame.new(0, -1.5, -0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))

local TORSOLERP = Instance.new("ManualWeld")
TORSOLERP.Parent = Root
TORSOLERP.Part0 = Torso
TORSOLERP.C0 = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))

local ROOTLERP = Instance.new("ManualWeld")
ROOTLERP.Parent = Root
ROOTLERP.Part0 = Root
ROOTLERP.Part1 = Torso
ROOTLERP.C0 = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))

local RIGHTARMLERP = Instance.new("ManualWeld")
RIGHTARMLERP.Parent = RightArm
RIGHTARMLERP.Part0 = RightArm
RIGHTARMLERP.Part1 = Torso
RIGHTARMLERP.C0 = CFrame.new(-1.5, 0, -0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))

local LEFTARMLERP = Instance.new("ManualWeld")
LEFTARMLERP.Parent = LeftArm
LEFTARMLERP.Part0 = LeftArm
LEFTARMLERP.Part1 = Torso
LEFTARMLERP.C0 = CFrame.new(1.5, 0, -0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))

local RIGHTLEGLERP = Instance.new("ManualWeld")
RIGHTLEGLERP.Parent = RightLeg
RIGHTLEGLERP.Part0 = RightLeg
RIGHTLEGLERP.Part1 = Torso
RIGHTLEGLERP.C0 = CFrame.new(-0.5, 2, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))

local LEFTLEGLERP = Instance.new("ManualWeld")
LEFTLEGLERP.Parent = LeftLeg
LEFTLEGLERP.Part0 = LeftLeg
LEFTLEGLERP.Part1 = Torso
LEFTLEGLERP.C0 = CFrame.new(0.5, 2, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))

local function weldBetween(a, b)
    local weld = Instance.new("ManualWeld", a)
    weld.Part0 = a
    weld.Part1 = b
    weld.C0 = a.CFrame:inverse() * b.CFrame
    return weld
end

function MAKETRAIL(PARENT, POSITION1, POSITION2, LIFETIME, COLOR)
    A = Instance.new("Attachment", PARENT)
    A.Position = POSITION1
    A.Name = "A"
    B = Instance.new("Attachment", PARENT)
    B.Position = POSITION2
    B.Name = "B"
    tr1 = Instance.new("Trail", PARENT)
    tr1.Attachment0 = A
    tr1.Attachment1 = B
    tr1.Enabled = true
    tr1.Lifetime = LIFETIME
    tr1.TextureMode = "Static"
    tr1.LightInfluence = 0
    tr1.Color = COLOR
    tr1.Transparency = NumberSequence.new(0, 1)
end

tommygun = Instance.new("Part", Character)
tommygun.Size = Vector3.new(2, 2, 2)
tommygun.CFrame = RightArm.CFrame
tommygun.CanCollide = false
tommygunweld = Instance.new("Weld", tommygun)
tommygunweld.Part0 = tommygun
tommygunweld.Part1 = RightArm
tommygunweld.C0 =
    tommygun.CFrame:inverse() * RightArm.CFrame * CFrame.new(0, -.80, 1.25) *
    CFrame.Angles(math.rad(98), math.rad(0), 0)
tommygun.Transparency = 1
-- Align Section
local AlignChar = miztgetcharacter()
local Hat = AlignChar:FindFirstChild("METALXLIGHTSEER77Accessory")

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
Align(Hat.Handle, tommygun, Vector3.new(0, 0, 0), Vector3.new(0, -90, -35))
shootbox = Instance.new("Part", Character)
shootbox.Size = Vector3.new(.2, .2, .2)
shootbox.CanCollide = false
shootbox.Transparency = 1
shootbox.CFrame = tommygun.CFrame
shootboxweld = weldBetween(shootbox, tommygun)
shootboxweld.C0 = CFrame.new(0, -.05, 2.62)
light = Instance.new("PointLight", shootbox)
light.Color = BrickColor.new("Bright yellow").Color
light.Range = 5
light.Brightness = 11
light.Enabled = false
particlemiter1 = Instance.new("ParticleEmitter", shootbox)
particlemiter1.Enabled = false
particlemiter1.Texture = "rbxassetid://461242617"
particlemiter1.Lifetime = NumberRange.new(.1)
particlemiter1.Size = NumberSequence.new(1, 0)
particlemiter1.Rate = 20
particlemiter1.RotSpeed = NumberRange.new(0)
particlemiter1.Speed = NumberRange.new(0)
tommygunammo = Instance.new("Part", Character)
tommygunammo.Size = Vector3.new(2, 2, 2)
tommygunammo.CFrame = tommygun.CFrame
tommygunammo.CanCollide = false
tommygunammoweld = Instance.new("Weld", tommygunammo)
tommygunammoweld.Part0 = tommygunammo
tommygunammoweld.Part1 = tommygun
tommygunammoweld.C0 =
    tommygun.CFrame:inverse() * tommygun.CFrame * CFrame.new(0, .4, .25) * CFrame.Angles(math.rad(0), math.rad(0), 0)
mtommygunammo = Instance.new("SpecialMesh", tommygunammo)
mtommygunammo.MeshType = "FileMesh"
mtommygunammo.Scale = Vector3.new(1, 1, 1)
mtommygunammo.MeshId, mtommygunammo.TextureId =
    "0",
    "0"

coroutine.wrap(
    function()
        while wait() and not killScript do
            hum.WalkSpeed = ws
        end
    end
)()

coroutine.wrap(
    function()
        for i, v in pairs(Character:GetChildren()) do
            if v.Name == "Animate" then
                v:Remove()
            end
        end
    end
)()

function damagealll(Radius, Position)
    local Returning = {}
    for _, v in pairs(workspace:GetChildren()) do
        if
            v ~= Character and v:FindFirstChildOfClass("Humanoid") and v:FindFirstChild("Torso") or
                v:FindFirstChild("UpperTorso")
         then
            if v:FindFirstChild("Torso") then
                local Mag = (v.Torso.Position - Position).magnitude
                if Mag < Radius then
                    table.insert(Returning, v)
                end
            elseif v:FindFirstChild("UpperTorso") then
                local Mag = (v.UpperTorso.Position - Position).magnitude
                if Mag < Radius then
                    table.insert(Returning, v)
                end
            end
        end
    end
    return Returning
end

ArtificialHB = Instance.new("BindableEvent", script)
ArtificialHB.Name = "Heartbeat"
script:WaitForChild("Heartbeat")

frame = 1 / 60
tf = 0
allowframeloss = false
tossremainder = false

lastframe = tick()
script.Heartbeat:Fire()

game:GetService("RunService").Heartbeat:connect(
    function(s, p)
        tf = tf + s
        if tf >= frame then
            if allowframeloss then
                script.Heartbeat:Fire()
                lastframe = tick()
            else
                for i = 1, math.floor(tf / frame) do
                    script.Heartbeat:Fire()
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
        game:service("RunService").Stepped:wait(0)
    else
        for i = 0, num do
            game:service("RunService").Stepped:wait(0)
        end
    end
end

doomtheme = Instance.new("Sound", Torso)
doomtheme.Volume = 1
doomtheme.Name = "doomtheme"
doomtheme.Looped = true
doomtheme.SoundId = "rbxassetid://318812395"
doomtheme:Play()

function SOUND(PARENT, ID, VOL, LOOP, REMOVE)
    so = Instance.new("Sound")
    so.Parent = PARENT
    so.SoundId = "rbxassetid://" .. ID
    so.Volume = VOL
    so.Looped = LOOP
    so:Play()
    removeuseless:AddItem(so, REMOVE)
end

mouse.KeyDown:connect(
    function(Press)
        if killScript then return end
        Press = Press:lower()
        if Press == "t" then
            if tauntdebounce then
                return
            end
            tauntdebounce = true
            local b1 = Instance.new("BillboardGui", Head)
            b1.Size = UDim2.new(0, 4, 0, 1.6)
            b1.StudsOffset = Vector3.new(0, 0, 0)
            b1.Name = "laff"
            b1.AlwaysOnTop = true
            b1.StudsOffset = Vector3.new(0, 2, 0)
            b1.Adornee = Head
            removeuseless:AddItem(b1, 3)
            local b2 = Instance.new("TextLabel", b1)
            b2.BackgroundTransparency = 1
            b2.Text = "HeHeHeHeHeHeHe..."
            b2.Font = "Garamond"
            b2.TextSize = 30
            b2.Name = "lafftext"
            b2.TextStrokeTransparency = 0
            b2.TextColor3 = BrickColor.new("Grey").Color
            b2.TextStrokeColor3 = Color3.new(0, 0, 0)
            b2.Size = UDim2.new(1, 0, .5, 0)
            laff = Instance.new("Sound", Head)
            laff.SoundId = "rbxassetid://2126502539"
            laff.Volume = 5
            laff:Play()
            wait(5)
            laff:Remove()
            tauntdebounce = false
        end
    end
)

mouse.KeyDown:connect(
    function(Press)
        if killScript then return end
        Press = Press:lower()
        if Press == "e" then
            if debounce then
                return
            end
            if equip then
                g1:Remove()
                light.Enabled = false
                pcall(
                    function()
                        temmy:Remove()
                    end
                )
                for i, v in pairs(tommygun:GetDescendants()) do
                    if v.Name == "temmy" then
                        v:Remove()
                    end
                end
                light.Enabled = false
                particlemiter1.Enabled = false
                hum.CameraOffset = Vector3.new(0, 0, 0)
                attacking = false
                equip = false
                shooting = false
                gunallowance = false
                ws = 18
            else
                g1 = Instance.new("BodyGyro", Root)
                g1.D = 175
                g1.P = 20000
                g1.MaxTorque = Vector3.new(0, 9000, 0)
                g1.CFrame = CFrame.new(Root.Position, mouse.Hit.p)
                attacking = true
                debounce = true
                equip = true
                coroutine.wrap(
                    function()
                        while equip and not killScript do
                            g1.CFrame = g1.CFrame:lerp(CFrame.new(Root.Position, mouse.Hit.p), .1)
                            ws = 10
                            swait()
                            if Root.Velocity.y > 1 then
                                position = "Jump3"
                            elseif Root.Velocity.y < -1 then
                                position = "Falling3"
                            elseif Root.Velocity.Magnitude > 2 and running == false and attacking == true then
                                position = "Walk3"
                            elseif Root.Velocity.Magnitude < 2 and running == false and attacking == true then
                                position = "Idle4"
                            end
                        end
                    end
                )()
                coroutine.wrap(
                    function()
                        while equip and not killScript do
                            swait()
                            settime = 0.05
                            sine = sine + change
                            if position == "Jump3" and attacking and not running then
                                change = .65
                                RIGHTLEGLERP.C0 =
                                    RIGHTLEGLERP.C0:lerp(
                                    CFrame.new(-0.5, 2, 0) * CFrame.Angles(math.rad(10), math.rad(0), math.rad(0)),
                                    0.4
                                )
                                LEFTLEGLERP.C0 =
                                    LEFTLEGLERP.C0:lerp(
                                    CFrame.new(0.5, 1.0, .9) * CFrame.Angles(math.rad(20), math.rad(0), math.rad(0)),
                                    0.4
                                )
                            elseif position == "Falling3" and attacking and not running then
                                change = .65
                                RIGHTLEGLERP.C0 =
                                    RIGHTLEGLERP.C0:lerp(
                                    CFrame.new(-0.5, 2, 0) * CFrame.Angles(math.rad(8), math.rad(4), math.rad(0)),
                                    0.4
                                )
                                LEFTLEGLERP.C0 =
                                    LEFTLEGLERP.C0:lerp(
                                    CFrame.new(0.5, 1.0, .9) * CFrame.Angles(math.rad(14), math.rad(-4), math.rad(0)),
                                    0.4
                                )
                            elseif position == "Walk3" and attacking == true and running == false then
                                change = .65
                                ROOTLERP.C0 =
                                    ROOTLERP.C0:lerp(
                                    CFrame.new(0, 0.05 * math.sin(sine / 4), 0) *
                                        CFrame.Angles(math.rad(0), math.rad(-50), math.rad(0)),
                                    .2
                                )
                                RIGHTLEGLERP.C0 =
                                    RIGHTLEGLERP.C0:lerp(
                                    CFrame.new(
                                        -0.5,
                                        1.92 - 0.35 * math.cos(sine / 8) / 2.8,
                                        0.2 - math.sin(sine / 8) / 3.4
                                    ) *
                                        CFrame.Angles(
                                            math.rad(10) + -math.sin(sine / 8) / 2.3,
                                            math.rad(0) * math.cos(sine / 1),
                                            math.rad(0),
                                            math.cos(25 * math.cos(sine / 8))
                                        ),
                                    0.1
                                )
                                LEFTLEGLERP.C0 =
                                    LEFTLEGLERP.C0:lerp(
                                    CFrame.new(
                                        0.5,
                                        1.92 + 0.35 * math.cos(sine / 8) / 2.8,
                                        0.2 + math.sin(sine / 8) / 3.4
                                    ) *
                                        CFrame.Angles(
                                            math.rad(10) - -math.sin(sine / 8) / 2.3,
                                            math.rad(0) * math.cos(sine / 1),
                                            math.rad(0),
                                            math.cos(25 * math.cos(sine / 8))
                                        ),
                                    0.1
                                )
                            elseif position == "Idle4" and attacking == true and running == false then
                                change = .65
                                ROOTLERP.C0 =
                                    ROOTLERP.C0:lerp(
                                    CFrame.new(0, -.2 + -.1 * math.sin(sine / 25), 0) *
                                        CFrame.Angles(math.rad(0), math.rad(-50), math.rad(0)),
                                    .1
                                )
                                RIGHTLEGLERP.C1 =
                                    RIGHTLEGLERP.C1:lerp(CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), 0, 0), .1)
                                RIGHTLEGLERP.C0 =
                                    RIGHTLEGLERP.C0:lerp(
                                    CFrame.new(-0.3, 2 - .1 * math.sin(sine / 25), 0) *
                                        CFrame.Angles(math.rad(0), math.rad(0), math.rad(-10)),
                                    0.1
                                )
                                LEFTLEGLERP.C1 = LEFTLEGLERP.C1:lerp(CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, 0), .1)
                                LEFTLEGLERP.C0 =
                                    LEFTLEGLERP.C0:lerp(
                                    CFrame.new(0.3, 2.0 - .1 * math.sin(sine / 25), 0) *
                                        CFrame.Angles(math.rad(0), math.rad(0), math.rad(10)),
                                    0.1
                                )
                            end
                        end
                    end
                )()
                SOUND(RightArm, 898163129, 6, false, 2)
                for i = 1, 30 do
                    tommygunweld.C0 =
                        tommygunweld.C0:lerp(
                        CFrame.new(0, -.68, 1.25) * CFrame.Angles(math.rad(90), math.rad(0), math.rad(-12)),
                        .25
                    )
                    RIGHTARMLERP.C0 =
                        RIGHTARMLERP.C0:lerp(
                        CFrame.new(-1, 0.1, 0.4) * CFrame.Angles(math.rad(-90), math.rad(-60), math.rad(0)),
                        0.25
                    )
                    LEFTARMLERP.C0 =
                        LEFTARMLERP.C0:lerp(
                        CFrame.new(1, 1.35, 0.4) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0)),
                        0.25
                    )
                    swait()
                end
                gunallowance = true
                mouse.Button1Down:connect(
                    function()
                        if gunallowance then
                            particlemiter1.Enabled = true
                            temmy = Instance.new("Sound", tommygun)
                            temmy.SoundId = "rbxassetid://2204318084"
                            temmy.Volume = 6
                            temmy.Name = "temmy"
                            temmy.Looped = true
                            temmy:Play()
                            shooting = true
                        end
                    end
                )
                mouse.Button1Up:connect(
                    function()
                        if gunallowance then
                            hum.CameraOffset = Vector3.new(0, 0, 0)
                            light.Enabled = false
                            particlemiter1.Enabled = false
                            pcall(
                                function()
                                    temmy:Remove()
                                end
                            )
                            for i, v in pairs(tommygun:GetDescendants()) do
                                if v.Name == "temmy" then
                                    v:Remove()
                                end
                            end
                            shooting = false
                        end
                    end
                )
                coroutine.wrap(
                    function()
                        if firsttime2 then
                            return
                        end
                        firsttime2 = true
                        while true and not killScript do
                            swait(3)
                            if shooting then
                                if switch1 then
                                    switch1 = false
                                    switch2 = true
                                    light.Enabled = true
                                elseif switch2 then
                                    switch1 = true
                                    switch2 = false
                                    light.Enabled = false
                                end
                                pcall(
                                    function()
                                        if mouse.Target.Parent:FindFirstChild("Torso") or mouse.Target:FindFirstChild("UpperTorso") then
                                            flingTarget = mouse.Target.Parent
                                            coroutine.wrap(function() wait(1) flingTarget = miztgetcharacter() end)()
                                        end
                                    end
                                )
                            end
                        end
                    end
                )()
                coroutine.wrap(
                    function()
                        if firsttime then
                            return
                        end
                        firsttime = true
                        while true and not killScript do
                            if shooting then
                                LEFTARMLERP.C0 =
                                    LEFTARMLERP.C0:lerp(
                                    CFrame.new(1, 1.35, 0.4) *
                                        CFrame.Angles(math.rad(-90), math.rad(0 - 10 * math.sin(sine)), math.rad(0)),
                                    0.25
                                )
                                RIGHTARMLERP.C0 =
                                    RIGHTARMLERP.C0:lerp(
                                    CFrame.new(-1, 0.1 + .4 * math.sin(sine), 0.4) *
                                        CFrame.Angles(math.rad(-90), math.rad(-60), math.rad(0)),
                                    0.25
                                )
                                pcall(
                                    function()
                                        if mouse.Target.Parent:FindFirstChild("Torso") or mouse.Target:FindFirstChild("UpperTorso") then
                                            flingTarget = mouse.Target.Parent
                                            coroutine.wrap(function() wait(1) flingTarget = miztgetcharacter() end)()
                                        end
                                    end
                                )
                            elseif not shooting then
                            end
                            swait()
                        end
                    end
                )()
                debounce = false
            end
        end
    end
)

mouse.KeyDown:connect(
    function(Press)
        if killScript then return end
        Press = Press:lower()
        if Press == "z" then
            print("Music switched to 1")
            id = 2199374985
            doomtheme.SoundId = "rbxassetid://" .. id
            doomtheme:Play()
        end
    end
)

mouse.KeyDown:connect(
    function(Press)
        if killScript then return end
        Press = Press:lower()
        if Press == "v" then
            print("Music switched to 4")
            id = 2111948183
            doomtheme.SoundId = "rbxassetid://" .. id
            doomtheme:Play()
        end
    end
)

mouse.KeyDown:connect(
    function(Press)
        if killScript then return end
        Press = Press:lower()
        if Press == "x" then
            print("Music switched to 2")
            id = 318812395
            doomtheme.SoundId = "rbxassetid://" .. id
            doomtheme:Play()
        end
    end
)

mouse.KeyDown:connect(
    function(Press)
        if killScript then return end
        Press = Press:lower()
        if Press == "c" then
            print("Music switched to 3")
            id = 180337897
            doomtheme.SoundId = "rbxassetid://" .. id
            doomtheme:Play()
        end
    end
)

mouse.KeyDown:connect(
    function(Press)
        if killScript then return end
        Press = Press:lower()
        if Press == "b" then
            print("Music switched to 5")
            id = 649148458
            doomtheme.SoundId = "rbxassetid://" .. id
            doomtheme:Play()
        end
    end
)

checks1 =
    coroutine.wrap(
    function()
        -------Checks
        while true and not killScript do
            if Root.Velocity.y > 1 then
                position = "Jump"
            elseif Root.Velocity.y < -1 then
                position = "Falling"
            elseif Root.Velocity.Magnitude < 2 then
                position = "Idle"
            elseif Root.Velocity.Magnitude < 20 then
                position = "Walking"
            elseif Root.Velocity.Magnitude > 20 then
                position = "Running"
            else
            end
            wait()
        end
    end
)
checks1()

function ray(POSITION, DIRECTION, RANGE, IGNOREDECENDANTS)
    return workspace:FindPartOnRay(Ray.new(POSITION, DIRECTION.unit * RANGE), IGNOREDECENDANTS)
end

function ray2(StartPos, EndPos, Distance, Ignore)
    local DIRECTION = CFrame.new(StartPos, EndPos).lookVector
    return ray(StartPos, DIRECTION, Distance, Ignore)
end

OrgnC0 = Neck.C0
local movelimbs =
    coroutine.wrap(
    function()
        while RunSrv.RenderStepped:wait() and not killScript do
            TrsoLV = Torso.CFrame.lookVector
            Dist = nil
            Diff = nil
            if not MseGuide then
                print("Failed to recognize")
            else
                local _, Point =
                    Workspace:FindPartOnRay(Ray.new(Head.CFrame.p, mouse.Hit.lookVector), Workspace, false, true)
                Dist = (Head.CFrame.p - Point).magnitude
                Diff = Head.CFrame.Y - Point.Y
                local _, Point2 =
                    Workspace:FindPartOnRay(Ray.new(LeftArm.CFrame.p, mouse.Hit.lookVector), Workspace, false, true)
                Dist2 = (LeftArm.CFrame.p - Point).magnitude
                Diff2 = LeftArm.CFrame.Y - Point.Y
                HEADLERP.C0 = CFrame.new(0, -1.5, -0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))
                Neck.C0 =
                    Neck.C0:lerp(
                    OrgnC0 *
                        CFrame.Angles(
                            (math.tan(Diff / Dist) * 1),
                            0,
                            (((Head.CFrame.p - Point).Unit):Cross(Torso.CFrame.lookVector)).Y * 1
                        ),
                    .1
                )
            end
        end
    end
)

local anims =
    coroutine.wrap(
    function()
        while true and not killScript do
            miztfling({
                Method = 'CFrame', -- This method will visualized like a teleporting root.
                Args = {
                    flingTarget, -- Change this to other player character.
                    2, -- Max amount of time.
                    60 -- Max lerp per fling.
                }
            })
            settime = 0.05
            sine = sine + change
            if position == "Jump" and attacking == false then
                change = 1
                tommygunweld.C0 =
                    tommygunweld.C0:lerp(CFrame.new(0, -.80, 1.25) * CFrame.Angles(math.rad(98), math.rad(0), 0), .25)
                LEFTLEGLERP.C1 = LEFTLEGLERP.C1:lerp(CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, 0), .1)
                RIGHTLEGLERP.C1 = RIGHTLEGLERP.C1:lerp(CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), 0, 0), .1)
                LEFTARMLERP.C1 = LEFTARMLERP.C1:lerp(CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, 0), .4)
                ROOTLERP.C0 =
                    ROOTLERP.C0:lerp(CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)), 0.4)
                LEFTARMLERP.C0 =
                    LEFTARMLERP.C0:lerp(
                    CFrame.new(1.4, .1, -.2) * CFrame.Angles(math.rad(20), math.rad(-3), math.rad(-4)),
                    0.4
                )
                RIGHTLEGLERP.C0 =
                    RIGHTLEGLERP.C0:lerp(
                    CFrame.new(-0.5, 2, 0) * CFrame.Angles(math.rad(10), math.rad(0), math.rad(0)),
                    0.4
                )
                LEFTLEGLERP.C0 =
                    LEFTLEGLERP.C0:lerp(
                    CFrame.new(0.5, 1.0, .9) * CFrame.Angles(math.rad(20), math.rad(0), math.rad(0)),
                    0.4
                )
            elseif position == "Jump2" and attacking == false then
                change = 1
                ROOTLERP.C0 =
                    ROOTLERP.C0:lerp(
                    CFrame.new(0, 0, 0) *
                        CFrame.Angles(
                            math.rad(-20 - 1 * math.sin(sine / 9)),
                            math.rad(0 + 0 * math.cos(sine / 8)),
                            math.rad(0) + Root.RotVelocity.Y / 30,
                            math.cos(10 * math.cos(sine / 10))
                        ),
                    0.3
                )
                LEFTLEGLERP.C1 = LEFTLEGLERP.C1:lerp(CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, 0), .3)
                RIGHTLEGLERP.C1 = RIGHTLEGLERP.C1:lerp(CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), 0, 0), .3)
                RIGHTARMLERP.C0 =
                    RIGHTARMLERP.C0:lerp(
                    CFrame.new(-1.5, .6, -.5) *
                        CFrame.Angles(
                            math.rad(32),
                            math.rad(5 - .1 * math.sin(sine / 12)),
                            math.rad(40 - .5 * math.sin(sine / 12))
                        ),
                    0.3
                )
                LEFTARMLERP.C0 =
                    LEFTARMLERP.C0:lerp(
                    CFrame.new(1.5, .6, -.5) *
                        CFrame.Angles(
                            math.rad(30),
                            math.rad(-5 + .1 * math.sin(sine / 12)),
                            math.rad(-40 + .5 * math.sin(sine / 12))
                        ),
                    0.3
                )
                LEFTARMLERP.C1 = LEFTARMLERP.C1:lerp(CFrame.new(.2, 1.2, -.3), .3)
                RIGHTLEGLERP.C0 =
                    RIGHTLEGLERP.C0:lerp(
                    CFrame.new(-0.54, 1.4 + .1 * math.sin(sine / 9), .4) *
                        CFrame.Angles(math.rad(9 + 2 * math.cos(sine / 9)), math.rad(0), math.rad(0)),
                    0.3
                )
                LEFTLEGLERP.C0 =
                    LEFTLEGLERP.C0:lerp(
                    CFrame.new(0.54, 2.0 + .02 * math.sin(sine / 9), 0.2 + .1 * math.sin(sine / 9)) *
                        CFrame.Angles(math.rad(25 + 5 * math.sin(sine / 9)), math.rad(20), math.rad(0)),
                    0.3
                )
            elseif position == "Falling" and attacking == false then
                change = 1
                tommygunweld.C0 =
                    tommygunweld.C0:lerp(CFrame.new(0, -.80, 1.25) * CFrame.Angles(math.rad(98), math.rad(0), 0), .25)
                LEFTLEGLERP.C1 = LEFTLEGLERP.C1:lerp(CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, 0), .1)
                RIGHTLEGLERP.C1 = RIGHTLEGLERP.C1:lerp(CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), 0, 0), .1)
                LEFTARMLERP.C1 = LEFTARMLERP.C1:lerp(CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, 0), .4)
                RIGHTLEGLERP.C0 =
                    RIGHTLEGLERP.C0:lerp(
                    CFrame.new(-0.5, 2, 0) * CFrame.Angles(math.rad(8), math.rad(4), math.rad(0)),
                    0.2
                )
                LEFTLEGLERP.C0 =
                    LEFTLEGLERP.C0:lerp(
                    CFrame.new(0.5, 1.0, .9) * CFrame.Angles(math.rad(14), math.rad(-4), math.rad(0)),
                    0.2
                )
                LEFTARMLERP.C0 =
                    LEFTARMLERP.C0:lerp(
                    CFrame.new(1.6, 0.5, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(20)),
                    0.2
                )
            elseif position == "Falling2" and attacking == false then
                change = 1
                ROOTLERP.C0 =
                    ROOTLERP.C0:lerp(
                    CFrame.new(0, 0, 0) *
                        CFrame.Angles(
                            math.rad(-20 - 1 * math.sin(sine / 9)),
                            math.rad(0 + 0 * math.cos(sine / 8)),
                            math.rad(0) + Root.RotVelocity.Y / 30,
                            math.cos(10 * math.cos(sine / 10))
                        ),
                    0.3
                )
                LEFTLEGLERP.C1 = LEFTLEGLERP.C1:lerp(CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, 0), .3)
                RIGHTLEGLERP.C1 = RIGHTLEGLERP.C1:lerp(CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), 0, 0), .3)
                RIGHTARMLERP.C0 =
                    RIGHTARMLERP.C0:lerp(
                    CFrame.new(-1.5, .6, -.5) *
                        CFrame.Angles(
                            math.rad(32),
                            math.rad(5 - .1 * math.sin(sine / 12)),
                            math.rad(40 - .5 * math.sin(sine / 12))
                        ),
                    0.3
                )
                LEFTARMLERP.C0 =
                    LEFTARMLERP.C0:lerp(
                    CFrame.new(1.5, .6, -.5) *
                        CFrame.Angles(
                            math.rad(30),
                            math.rad(-5 + .1 * math.sin(sine / 12)),
                            math.rad(-40 + .5 * math.sin(sine / 12))
                        ),
                    0.3
                )
                LEFTARMLERP.C1 = LEFTARMLERP.C1:lerp(CFrame.new(.2, 1.2, -.3), .3)
                RIGHTLEGLERP.C0 =
                    RIGHTLEGLERP.C0:lerp(
                    CFrame.new(-0.54, 1.4 + .1 * math.sin(sine / 9), .4) *
                        CFrame.Angles(math.rad(9 + 2 * math.cos(sine / 9)), math.rad(0), math.rad(0)),
                    0.3
                )
                LEFTLEGLERP.C0 =
                    LEFTLEGLERP.C0:lerp(
                    CFrame.new(0.54, 2.0 + .02 * math.sin(sine / 9), 0.2 + .1 * math.sin(sine / 9)) *
                        CFrame.Angles(math.rad(25 + 5 * math.sin(sine / 9)), math.rad(20), math.rad(0)),
                    0.3
                )
            elseif position == "Walking" and attacking == false and running == false then
                change = 1.2
                walking = true
                tommygunweld.C0 =
                    tommygunweld.C0:lerp(CFrame.new(0, -.80, 1.25) * CFrame.Angles(math.rad(98), math.rad(0), 0), .25)
                RIGHTARMLERP.C0 =
                    RIGHTARMLERP.C0:lerp(
                    CFrame.new(-1.3, 1, 0) * CFrame.Angles(math.rad(180), math.rad(1), math.rad(10)),
                    0.1
                )
                LEFTLEGLERP.C1 = LEFTLEGLERP.C1:lerp(CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, 0), .1)
                RIGHTLEGLERP.C1 = RIGHTLEGLERP.C1:lerp(CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), 0, 0), .1)
                LEFTARMLERP.C0 =
                    LEFTARMLERP.C0:lerp(
                    CFrame.new(1.5 + Root.RotVelocity.Y / 85, .35, .5 * math.sin(sine / 8)) *
                        CFrame.Angles(
                            math.rad(-35 * math.sin(sine / 8)),
                            math.rad(0 * math.sin(sine / 8)),
                            math.rad(10 + Root.RotVelocity.Y / 10, math.sin(20 * math.sin(sine / 4)))
                        ),
                    .3
                )
                ROOTLERP.C0 =
                    ROOTLERP.C0:lerp(
                    CFrame.new(0, 0.05 * math.sin(sine / 4), 0) *
                        CFrame.Angles(
                            math.rad(-10),
                            math.rad(5 * math.cos(sine / 7)),
                            math.rad(0) + Root.RotVelocity.Y / 30,
                            math.cos(25 * math.cos(sine / 10))
                        ),
                    0.1
                )
                RIGHTLEGLERP.C0 =
                    RIGHTLEGLERP.C0:lerp(
                    CFrame.new(-0.5, 1.92 - 0.35 * math.cos(sine / 8) / 2.8, 0.2 - math.sin(sine / 8) / 3.4) *
                        CFrame.Angles(
                            math.rad(10) + -math.sin(sine / 8) / 2.3,
                            math.rad(0) * math.cos(sine / 1),
                            math.rad(0),
                            math.cos(25 * math.cos(sine / 8))
                        ),
                    0.3
                )
                LEFTLEGLERP.C0 =
                    LEFTLEGLERP.C0:lerp(
                    CFrame.new(0.5, 1.92 + 0.35 * math.cos(sine / 8) / 2.8, 0.2 + math.sin(sine / 8) / 3.4) *
                        CFrame.Angles(
                            math.rad(10) - -math.sin(sine / 8) / 2.3,
                            math.rad(0) * math.cos(sine / 1),
                            math.rad(0),
                            math.cos(25 * math.cos(sine / 8))
                        ),
                    0.3
                )
            elseif position == "Idle" and attacking == false and running == false then
                change = .5
                tommygunweld.C0 =
                    tommygunweld.C0:lerp(CFrame.new(0, -.80, 1.25) * CFrame.Angles(math.rad(98), math.rad(0), 0), .25)
                ROOTLERP.C0 =
                    ROOTLERP.C0:lerp(
                    CFrame.new(0, -.2 + -.1 * math.sin(sine / 12), 0) *
                        CFrame.Angles(math.rad(0), math.rad(25), math.rad(0)),
                    .1
                )
                RIGHTARMLERP.C0 =
                    RIGHTARMLERP.C0:lerp(
                    CFrame.new(-1.3 + .1 * math.sin(sine / 12), 1 + .1 * math.sin(sine / 12), 0) *
                        CFrame.Angles(math.rad(180), math.rad(1), math.rad(8 + 5 * math.sin(sine / 12))),
                    0.1
                )
                LEFTARMLERP.C0 =
                    LEFTARMLERP.C0:lerp(
                    CFrame.new(1.59 - .05 * math.sin(sine / 12), 0.1 - .1 * math.sin(sine / 12), 0) *
                        CFrame.Angles(math.rad(-2), math.rad(2), math.rad(8 - 6 * math.sin(sine / 12))),
                    .2
                )
                RIGHTLEGLERP.C1 = RIGHTLEGLERP.C1:lerp(CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), 0, 0), .1)
                RIGHTLEGLERP.C0 =
                    RIGHTLEGLERP.C0:lerp(
                    CFrame.new(-0.3, 2 - .1 * math.sin(sine / 12), 0) *
                        CFrame.Angles(math.rad(0), math.rad(0), math.rad(-10)),
                    0.1
                )
                LEFTLEGLERP.C1 = LEFTLEGLERP.C1:lerp(CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, 0), .1)
                LEFTLEGLERP.C0 =
                    LEFTLEGLERP.C0:lerp(
                    CFrame.new(0.3, 2.0 - .1 * math.sin(sine / 12), 0) *
                        CFrame.Angles(math.rad(0), math.rad(0), math.rad(10)),
                    0.1
                )
            elseif position == "Idle2" and attacking == false and running == false then
                change = .75
                ROOTLERP.C0 =
                    ROOTLERP.C0:lerp(
                    CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0 - 3 * math.sin(sine / 9)), 0, 0),
                    .1
                )
                RIGHTLEGLERP.C1 = RIGHTLEGLERP.C1:lerp(CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), 0, 0), .1)
                LEFTLEGLERP.C1 = LEFTLEGLERP.C1:lerp(CFrame.new(-.2, .2, 0) * CFrame.Angles(0, 0, 0), .1)
                LEFTARMLERP.C1 = CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, 0)
                LEFTARMLERP.C0 =
                    LEFTARMLERP.C0:lerp(
                    CFrame.new(1.6, 0.8 - .1 * math.sin(sine / 9), 0) *
                        CFrame.Angles(
                            math.rad(0),
                            math.rad(0 + 3 * math.sin(sine / 9)),
                            math.rad(35 - 5 * math.sin(sine / 9))
                        ),
                    0.4
                )
                RIGHTARMLERP.C0 =
                    RIGHTARMLERP.C0:lerp(
                    CFrame.new(-1.6, 0.8 - .1 * math.sin(sine / 9), 0) *
                        CFrame.Angles(
                            math.rad(0),
                            math.rad(0 - 3 * math.sin(sine / 9)),
                            math.rad(-35 + 5 * math.sin(sine / 9))
                        ),
                    0.4
                )
                RIGHTLEGLERP.C0 =
                    RIGHTLEGLERP.C0:lerp(
                    CFrame.new(-0.54, 1.4 + .1 * math.sin(sine / 9), .4) *
                        CFrame.Angles(math.rad(9 + 2 * math.cos(sine / 9)), math.rad(0), math.rad(0)),
                    0.4
                )
                LEFTLEGLERP.C0 =
                    LEFTLEGLERP.C0:lerp(
                    CFrame.new(0.5, 2.0, 0) *
                        CFrame.Angles(math.rad(0), math.rad(0), math.rad(-10 + 2 * math.sin(sine / 9))),
                    0.4
                )
            elseif position == "Walking2" and attacking == false and running == false then
                ws = 50
                ROOTLERP.C0 =
                    ROOTLERP.C0:lerp(
                    CFrame.new(0, 0, 0) *
                        CFrame.Angles(
                            math.rad(-20 - 1 * math.sin(sine / 9)),
                            math.rad(0 + 0 * math.cos(sine / 8)),
                            math.rad(0) + Root.RotVelocity.Y / 30,
                            math.cos(10 * math.cos(sine / 10))
                        ),
                    0.3
                )
                LEFTLEGLERP.C1 = LEFTLEGLERP.C1:lerp(CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, 0), .3)
                RIGHTLEGLERP.C1 = RIGHTLEGLERP.C1:lerp(CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), 0, 0), .3)
                RIGHTARMLERP.C0 =
                    RIGHTARMLERP.C0:lerp(
                    CFrame.new(-1.5, .6, -.5) *
                        CFrame.Angles(
                            math.rad(32),
                            math.rad(5 - .1 * math.sin(sine / 12)),
                            math.rad(40 - .5 * math.sin(sine / 12))
                        ),
                    0.3
                )
                LEFTARMLERP.C0 =
                    LEFTARMLERP.C0:lerp(
                    CFrame.new(1.5, .6, -.5) *
                        CFrame.Angles(
                            math.rad(30),
                            math.rad(-5 + .1 * math.sin(sine / 12)),
                            math.rad(-40 + .5 * math.sin(sine / 12))
                        ),
                    0.3
                )
                LEFTARMLERP.C1 = LEFTARMLERP.C1:lerp(CFrame.new(.2, 1.2, -.3), .3)
                RIGHTLEGLERP.C0 =
                    RIGHTLEGLERP.C0:lerp(
                    CFrame.new(-0.54, 1.4 + .1 * math.sin(sine / 9), .4) *
                        CFrame.Angles(math.rad(9 + 2 * math.cos(sine / 9)), math.rad(0), math.rad(0)),
                    0.3
                )
                LEFTLEGLERP.C0 =
                    LEFTLEGLERP.C0:lerp(
                    CFrame.new(0.54, 2.0 + .02 * math.sin(sine / 9), 0.2 + .1 * math.sin(sine / 9)) *
                        CFrame.Angles(math.rad(25 + 5 * math.sin(sine / 9)), math.rad(20), math.rad(0)),
                    0.3
                )
            elseif position == "Running" and attacking == false then
                change = 1
                RIGHTARMLERP.C0 =
                    RIGHTARMLERP.C0:lerp(
                    CFrame.new(0, .5, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)),
                    0.3
                )
                LEFTARMLERP.C1 =
                    LEFTARMLERP.C1:lerp(
                    CFrame.new(-1.24 + .6 * math.sin(sine / 4) / 1.4, 0.54, 0 - 0.8 * math.sin(sine / 4)) *
                        CFrame.Angles(
                            math.rad(6 + 140 * math.sin(sine / 4) / 1.2),
                            math.rad(0),
                            math.rad(20 + 70 * math.sin(sine / 4))
                        ),
                    0.3
                )
                LEFTARMLERP.C0 =
                    LEFTARMLERP.C0:lerp(CFrame.new(0, .5, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)), .3)
                ROOTLERP.C0 =
                    ROOTLERP.C0:lerp(
                    CFrame.new(0, -.2, 0) *
                        CFrame.Angles(
                            math.rad(-20 - 0 * math.sin(sine / 4)),
                            math.rad(0 + 6 * math.sin(sine / 4)),
                            math.rad(0) + Root.RotVelocity.Y / 30,
                            math.sin(10 * math.sin(sine / 4))
                        ),
                    0.3
                )
                RIGHTLEGLERP.C1 = RIGHTLEGLERP.C1:lerp(CFrame.new(0, 0, -.2 + .5 * -math.sin(sine / 4)), .3)
                RIGHTLEGLERP.C0 =
                    RIGHTLEGLERP.C0:lerp(
                    CFrame.new(-0.5, 1.6 + 0.1 * math.sin(sine / 4), .7 * -math.sin(sine / 4)) *
                        CFrame.Angles(math.rad(15 + -50 * math.sin(sine / 4)), 0, 0),
                    .3
                )
                LEFTLEGLERP.C1 = LEFTLEGLERP.C1:lerp(CFrame.new(0, 0, -.2 + .5 * math.sin(sine / 4)), .3)
                LEFTLEGLERP.C0 =
                    LEFTLEGLERP.C0:lerp(
                    CFrame.new(0.5, 1.6 - 0.1 * math.sin(sine / 4), .7 * math.sin(sine / 4)) *
                        CFrame.Angles(math.rad(15 + 50 * math.sin(sine / 4)), 0, 0),
                    .3
                )
            end
            swait()
        end
    end
)
anims()
warn("Risen from hell, ready to prove his reputation. Made by Supr14")