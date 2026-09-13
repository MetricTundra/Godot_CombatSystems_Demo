extends State
class_name IdleState

func enter():
	actor.animation_player.play("PlayerLibrary/SwordShieldIdle")
	actor.animation_player.speed_scale = 1.0
	
func update(delta: float):
	pass

func exit():
	pass
