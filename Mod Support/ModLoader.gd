extends Node





func _ready():
	var dir = Directory.new()
	if dir.open("user://Mods") == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if not dir.current_is_dir():
				var mod = load("user://Mods/" + file_name).new()
				get_tree().get_root().call_deferred("add_child", mod)
			file_name = dir.get_next()
	else:
		dir.open("user://")
		dir.make_dir("Mods")

