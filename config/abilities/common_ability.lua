local array = ed.config.array;
local map = ed.config.map;
local vec3 = ed.config.vec3;


return array
{
    ed.config.AbilityConfig {
        name = "abi_test",
        on_start = array {
            ed.config.DebugLog {
                content = "ability start ...",
                level = "warn",
            },

            ed.config.WaitTime {
                duration = 10,
            },

            ed.config.Branch {
                predicate = ed.config.ByCompareVariable {
                    compare_type = "less",
                    value1 = 10,
                    value2 = 20,
                },
                on_success = array {
                    ed.config.WaitTime {
                        duration = 3
                    },
                    
                    ed.config.ApplyModifier {
                        name = "mod_heal_target",
                        period = 0.3,
                        duration = 5
                    }
                }
            }
        },

        variables = map
        {
            position = vec3 { x = 10, y = 20, z = 0 },
            yaw = 60
        }
    }
}
