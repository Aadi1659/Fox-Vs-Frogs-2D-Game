extends CanvasLayer

func _process(delta):
	$fps.text = "FPS: " + str(Engine.get_frames_per_second())
