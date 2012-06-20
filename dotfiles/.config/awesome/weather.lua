-- Load Environment
local http = require("socket.http")
local awful = awful
local ipairs = ipairs
local widget = widget
local string = string
local pairs = pairs
local timer = timer

module('weather')

function update(widget, data_points)
  -- Grab google weather data
  url = "http://www.google.com/ig/api?weather=Buzău"
  local data = http.request(url)

  -- Only snag current conditions
  if data then
    current = data:match("<forecast_information>(.-)</current_conditions>")

    -- Data point config
    if not data_points then
      data_points = { "postal_code", "temp_c", "condition", "wind_condition", "humidity", "forecast_date" }
    end

    -- Parse!
    local parsed_values = {}
    for key,name in ipairs(data_points) do
      parsed_value = current:match('<' .. name ..' data="(.-)"/>')
      parsed_values[name] = parsed_value
    end

    -- Set Text
    widget.text = " " .. parsed_values["postal_code"] .. "  " .. parsed_values["temp_c"]  .. " °C"

    -- Set Tooltip
    tip = "\n"
    for k,v in pairs(parsed_values) do
      tip = tip .. k .. ": " .. v .. "\n"
    end

    tooltip = awful.tooltip({
      objects = { widget },
      timer_function = function()
        return tip
      end
    })
  end
end

function register(widget, data_points)
  -- Set timer
  weather_update = timer({ timeout = 600 })
  weather_update:add_signal("timeout", function() 
    update(widget, data_points)
  end)
  weather_update:start()

  -- Do initial load
  update(widget, data_points)
end
