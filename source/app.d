module app;

public import eload;
public import window;
public import graphics;
public import events;
import std.stdio : writeln;
import derelict.sfml2.window;
import std.conv : to;

static float speed = 1.75;

void main() {
	loadLibraries();

	Window window = new Window(800,600,"Hello!");
	window.setFramerateLimit(60);
	Scene main = new Scene();

	while(window.isOpen()) {
		while(window.pollEvent()) {
			setup_keys(window.getEvent());
			if(window.getEvent.have_EventType(EventType.closed)) {
				window.close();
			}
		}
		

		window.clear(Color.black);
		window.drawScene(main);
		window.display();
	}
}