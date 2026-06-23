local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AHonaHub"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 780, 0, 520)
MainFrame.BackgroundColor3 = Color3.fromRGB(13, 13, 17)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 1.5
MainStroke.Color = Color3.fromRGB(45, 45, 60)
MainStroke.Parent = MainFrame

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
TitleBar.Size = UDim2.new(1, 0, 0, 50)
TitleBar.BackgroundColor3 = Color3.fromRGB(18, 18, 23)
TitleBar.BorderSizePixel = 0

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = TitleBar
TitleLabel.Size = UDim2.new(1, -140, 1, 0)
TitleLabel.Position = UDim2.new(0, 20, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "AHona Hub"
TitleLabel.TextColor3 = Color3.fromRGB(220, 180, 255)
TitleLabel.TextSize = 24
TitleLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold)
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

local VersionLabel = Instance.new("TextLabel")
VersionLabel.Parent = TitleBar
VersionLabel.Size = UDim2.new(0, 100, 1, 0)
VersionLabel.Position = UDim2.new(1, -180, 0, 0)
VersionLabel.BackgroundTransparency = 1
VersionLabel.Text = "Pro"
VersionLabel.TextColor3 = Color3.fromRGB(130, 240, 130)
VersionLabel.TextSize = 18
VersionLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold)

local CloseButton = Instance.new("TextButton")
CloseButton.Parent = TitleBar
CloseButton.Size = UDim2.new(0, 36, 0, 36)
CloseButton.Position = UDim2.new(1, -46, 0, 7)
CloseButton.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
CloseButton.Text = "✕"
CloseButton.TextColor3 = Color3.fromRGB(255, 90, 90)
CloseButton.TextSize = 18
CloseButton.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseButton

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Tabs
local TabHolder = Instance.new("Frame")
TabHolder.Parent = MainFrame
TabHolder.Size = UDim2.new(1, 0, 0, 45)
TabHolder.Position = UDim2.new(0, 0, 0, 50)
TabHolder.BackgroundColor3 = Color3.fromRGB(16, 16, 21)
TabHolder.BorderSizePixel = 0

local TabList = Instance.new("UIListLayout")
TabList.Parent = TabHolder
TabList.FillDirection = Enum.FillDirection.Horizontal
TabList.SortOrder = Enum.SortOrder.LayoutOrder
TabList.Padding = UDim.new(0, 4)

local Tabs = {
    {Name = "Main", Color = Color3.fromRGB(255, 100, 100)},
    {Name = "Visuals", Color = Color3.fromRGB(100, 200, 255)},
    {Name = "ESP", Color = Color3.fromRGB(100, 255, 150)},
    {Name = "World", Color = Color3.fromRGB(255, 200, 100)},
    {Name = "Character", Color = Color3.fromRGB(200, 150, 255)},
    {Name = "기타", Color = Color3.fromRGB(180, 180, 180)},
    {Name = "Configs", Color = Color3.fromRGB(130, 220, 130)},
}

local TabButtons = {}
local ContentFrame = Instance.new("Frame")
ContentFrame.Parent = MainFrame
ContentFrame.Size = UDim2.new(1, 0, 1, -95)
ContentFrame.Position = UDim2.new(0, 0, 0, 95)
ContentFrame.BackgroundTransparency = 1

for i, tab in ipairs(Tabs) do
    local TabBtn = Instance.new("TextButton")
    TabBtn.Parent = TabHolder
    TabBtn.Size = UDim2.new(0, 100, 1, 0)
    TabBtn.BackgroundTransparency = 1
    TabBtn.Text = tab.Name
    TabBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
    TabBtn.TextSize = 15
    TabBtn.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")

    local Underline = Instance.new("Frame")
    Underline.Parent = TabBtn
    Underline.Size = UDim2.new(1, 0, 0, 3)
    Underline.Position = UDim2.new(0, 0, 1, -3)
    Underline.BackgroundColor3 = tab.Color
    Underline.BackgroundTransparency = 1

    TabBtn.MouseButton1Click:Connect(function()
        for _, btn in pairs(TabButtons) do
            btn.Underline.BackgroundTransparency = 1
            btn.Button.TextColor3 = Color3.fromRGB(180, 180, 200)
        end
        Underline.BackgroundTransparency = 0
        TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        -- 여기에 각 탭별 Content 업데이트 함수 호출
    end)

    TabButtons[tab.Name] = {Button = TabBtn, Underline = Underline}
end

-- 드래그 기능
local dragging, dragInput, dragStart, startPos
TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- 모바일 스케일
if UserInputService.TouchEnabled then
    MainFrame.Size = UDim2.new(0, 680, 0, 460)
end

print("AHona Hub 로드 완료")
