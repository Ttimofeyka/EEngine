module events;

import derelict.sfml2.system;
import derelict.sfml2.window;
import derelict.sfml2.graphics;

enum EventType {
    closed,
    resized,
    keyPressed,
    keyReleased,
    mousePressed,
    mouseReleased,
    mouseMoved,
    unknow
}

static bool keyW=false;
static bool keyS=false;
static bool keyA=false;
static bool keyD=false;
static bool keyLeft=false;
static bool keyRight=false;

void setup_keys(Event ev) {
    if(ev.have_EventType(EventType.keyPressed)) {
        if(ev.getKeyCode()==sfKeyW) keyW=true;
        else if(ev.getKeyCode()==sfKeyS) keyS=true;
        else if(ev.getKeyCode()==sfKeyA) keyA=true;
        else if(ev.getKeyCode()==sfKeyD) keyD=true;
        else if(ev.getKeyCode()==sfKeyLeft) keyLeft=true;
        else if(ev.getKeyCode()==sfKeyRight) keyRight=true;
    }
    else if(ev.have_EventType(EventType.keyReleased)) {
        if(ev.getKeyCode()==sfKeyW) keyW=false;
        else if(ev.getKeyCode()==sfKeyS) keyS=false;
        else if(ev.getKeyCode()==sfKeyA) keyA=false;
        else if(ev.getKeyCode()==sfKeyD) keyD=false;
        else if(ev.getKeyCode()==sfKeyLeft) keyLeft=false;
        else if(ev.getKeyCode()==sfKeyRight) keyRight=false;
    }
}

class Event {
    private EventType type;
    sfEvent event;

    this(sfEvent ev) {
        this.event=ev;
        switch(this.event.type) {
            case sfEvtClosed:
                this.type=EventType.closed;
                break;
            case sfEvtResized:
                this.type=EventType.resized;
                break;
            case sfEvtKeyPressed:
                this.type=EventType.keyPressed;
                break;
            case sfEvtKeyReleased:
                this.type=EventType.keyReleased;
                break;
            case sfEvtMouseButtonPressed:
                this.type=EventType.mousePressed;
                break;
            case sfEvtMouseButtonReleased:
                this.type=EventType.mouseReleased;
                break;
            case sfEvtMouseMoved:
                this.type=EventType.mouseMoved;
                break;
            default:
                this.type=EventType.unknow;
                break;
        }
    }
    bool have_EventType(EventType t) {
        return this.type==t;
    }
    sfKeyCode getKeyCode() {return this.event.key.code;}
}