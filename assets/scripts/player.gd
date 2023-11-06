extends CharacterBody2D

@export var speed = 200
var click_indicator = preload("res://assets/scenes/click.tscn")
var target = position
var level
var stun_timer
var stunned = false

func _ready():
	level = get_node("/root/Level")
	
func stun_self():
	stunned = true
	stun_timer.start()

func stun_recover():
	stunned = false

func _unhandled_input(event):
	if event.is_action_pressed("click"):
		var click = click_indicator.instantiate()
		target = get_global_mouse_position()
		click.position = target
		level.add_child(click)

func _physics_process(_delta):
	if !stunned:
		velocity = position.direction_to(target) * speed
		look_at(target)
		if position.distance_to(target) > 10:
			move_and_slide()
