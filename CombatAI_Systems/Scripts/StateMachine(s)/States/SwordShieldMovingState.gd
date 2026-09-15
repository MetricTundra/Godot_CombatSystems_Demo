class_name SwordShieldMovingState
extends State

func enter(data: Variant = null):
    pass

func exit():
    pass

func update(delta: float):
    var input = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
    actor.move_character(input)
    
    if input == Vector2.ZERO:
        state_machine.switch_state(actor.idle_state, null)
    
    actor.blend_position = actor.blend_position.lerp(input, 10.0 * delta)

    actor.animation_tree.set(
        "parameters/TestMovement/blend_position",
        actor.blend_position
    )

func physics_update(delta: float):
    pass