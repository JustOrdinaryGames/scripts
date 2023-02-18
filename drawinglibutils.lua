local ret = {}

function ret.getStringWidth(msg, size)
    local text = Drawing.new("Text")
    text.Position = Vector2.new(-100000,-100000)
    text.Size = size
    text.Visible = true
    text.Transparency = 1
    text.Color = Color3.new(1,1,1)
    text.Text = msg
    text.Font = 2
    local bounds = text.TextBounds
    text:Remove()
    return bounds.X
end
function ret.getFontHeight(size)
    local text = Drawing.new("Text")
    text.Position = Vector2.new(-100000,-100000)
    text.Size = size
    text.Visible = true
    text.Transparency = 1
    text.Color = Color3.new(1,1,1)
    text.Text = 'test'
    text.Font = 2
    local bounds = text.TextBounds
    text:Remove()
    return bounds.Y
end

return ret