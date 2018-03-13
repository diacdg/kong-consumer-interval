-- Copyright (C) Kong Inc.
local responses = require "kong.tools.responses"
local BasePlugin = require "kong.plugins.base_plugin"

local ngx_log = ngx.log
local tostring = tostring
local tonumber = tonumber

local AVAILABLE_IN = "X-NextAvailableRequests-StartIn"
local STOP_IN = "X-NextAvailableRequests-StopIn"

local ConsumerIntervalHandler = BasePlugin:extend()

ConsumerIntervalHandler.PRIORITY = 902
ConsumerIntervalHandler.VERSION = "0.1"

function ConsumerIntervalHandler:new()
  ConsumerIntervalHandler.super.new(self, "consumer-interval")
end

function ConsumerIntervalHandler:access(conf)
  local curentSecond = tonumber(os.date("%S"))

  if conf.interval_start > curentSecond or conf.interval_end < curentSecond then
    local nextTime = 60 - curentSecond + conf.interval_start;
 
    if nextTime >= 60 then
      nextTime = nextTime - 60
    end    

    ngx.header[AVAILABLE_IN] = nextTime
    ngx.header[STOP_IN] = nextTime + (conf.interval_end - conf.interval_start)

    return responses.send(403, "You can make next api call in " .. nextTime .. " seconds" )
  end
end

return ConsumerIntervalHandler
