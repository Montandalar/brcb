-- vim: ts=4 sw=4 et
local modname = minetest.get_current_modname()

local nodes = {
    {"default:cactus", "Cactus"},
    {"default:dirt", "Dirt"},
}

for _, node_info in pairs(nodes) do
    local node, desc = unpack(node_info)
    br.register_bricks(node, "default", desc, modname)
end
