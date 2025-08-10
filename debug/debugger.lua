local Debugger = {}

function Debugger.Start()
    package.cpath = package.cpath .. ';C:/Users/Administrator/AppData/Roaming/JetBrains/Rider2025.1/plugins/EmmyLua/debugger/emmy/windows/x64/?.dll'
    local dbg = require('emmy_core')
    
    dbg.tcpListen('localhost', 9966)
    dbg.waitIDE();
end

ed.Debugger = Debugger;
return Debugger;