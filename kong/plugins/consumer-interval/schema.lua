local Errors = require "kong.dao.errors"

local REDIS = "redis"

return {
  fields = {
    interval_start = { type = "number", required = true },
    interval_end   = { type = "number", required = true },
  },
  self_check = function(schema, plugin_t, dao, is_update)
    if plugin_t.interval_start == nil then
      return false, Errors.schema "Value for interval_start must be set"
    elseif plugin_t.interval_start < 0 or plugin_t.interval_start > 59 then
      return false, Errors.schema "Value for interval_start must be greater then 0 and lower then 59"
    end

    if plugin_t.interval_end == nil then
      return false, Errors.schema "Value for interval_end must be set"
    elseif plugin_t.interval_end < 0 or plugin_t.interval_end > 59 then
      return false, Errors.schema "Value for interval_end must be greater then 0 and lower then 59"
    end

    if plugin_t.interval_start >= plugin_t.interval_end then
      return false, Errors.schema "Value for interval_end must be greater then interval_start"
    end
      
    return true
  end
}
