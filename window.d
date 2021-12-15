module window;

import derelict.sfml2.system;
import derelict.sfml2.window;
import derelict.sfml2.graphics;
public import graphics;
public import events;
import core.math : sqrt;
import std.math.exponential : pow;

enum Color {
    black = sfBlack,
    white = sfWhite,
    green = sfGreen,
    yellow = sfYellow,
    blue = sfBlue,
    red = sfRed
}

sfColor getRGBA(sfUint8 r, sfUint8 g, sfUint8 b, sfUint8 a) {
    return sfColor(r,g,b,a);
}

class Clock {
    sfClock* clock;
    this() {
        this.clock=sfClock_create();
    }
    float getElapsedTimeF() {
        sfTime time = sfClock_getElapsedTime(this.clock);
        return cast(float)sfTime_asMilliseconds(time);
    }
    void reset() {sfClock_restart(this.clock);}
}

float getDistance(float x1, float y1, float x2, float y2) {
    float x1x2 = pow(x2-x1,2);
    float y1y2 = pow(y2-y1,2);
    return sqrt(x1x2+y1y2);
}

class Window {
    private sfRenderWindow* window;
    private char* name;
    private sfVector2i mousepos;
    private Event event;

    this(int width, int height, string nam) {
        const char* snam = nam.ptr;
        this.name=cast(char*)snam;
        sfVideoMode mode = {width, height, 32};
        this.window = sfRenderWindow_create(mode, this.name, sfClose, null);
    }

    void setName(string nam) {
        const char* snam = nam.ptr;
        this.name=cast(char*)snam;
        sfRenderWindow_setTitle(this.window,this.name);
    }
    void setSize(uint w, uint h) {sfRenderWindow_setSize(this.window,sfVector2u(w,h));}
    char* getName() {return this.name;}

    sfBool isOpen() {return sfRenderWindow_isOpen(this.window);}
    sfBool pollEvent() {
        sfEvent ev;
        sfBool a = sfRenderWindow_pollEvent(this.window,&ev);
        this.event = new Event(ev);
        this.mousepos = sfMouse_getPositionRenderWindow(this.window);
        return a;
    }

    void close() {sfRenderWindow_close(this.window);}
    void display() {sfRenderWindow_display(this.window);}
    void destroy() {sfRenderWindow_destroy(this.window);}
    void clear(sfColor color) {sfRenderWindow_clear(this.window,color);}

    void drawRect(Rectangle rect) {
        sfRenderWindow_drawRectangleShape(this.window,rect.getRS(),null);
    }
    void drawCircle(Circle circle) {
        sfRenderWindow_drawCircleShape(this.window,circle.getCS(),null);
    }
    void drawScene(Scene scene) {
        Rectangle[int] rects=scene.getRects();
        Circle[int] circles=scene.getCircles();
        for(int i=0; i<rects.length; i++) {
            drawRect(rects[i]);
        }
        for(int i=0; i<circles.length; i++) {
            drawCircle(circles[i]);
        }
    }

    void setFramerateLimit(int fps) {
        sfRenderWindow_setFramerateLimit(this.window,cast(uint)fps);
    }

    bool collision_IR_II(IntRect ir, int i1, int i2) {
        sfIntRect sfir = ir.toSFIR();
        if(sfIntRect_contains(&sfir,i1,i2)) return true;
        return false;
    }
    bool intersects_IR_IR(IntRect ir, IntRect ir2) {
        sfIntRect sfir = ir.toSFIR();
        sfIntRect sfir2 = ir2.toSFIR();
        if(sfIntRect_intersects(&sfir,&sfir2,null)) return true;
        return false;
    }

    Event getEvent() {return this.event;}

    sfRenderWindow* getRW() {return this.window;}
}