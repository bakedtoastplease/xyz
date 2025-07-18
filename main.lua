local uis = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local rightArm = char:WaitForChild("RightUpperArm")

local controlling = false
local sensitivity = 0.1 -- чувствительность

-- Включение/выключение управления
uis.InputBegan:Connect(function(input, processed)
    if input.KeyCode == Enum.KeyCode.LeftControl then
        controlling = true
        print("✅ Управление правой рукой включено")
    end
end)

uis.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.LeftControl then
        controlling = false
        print("❌ Управление правой рукой выключено")
    end
end)

-- Управление мышкой
local lastMousePos = uis:GetMouseLocation()
runService.RenderStepped:Connect(function()
    if controlling then
        local mousePos = uis:GetMouseLocation()
        local delta = mousePos - lastMousePos
        lastMousePos = mousePos

        -- Двигаем правую руку в зависимости от движения мыши
        rightArm.CFrame = rightArm.CFrame * CFrame.Angles(
            math.rad(-delta.Y * sensitivity), -- вверх/вниз
            math.rad(delta.X * sensitivity),  -- влево/вправо
            0
        )
    else
        lastMousePos = uis:GetMouseLocation()
    end
end)
