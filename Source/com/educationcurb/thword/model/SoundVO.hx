package com.educationcurb.thword.model;
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
