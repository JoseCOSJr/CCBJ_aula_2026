extends Control
class_name HudNode

@export var textScore: RichTextLabel
@export var hpNodesArray: Array[Control]

static var hudInScene: HudNode = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hudInScene = self
	#Fade.fadeInScene.StartFade(Color.RED, 1)

func AttScore()->void:
	textScore.text = "Pontos: "+str(GameManager.GetScore())

func AttHp(hpNow: int)->void:
	
	for i in hpNodesArray.size():
		var nodeHpX: Control = hpNodesArray[i]
		if i >= hpNow:
			nodeHpX.hide()
			continue
		
		nodeHpX.show()
