extends Node2D

const BALL_SCENE = preload("res://prefabs/ball.tscn")

var score: int = 0: set = _set_score
var high_score: int = 0: set = _set_high_score

@onready var loaded_data = Datas.load()

func _ready() -> void:
	# Presets animations
	%AnimationPlayer.speed_scale = 0
	%AnimationPlayer.play("basket")
	# Load datas
	high_score = loaded_data
	# Connect to the global event bus
	Events.player_scored.connect(_on_player_scored)
	Events.game_over.connect(_on_game_over)
	# Spawn ball
	spawner()

# This function is used to spawn the ball
func spawner() -> void:
	var new_ball = BALL_SCENE.instantiate()
	var Spawns = %Spawns
	var rand_spawn = Spawns.get_children()[randi()%Spawns.get_child_count()]
	new_ball.position = rand_spawn.global_position
	add_child(new_ball)

# Setters and Getters
func _set_score(new_value: int) -> void:
	score = new_value
	%ScoreControl/Score.text = str(score)
	%AnimationPlayer.speed_scale = ceil(score/10) * 0.1
	
func _set_high_score(new_value: int) -> void:
	high_score = new_value
	%ScoreControl/High.text = str(high_score)
	Datas.save(high_score)

# Signals
# This function runs when the global event bus emits a "game_over" signal
func _on_game_over() -> void:
	if score > high_score:
		high_score = score
		print(high_score)
	score = 0
	%AnimationPlayer.play("RESET")
	%AnimationPlayer.play("basket")

# This function runs when the global event bus emits a "player_scored" signal
func _on_player_scored(points: int) -> void:
	score += points
