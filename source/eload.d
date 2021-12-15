module eload;

import derelict.sfml2.system;
import derelict.sfml2.window;
import derelict.sfml2.graphics;
import derelict.sfml2.audio;
import std.file : thisExePath;
import std.path : dirName;
import derelict.opengl3.gl;

void loadLibraries() {
    DerelictSFML2System.load(thisExePath().dirName~"\\lib\\csfml-system-2.dll");
	DerelictSFML2Window.load(thisExePath().dirName~"\\lib\\csfml-window-2.dll");
	DerelictSFML2Graphics.load(thisExePath().dirName~"\\lib\\csfml-graphics-2.dll");
    DerelictSFML2Audio.load(thisExePath().dirName~"\\lib\\csfml-audio-2.dll");
    DerelictGL3.load();
}