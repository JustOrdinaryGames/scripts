local lib = {}

local savedImages = {}
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
        function args.drawRect(x,y,width,height,color,transparency)
            local square = Drawing.new("Square")
            square.Position = Vector2.new(x,y)
            square.Size = Vector2.new(width,height)
            square.Visible = true
            square.Transparency = 1
            square.Color = color
            if transparency ~= nil then
                square.Transparency = 1 - transparency -- Converts bullshit transparency to not bullshit transparency
            end
            table.insert(pastDraws, square)
        end
        function args.drawImage(x,y,width,height,color,imageurl,transparency)
            if savedImages[imageurl] == nil then
                savedImages[imageurl] = game:HttpGet(imageurl)
            end
            local square = Drawing.new("Image")
            square.Position = Vector2.new(x,y)
            square.Size = Vector2.new(width,height)
            square.Visible = true
            square.Transparency = 1
            square.Color = color
            square.Data = savedImages[imageurl]
            if transparency ~= nil then
                square.Transparency = 1 - transparency -- Converts bullshit transparency to not bullshit transparency
            end
            table.insert(pastDraws, square)
        end
        function args.drawString(msg,x,y,size,color,transparency)
            local text = Drawing.new("Text")
            text.Position = Vector2.new(x,y)
            text.Size = size
            text.Visible = true
            text.Transparency = 1
            text.Color = color
            text.Text = msg
            text.Font = 3
            if transparency ~= nil then
                text.Transparency = 1 - transparency -- Converts bullshit transparency to not bullshit transparency
            end
            table.insert(pastDraws, text)
        end
        function args.drawStringWithOutline(msg,x,y,size,color,outline,transparency)
            local text = Drawing.new("Text")
            text.Position = Vector2.new(x,y)
            text.Size = size
            text.Visible = true
            text.Transparency = 1
            text.Color = color
            text.Text = msg
            text.Outline = true
            text.OutlineColor = outline
            text.Font = 3
            if transparency ~= nil then
                text.Transparency = 1 - transparency -- Converts bullshit transparency to not bullshit transparency
            end
            table.insert(pastDraws, text)
        end
        function args.getStringWidth(msg, size)
            local text = Drawing.new("Text")
            text.Position = Vector2.new(-100000,-100000)
            text.Size = size
            text.Visible = true
            text.Transparency = 1
            text.Color = Color3.new(1,1,1)
            text.Text = msg
            text.Font = 3
            local bounds = text.TextBounds
            text:Remove()
            return bounds.X
        end
        drawScreenFunc(args, mouse.X, mouse.Y + 36)
    end
end)

local mouse1D = mouse.Button1Down:Connect(function()
    if mouseClickedFunc ~= nil then
        mouseClickedFunc(mouse.X, mouse.Y + 36, 0)
    end
end)

local mouse2D = mouse.Button2Down:Connect(function()
    if mouseClickedFunc ~= nil then
        mouseClickedFunc(mouse.X, mouse.Y + 36, 1)
    end
end)

local mouse1U = mouse.Button1Up:Connect(function()
    if mouseReleasedFunc ~= nil then
        mouseReleasedFunc(mouse.X, mouse.Y + 36, 0)
    end
end)

local mouse2U = mouse.Button2Up:Connect(function()
    if mouseReleasedFunc ~= nil then
        mouseReleasedFunc(mouse.X, mouse.Y + 36, 1)
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
            --print('Unhooked Successfully')
            break
        end
    end
end)()

return lib