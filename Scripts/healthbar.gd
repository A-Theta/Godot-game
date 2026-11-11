extends TextureProgressBar
@onready var parent = self.get_parent()
func _process(_delta: float) -> void:
	self.value=(parent.health*100)/parent.maxhealth
	
	
