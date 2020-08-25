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

package com.glasirgames.thword.model;

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
