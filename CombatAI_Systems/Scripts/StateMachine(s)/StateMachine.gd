class_name StateMachine
extends Node

var current_state: State

func initialize(state: State, actor: Node, data: Variant = null):
    for child in get_children():
        if child is State:
            child.actor = actor
            child.state_machine = self

    current_state = state
    current_state.enter(data)

func switch_state(new_state: State, data: Variant = null):
    if current_state:
        current_state.exit()
    
    current_state = new_state
    current_state.enter(data)

func update(delta: float):
    if current_state:
        current_state.update(delta)

func physics_update(delta: float):
    if current_state:
        current_state.physics_update(delta)

func handle_input(event: InputEvent):
    pass

