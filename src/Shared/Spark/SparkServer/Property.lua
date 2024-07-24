local RepS = game:GetService('ReplicatedStorage')

local Packages = RepS.Packages
local Trove = require(Packages.Trove)

local Modules = RepS.Modules
local Value = require(Modules.Value)

local Property = {}
Property.__index = Property

function Property.new(Name, initialValue, Event)
    local self = setmetatable({}, Property)

    self.PrivateValues = {}
    self.Value = Value.new('___')
    self.Trove = Trove.new()

    self.Event = Event
    self.Event.Fired:Connect(function(player, ...)
        if not self.PrivateValues[player] then
            self:AddClient(player)
        end
    end)

    self.Value.Changed:Connect(function(oldValue, newValue)
        for player, _ in self.PrivateValues do
            self:SetFor(player, newValue)
        end
    end)

    self.Value:Set(initialValue)

    return self
end

function Property:Get()
    return self.Value:Get()
end

function Property:Set(value)
    self.Value:Set(value)
end

function Property:SetFor(player, value)
    local playerVal = self.PrivateValues[player] 
    if not playerVal then
        self:AddClient(player)
    else
        local playerValue = self.PrivateValues[player][2]
        playerValue:Set(value)
    end
end

function Property:AddClient(player)
    local playerTrove = self.Trove:Extend()
    local newValue = Value.new(self:Get())
    playerTrove:Connect(newValue.Changed, function(...)
        self:Broadcast(player)
    end)
    self.PrivateValues[player] = {
        playerTrove, 
        newValue
    }

    self:Broadcast(player)
end

function Property:RemoteClient(player)
    local privValues = self.PrivateValues[player]
    privValues[1]:Clean()
    self.PrivateValues[player] = nil
end

function Property:Broadcast(players : table)
    if typeof(players) == 'table' then
        for _, player in players do
            local privValues = self.PrivateValues[player]
            self.Event:FireClient(player, privValues[2]:Get())
        end
    elseif players:IsA('Player') then
        local privValues = self.PrivateValues[players]
        self.Event:Fire(players, privValues[2]:Get())
    end
end

function Property:Destroy()
    self.Trove:Clean()
    self.Event:Destroy()
end

return Property