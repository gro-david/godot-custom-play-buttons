@tool
extends HBoxContainer

var list_element = load("res://addons/custom_play_buttons/play_button_list_element.tscn")

func _on_add_pressed():
	if $filepath.text == "":
		return
	var new_element = list_element.instantiate()
	new_element.get_node("container/filepath").text = $filepath.text
	get_parent().get_parent().add_child(new_element)
	$filepath.text = ""

func _on_open_filedialog_pressed():
	$filedialog.show()

func _on_filedialog_visibility_changed():
	if $filedialog.current_path == "res://":
		return
	$filepath.text = $filedialog.current_path


func _on_filepath_text_submitted(new_text:String):
	if new_text == "":
		return
	var new_element = list_element.instantiate()
	new_element.get_node("container/filepath").text = new_text
	get_parent().get_parent().add_child(new_element)
	$filepath.text = ""