@abstract
class_name State
extends Node

var actor: Node
var state_machine: StateMachine

@abstract func enter(data: Variant = null)

@abstract func exit()

@abstract func update(delta: float)

@abstract func physics_update(delta: float)

