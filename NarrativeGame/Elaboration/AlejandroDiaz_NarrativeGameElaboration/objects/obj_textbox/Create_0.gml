
depth = -room_height;

font_size = 8;
font_add("Arial",font_size,0,0,32,128);

text_offset = 6;
text_offset_vert = 3;

speaker = noone;

text = "";

text_part = "";
l_vel = 0.8; // not the actually letter pace, but ballpark enough, it gets rounded to a value in which the inverse is an integer
letter = 1;
l = letter;
pause = l_vel * 11/12;

function update_text() {
	
	if (speaker != noone) text = speaker.text;
	
	if (letter - 1 >= string_length(text)) return;
	
	if (l == letter && string_char_at(text,letter) != " ") {
		
		text_part = string_copy(text,0,letter);
		audio_play_sound(snd_comm,0,0);
		
	}
	
	l += l_vel;
	
	if (string_char_at(text,letter) == "." ||
		string_char_at(text,letter) == "," ||
		string_char_at(text,letter) == "!") l -= pause;
	
	if (l > letter + 1) {
		letter++;
		l = letter;
	}
	
}