extends Node2D
const TILE_LAYER = 2

@export var SNAKE_COLOR: Color
var MOVE_INTERVAL: float = .1

@onready var TILE_PREFAB = preload("res://prefabs/tile.tscn")
var map = []
var snake: Array[BoardTile] = []
var timer=0.0

var sm: SnakeManager

func _ready() -> void:
	populate_grid(20,20)
	sm = SnakeManager.new(SNAKE_COLOR)
	populate_snake(4,4,3)

func populate_grid(cols: int, rows: int):
	for y in range(0,rows):
		var row = []
		for x in range(0, cols):
			var curr: BoardTile = TILE_PREFAB.instantiate()
			curr.init(x,y)
			var y_margin = 2 if y > 0 else 0
			var x_margin = 2 if x > 0 else 0
			curr.position = Vector2(x* (curr.get_width() + x_margin), y* (curr.get_height() + y_margin))
			curr.z_index = TILE_LAYER
			add_child(curr)
			row.append(curr)
		map.append(row)

func populate_snake(x: int, y: int, len: int):
	for i in range(0,len):
		var curr:= map[y][x-i] as BoardTile
		curr.set_snake(SNAKE_COLOR)
		snake.append(curr)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer += delta
	while(timer > MOVE_INTERVAL):
		timer -= MOVE_INTERVAL
		process_move()
	
func process_move() -> bool:
	snake.pop_back().clear_snake()
	var front = snake.front()
	var next:BoardTile = get_next_tile(sm.direction, front)
	if not next.set_snake(SNAKE_COLOR):
		kill_snake()
		return false
	snake.push_front(next)
	return true

func kill_snake():
	if not sm.invincible:
		await get_tree().create_timer(5.0).timeout



func get_next_tile(dir: Globals.Direction, front: BoardTile) -> BoardTile:
	var next: BoardTile
	match dir:
		Globals.Direction.UP:
			if(front.y > 0):
				next = map[front.y-1][front.x]
			elif(front.x<map[0].size()-1):
				next = map[front.y][front.x+1]
				sm.direction = Globals.Direction.RIGHT
			else:
				next = map[front.y][front.x-1]
				sm.direction = Globals.Direction.LEFT
		Globals.Direction.RIGHT:
			if(front.x < map[0].size()-1):
				next = map[front.y][front.x+1]
			elif(front.y < map.size()-1):
				next = map[front.y+1][front.x]
				sm.direction = Globals.Direction.DOWN
			else:
				next = map[front.y-1][front.x]
				sm.direction = Globals.Direction.UP
		Globals.Direction.DOWN:
			if(front.y < map.size()-1):
				next = map[front.y+1][front.x]
			elif(front.x < map[0].size()-1):
				next = map[front.y][front.x+1]
				sm.direction = Globals.Direction.RIGHT
			else:
				next = map[front.y][front.x-1]
				sm.direction = Globals.Direction.LEFT
		Globals.Direction.LEFT:
			if(front.x > 0):
				next = map[front.y][front.x-1]
			elif(front.y > 0):
				next = map[front.y-1][front.x]
				sm.direction = Globals.Direction.UP
			else:
				next = map[front.y+1][front.x]
				sm.direction = Globals.Direction.DOWN
	return next

#func _on_flash_timer_timeout() -> void:
	#for bt in snake:
#		bt.
