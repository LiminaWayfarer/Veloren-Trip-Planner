@tool
extends TextureRect

@export_tool_button("Set name") var push = set_label_name

@export var Links : Array[Node]
var weight := INF
var a_star_id : int = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	set_label_name()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func set_label_name():
	%CityName.text = self.name
	$PopupMenu.set_item_text(0, self.name)

func show_city_name(toggle : bool) :
	%CityName.visible = toggle

func _on_mouse_entered():
	$AnimationPlayer.play("expand")


func _on_mouse_exited():
	$AnimationPlayer.play_backwards("expand")


func _on_button_pressed():
	$PopupMenu.position = self.global_position
	$PopupMenu.show()


func _on_popup_menu_id_pressed(id):
	match id :
		1 :
			get_tree().root.get_node("Control").set_origin_city(self)
		2 :
			get_tree().root.get_node("Control").set_target_city(self)
