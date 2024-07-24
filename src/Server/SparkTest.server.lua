local RepS = game:GetService('ReplicatedStorage')
local Modules = RepS.Modules
local Spark = require(Modules.Spark)

local NewEvent = Spark.Event('someEvent')
NewEvent.Fired:Connect(function()
    print('someEvent Fired!')
end)

local NewFunction = Spark.Function('someFunction')
NewFunction.OnInvoke = function()
    print('someFunction Invoked!')
    return 'A Cool Response!'
end

local initialValue = 'ABC'
local NewProperty = Spark.Property('someProperty', initialValue)

--[[ 
    Update The Server Value
    Which overwrites all player-specific data

    NewProperty:Set('XYZ')
]]

--[[
    Or give each player 
    values specific to them

    NewProperty:SetFor(player, 'DEF')
]]
