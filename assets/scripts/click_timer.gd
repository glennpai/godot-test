extends Timer

@export var transition_rate = 0.05
var sprite

func _ready():
	sprite = get_node("../Sprite2D")
	start()

func _process(_delta):
	sprite.set_modulate(lerp(sprite.get_modulate(), Color(0,0,0,0), transition_rate))

func _on_Click_timeout():
	get_parent().queue_free()
