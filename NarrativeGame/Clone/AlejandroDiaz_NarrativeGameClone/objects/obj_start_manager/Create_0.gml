
function play() {
	
	if (keyboard_check(vk_space)) {
		
		audio_stop_all();
		room_goto(rm_game);
		
	}
	
}
