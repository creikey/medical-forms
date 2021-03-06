extends Node2D

export (PackedScene) var original_form

func _on_SaveButton_pressed():
	ensure_responses_dir()
	if($StaticUI/NameEdit.text == ""):
		return
	var packed_form = PackedScene.new()
	var current_form = get_form_node()
	packed_form.pack(current_form)
	ResourceSaver.save("user://responses/" + $StaticUI/NameEdit.text + ".tscn", packed_form)
	current_form.queue_free()
	var new_form = original_form.instance()
	new_form.name = "Form"
	add_child(new_form)
	$StaticUI/NameEdit.text = ""
	update_file_list()

func update_file_list():
	var responses = get_files_in_dir("user://responses/")
	$StaticUI/FileList.text = ""
	for r in responses:
		$StaticUI/FileList.text += r + "\n"

func get_files_in_dir(in_dir):
	var files = []
	var dir = Directory.new()
	dir.open(in_dir)
	dir.list_dir_begin()
	
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			files.append(file)
	dir.list_dir_end()
	return files

func get_form_node():
	for n in get_children():
		if(n.is_in_group("forms")):
			return n

func ensure_responses_dir():
	var dir = Directory.new()
	dir.open("user://")
	if(dir.dir_exists("responses")):
		return
	dir.make_dir("responses")
