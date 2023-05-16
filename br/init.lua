-- SPDX-FileCopyrightText: 2023 Blockhead
--
-- SPDX-License-Identifier: CC0-1.0

-- vim: ts=4 sw=4 et
local thismodname = minetest.get_current_modname()
br = {}

local function register_bricks(sourcenode, sourcemod, desc, modname)
    local node_props = table.copy(minetest.registered_nodes[sourcenode])

    local T = minetest.get_translator(modname)

    if node_props.description then
        print(node_props.description, desc)
        node_props.description = T(string.format("%s Bricks", desc))
        print(node_props.description)
    end

    local newtiles = {}
    if node_props.tiles then
        for _,tex in ipairs(node_props.tiles) do
            table.insert(newtiles, string.format("(%s)^br_brick_overlay.png", tex))
        end
        node_props.tiles = newtiles
    end

    local newnode_name = modname .. ":"
        ..  string.gsub(sourcenode, sourcemod..":", "")
    minetest.register_node(newnode_name, node_props)

    minetest.register_craft({
        output = newnode_name .. " 4",
        recipe = {
            {sourcenode, sourcenode},
            {sourcenode, sourcenode},
        },
    })

    minetest.register_craft({
        output = sourcenode,
        recipe = { {newnode_name}, },
    })

end
br.register_bricks = register_bricks
