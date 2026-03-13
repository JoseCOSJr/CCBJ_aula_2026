extends Area3D

@onready var frontSide: Node3D = $CollisionShape3D/Frente
@onready var backSide: Node3D = $CollisionShape3D/Tras

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_exited.connect(PrintExitSide)


func PrintExitSide(body: Node3D)->void:
	if !body.is_in_group("Player"):
		return
	
	var distFront  = frontSide.global_position.distance_to(body.global_position)
	var distBack  = backSide.global_position.distance_to(body.global_position)
	if distBack < distFront:
		print("De trás")
		return
	
	print("Da frente")
	
