extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func FallInHole(body: Node3D)->void:
	if body.is_in_group("Player"):
		GameManager.gameManagerInScene.AddLife(-1)
		
		var timeTrasition: float = 0.5
		
		Fade.fadeInScene.StartFade(Color.BLACK, timeTrasition)
		await get_tree().create_timer(timeTrasition).timeout
		
		GameManager.RestartPlayerPos()
		#Fade.fadeInScene.StartFade(Fade.colorFadeIn, timeTrasition)
		Fade.fadeInScene.FadeIn(timeTrasition)
