extends CharacterBody2D

var drone_speed: int = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var direction = Vector2.RIGHT 
	velocity = direction * drone_speed
	move_and_slide()
	loop_x()
	

func loop_x():
	var view_width: int = get_viewport().size.x
	if position.x - $DroneSprite.texture.get_width() / 2 >= view_width:
		position.x = 0
		if drone_speed <= 1000:
			drone_speed += drone_speed
