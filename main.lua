local rows, cols, grid
local cell_width = 10
local counter = 0
local freq = 0.05

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

local function checkNeighbor(g, x, y)
	if x >= 1 and x <= rows and y >= 1 and y <= cols then
		return g[x][y] == 1
	end
	return false
end

function love.load()
	counter = 0
	rows = love.graphics.getWidth() / cell_width
	cols = love.graphics.getHeight() / cell_width

	grid = make2DArray(rows, cols)
	fill2DArray(grid, rows)
end

function love.update(dt)
	counter = counter + dt
	if counter >= freq then
		local next = make2DArray(rows, cols)

		for i = 1, cols do
			for j = 1, rows do
				local checkArr = {
					checkNeighbor(grid, j - 1, i - 1),
					checkNeighbor(grid, j, i - 1),
					checkNeighbor(grid, j + 1, i - 1),
					checkNeighbor(grid, j - 1, i),
					checkNeighbor(grid, j + 1, i),
					checkNeighbor(grid, j - 1, i + 1),
					checkNeighbor(grid, j, i + 1),
					checkNeighbor(grid, j + 1, i + 1),
				}
				local aliveNeighbors = 0
				for _, v in pairs(checkArr) do
					if v then
						aliveNeighbors = aliveNeighbors + 1
					end
				end

				if grid[j][i] == 0 and aliveNeighbors == 3 then
					next[j][i] = 1
				elseif grid[j][i] == 1 and (aliveNeighbors > 3 or aliveNeighbors < 2) then
					next[j][i] = 0
				else
					next[j][i] = grid[j][i]
				end
			end
		end

		grid = next

		counter = 0
	end
end

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
			if grid[j][i] == 1 then
				love.graphics.rectangle("fill", (j - 1) * cell_width, (i - 1) * cell_width, cell_width, cell_width)
			else
				love.graphics.rectangle("line", (j - 1) * cell_width, (i - 1) * cell_width, cell_width, cell_width)
			end
		end
	end
end
