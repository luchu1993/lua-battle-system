ed.config = {};
ed.config._field_check_enable = ed.Editor;

ed.config.required = { required = true };
ed.config.default = function (value)
    return { required = false, default = value };
end

local _field_check = function(cls, cfg)
    if cls._cname == "array" or cls._cname == "map" then
        return 
    end
    
    for k, v in pairs(cfg) do
        local def = cls._define[k];
        if not def then
            error(string.format("[%s]: `%s` in config is useless.", cls._cname, k));
        end
    end

    if cls._require_fields == nil then
        cls._require_fields = {};
        for field, define in pairs(cls._define) do
            if define.required then
                table.insert(cls._require_fields, field)
            end
        end
    end

    for _, field in ipairs(cls._require_fields) do
        if cfg[field] == nil then
            error(string.format("[%s]: `%s` is required.", cls._cname, field));
        end
    end
end

local raw_get = rawget;

ed.CONFIG = function (cname, define)
    local config_cls = {};
    config_cls._define = define;
    config_cls._cname = cname;
    ed.config[cname] = config_cls;

    config_cls.__index = function(t, k)
        if t._cls._cname == "array" or t._cls._cname == "map" then
            return raw_get(t, k);
        end

        local def = t._cls._define[k];
        if def == nil then
            error(string.format("[%s]: `%s` is not defined.", t._cls._cname, k))
        end

        return def.default;
    end

    config_cls.__newindex = function(t, k, v)
        error(string.format("[%s]: `%s` is immutable.", cname, k));
    end

    config_cls.__tostring = function (config)
        local field_strs = {}

        if config._cls._cname == "array" then
            for _, e in ipairs(config) do 
                table.insert(field_strs, tostring(e));
            end
        elseif config._cls._cname == "map" then
            for k, v in pairs(config) do
                if k ~= "_cls" then
                    table.insert(field_strs, string.format("%s = %s", k, tostring(v)));
                end
            end
        else
            for field, _ in pairs(config_cls._define) do
                table.insert(field_strs, string.format("%s = %s", field, tostring(config[field])));
            end
        end

        return table.concat({ config._cls._cname,  " { ", table.concat(field_strs, ", "),  " }"});
    end

    setmetatable(config_cls, {
        __call = function (cls, cfg)

            if ed.config._field_check_enable then
                _field_check(cls, cfg);
            end

            cfg._cls = cls;
            return setmetatable(cfg, cls);
        end
    })

end

require("src.config_define")

return ed.config;