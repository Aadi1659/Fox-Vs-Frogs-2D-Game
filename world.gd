extends Node2D

func _on_restart_pressed():
	Game.playerHealth = 10
	Game.goldCount = 0
	get_tree().change_scene_to_file("res://world.tscn")
