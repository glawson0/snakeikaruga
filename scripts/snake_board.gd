extends Node2D
class_name SnakeBoard

const TILE_LAYER = 2
const MOVE_INTERVAL: float = .09
const BOARD_OFFSET = Vector2(16,16)
const DEFAULT_START_LOCATION = Vector2i(4,4)

const EAT_SFX = preload("res://resources/sfx/Hit damage 1.wav")
signal game_won
signal game_lost

@onready var TILE_PREFAB = preload("res://prefabs/tile.tscn")

var map
var timer=0.0
var goal
var started= false

var sm: SnakeManager
var pp: PelletPlacer
var bactrack_cout = 0
var hit_count = 0

func init(score: int, guide:Array, start_location = DEFAULT_START_LOCATION) -> void:
	sm = %SnakeManager
	sm.init()
	pp = %PelletPlacer
	goal = score
	populate_grid(guide)
	pp.init(guide.size() * guide[0].size())
	populate_snake(start_location.x, start_location.y,3)
	populate_pellets(4)
	update_goal()

func populate_grid(guide:Array):
	var count = 0
	map = []
	for y in range(0, guide.size()):
		var guide_row = guide[y]
		var row = []
		for x in range(0, guide_row.size()):
			var curr: BoardTile = TILE_PREFAB.instantiate()
			var is_valid = guide_row[x] == '_' or guide_row[x] == 'p'
			curr.init(x, y, is_valid, guide_row[x] == '_')
			var y_margin = 2 if y > 0 else 0
			var x_margin = 2 if x > 0 else 0
			curr.position = Vector2(x* (curr.get_width() + x_margin), y* (curr.get_height() + y_margin)) + BOARD_OFFSET
			curr.z_index = TILE_LAYER
			curr.area_entered.connect(on_tile_entry)
			add_child(curr)
			row.append(curr)
		map.append(row)
	return count

func populate_snake(x: int, y: int, length: int):
	for i in range(0,length):
		var curr:= map[y][x-i] as BoardTile
		curr.set_snake(sm.active_color)
		sm.tiles.append(curr)
		
func populate_pellets(num_pellets: int):
	for i in range(0,num_pellets):
		add_pellet()

func get_tile_from_index(index: int) -> BoardTile:
	var y = index/map[0].size()
	var x = index % map[0].size()
	return map[y][x]

func add_pellet():
	var index = pp.next_tile_index()
	var tile = get_tile_from_index(index)
	while(not tile.can_be_pellet()):
		index = pp.next_tile_index()
		tile = get_tile_from_index(index)
	tile.set_pellet(pp.get_color())
	
func start():
	started = true
	
func _process(delta: float) -> void:
	if( started == false):
		return
	timer += delta
	while(timer > MOVE_INTERVAL):
		timer -= MOVE_INTERVAL
		process_move()
	
func process_move() -> bool:
	var front = sm.tiles.front()
	var next: BoardTile = get_next_tile(sm.direction, front)
	
	var ate_pellet = false
	if next.is_pellet():
		add_pellet()
		ate_pellet = true
		_play_sfx(EAT_SFX, 3.0)
	else:
		sm.remove_tail()
	
	var backtrack = false
	if not next.set_snake(sm.active_color):
		if sm.do_damage():
			bactrack_cout +=1
		backtrack = true
	sm.tiles.push_front(next)
	if ate_pellet or backtrack:
		update_goal()
	return not backtrack

func get_next_tile(dir: Globals.Direction, front: BoardTile) -> BoardTile:
	var next: BoardTile
	match dir:
		Globals.Direction.UP:
			if(front.y > 0 and map[front.y-1][front.x].is_invalid()):
				next = map[front.y-1][front.x]
			elif(front.x<map[0].size()-1 and map[front.y][front.x+1].is_invalid):
				next = map[front.y][front.x+1]
				sm.direction = Globals.Direction.RIGHT
			else:
				next = map[front.y][front.x-1]
				sm.direction = Globals.Direction.LEFT
		Globals.Direction.RIGHT:
			if(front.x < map[0].size()-1 and map[front.y][front.x+1].is_invalid()):
				next = map[front.y][front.x+1]
			elif(front.y < map.size()-1 and map[front.y+1][front.x].is_invalid):
				next = map[front.y+1][front.x]
				sm.direction = Globals.Direction.DOWN
			else:
				next = map[front.y-1][front.x]
				sm.direction = Globals.Direction.UP
		Globals.Direction.DOWN:
			if(front.y < map.size()-1 and map[front.y+1][front.x].is_invalid()):
				next = map[front.y+1][front.x]
			elif(front.x < map[0].size()-1 and map[front.y][front.x+1].is_invalid()):
				next = map[front.y][front.x+1]
				sm.direction = Globals.Direction.RIGHT
			else:
				next = map[front.y][front.x-1]
				sm.direction = Globals.Direction.LEFT
		Globals.Direction.LEFT:
			if(front.x > 0 and map[front.y][front.x-1].is_invalid()):
				next = map[front.y][front.x-1]
			elif(front.y > 0 and map[front.y-1][front.x].is_invalid()):
				next = map[front.y-1][front.x]
				sm.direction = Globals.Direction.UP
			else:
				next = map[front.y+1][front.x]
				sm.direction = Globals.Direction.DOWN
	return next

func on_tile_entry(Area: Area2D):
	var bullet = Area as TankBullet
	if bullet.color != sm.selected_color:
		if sm.do_damage():
			update_goal()
			hit_count += 1
	bullet.queue_free()

func update_goal():
	var score = sm.tiles.size()
	if score == 0:
		game_lost.emit()
	%ScoreLabel.text = "Goal: %d/%d"%[score, goal]
	if score == goal:
		game_won.emit()

func _play_sfx(sfx: AudioStream, volume: float):
	var player = AudioStreamPlayer2D.new()
	player.stream = sfx
	player.volume_db = volume
	add_child(player)
	player.play()
	await player.finished
	player.queue_free()
