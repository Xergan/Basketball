extends AnimationPlayer

signal celebrate_emote()
signal taunt_emote()

func change_emoji(path):
	var files = DirAccess.get_files_at(path)
	if files.is_empty():
		return
		
	var rand_index:int = randi() % files.size()
	var file = files[rand_index]
	if file:
		file = file.replace(".import", "")
		var image = load(path+file)
		
		%Emoji.texture = image
		
func play_audio(file):
	file = file.replace(".import", "")
	%AudioStreamPlayer.stream = load(file)
	%AudioStreamPlayer.play()

func _on_celebrate_emote() -> void:
	var path = "res://assets/success/"
	change_emoji(path)
	play_audio("res://assets/net.ogg")
		
func _on_taunt_emote() -> void:
	var path = "res://assets/taunt/"
	change_emoji(path)
	play_audio("res://assets/hit.ogg")
