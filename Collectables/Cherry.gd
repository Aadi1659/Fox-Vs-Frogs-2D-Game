extends Area2D

@onready var eat = $eat

func _on_body_entered(body):
	if body.name == "Player":
		if Game.playerHealth < 10:
			Game.playerHealth += 1
		eat.play()
		#we will use something called as a tween to make the cherry disappear in a better way
		var tween = get_tree().create_tween()
		var tween1 = get_tree().create_tween()		
		tween.tween_property(self, "position", position - Vector2(0,30), 0.3)
		tween1.tween_property(self, "modulate:a", 0, 0.3)
		tween.tween_callback(queue_free)
	
