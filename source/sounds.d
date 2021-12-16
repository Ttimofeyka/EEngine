module sounds;

import derelict.sfml2.system;
import derelict.sfml2.window;
import derelict.sfml2.audio;

class Sound {
    sfSound* sound;
    sfSoundBuffer* buffer;

    this(string dir) {
        this.sound = sfSound_create();
        this.buffer = sfSoundBuffer_createFromFile(dir.ptr);
        sfSound_setBuffer(this.sound,this.buffer);
    }
    void play() {
        sfSound_play(this.sound);
    }
    void setVolume(float value) {
        sfSound_setVolume(this.sound,value);
    }
    void stop() {
        sfSound_stop(this.sound);
    }
    bool isStopped() {
        if(sfSound_getStatus(this.sound)==sfStopped) return true;
        return false;
    }
    void reload(string dir) {
        this.buffer = sfSoundBuffer_createFromFile(dir.ptr);
        sfSound_setBuffer(this.sound,this.buffer);
    }
    void setLoop(bool loop) {
        if(loop) sfSound_setLoop(this.sound,sfTrue);
        else sfSound_setLoop(this.sound,sfFalse);
    }
}

class Music {
    sfMusic* music;

    this(string dir) {
        this.music=sfMusic_createFromFile(dir.ptr);
    }
    void play() {
        sfMusic_play(this.music);
    }
    void stop() {
        sfMusic_stop(this.music);
    }
    bool isStopped() {
        if(sfMusic_getStatus(this.music)==sfStopped) return true;
        return false;
    }
    void reload(string dir) {
        this.music=sfMusic_createFromFile(dir.ptr);
    }
    void setLoop(bool loop) {
        if(loop) sfMusic_setLoop(this.music,sfTrue);
        else sfMusic_setLoop(this.music,sfFalse);
    }
}