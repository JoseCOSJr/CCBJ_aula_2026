extends Camera3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(lerp(0, 1, 0.5))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position.lerp(Vector3.UP*10, 0.11)
