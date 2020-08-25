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

import openfl.media.Sound;
class SoundVO
{
    public function new(){}

    private var _id:Int;
    public var id(get, set):Int;
    private function get_id():Int
    {
        return _id;
    }
    private function set_id(id:Int):Int
    {
        if (_id == id) return id;
        _id = id;
        return id;
    }

    private var _url:String;
    public var url(get, set):String;
    private function get_url():String
    {
        return _url;
    }
    private function set_url(url:String):String
    {
        if (_url == url) return url;
        _url = url;
        return url;
    }

    private var _name:String;
    public var name(get, set):String;
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

    private var _word:String;
    public var word(get, set):String;
    private function get_word():String
    {
        return _word;
    }
    private function set_word(word:String):String
    {
        if (_word == word) return word;
        _word = word;
        return word;
    }

    private var _sound:Sound;
    public var sound(get, set):Sound;
    private function get_sound():Sound
    {
        return _sound;
    }
    private function set_sound(sound:Sound):Sound
    {
        if (_sound == sound) return sound;
        _sound = sound;
        return sound;
    }
}
