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

import openfl.media.Sound;
import openfl.media.SoundTransform;
import openfl.media.SoundChannel;
import com.glasirgames.thword.model.SoundVO;

class SoundManager
{
    private var _sounds:Array<SoundVO>;
    private var _musicSoundChannel:SoundChannel;
    private var _currentMusic:Sound;
    public var _soundChannel:SoundChannel;
    private var _currentSound:Sound;

    public function new(sounds:Array<SoundVO>)
    {
        _sounds = sounds;
    }

    public function play(name:String):Void
    {
        var tmpSnds:Array<SoundVO> = new Array<SoundVO>();

        for(i in 0 ... _sounds.length)
        {
            if(_sounds[i].name == name)
            {
                tmpSnds.push(_sounds[i]);
            }
        }

        if(tmpSnds.length > 0){
            var randomNumber:Int = Std.int(Math.random()*tmpSnds.length);
            _currentSound = tmpSnds[randomNumber].sound;
            _soundChannel = _currentSound.play();
        }

    }

    public function stop(name:String):Void
    {
        for(i in 0 ... _sounds.length)
        {
            if(_sounds[i].name == name)
            {
                if (_soundChannel != null)
                {
                    _soundChannel.stop();
                }
            }
        }
    }

    public function getSound(name:String):Sound
    {
        var tmpSnds:Array<SoundVO> = new Array<SoundVO>();
        var snd:Sound = new Sound();

        for(i in 0 ... _sounds.length)
        {
            if(StrUtil.CleanWordSlash(_sounds[i].name) == name)
            {
                tmpSnds.push(_sounds[i]);
            }
        }

        if(tmpSnds.length > 0){
            var randomNumber:Int = Std.int(Math.random()*tmpSnds.length);
            snd = tmpSnds[randomNumber].sound;
        }
        return snd;
    }

    public function playMusic(name:String, volume:Float = 1.0):Void
    {
        for(i in 0 ... _sounds.length)
        {
            if(_sounds[i].name == name)
            {
                var sndTrans:SoundTransform = new SoundTransform(volume);

                _currentMusic = _sounds[i].sound;
                
                _musicSoundChannel = _currentMusic.play(0.0, 30, sndTrans);
            }
        }
    }

    public function pauseMusic():Void
    {
        _musicSoundChannel.stop();
    }

    public function stopMusic(name:String):Void
    {
        for(i in 0 ... _sounds.length)
        {
            if(_sounds[i].name == name)
            {
                _musicSoundChannel.stop();
            }
        }
    }

}
