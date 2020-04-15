
local step_time = 30
local chance = 0.01
--~ local step_time = 5
--~ local chance = 1

local function step()
	minetest.after(step_time, step)

	-- get all not attached players
	local players = {}
	do
		local all_players = minetest.get_connected_players()
		local i = 1
		for _, player in ipairs(all_players) do
			if not player:get_attach() then
				players[i] = player
				i = i + 1
			end
		end
	end

	if #players < 2 then
		return
	end

	for _, player in ipairs(players) do
		if math.random() < chance and not player:get_attach() then
			-- rider found, search for horse
			local horse = players[math.random(#players)]
			player:set_attach(horse, "", vector.new(0, 10, 0), vector.new())
			player:set_eye_offset(vector.new(0, 10, 0), vector.new(0, 10, 0))
			break
		end
	end
end

minetest.after(0, step)
