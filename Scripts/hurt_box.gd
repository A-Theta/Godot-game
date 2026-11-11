class_name hurtbox
extends Area2D
@onready var immunity_timer=$immunity_timer
var immunity=0
signal hurt
@onready var self_hitbox=self.get_parent().find_child("hitbox")
var hitbox_in=0
var hitbox_out=0
func _on_area_entered(area) -> void:
	if area is hitbox && area!=self_hitbox:
		hitbox_in=1
		hitbox_out=0
func _on_area_exited(area: Area2D) -> void:
	if area is hitbox && area!=self_hitbox:
		hitbox_in=0
		hitbox_out=1
func _on_immunity_timer_timeout() -> void:
	immunity=0
func _physics_process(_delta: float) -> void:
	if hitbox_in && !hitbox_out && !immunity:
		emit_signal("hurt")
		immunity=1
		immunity_timer.start()
