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
			for j in [0...Game.width]
				row = []
				for i in [0...Game.length]
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

			Game.initialize() if Game.over()

		Game.over = ->
			for row in Game.grid
				for column in row
					if column.activated
						return false
			true

		Game.range = (x) ->
		  if x < 0
		    return new Array(0)
		  else
		    return new Array(x)

		"GameCtrl"
	]
