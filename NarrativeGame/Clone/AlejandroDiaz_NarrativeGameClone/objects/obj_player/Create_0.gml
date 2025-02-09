
vel = 1;

function update() {
	
	check_win();
	pick_up_key();
	spawn_textbox();
	move();
	update_depth();
	
}

function check_win() {
	if (instance_place(x,y,obj_goal)) {
		audio_play_sound(snd_bubble,0,0);
		room_goto(rm_start);
	}
}

has_key = false;
function pick_up_key() {
	
	key = instance_place(x,y,obj_key);
	
	if (key != noone) {
		instance_destroy(key);
		if (instance_exists(obj_door)) {
			has_key = true;
		}
		audio_play_sound(snd_collect,0,0);
	}
	
}

facing = 0;
// 0 = down;
// 1 = up;
// 2 = right;
// 3 = left;

function move() {
	
	if (x < -100 || x > room_width + 100 ||
		y < -100 || y > room_height + 100) visible = false;
	else visible = true;
	
	if (keyboard_check(ord("A"))) {
		
		switch_frames = keyboard_check_pressed(ord("A")) || 
			!(keyboard_check(ord("D")) ||
			keyboard_check(ord("W")) ||
			keyboard_check(ord("S")));
		
		if (facing != 0 && switch_frames) {
			
			image_index = 12;
			
			facing = 0;
			
		}
		
		if (!place_meeting(x-vel,y,obj_wall)) {
			
			door = instance_place(x-vel,y,obj_door);
			
			if (!((door != noone) && door.image_index == 0)) {
				
				x -= vel;
				
			}
			
		}
		
	} if (keyboard_check(ord("D"))) { 
		switch_frames = keyboard_check_pressed(ord("D")) || 
			!(keyboard_check(ord("A")) ||
			keyboard_check(ord("W")) ||
			keyboard_check(ord("S")));
		if (facing != 1 && switch_frames) {
			image_index = 8;
			facing = 1;	
		}
		if (!place_meeting(x+vel,y,obj_wall)) {
			door = instance_place(x+vel,y,obj_door);
			if (!((door != noone) && door.image_index == 0)) {
				x += vel;
			}
		} 
	} if (keyboard_check(ord("W"))) {
		switch_frames = keyboard_check_pressed(ord("W")) || 
			!(keyboard_check(ord("A")) ||
			keyboard_check(ord("D")) ||
			keyboard_check(ord("S")));
		if (facing != 2 && switch_frames) {
			image_index = 4;
			facing = 2;	
		}
		if (!place_meeting(x,y-vel,obj_wall)) {
			door = instance_place(x,y-vel,obj_door);
			
			// opening the door
			if (door && has_key) {
				door.image_index = 1; 
				audio_play_sound(snd_door,0,0);
				has_key = false;
			}
			
			if (!((door != noone) && door.image_index == 0)) {
				y -= vel;
			}
		} 
	} if (keyboard_check(ord("S"))) {
		switch_frames = keyboard_check_pressed(ord("S")) || 
			!(keyboard_check(ord("A")) ||
			keyboard_check(ord("W")) ||
			keyboard_check(ord("D")));
		if (facing != 3 && switch_frames) {
			image_index = 0;
			facing = 3;	
		}
		if (!place_meeting(x,y+vel,obj_wall)) {
			door = instance_place(x,y+vel,obj_door);
			if (!((door != noone) && door.image_index == 0)) {
				y += vel;
			}
		}
	}
	
	move_camera();
	
	if (keyboard_check(ord("A")) ||
		keyboard_check(ord("W")) ||
		keyboard_check(ord("D")) ||
		keyboard_check(ord("S"))) animate();
	
}

vel_animation = 18;
timer = vel_animation;

function animate() {
	
	if (timer == 0) {
		
		if ((image_index + 1) % 4 == 0) image_index -= 3;
		else image_index++;
		
		timer = vel_animation;
		
	} else timer--;
	
}

function move_camera() {
	
	targetx = x - (camera_get_view_width(view_camera[0]) / 2); 
	targety = y - (camera_get_view_height(view_camera[0]) / 2);
	camera_set_view_pos(view_camera[0],targetx, targety);
	
}

function update_depth() {
	
	// The following comment works (not for the npcs) without using y for depth 
	/*
	if (place_meeting(x,y,obj_bush)) depth = 1;
	else depth = -1;
	*/
	
	depth = -y;
	
}

textbox = noone;
far_away_from_text = 100;
function spawn_textbox() {
	
	if (keyboard_check_pressed(vk_space)) {
		
		if (textbox != noone) {
			
			instance_destroy(textbox);
			textbox = noone;
			
		}	
		
		if (instance_place(x-vel,y,obj_npc_2) ||
			instance_place(x+vel,y,obj_npc_2) ||
			instance_place(x,y-vel,obj_npc_2) ||
			instance_place(x,y+vel,obj_npc_2)) {
			
			textbox = instance_create_layer(camera_get_view_x(view_camera[0]) + 
				camera_get_view_width(view_camera[0])/2 - 114,
				camera_get_view_y(view_camera[0]) + 
				camera_get_view_height(view_camera[0])*2/7,"Instances",obj_textbox);
			textbox.speaker = obj_npc_2;
			
			audio_play_sound(snd_comm,0,0);
			
		} else if (instance_place(x-vel,y,obj_npc_1) ||
			instance_place(x+vel,y,obj_npc_1) ||
			instance_place(x,y-vel,obj_npc_1) ||
			instance_place(x,y+vel,obj_npc_1)) {
			
			textbox = instance_create_layer(camera_get_view_x(view_camera[0]) + 
				camera_get_view_width(view_camera[0])/2 - 114,
				camera_get_view_y(view_camera[0]) + 
				camera_get_view_height(view_camera[0])*2/7,"Instances",obj_textbox);
			textbox.speaker = obj_npc_1;
			
			audio_play_sound(snd_comm,0,0);
		
		}
		
	}
	
	if (textbox == noone) return;
	
	if (x > textbox.x + textbox.sprite_width/2 + far_away_from_text || 
		x < textbox.x + textbox.sprite_width/2 - far_away_from_text ||
		y > textbox.y + room_height/6 || 
		y < textbox.y + room_height/6 - far_away_from_text) {
		instance_destroy(textbox);
		textbox = noone;
	}
	
}

