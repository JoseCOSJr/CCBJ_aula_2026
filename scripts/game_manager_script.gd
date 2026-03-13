extends Node
class_name GameManager

static var gameManagerInScene :GameManager= null
var score: int = 0
var hpPlayer: int = 3
var savePosPlayer: Vector3
var playerNode: Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gameManagerInScene = self
	playerNode= get_tree().get_first_node_in_group("Player")
	savePosPlayer = playerNode.global_position

static func AddScore(add: int)->void:
	gameManagerInScene.score+= add
	HudNode.hudInScene.AttScore()

static  func GetScore()->int:
	return gameManagerInScene.score

static func AddLife(add: int)->void:
	gameManagerInScene.hpPlayer += add
	HudNode.hudInScene.AttHp(gameManagerInScene.hpPlayer)
	
	if gameManagerInScene.hpPlayer <= 0:
		print("Morreu")
		return

static func RestartPlayerPos()->void:
	gameManagerInScene.playerNode.global_position = gameManagerInScene.savePosPlayer
