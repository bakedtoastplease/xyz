local uis = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local player = game.Players.LocalPlayer

local char = player.Character or player.CharacterAdded:Wait()
local leftArm = char:WaitForChild("LeftUpperArm")
local rightArm = char:WaitForChild("RightUpperArm")

local moveHands = false
local leftInput = Vector2.new(0, 0)
local rightInput = Vector2.new(0, 0)

-- 🎮 Обработка триггера (LT)
uis.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.ButtonL2 then
        moveHands = true
    end
end)

uis.InputEnded:Connect(function(input, processed)
    if input.KeyCode == Enum.KeyCode.ButtonL2 then
        moveHands = false
    end
end)

-- 🎮 Чтение стиков
uis.InputChanged:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Thumbstick1 then
        leftInput = input.Position
    elseif input.KeyCode == Enum.KeyCode.Thumbstick2 then
        rightInput = input.Position
    end
end)

-- 🦾 Движение рук
runService.RenderStepped:Connect(function()
    if moveHands then
        -- Левая рука
        leftArm.CFrame = leftArm.CFrame * 
            CFrame.new(leftInput.X * 0.1, 0, -leftInput.Y * 0.1)
        -- Правая рука
        rightArm.CFrame = rightArm.CFrame * 
            CFrame.new(rightInput.X * 0.1, 0, -rightInput.Y * 0.1)
    end
end)
