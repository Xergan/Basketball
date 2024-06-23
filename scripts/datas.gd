extends Node

const SAVE_FILE_PATH = "user://score.cfg"

@onready var config = ConfigFile.new()

func save(high_score):
	config.set_value("player", "high_score", high_score)
	config.save(SAVE_FILE_PATH)

func load():
	var err = config.load(SAVE_FILE_PATH)
	
	if err != OK:
		return 0
		
	return config.get_value("player", "high_score")
