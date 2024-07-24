local RepS = game:GetService('ReplicatedStorage')
local TextService = game:GetService('TextService')
local Modules = RepS.Modules
local Spark = require(Modules.Spark)

local TestProperty = Spark.Property('someProperty')
TestProperty.Changed:Connect(function(oldValue, newValue)
    print('Received Value! :', oldValue, '->', newValue)
end)

TestProperty:Get() --> returns the initial value or '___'

local TestEvent = Spark.Event('someEvent')
TestEvent.Fired:Connect(function()
    print('someEvent Fired On Client!')
end)
TestEvent:Fire('Any Args')

local TestFunction = Spark.Function('someFunction')
local response = TestFunction:Invoke('Any Args')
print(response, 'Fetched!')