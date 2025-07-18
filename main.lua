local xyz = {}

function xyz:CreateHub()
    -- Проверка на повторное создание
    if game:GetService("CoreGui"):FindFirstChild("XYZHub") then
        game:GetService("CoreGui").XYZHub:Destroy()
    end

    -- Основные сервисы
    local TweenService = game:GetService("TweenService")
    local UserInputService = game:GetService("UserInputService")
    local RunService = game:GetService("RunService")

    -- Создание основного GUI
    local XYZHub = Instance.new("ScreenGui")
    XYZHub.Name = "XYZHub"
    XYZHub.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    XYZHub.ResetOnSpawn = false
    XYZHub.Parent = game:GetService("CoreGui")

    -- Основной фрейм
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 400, 0, 450)
    MainFrame.Position = UDim2.new(0.5, -200, 0.5, -225)
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    MainFrame.BackgroundTransparency = 0.3
    MainFrame.BorderSizePixel = 0
    MainFrame.ZIndex = 10
    MainFrame.ClipsDescendants = true

    -- Эффект стекла (glassmorphism)
    local GlassEffect = Instance.new("Frame")
    GlassEffect.Name = "GlassEffect"
    GlassEffect.Size = UDim2.new(1, 0, 1, 0)
    GlassEffect.BackgroundTransparency = 0.9
    GlassEffect.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    GlassEffect.BorderSizePixel = 0
    GlassEffect.ZIndex = 11

    local UIStroke = Instance.new("UIStroke")
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    UIStroke.Color = Color3.fromRGB(255, 255, 255)
    UIStroke.Transparency = 0.7
    UIStroke.Thickness = 1
    UIStroke.LineJoinMode = Enum.LineJoinMode.Round
    UIStroke.Parent = MainFrame

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 12)
    UICorner.Parent = MainFrame

    -- Тень
    local DropShadow = Instance.new("ImageLabel")
    DropShadow.Name = "DropShadow"
    DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
    DropShadow.BackgroundTransparency = 1
    DropShadow.BorderSizePixel = 0
    DropShadow.Position = UDim2.new(0.5, 0, 0.5, 4)
    DropShadow.Size = UDim2.new(1, 20, 1, 20)
    DropShadow.Image = "rbxassetid://1316045217"
    DropShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    DropShadow.ImageTransparency = 0.8
    DropShadow.ScaleType = Enum.ScaleType.Slice
    DropShadow.SliceCenter = Rect.new(10, 10, 118, 118)
    DropShadow.ZIndex = 9
    DropShadow.Parent = MainFrame

    GlassEffect.Parent = MainFrame
    MainFrame.Parent = XYZHub

    -- Заголовок и кнопка закрытия
    local TopBar = Instance.new("Frame")
    TopBar.Name = "TopBar"
    TopBar.Size = UDim2.new(1, 0, 0, 40)
    TopBar.BackgroundTransparency = 1
    TopBar.ZIndex = 12
    TopBar.Parent = MainFrame

    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(0, 200, 1, 0)
    Title.Position = UDim2.new(0, 15, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "XYZ Hub"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 18
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.ZIndex = 12
    Title.Parent = TopBar

    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(1, -40, 0.5, -15)
    CloseButton.AnchorPoint = Vector2.new(1, 0.5)
    CloseButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
    CloseButton.BackgroundTransparency = 0.8
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.TextSize = 14
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.ZIndex = 12

    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(1, 0)
    CloseCorner.Parent = CloseButton

    CloseButton.Parent = TopBar

    -- Вкладки
    local Tabs = Instance.new("Frame")
    Tabs.Name = "Tabs"
    Tabs.Size = UDim2.new(1, -30, 0, 30)
    Tabs.Position = UDim2.new(0, 15, 0, 50)
    Tabs.BackgroundTransparency = 1
    Tabs.ZIndex = 12
    Tabs.Parent = MainFrame

    local TabList = {"Player", "Combat", "Visuals"}
    local TabButtons = {}

    for i, tabName in ipairs(TabList) do
        local TabButton = Instance.new("TextButton")
        TabButton.Name = tabName .. "Tab"
        TabButton.Size = UDim2.new(0.333, -5, 1, 0)
        TabButton.Position = UDim2.new((i-1) * 0.333, 0, 0, 0)
        TabButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabButton.BackgroundTransparency = 0.9
        TabButton.Text = tabName
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabButton.TextSize = 14
        TabButton.Font = Enum.Font.Gotham
        TabButton.ZIndex = 12

        local TabCorner = Instance.new("UICorner")
        TabCorner.CornerRadius = UDim.new(0, 6)
        TabCorner.Parent = TabButton

        TabButton.Parent = Tabs
        TabButtons[tabName] = TabButton
    end

    -- Контейнер для контента вкладок
    local TabContent = Instance.new("Frame")
    TabContent.Name = "TabContent"
    TabContent.Size = UDim2.new(1, -30, 1, -100)
    TabContent.Position = UDim2.new(0, 15, 0, 90)
    TabContent.BackgroundTransparency = 1
    TabContent.ZIndex = 12
    TabContent.Parent = MainFrame

    -- Создаем контент для каждой вкладки
    local PlayerTab = Instance.new("ScrollingFrame")
    PlayerTab.Name = "PlayerTab"
    PlayerTab.Size = UDim2.new(1, 0, 1, 0)
    PlayerTab.BackgroundTransparency = 1
    PlayerTab.ScrollBarThickness = 3
    PlayerTab.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
    PlayerTab.ScrollBarImageTransparency = 0.8
    PlayerTab.Visible = false
    PlayerTab.ZIndex = 12
    PlayerTab.Parent = TabContent

    local CombatTab = Instance.new("ScrollingFrame")
    CombatTab.Name = "CombatTab"
    CombatTab.Size = UDim2.new(1, 0, 1, 0)
    CombatTab.BackgroundTransparency = 1
    CombatTab.ScrollBarThickness = 3
    CombatTab.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
    CombatTab.ScrollBarImageTransparency = 0.8
    CombatTab.Visible = false
    CombatTab.ZIndex = 12
    CombatTab.Parent = TabContent

    local VisualsTab = Instance.new("ScrollingFrame")
    VisualsTab.Name = "VisualsTab"
    VisualsTab.Size = UDim2.new(1, 0, 1, 0)
    VisualsTab.BackgroundTransparency = 1
    VisualsTab.ScrollBarThickness = 3
    VisualsTab.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
    VisualsTab.ScrollBarImageTransparency = 0.8
    VisualsTab.Visible = false
    VisualsTab.ZIndex = 12
    VisualsTab.Parent = TabContent

    -- Функция для создания кнопок с градиентом
    local function CreateGradientButton(name, text, parent, position)
        local Button = Instance.new("TextButton")
        Button.Name = name
        Button.Size = UDim2.new(1, 0, 0, 40)
        Button.Position = position or UDim2.new(0, 0, 0, 0)
        Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Button.BackgroundTransparency = 0.9
        Button.Text = text
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        Button.TextSize = 14
        Button.Font = Enum.Font.Gotham
        Button.ZIndex = 13

        local Corner = Instance.new("UICorner")
        Corner.CornerRadius = UDim.new(0, 8)
        Corner.Parent = Button

        local Gradient = Instance.new("UIGradient")
        Gradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 150, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 100, 255))
        }
        Gradient.Rotation = 90
        Gradient.Transparency = NumberSequence.new(0.7)
        Gradient.Parent = Button

        local Stroke = Instance.new("UIStroke")
        Stroke.Color = Color3.fromRGB(255, 255, 255)
        Stroke.Thickness = 1
        Stroke.Transparency = 0.8
        Stroke.Parent = Button

        Button.Parent = parent
        return Button
    end

    -- Добавляем кнопки на вкладку Player
    local FlyButton = CreateGradientButton("FlyButton", "Fly", PlayerTab, UDim2.new(0, 0, 0, 10))
    local NoclipButton = CreateGradientButton("NoclipButton", "Noclip", PlayerTab, UDim2.new(0, 0, 0, 60))
    local SpeedButton = CreateGradientButton("SpeedButton", "Speed Hack", PlayerTab, UDim2.new(0, 0, 0, 110))

    -- Добавляем кнопки на вкладку Visuals
    local ESPButton = CreateGradientButton("ESPButton", "ESP", VisualsTab, UDim2.new(0, 0, 0, 10))
    local ChamsButton = CreateGradientButton("ChamsButton", "Chams", VisualsTab, UDim2.new(0, 0, 0, 60))
    local FullbrightButton = CreateGradientButton("FullbrightButton", "Fullbright", VisualsTab, UDim2.new(0, 0, 0, 110))

    -- Добавляем кнопки на вкладку Combat
    local AimbotButton = CreateGradientButton("AimbotButton", "Aimbot", CombatTab, UDim2.new(0, 0, 0, 10))
    local TriggerBotButton = CreateGradientButton("TriggerBotButton", "Trigger Bot", CombatTab, UDim2.new(0, 0, 0, 60))
    local SilentAimButton = CreateGradientButton("SilentAimButton", "Silent Aim", CombatTab, UDim2.new(0, 0, 0, 110))

    -- Функционал кнопок (заглушки)
    FlyButton.MouseButton1Click:Connect(function()
        print("Fly activated")
    end)

    NoclipButton.MouseButton1Click:Connect(function()
        print("Noclip activated")
    end)

    ESPButton.MouseButton1Click:Connect(function()
        print("ESP activated")
    end)

    -- Переключение вкладок
    local function ShowTab(tabName)
        for _, tab in pairs({PlayerTab, CombatTab, VisualsTab}) do
            tab.Visible = false
        end
        
        if tabName == "Player" then
            PlayerTab.Visible = true
        elseif tabName == "Combat" then
            CombatTab.Visible = true
        elseif tabName == "Visuals" then
            VisualsTab.Visible = true
        end
    end

    for tabName, button in pairs(TabButtons) do
        button.MouseButton1Click:Connect(function()
            ShowTab(tabName)
        end)
    end

    -- Показываем первую вкладку по умолчанию
    ShowTab("Player")

    -- Перетаскивание окна
    local dragging
    local dragInput
    local dragStart
    local startPos

    local function Update(input)
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    TopBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            Update(input)
        end
    end)

    -- Анимации открытия/закрытия
    local function OpenGUI()
        XYZHub.Enabled = true
        MainFrame.Size = UDim2.new(0, 0, 0, 0)
        MainFrame.Visible = true
        
        local tween = TweenService:Create(
            MainFrame,
            TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 400, 0, 450)}
        )
        tween:Play()
    end

    local function CloseGUI()
        local tween = TweenService:Create(
            MainFrame,
            TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
            {Size = UDim2.new(0, 0, 0, 0)}
        )
        
        tween.Completed:Connect(function()
            XYZHub:Destroy()
        end)
        
        tween:Play()
    end

    -- Кнопка закрытия
    CloseButton.MouseButton1Click:Connect(CloseGUI)

    -- Кнопка открытия GUI (создаем отдельную кнопку)
    local OpenButton = Instance.new("TextButton")
    OpenButton.Name = "OpenButton"
    OpenButton.Size = UDim2.new(0, 50, 0, 50)
    OpenButton.Position = UDim2.new(0, 20, 0.5, -25)
    OpenButton.AnchorPoint = Vector2.new(0, 0.5)
    OpenButton.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
    OpenButton.BackgroundTransparency = 0.7
    OpenButton.Text = "XYZ"
    OpenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    OpenButton.TextSize = 14
    OpenButton.Font = Enum.Font.GothamBold
    OpenButton.ZIndex = 10

    local OpenCorner = Instance.new("UICorner")
    OpenCorner.CornerRadius = UDim.new(1, 0)
    OpenCorner.Parent = OpenButton

    local OpenStroke = Instance.new("UIStroke")
    OpenStroke.Color = Color3.fromRGB(255, 255, 255)
    OpenStroke.Thickness = 1
    OpenStroke.Transparency = 0.7
    OpenStroke.Parent = OpenButton

    OpenButton.Parent = XYZHub

    OpenButton.MouseButton1Click:Connect(function()
        OpenGUI()
        OpenButton.Visible = false
    end)

    MainFrame.Visible = false
    OpenGUI()
end

return xyz
