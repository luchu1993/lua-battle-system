_G.ed = {};

require("debug.debugger");
ed.Debugger.Start();

require("src.init")

local common_ability = require("config.abilities.common_ability");

for _, ability in ipairs(common_ability) do
    print("-------------------------------");
    print(ability);
end
