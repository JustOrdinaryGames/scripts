local lib = {}

local pastDraws = {}
local drawScreenFunc = nil
local mouseClickedFunc = nil
local mouseReleasedFunc = nil
local mouse = game.Players.LocalPlayer:GetMouse()

function lib:ConnectToDrawScreen(func)
    drawScreenFunc = func
end
function lib:ConnectToMouseClicked(func)
    mouseClickedFunc = func
end
function lib:ConnectToMouseReleased(func)
    mouseReleasedFunc = func
end

local drawScreen = game.RunService.RenderStepped:Connect(function()
    for i,v in pairs(pastDraws) do
        v:Remove()
    end
    pastDraws = {}
    if drawScreenFunc ~= nil then
        local args = {}
        function args.drawRect(x,y,width,height,color)
            local square = Drawing.new("Square")
            square.Position = Vector2.new(x,y)
            square.Size = Vector2.new(width,height)
            square.Visible = true
            square.Transparency = 1
            square.Color = color
            table.insert(pastDraws, square)
        end
        drawScreenFunc(args, mouse.X, mouse.Y)
    end
end)

local mouse1D = mouse.Button1Down:Connect(function()
    if mouseClickedFunc ~= nil then
        mouseClickedFunc(mouse.X, mouse.Y, 0)
    end
end)

local mouse2D = mouse.Button2Down:Connect(function()
    if mouseClickedFunc ~= nil then
        mouseClickedFunc(mouse.X, mouse.Y, 1)
    end
end)

local mouse1U = mouse.Button1Up:Connect(function()
    if mouseReleasedFunc ~= nil then
        mouseReleasedFunc(mouse.X, mouse.Y, 0)
    end
end)

local mouse2U = mouse.Button2Up:Connect(function()
    if mouseReleasedFunc ~= nil then
        mouseReleasedFunc(mouse.X, mouse.Y, 1)
    end
end)

coroutine.wrap(function()
    while wait() do
        if _G.disableuilolololololololololololol then
            _G.disableuilolololololololololololol = false
            drawScreen:Disconnect()
            mouse1D:Disconnect()
            mouse1U:Disconnect()
            mouse2D:Disconnect()
            mouse2U:Disconnect()
            for i,v in pairs(pastDraws) do
                v:Remove()
            end
            pastDraws = {}
            print('Unhooked Successfully')
            break
        end
    end
end)()

return lib