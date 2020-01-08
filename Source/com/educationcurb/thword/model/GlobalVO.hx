package com.educationcurb.thword.model;
import starling.utils.AssetManager;
class GlobalVO
{
    public var name(get, set):String;
    public var soundsArr(get, set):Array<SoundVO>;
    public var assets(get, set):AssetManager;

    public function new() {
    }

    private var _name:String;
    private function get_name():String
    {
        return _name;
    }
    private function set_name(name:String):String
    {
        if (_name == name) return name;
        _name = name;
        return name;
    }

    private var _soundsArr:Array<SoundVO>;
    private function get_soundsArr():Array<SoundVO>
    {
        return _soundsArr;
    }
    private function set_soundsArr(soundsArr:Array<SoundVO>):Array<SoundVO>
    {
        if (_soundsArr == soundsArr) return soundsArr;
        _soundsArr = soundsArr;
        return soundsArr;
    }

    private var _assets:AssetManager;
    private function get_assets():AssetManager
    {
        return _assets;
    }
    private function set_assets(assets:AssetManager):AssetManager
    {
        if (_assets == assets) return assets;
        _assets = assets;
        return assets;
    }

    
}
