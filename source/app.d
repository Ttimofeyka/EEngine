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

	while(window.isOpen()) {
		while(window.pollEvent()) {
			if(window.getEvent.have_EventType(EventType.closed)) {
				window.close();
			}
		}

		window.clear(getRGBA(90,90,90,255));
		window.display();
	}
}