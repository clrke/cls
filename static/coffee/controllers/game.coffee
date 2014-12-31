angular.module 'ClsApp'
	.controller 'GameCtrl', ['$http', ($http) ->
		Game = this

		Game.level = 1

		Game.length = 6
		Game.width = 6
		Game.clicksLength = 3

		Game.grid = []

		Game.initialize = ->
			Game.grid = []
			for j in [0...Game.length]
				row = []
				for i in [0...Game.width]
					row.push({'activated': false, 'x':i, 'y':j})
				Game.grid.push(row)

			Game.setClicks()

		Game.setClicks = ->
			tilesFlat = []

			for x in [0...Game.width]
				for y in [0...Game.length]
					tilesFlat.push([x, y])

			shuffle(tilesFlat)

			clicks = []

			for i in [0...Game.clicksLength]
				tile = tilesFlat[i];
				Game.activate(tile[0], tile[1])

		Game.activate = (x, y)->
			tile = Game.grid[y][x]
			tile.activated = ! tile.activated

			if y > 0
				tile = Game.grid[y-1][x]
				tile.activated = ! tile.activated
			if y < Game.length - 1
				tile = Game.grid[y+1][x]
				tile.activated = ! tile.activated
			if x > 0
				tile = Game.grid[y][x-1]
				tile.activated = ! tile.activated
			if x < Game.width - 1
				tile = Game.grid[y][x+1]
				tile.activated = ! tile.activated

			Game.levelUp() & Game.initialize() if Game.over()

		Game.over = ->
			for row in Game.grid
				for column in row
					if column.activated
						return false
			true

		Game.levelUp = ->
			powerUps = []

			if Game.width < Game.clicksLength and Game.width < 12
				powerUps.push(0)
			if Game.length < Game.clicksLength
				powerUps.push(1)
			if Game.clicksLength < Game.width*Game.length / 2
				powerUps.push(2)

			shuffle(powerUps)

			switch powerUps[0]
				when 0
					Game.width++
				when 1
					Game.length++
				when 2
					Game.clicksLength++

			Game.level++

		Game.range = (x) ->
		  if x < 0
		    return new Array(0)
		  else
		    return new Array(x)

		Game.classOf = (tile) ->
			[x, y] = [tile.x, tile.y]
			{
				'secondary': ! tile.activated
				'round-tl':
					! Game.grid[y-1]?[x-1]?.activated and tile.activated and
					! Game.grid[y-1]?[x]?.activated and ! Game.grid[y]?[x-1]?.activated
				'round-tr':
					! Game.grid[y-1]?[x+1]?.activated and tile.activated and
					! Game.grid[y-1]?[x]?.activated and ! Game.grid[y]?[x+1]?.activated
				'round-bl':
					! Game.grid[y+1]?[x-1]?.activated and tile.activated and
					! Game.grid[y+1]?[x]?.activated and ! Game.grid[y]?[x-1]?.activated
				'round-br':
					! Game.grid[y+1]?[x+1]?.activated and tile.activated and
					! Game.grid[y+1]?[x]?.activated and ! Game.grid[y]?[x+1]?.activated
			}
		"GameCtrl"
	]
