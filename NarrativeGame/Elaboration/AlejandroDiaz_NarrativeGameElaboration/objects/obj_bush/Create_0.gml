
depth = -(y + sprite_height - obj_player.sprite_height);
music = snd_bush;
snd = noone;

function sound() {
	
	if (place_meeting(x,y,obj_player)) {
		
		if (!audio_is_playing(music)) {
			
			show_debug_message("hiiiiiii");
			snd = audio_play_sound(music,2,1);
			
		}
		
	} 
	
	else {
		
		audio_stop_sound(snd);
		
	}
	
}
