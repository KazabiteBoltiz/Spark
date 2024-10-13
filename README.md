# Spark Networking

## Motivation:
- As a user of a rbxutil's [Comm](https://sleitnick.github.io/RbxUtil/api/Comm/) module, I dislike how I could not fetch the same comm object in multiple scripts on one side of the backend. The only way to tackle this problem was to grab any namespaces you required, and then add them to a module for your scripts to get from. I wasn't a fan of this. The Spark module solves this problem by allowing you to get any remoteEvents, remoteFunctions as many times as you want, in any number of scripts.
- The `Comm` module had some interesting features like RemoteProperties which had been the main reason of me using the module. So, it was only logical for me to add this feature into Spark.
- I plan to add namespaces to Spark to divide the networking collections to suit the needs of code architecture enthusiasts.

## Features:
- ### **Spark.Event(EventName : string)**
  Returns a Spark "Event" object, which shortens simple methods like :FireServer() and :FireClient() to :Fire(), along with :FireAll() for :FireAllClients()
- ### **Spark.Function(FunctionName : string)**
  Returns a Spark "Function" object, which comes with Function:Invoke() on client, and Function.OnInvoke, which work similarly to usual RemoteFunctions. I however, have intentionally not added Client invoking on server (RemoteFunctions should never be invoked on server anyway)
- ### **Spark.Property(PropertyName : string, initialValue : any)**
- Returns a Spark "Property" object, which allows value replication from the Server to the client without using ValueInstances and cluttering the Explorer. Property:Set(value : any) and Property:SetFor(player : Player, value : any) work similarly to rbxutil's RemoteProperty.
- ### **Fake Signalling/ Signal Placebos**
  If an event/signal/property does not exist on the server and a client asks for it and does not want to yield and wait till the server creates it, Spark introduces a feature called "Fake Signalling", which makes the client think the event exists and lets it proceed with client scripts. This is basically letting the client shoot in the dark. When the server does add the event/function/property, the fake client version is replaced with the actual connections and signals. This comes with destruction support, which cleans up all signals on client when they are destroyed by the Server.

## Warning:
- I've used my own modules (Value.lua) and expect to use many more in the future. The wally indexing might be incorrect, which I'll look into a little later.
- This is currently a networking project that's not battle-tested. It's going to receive updates and include all the features that my projects require.
- Contribution is welcome, and appreciated.

  
