extends Timer

var enemy_scene = preload("res://assets/scenes/enemy.tscn")
var level
var player
var rng
var spawn_path
var spawn_position

func _ready():
	level = get_node("/root/Level")
	player = get_node("/root/Level/Player")
	spawn_path = player.get_node("SpawnPath/SpawnPathFollow")
	spawn_position = spawn_path.get_node("SpawnMarker")
	rng = RandomNumberGenerator.new()
	start()

func _on_Timer_timeout():
	var enemy = enemy_scene.instantiate()
	rng.randomize()
	spawn_path.progress = rng.randi_range(0, 4057)
	enemy.global_position = spawn_position.global_position
	level.add_child(enemy)
