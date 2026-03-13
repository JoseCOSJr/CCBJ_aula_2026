extends AnimatableBody3D

@export var pathFollow: PathFollow3D
@export var durationPath: float = 3
@export var timer: Timer

var speed: float
var canMove: bool = false
var goingBack: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	speed = 1.0/durationPath
	timer.timeout.connect(SetCanMove)


func _physics_process(delta: float)-> void:
	if !canMove:
		return
	
	if goingBack:
		pathFollow.progress_ratio -= speed*delta
	else :
		pathFollow.progress_ratio += speed*delta
	
	global_position = pathFollow.global_position
	
	if (goingBack && pathFollow.progress_ratio == 0) || (not goingBack && pathFollow.progress_ratio == 1):
		timer.start()
		canMove = false
		goingBack = !goingBack

func SetCanMove()->void:
	canMove = true
