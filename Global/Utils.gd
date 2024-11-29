extends Node

func add_animation(sprite_frames : SpriteFrames, spritesheet: Texture, sprite_size: Vector2, frames : Array, name: String):
	sprite_frames.add_animation(name)
	sprite_frames.set_animation_loop(name,true)
	for frame: Vector2 in frames:
		var frame_tex := AtlasTexture.new()
		frame_tex.atlas = spritesheet
		frame_tex.region = Rect2(Vector2(frame.x,frame.y)*sprite_size,sprite_size)
		sprite_frames.add_frame(name,frame_tex,1,-1) 
