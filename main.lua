local cell_width, rows, cols, grid, new_grid

local function make2DArray(r, c)
	local arr = {}

	for _ = 1, r do
		local inner_arr = {}
		for _ = 1, c do
			table.insert(inner_arr, 0)
		end
		table.insert(arr, inner_arr)
	end

	return arr
end

local function fill2DArray(arr, r)
	math.randomseed(os.time())

	for _, inner_arr in ipairs(arr) do
		for i = 1, r do
			inner_arr[i] = math.random(0, 1)
		end
	end
end

function love.load()
	cell_width = 20
	rows = love.graphics.getWidth() / cell_width
	cols = love.graphics.getHeight() / cell_width

	grid = make2DArray(rows, cols)
	fill2DArray(grid, rows)
end

function love.update(dt) end

function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	end
end

function love.draw()
	love.graphics.setBackgroundColor(1, 1, 1)
	for i = 1, cols do
		for j = 1, rows do
			love.graphics.setColor(0, 0, 0)
			print(j, i)
			if grid[j][i] == 1 then
				love.graphics.rectangle("fill", (j - 1) * cell_width, (i - 1) * cell_width, cell_width, cell_width)
			else
				love.graphics.rectangle("line", (j - 1) * cell_width, (i - 1) * cell_width, cell_width, cell_width)
			end
		end
	end
end
