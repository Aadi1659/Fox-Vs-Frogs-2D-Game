extends Node

#for android and ios devices too, use users://savegame.bin
const SAVE_PATH = "res://savegame.bin"

func saveGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var data: Dictionary = {
		"playerHealth":Game.playerHealth,
		"Gold":Game.goldCount
	}
	#godot 4 update
	var jstr = JSON.stringify(data)
	file.store_line(jstr)

func loadGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if FileAccess.file_exists(SAVE_PATH) == true:
		if not file.eof_reached():
			var currentLine = JSON.parse_string(file.get_line())
			if currentLine:
				Game.playerHealth = currentLine["playerHealth"]
				Game.goldCount = currentLine["Gold"]
	
	
