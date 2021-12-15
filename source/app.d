module app;

public import eload;
public import window;
public import graphics;
public import events;
import derelict.sfml2.window;

void main() {
	loadLibraries();

	Window window = new Window(800,600,"Hello!");
	window.setFramerateLimit(60);

	while(window.isOpen()) {
		while(window.pollEvent()) {
			if(window.getEvent.have_EventType(EventType.closed)) {
				window.close();
			}
		}
		

		window.clear(Color.black);
		window.display();
	}
}
