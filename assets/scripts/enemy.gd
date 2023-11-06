extends CharacterBody2D

@export var speed = 100
@export var knockback = 500

var stun_timer
var player
var move_dir = Vector2.ZERO
var knockback_dir = Vector2.ZERO
var stunned = false

func _ready():
	stun_timer = get_node("./CollisionShape2D/StunTimer")
	player = get_node("/root/Level/Player")

func stun_self():
	stunned = true
	move_dir = Vector2.ZERO
	stun_timer.start()

func stun_recover():
	stunned = false
	knockback_dir = Vector2.ZERO

func movement_loop(delta):
	var motion

	if !stunned:
		var target = player.global_position
		look_at(target)

		move_dir = global_position.direction_to(target)
		motion = move_dir.normalized() * speed
	else:
		motion = knockback_dir * knockback
	
	var collision = move_and_collide(motion * delta)

	if collision:
		if collision.get_collider().name == "Player":
			stun_self()
			knockback_dir = collision.get_normal()
	else:
		knockback_dir = Vector2.ZERO

func _physics_process(delta):
	movement_loop(delta)
