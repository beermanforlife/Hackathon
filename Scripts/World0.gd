extends Node2D

onready var player = $Player
onready var spawn_point = $Spawn
onready var timer = $Timer
onready var window = $Windows
onready var score_label = get_node("Score Label")
var speedModifyer = 1
var score = 0
var gameStarted = false
var currentSprite = 4
var cat = "res://Sprites/catspritesx"
var dog = "res://Sprites/dog"
var animal = cat
var scene_chair = load("res://Sceens/Assets/Chair.tscn")
var scene_desk = load("res://Sceens/Assets/Desk.tscn")
var scene_planter = load("res://Sceens/Assets/PlanterBox.tscn")
var scene_fiddle = load("res://Sceens/Assets/FiddleLeaf.tscn")
var scene_fiddle_fiddle = load("res://Sceens/Assets/Fiddle_Fiddle.tscn")
var scene_chair_desk = load("res://Sceens/Assets/Chair_Desk.tscn")
var scene_planter_planter = load("res://Sceens/Assets/Planter_Planter.tscn")
var scene_shuffle = load("res://Sceens/Assets/ShuffleBoard.tscn")
var scene_kitchen = load("res://Sceens/Assets/Kitchen.tscn")
# Called when the node enters the scene tree for the first time.
# Moves to Vector(0,0) at a speed of 1 unit per second
var speed = 200 # Change this to increase it to more units/second
func _ready():
	get_node("GameOver").hide()
	window.position.x = spawn_point.position.x
	timer.paused = true
		
func _physics_process(delta):
	if gameStarted:
		window.position = window.position.move_toward(Vector2(-spawn_point.position.x,window.position.y), delta * speed)
		if window.position.x <= -spawn_point.position.x:
			window.position.x = spawn_point.position.x

func spawn_new_item():
	var spawn_seed = int(rand_range(0, 8))
	print(spawn_seed)
	var spawned
	if spawn_seed == 0:
		spawned = scene_chair.instance()
	elif spawn_seed == 1:
		spawned = scene_desk.instance()
	elif spawn_seed == 2:
		spawned = scene_planter.instance()
	elif spawn_seed == 3:
		spawned = scene_fiddle.instance()
	elif spawn_seed == 4:
		spawned = scene_fiddle_fiddle.instance()
	elif spawn_seed == 5:
		spawned = scene_chair_desk.instance()
	elif spawn_seed == 6:
		spawned = scene_planter_planter.instance()
	elif spawn_seed == 7:
		spawned = scene_shuffle.instance()
	elif spawn_seed == 8:
		spawned = scene_kitchen.instance()
	spawned.position.x = spawn_point.position.x
	spawned.position.y = spawn_point.position.y
	spawned.increse_speed(speedModifyer)
	add_child(spawned)
	
func update_score_label():
	score_label.text = "Score " + str(score)


func _on_End_area_entered(area):
	if area.name == "Player":
		get_node("GameOver").show()
	area.queue_free()
	score += 1;
	update_score_label()
	if score % 10 == 0:
		speedModifyer += .5



func _on_PlanterBox_grass_entered():
	player.WaterArea_area_entered()


func _on_PlanterBox_grass_exited():
	player.WaterArea_area_exited()


func _on_Timer_timeout():
	spawn_new_item()


func _on_Next_button_up():
	if currentSprite < 4:
		currentSprite+=1
		player.setSprite(animal+str(currentSprite)+'.png')


func _on_Previous_button_up():
		if currentSprite > 1:
			currentSprite-=1
			player.setSprite(animal+str(currentSprite)+'.png')


func _on_Start_button_up():
	gameStarted = true
	get_node("Picker").hide()
	timer.paused = false


func _on_Button_button_up():
	get_tree().reload_current_scene()


func _on_Dog_button_up():
	animal = dog
	player.setSprite(animal+str(currentSprite)+'.png')


func _on_Cat_button_up():
	animal = cat
	player.setSprite(animal+str(currentSprite)+'.png')
