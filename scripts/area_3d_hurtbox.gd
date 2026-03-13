extends Area3D
class_name Hurtbox

@export var maxHp: int = 1
@export var vibra: Vibration
var hpNow: int

func _ready() -> void:
	hpNow = maxHp


func AddHp(add: int)->void:
	hpNow += add
	
	if add < 0 && vibra:
		vibra.StartVibration(1, 0.2, 0.2)
	
	if hpNow > maxHp:
		hpNow = maxHp
	elif hpNow <= 0:
		hpNow = 0
		owner.hide()
	
	if owner.is_in_group("Player"):
		GameManager.gameManagerInScene.AddLife(add)
	
