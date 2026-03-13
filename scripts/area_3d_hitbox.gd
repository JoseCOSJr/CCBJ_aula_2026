extends Area3D
class_name Hitbox

@export var groupIgnore: String
@export var damage: int = 1
@export var sfxHit: AudioStream

@onready var audioEmitter: AudioStreamPlayer3D = $AudioStreamPlayer3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect(EnterArea)


func EnterArea(area: Area3D)->void:
	
	if !area.has_method("AddHp") || area.owner.is_in_group(groupIgnore):
		return
	
	area.AddHp(-damage)
	audioEmitter.stream = sfxHit
	audioEmitter.play()

func Disactive()->void:
	monitorable = false
	monitoring = false

func Active()->void:
	monitorable = true
	monitoring = true
