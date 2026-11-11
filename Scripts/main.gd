extends Node2D
@onready var Player: Node2D = $"Player"
func _process(delta: float) -> void:
	if Player.go_main_menu==1:
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	if Player.restart_game==1:
		get_tree().reload_current_scene()
		
