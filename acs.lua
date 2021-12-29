local GUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/aaaa"))()

local UI = GUI:CreateWindow("AdvancedCuckShit")

local Home = UI:addPage("Mosin Nagant",1,true,6)

Home:addLabel("Gun Mods")

Home:addLabel("Gun Mods must be reran after death",
"Also don't hold the gun whilst modding")

local infammov = false
local onehitv = false
local penetv = false
local infammo = Home:addToggle("Inf Ammo",function(value) infammov = value end)
local onehit = Home:addToggle("Inf Damage",function(value) onehitv = value end)
local penet = Home:addToggle("Inf Penetration",function(value) penetv = value end)

Home:addButton("Mod the gun",function()
    local v4 = require(game:GetService("Players").LocalPlayer.Backpack["Mosin Nagant"]["ACS_Settings"])
    if infammov then
        v4.Ammo = math.huge
        v4.StoredAmmo = math.huge
        v4.AmmoInGun = math.huge
        v4.MaxStoredAmmo = math.huge
        v4.MagCount = true
    end
    if onehitv then
        v4.LimbDamage = 1000
        v4.TorsoDamage = 1000
        v4.HeadDamage = 1000
    end
    if penetv then
        v4.BulletPenetration = 75
    end
    v4.MinSpread = 0
    v4.MaxSpread = 0
    v4.CrossHair = true
    v4.CenterDot = false
    game.StarterGui:SetCore("SendNotification",{
        Title = "Modded";
        Text = "acs on bottom";
    })
end)