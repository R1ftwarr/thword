/**
THWORD - A fast paced, challenging word game
Copyright (C) 2020  Glasir Games Pty Ltd

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
**/

package com.glasirgames.thword.utils;

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
