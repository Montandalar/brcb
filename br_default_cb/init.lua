-- SPDX-FileCopyrightText: 2023 Blockhead
--
-- SPDX-License-Identifier: CC0-1.0

-- vim: ts=4 sw=4 et
local modname = minetest.get_current_modname()

local nodes = {
    {"br_default:cactus", "Cactus Bricks"},
    {"br_default:dirt", "Dirt Bricks"},
}

for _, node_info in pairs(nodes) do
    local node, desc = unpack(node_info)
    cb.register_for_compression(node, "br_default", desc, modname)
end
