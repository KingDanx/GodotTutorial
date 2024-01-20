extends RigidBody2D

const grenade_speed: int = 500
var direction: Vector2 = Vector2.UP

func _process(_delta):
	#position += direction * grenade_speed * delta
	pass
