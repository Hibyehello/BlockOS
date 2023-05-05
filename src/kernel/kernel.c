void print_string(volatile char* video_mem, char color, const char* str) {
	while(*str != 0) {
		  *video_mem++ = *str++;
		  *video_mem++ = color;
		}
}

void main() {
	volatile char* video_mem = (volatile char*) 0xb8000;
	video_mem += 0xA0;
	char color = 0x09;

	print_string(video_mem, color, "My kernel's first string!");

	while(1);
 }

