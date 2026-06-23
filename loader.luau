local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AHonaHub"
ScreenGui.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 500, 0, 400)
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
MainFrame.BackgroundTransparency = 0.05
MainFrame.BorderSizePixel = 0

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

local TitleBar = Instance.new("Frame")
TitleBar.Parent = MainFrame
TitleBar.Size = UDim2.new(1, 0, 0, 45)
TitleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
TitleBar.BackgroundTransparency = 0.5
TitleBar.BorderSizePixel = 0

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = TitleBar
TitleLabel.Size = UDim2.new(1, -50, 1, 0)
TitleLabel.Position = UDim2.new(0, 20, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "AHona Hub"
TitleLabel.TextColor3 = Color3.fromRGB(200, 180, 255)
TitleLabel.TextSize = 22
TitleLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.TextScaled = true

local CloseButton = Instance.new("TextButton")
CloseButton.Parent = TitleBar
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -38, 0, 8)
CloseButton.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
CloseButton.BackgroundTransparency = 0.5
CloseButton.BorderSizePixel = 0
CloseButton.Text = "✕"
CloseButton.TextColor3 = Color3.fromRGB(255, 100, 100)
CloseButton.TextSize = 16
CloseButton.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
CloseButton.AutoButtonColor = false

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 5)
CloseCorner.Parent = CloseButton

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

local Sidebar = Instance.new("Frame")
Sidebar.Parent = MainFrame
Sidebar.Size = UDim2.new(0, 120, 1, -45)
Sidebar.Position = UDim2.new(0, 0, 0, 45)
Sidebar.BackgroundColor3 = Color3.fromRGB(16, 16, 20)
Sidebar.BackgroundTransparency = 0.5
Sidebar.BorderSizePixel = 0

local ContentFrame = Instance.new("Frame")
ContentFrame.Parent = MainFrame
ContentFrame.Size = UDim2.new(1, -120, 1, -45)
ContentFrame.Position = UDim2.new(0, 120, 0, 45)
ContentFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
ContentFrame.BackgroundTransparency = 0.1
ContentFrame.BorderSizePixel = 0

local TabData = {
    {Name = "Rage", Icon = "⚡", Color = Color3.fromRGB(255, 150, 100)},
    {Name = "Silent Aim", Icon = "🎯", Color = Color3.fromRGB(100, 200, 255)},
    {Name = "Visuals", Icon = "👁️", Color = Color3.fromRGB(150, 255, 150)},
    {Name = "Misc", Icon = "⚙️", Color = Color3.fromRGB(200, 200, 200)},
}

for i, data in ipairs(TabData) do
    local Button = Instance.new("TextButton")
    Button.Parent = Sidebar
    Button.Size = UDim2.new(1, -10, 0, 45)
    Button.Position = UDim2.new(0, 5, 0, 5 + (i - 1) * 50)
    Button.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    Button.BackgroundTransparency = 0.8
    Button.BorderSizePixel = 0
    Button.Text = ""
    Button.AutoButtonColor = false

    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 6)
    ButtonCorner.Parent = Button

    local IconLabel = Instance.new("TextLabel")
    IconLabel.Parent = Button
    IconLabel.Size = UDim2.new(0, 30, 1, 0)
    IconLabel.Position = UDim2.new(0, 8, 0, 0)
    IconLabel.BackgroundTransparency = 1
    IconLabel.Text = data.Icon
    IconLabel.TextSize = 18
    IconLabel.TextColor3 = data.Color
    IconLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")

    local NameLabel = Instance.new("TextLabel")
    NameLabel.Parent = Button
    NameLabel.Size = UDim2.new(1, -45, 1, 0)
    NameLabel.Position = UDim2.new(0, 42, 0, 0)
    NameLabel.BackgroundTransparency = 1
    NameLabel.Text = data.Name
    NameLabel.TextColor3 = Color3.fromRGB(180, 180, 200)
    NameLabel.TextSize = 14
    NameLabel.TextXAlignment = Enum.TextXAlignment.Left
    NameLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")

    local ActiveBar = Instance.new("Frame")
    ActiveBar.Parent = Button
    ActiveBar.Size = UDim2.new(0, 3, 1, -10)
    ActiveBar.Position = UDim2.new(0, 0, 0, 5)
    ActiveBar.BackgroundColor3 = data.Color
    ActiveBar.BackgroundTransparency = 1
    ActiveBar.BorderSizePixel = 0

    if i == 1 then
        ActiveBar.BackgroundTransparency = 0
        Button.BackgroundTransparency = 0.5
    end

    Button.MouseButton1Click:Connect(function()
        for _, child in ipairs(Sidebar:GetChildren()) do
            if child:IsA("TextButton") and child:FindFirstChild("ActiveBar") then
                child.ActiveBar.BackgroundTransparency = 1
                child.BackgroundTransparency = 0.8
            end
        end
        ActiveBar.BackgroundTransparency = 0
        Button.BackgroundTransparency = 0.5
    end)
end

local dragging = false
local dragStart = nil
local frameStart = nil

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        frameStart = MainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(
            frameStart.X.Scale,
            frameStart.X.Offset + delta.X,
            frameStart.Y.Scale,
            frameStart.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)
