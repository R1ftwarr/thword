package com.educationcurb.thword.utils;
import starling.display.Quad;
import starling.display.Sprite;

class Border extends Sprite
{
    public function new(w:Float, h:Float, thickness:Int, ?colour:UInt = 0x000000)
    {
        super();

        this.width = w;
        this.height = h;

        var top : Quad = new Quad(w, thickness, colour);
        top.x = 0;
        top.y = 0;
        this.addChild(top);

        var bottom : Quad = new Quad(w, thickness, colour);
        bottom.x = 0;
        bottom.y = h - thickness;
        this.addChild(bottom);

        var left : Quad = new Quad(thickness, h, colour);
        left.x = 0;
        left.y = 0;
        this.addChild(left);

        var right : Quad = new Quad(thickness, h, colour);
        right.x = w - thickness;
        right.y = 0;
        this.addChild(right);
    }
}
