local awful = require("awful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local ui = {}
-- Movement functions :
-- ~~~~~~~~~~~~~~~~~~~~

-- Move local client
ui.move_client = function(c, direction)
    -- If client is floating, move to edge
    if c.floating or (awful.layout.get(mouse.screen) == awful.layout.suit.floating) then
        -- If maxed layout then swap windows
        if direction == "up" then
            c:relative_move(0, -10, 0, 0)
        elseif direction == "down" then
            c:relative_move(0, 10, 0, 0)
        elseif direction == "left" then
            c:relative_move(-10, 0, 0, 0)
        elseif direction == "right" then
            c:relative_move(10, 0, 0, 0)
        end
    elseif awful.layout.get(mouse.screen) == awful.layout.suit.max then
        -- Otherwise swap the client in the tiled layout
        if direction == "up" or direction == "left" then
            awful.client.focus.byidx(-1, c)
        elseif direction == "down" or direction == "right" then
            awful.client.focus.byidx(1, c)
        end
    else
        awful.client.focus.bydirection(direction, c)
    end
end

-- Resize local client
local floating_resize_amount = dpi(20)
local tiling_resize_factor = 0.05

ui.resize_client = function(c, direction)
    if awful.layout.get(mouse.screen) == awful.layout.suit.floating or (c and c.floating) then
        if direction == "up" then
            c:relative_move(0, 0, 0, -floating_resize_amount)
        elseif direction == "down" then
            c:relative_move(0, 0, 0, floating_resize_amount)
        elseif direction == "left" then
            c:relative_move(0, 0, -floating_resize_amount, 0)
        elseif direction == "right" then
            c:relative_move(0, 0, floating_resize_amount, 0)
        end
    else
        if direction == "up" then
            awful.client.incwfact(-tiling_resize_factor)
        elseif direction == "down" then
            awful.client.incwfact(tiling_resize_factor)
        elseif direction == "left" then
            awful.tag.incmwfact(-tiling_resize_factor)
        elseif direction == "right" then
            awful.tag.incmwfact(tiling_resize_factor)
        end
    end
end

-- Raise focus client
ui.raise_client = function()
    if client.focus then
        client.focus:raise()
    end
end

return ui
