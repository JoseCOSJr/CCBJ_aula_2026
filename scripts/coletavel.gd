extends Node3D

signal coletado
var isGet: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var area3DHere = $Area3D
	area3DHere.area_entered.connect(Coletar)


func Coletar(entroNode: Area3D)->void:
	if !entroNode.owner.is_in_group("Player"):
		return
	
	#print("Pegou "+name)
	coletado.emit()
	isGet = true
	queue_free()

func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		#"parent" : get_parent().get_path(),
		"pos_x" : position.x, # Vector2 is not supported by JSON
		"pos_y" : position.y,
		"pos_z" : position.z,
		"is_get" : isGet,
	}
	return save_dict
