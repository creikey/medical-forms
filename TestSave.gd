extends Node2D

export (PackedScene) var original_form

func _on_SaveButton_pressed():
	if($StaticUI/NameEdit.text == ""):
		return
	var current_form = PackedScene.new()
	current_form.pack($Form)
	ResourceSaver.save("res://responses/" + $StaticUI/NameEdit.text + ".tscn", current_form)
	$Form.queue_free()
	var new_form = original_form.instance()
	add_child(new_form)
	new_form.name = "Form"
	$StaticUI/NameEdit.text = ""
	update_file_list()

func update_file_list():
	var responses = get_files_in_dir("res://responses/")
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
