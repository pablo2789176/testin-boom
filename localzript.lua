-- FirearmClient_Priority.lua
local FirearmClient = {}
local GunAmmo = {} -- Inicializa la tabla para almacenar el ammo de cada arma

function FirearmClient:RealFire(gun)
    if not self:CanFire(gun) then return end

    local CurrentAmmo = gun:GetAttribute("CurrentAmmo")
    gun:SetAttribute("CurrentAmmo", CurrentAmmo - 1)
    GunAmmo[gun] = gun:GetAttribute("CurrentAmmo")

    -- Verificar si el arma está configurada correctamente
    if not gun:GetAttribute("Damage") then
        error("Arma no configurada correctamente")
    end

    -- Aquí puedes incluir la lógica de disparo, efectos visuales, etc.
end

function FirearmClient:CanFire(gun)
    if not gun:IsA("Tool") or not gun.Parent then return false end
    if gun:IsHolstered() or gun:IsReloading() then return false end

    -- Verificar si el jugador tiene permiso para disparar el arma
    if not self:HasPermissionToFire(gun) then return false end

    local CurrentAmmo = gun:GetAttribute("CurrentAmmo")
    return CurrentAmmo and CurrentAmmo > 0
end

function FirearmClient:HasPermissionToFire(gun)
    -- Verificar si el jugador tiene una cierta habilidad o permiso específico
    -- ...
    return true -- o false según sea necesario
end

-- Reemplazar la función original con la función modificada
RealFire = FirearmClient.RealFire

return FirearmClient -- Devuelve el módulo para su uso en otros scripts
