extends Node

@export var cenaTroca: PackedScene

func ComecarTrocaCena()->void:
	var duracao: float = 1
	Fade.fadeInScene.StartFade(Color.BLACK, duracao)
	
	await get_tree().create_timer(duracao).timeout
	
	get_tree().change_scene_to_packed(cenaTroca)
	
	Fade.fadeInScene.FadeIn(duracao)
