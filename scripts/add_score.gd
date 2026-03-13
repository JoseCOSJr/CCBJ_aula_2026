extends Node3D

@export var addValue:int =1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func AddScore() -> void:
	GameManager.AddScore(addValue)
