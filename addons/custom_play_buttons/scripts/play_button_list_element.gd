@tool
extends HBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	set_meta("play_button_list_element", true)


func _on_filedialog_visibility_changed():
	if $filedialog.current_path == "res://":
		return
	$filepath.text = $filedialog.current_path


func _on_open_filedialog_pressed():
	$filedialog.show()

func _on_remove_pressed():
	get_parent().queue_free()


func _on_filepath_text_submitted(new_text:String):
	if not new_text == "":
		return
	_on_remove_pressed()
