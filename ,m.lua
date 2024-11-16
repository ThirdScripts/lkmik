local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

if character and character:FindFirstChild("HumanoidRootPart") then
    local rootPart = character.HumanoidRootPart

    -- Целевая позиция CFrame
    local targetCFrame = CFrame.new(
        -262.962463, 13.3500071, -174.956131,
        -0.996491253, 3.02736538e-08, 0.0836972967, 
        2.80679302e-08, 1, -2.7530243e-08, 
        -0.0836972967, -2.50844341e-08, -0.996491253
    )
    local targetPosition = targetCFrame.Position -- Конечные координаты
    
    -- Создаём BodyVelocity для плавного перемещения
    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(1e6, 1e6, 1e6) -- Устанавливаем высокую силу для движения
    bodyVelocity.Velocity = Vector3.zero -- Изначальная скорость 0
    bodyVelocity.Parent = rootPart

    -- Плавное перемещение
    local speed = 150 -- Скорость перемещения (единиц в секунду)
    local distance = (targetPosition - rootPart.Position).Magnitude
    local travelTime = distance / speed
    local startTime = tick()

    while tick() - startTime < travelTime do
        local direction = (targetPosition - rootPart.Position).Unit
        bodyVelocity.Velocity = direction * speed
        wait()
    end

    -- Остановка персонажа
    bodyVelocity:Destroy()
    rootPart.CFrame = targetCFrame -- Точное положение после завершения
else
    warn("Не удалось найти HumanoidRootPart.")
end
