_G.JustsMiztHubDisabled = false
local reanimMode = ""
local noclip = false

local DiscordLib = loadstring(game:HttpGet "https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/discord")()

local win = DiscordLib:Window("Mizt Hub V0.1 BETA (Unofficial)")

local serv = win:Server("Scripts", "")

local reanimChanger = serv:Channel("Reanimate")

function runReanim()
    runningScript = true
    if reanimMode == "Normal" then
        _G.MiztReanimSettings = {
            PermanentDeath = false,
            NoHeadPermanentDeath = false,
            Noclip = noclip,
            HatReanimate = false,
            SemiHatReanimate = false,
            UseMizaruTorso = true,
            FlingActive = false,
            AlignMethod = false,
            Netless = true,
            ActiveLegacyNet = false,
            NetlessVelocity = {0,0,-50}
        }

        loadstring(game:HttpGet('https://raw.githubusercontent.com/Sylixe/Scripts/main/MiztReanimate.lua',true))()
    elseif reanimMode == "Perm Death" then
        _G.MiztReanimSettings = {
            PermanentDeath = true,
            NoHeadPermanentDeath = false,
            Noclip = noclip,
            HatReanimate = false,
            SemiHatReanimate = false,
            UseMizaruTorso = true,
            FlingActive = true,
            AlignMethod = false,
            Netless = true,
            ActiveLegacyNet = false,
            NetlessVelocity = {0,0,-50}
        }

        loadstring(game:HttpGet('https://raw.githubusercontent.com/Sylixe/Scripts/main/MiztReanimate.lua',true))()
    elseif reanimMode == "Perm Death (Headless)" then
        _G.MiztReanimSettings = {
            PermanentDeath = true,
            NoHeadPermanentDeath = true,
            Noclip = noclip,
            HatReanimate = false,
            SemiHatReanimate = false,
            UseMizaruTorso = true,
            FlingActive = true,
            AlignMethod = false,
            Netless = true,
            ActiveLegacyNet = false,
            NetlessVelocity = {0,0,-50}
        }

        loadstring(game:HttpGet('https://raw.githubusercontent.com/Sylixe/Scripts/main/MiztReanimate.lua',true))()
    end
end

local modeChanger =
reanimChanger:Dropdown(
    "Reanimate mode",
    {"Normal", "Perm Death", "Perm Death (Headless)"},
    function(mode)
        reanimMode = mode
    end
)

reanimChanger:Toggle(
    "Noclip",
    false,
    function(bool)
        noclip = bool
    end
)

local aScripts = serv:Channel("Anim Scripts")

aScripts:Button(
    "Krystal Dance",
    function()
        if reanimMode == "" then
            DiscordLib:Notification("Error", "Select a reanimation mode", "Okay")
        else
            runReanim()
            coroutine.wrap(function()
                print("Running github build! - Krystal Dance")
                loadstring(game:HttpGet('https://raw.githubusercontent.com/JustOrdinaryGames/scripts/main/Unofficial%20Mizt%20Hub/Scripts/Normal/Krystal%20Dance.lua',true))()
                --print("Running paste.ee build! (DEBUG) - Krystal Dance")
                --loadstring(game:HttpGet('',true))()
            end)()
        end
    end
)

aScripts:Button(
    "Memeus",
    function()
        if reanimMode == "" then
            DiscordLib:Notification("Error", "Select a reanimation mode", "Okay")
        else
            runReanim()
            coroutine.wrap(function()
                print("Running github build! - Memeus")
                loadstring(game:HttpGet('https://raw.githubusercontent.com/JustOrdinaryGames/scripts/main/Unofficial%20Mizt%20Hub/Scripts/Normal/Memeus.lua',true))()
            end)()
        end
    end
)

local aScripts = serv:Channel("Hat Scripts")

aScripts:Button(
    "Neptunian V",
    function()
        if reanimMode == "" then
            DiscordLib:Notification("Error", "Select a reanimation mode", "Okay")
        elseif reanimMode == "Normal" then
            DiscordLib:Notification("Error", "Please use a permanent death mode.", "Okay")
        else
            runReanim()
            coroutine.wrap(function()
                print("Running github build! - Neptunian V")
                loadstring(game:HttpGet('https://raw.githubusercontent.com/JustOrdinaryGames/scripts/main/Unofficial%20Mizt%20Hub/Scripts/Hat%20Scripts/Neptunian%20V.lua',true))()
            end)()
        end
    end
)

local credits = serv:Channel("Credits")

credits:Label("Reanimation: Mizt#5033")
credits:Label("UI Library: dawid#7205 (might be outdated)")
credits:Label("Script Hub Creator: JustOrdinaryGames#0986 [me :)]")