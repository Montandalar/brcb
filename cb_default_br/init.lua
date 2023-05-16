-- vim: ts=4 sw=4 et
local modname = minetest.get_current_modname()

local nodes = {
    {"cb_default:cactus", "Cactus (compressed)"},
    {"cb_default:dirt", "Dirt (compressed)"},
}

for _, node_info in pairs(nodes) do
    local node, desc = unpack(node_info)
    br.register_bricks(node, "cb_default", desc, modname)
end
