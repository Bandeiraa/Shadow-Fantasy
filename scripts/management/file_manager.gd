extends Node
class_name FileManager

export(String) var textures_path

func _ready() -> void:
	randomize()
	
	
func get_files_in_path() -> Array:
	var assets_list: Array = []
	var sub_folders: Array = get_files(textures_path)
	var current_folder: String = textures_path + sub_folders[randi() % sub_folders.size()]
	var folder_elements: Array = get_files(current_folder)
	for index in folder_elements.size():
		if index % 2 == 0:
			assets_list.append(current_folder + "/" + folder_elements[index])
			
	return assets_list
	
	
func get_files(path: String) -> Array:
	var files: Array = []
	var directory: Directory = Directory.new()
	var _open_directory: bool = directory.open(path)
	var _list_directory: bool = directory.list_dir_begin()
	
	while true:
		var file = directory.get_next()
		if file == "":
			break
			
		elif not file.begins_with("."):
			files.append(file)
			
	directory.list_dir_end()
	return files
