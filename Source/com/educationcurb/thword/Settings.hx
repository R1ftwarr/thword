package com.educationcurb.thword;

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
