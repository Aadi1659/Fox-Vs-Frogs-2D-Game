extends Area2D

@onready var sound = $death

func _on_body_entered(body):
	if body.name == "Player":
		sound.play()
		await sound.finished
		Game.playerHealth = 10
		Game.goldCount = 0
		get_tree().change_scene_to_file("res://main.tscn")

