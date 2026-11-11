extends Node2D
@onready var main_menu: Button = $"Main-Menu"
@onready var restart: Button = $Restart
signal restart_game
signal go_main_menu
func _on_restart_pressed() -> void:
	emit_signal("restart_game")
func _on_main_menu_pressed() -> void:
	emit_signal("go_main_menu")
