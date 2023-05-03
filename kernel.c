void main() {
	char* video_mem = (char*)0xb8000;
	video_mem += 0xA0;
	char color = 0x0f;
	const char* string = "test";
	
	video_mem--; // Here to remove need for logic

	// Doesn't work
	while(*string != 0) {
	  *++video_mem = *string++;
	  *++video_mem = color;
	}

	// Works
	*++video_mem = 't';
	*++video_mem = color;
	*++video_mem = 'e';
	*++video_mem = color;
	*++video_mem = 's';
	*++video_mem = color;
	*++video_mem = 't';
	*++video_mem = color;

	while(1);
 }

