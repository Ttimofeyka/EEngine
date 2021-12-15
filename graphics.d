module graphics;

import derelict.sfml2.system;
import derelict.sfml2.window;
import derelict.sfml2.graphics;
public import window;

class IntRect {
    int one; int two;
    int three; int four;

    this(int one, int two, int three, int four) {
        this.one=one; this.two=two; this.three=three; this.four=four;
    }
    this(Rectangle rect) {
        sfVector2i xy = rect.getIPos();
        sfVector2i wh = rect.getISize();
        this.one=xy.x; this.two=xy.y;
        this.three=wh.x; this.four=wh.y;
    }
    this(Circle circle) {
        sfVector2i xy = circle.getIPos();
        this.one=xy.x; this.two=xy.y;
        this.three=cast(int)circle.getISize()/2;
        this.four=cast(int)circle.getISize()/2;
    }

    sfIntRect toSFIR() {
        return sfIntRect(this.one,this.two,this.three,this.four);
    }
}

class Rectangle {
    private sfRectangleShape* shape;
    private float x; private float y;
    private float width; private float height;
    private sfColor color;
    private Scene scene;
    private int numinscene=-1;

    this(float x, float y, float width, float height) {
        this.x=x; this.y=y; this.width=width; this.height=height;
        this.shape = sfRectangleShape_create();
        sfRectangleShape_setPosition(this.shape,sfVector2f(this.x,this.y));
        sfRectangleShape_setSize(this.shape,sfVector2f(this.width,this.height));
    }

    void setPos(float x, float y) {
        this.x=x; this.y=y;
        sfRectangleShape_setPosition(this.shape,sfVector2f(this.x,this.y));
        if(numinscene != -1) {
            this.scene.setRect(this,numinscene);
        }
    }

    void setSize(float width, float height) {
        this.width=width; this.height=height;
        sfRectangleShape_setSize(this.shape,sfVector2f(this.width,this.height));
        if(numinscene != -1) {
            this.scene.setRect(this,numinscene);
        }
    }

    void setColor(sfColor color) {
        this.color=color;
        sfRectangleShape_setFillColor(this.shape,this.color);
        if(numinscene != -1) {
            this.scene.setRect(this,numinscene);
        }
    }

    void setScene(Scene scene) {
        this.scene=scene;
        numinscene=scene.addRect(this);
    }

    void destroy() {
        sfRectangleShape_destroy(this.shape);
    }

    void setOutline(float power, sfColor color) {
        sfRectangleShape_setOutlineColor(this.shape,color);
        sfRectangleShape_setOutlineThickness(this.shape,power);
    }

    void setRotation(float rotate) {
        sfRectangleShape_setRotation(this.shape,rotate);
    }
    void rotate(float rot) {
        sfRectangleShape_rotate(this.shape,rot);
    }
    float getRotation() {
        return sfRectangleShape_getRotation(this.shape);
    }

    sfVector2f getPos() {
        return sfVector2f(this.x,this.y);
    }
    sfVector2i getIPos() {
        return sfVector2i(cast(int)this.x,cast(int)this.y);
    }
    sfVector2f getSize() {
        return sfVector2f(this.width,this.height);
    }
    sfVector2i getISize() {
        return sfVector2i(cast(int)this.width,cast(int)this.height);
    }
    sfVector2f getGlobalPos() {
        sfFloatRect sffr = sfRectangleShape_getGlobalBounds(this.shape);
        return sfVector2f(sffr.left,sffr.height);
    }

    sfRectangleShape* getRS() {return this.shape;}
}

class Circle {
    private sfCircleShape* shape;
    private float size;
    private float x; private float y;
    private sfColor color;
    private Scene scene;
    private int numinscene=-1;

    this(float x, float y, float size) {
        this.size=size; this.x=x; this.y=y;
        this.shape = sfCircleShape_create();
        sfCircleShape_setPosition(this.shape,sfVector2f(this.x,this.y));
        sfCircleShape_setRadius(this.shape,this.size);
    }

    void setPos(float x, float y) {
        this.x=x; this.y=y;
        sfCircleShape_setPosition(this.shape,sfVector2f(this.x,this.y));
        if(numinscene != -1) {
            this.scene.setCircle(this,numinscene);
        }
    }

    void setSize(float size) {
        this.size=size;
        sfCircleShape_setRadius(this.shape,this.size);
        if(numinscene != -1) {
            this.scene.setCircle(this,numinscene);
        }
    }

    void setColor(sfColor color) {
        this.color=color;
        sfCircleShape_setFillColor(this.shape,this.color);
        if(numinscene != -1) {
            this.scene.setCircle(this,numinscene);
        }
    }

    void setScene(Scene scene) {
        this.scene=scene;
        numinscene=scene.addCircle(this);
    }

    void destroy() {
        sfCircleShape_destroy(this.shape);
    }

    void setOutline(float size, sfColor color) {
        sfCircleShape_setOutlineThickness(this.shape,size);
        sfCircleShape_setOutlineColor(this.shape,color);
    }

    sfVector2f getPos() {
        return sfVector2f(this.x,this.y);
    }
    sfVector2i getIPos() {
        return sfVector2i(cast(int)this.x,cast(int)this.y);
    }
    float getSize() {
        return this.size;
    }
    int getISize() {
        return cast(int)this.size;
    }

    sfCircleShape* getCS() {return this.shape;}
}

class Scene {
    private Rectangle[int] rects;
    private int[Rectangle] rects2;
    private int irects;

    private Circle[int] circles;
    private int[Circle] circles2;
    private int icircles;
    
    this() {
        this.irects=0;
        this.icircles=0;
    }
    int addRect(Rectangle rect) {
        this.rects[this.irects]=rect;
        this.rects2[rect]=this.irects;
        this.irects+=1;
        return this.irects-1;
    }
    void setRect(Rectangle rect, int num) {
        this.rects[num]=rect;
        this.rects2[rect]=num;
    }
    int addCircle(Circle circle) {
        this.circles[this.icircles]=circle;
        this.circles2[circle]=this.icircles;
        this.icircles+=1;
        return this.icircles-1;
    }
    void setCircle(Circle circle, int num) {
        this.circles[num]=circle;
        this.circles2[circle]=num;
    }

    Rectangle[int] getRects() {return this.rects;}
    Circle[int] getCircles() {return this.circles;}
}