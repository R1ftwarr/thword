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

package com.glasirgames.thword;

class Settings
{
    private static var instance : Settings;

    //GAME TYPE
    public static inline var GAME_ENDURANCE : String = "gameendurance";
    public static inline var GAME_RAMPAGE : String = "gamerampage";

    public static var SKIP_DEVICE_SETTINGS : Bool = false;

    //APPLE DEVCICES
    public static var IPHONE5 : String = "iphone5";  //1136 x 640

    public var realWidth : Int;
    public var realHeight : Int;

    public var iOS : Bool = false;

    public var stageWidth : Int;
    public var stageHeight : Int;
    public var scale : Int;
    public var tablet : String;
    public var scaleAdjustment : Float = 1;
    public var scaleAdjustmentMinor : Float = 1;
    public var scaleAdjustmentSlider : Float = 1;

    public var fontTiny : Float = 8;
    public var fontSmall : Float = 12;
    public var fontMedium : Float = 16;
    public var fontLarge : Float = 20;
    public var fontExLarge : Float = 30;
    public var fontSuperLarge : Float = 40;

    public var skipGame(default, never) : Bool = false;
    public var resetSaveFile(default, never) : Bool = false;

    public static function getInstance() : Settings
    {
        if (instance == null)
        {
            instance = new Settings();
        }
        return instance;
    }

    public function new()
    {
    }
}
