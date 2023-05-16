-- vim: ts=4 sw=4 et
local thismodname = minetest.get_current_modname()
cb = {}

local function to_compressed_texture(texture)
    --[[ Don't think it works like this..
    local upper_left = "(%s)^[sheet:2x2:0,0"
    local upper_right = "(%s)^[sheet:2x2:1,0"
    local lower_left = "(%s)^[sheet:2x2:0,1"
    local lower_right = "(%s)^[sheet:2x2:1,1"

    return
        upper_left--]]

    --[[ Doesn't work for derivatives, not a pure filename
        --return string.format(
        "[combine:32x32:0,0=%s:0,16=%s:16,0=%s:16,16=%s",
        texture, texture, texture, texture)
    --]]
    
    return "(" .. texture  .. ")^cb_compression_overlay.png"

end
cb.to_compressed_texture = to_compressed_texture

local function register_for_compression(sourcenode, sourcemod, desc, modname)
    local node_props = table.copy(minetest.registered_nodes[sourcenode])

    local T = minetest.get_translator(modname)

    if node_props.description then
        node_props.description = T(string.format("%s (compressed)", desc))
    end

    local newtiles = {}
    if node_props.tiles then
        for _,tex in ipairs(node_props.tiles) do
            table.insert(newtiles, to_compressed_texture(tex))
        end
        node_props.tiles = newtiles
    end

    local newnode_name = modname .. ":"
        ..  string.gsub(sourcenode, sourcemod..":", "")
    minetest.register_node(newnode_name, node_props)

    minetest.register_craft({
        output = newnode_name,
        recipe = {
            {sourcenode, sourcenode, sourcenode},
            {sourcenode, sourcenode, sourcenode},
            {sourcenode, sourcenode, sourcenode},
        },
    })

    minetest.register_craft({
        output = sourcenode .. " 9",
        recipe = { {newnode_name}, },
    })

end
cb.register_for_compression = register_for_compression
