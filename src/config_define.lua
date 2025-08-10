ed.CONFIG("array", {})
ed.CONFIG( "map",{})

ed.CONFIG( "vec3", {
    x = ed.config.required,
    y = ed.config.required,
    z = ed.config.required
});

ed.CONFIG("AbilityConfig", {
    name = ed.config.required,
    on_start = ed.config.default(nil),
    variables = ed.config.default(nil),
})

ed.CONFIG("ApplyModifier", {
    name = ed.config.required,
    period = ed.config.default(0.3),
    duration = ed.config.default(0),
});

ed.CONFIG("WaitTime", {
    duration = ed.config.default(1)
});

ed.CONFIG("Branch", {
    predicate = ed.config.required,
    on_success = ed.config.default(nil),
    on_failed = ed.config.default(nil),
})

ed.CONFIG( "ByCompareVariable", {
    compare_type = ed.config.required,
    value1 = ed.config.required,
    value2 = ed.config.required,
});

ed.CONFIG( "DebugLog", {
    level = ed.config.default("info"),
    content = ed.config.required
});
