
depth = -2;

speaker = noone;

text = "";

font_size = 8;
font_add("Arial",font_size,0,0,32,128);

text_offset = 6;
text_offset_vert = 3;

function update_text() {
	
	if (speaker != noone) text = speaker.text; 
	
}

