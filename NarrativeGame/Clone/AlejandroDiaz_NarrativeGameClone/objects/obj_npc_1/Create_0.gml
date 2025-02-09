
depth = -y;

text_1 = "The key is some way to the east of here.";

text_2 = "Great. My friend will tell you how to escape this place.";

text = text_1;

function update_text() {
	
	if (obj_player.has_key) text = text_2;
	
}
