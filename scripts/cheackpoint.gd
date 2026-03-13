extends Node3D


func SetCheckPoint(body: Node3D)->void:
	GameManager.gameManagerInScene.savePosPlayer = body.global_position
	SaveLoad.saveLoadScene.save_game()
