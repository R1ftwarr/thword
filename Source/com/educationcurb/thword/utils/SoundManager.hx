package com.educationcurb.thword.utils;

import openfl.media.Sound;
import openfl.media.SoundTransform;
import openfl.media.SoundChannel;
import com.educationcurb.thword.model.SoundVO;
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

        //Comment
    }

    public function play(name:String):Void
    {
        var tmpSnds:Array<SoundVO> = new Array<SoundVO>();

        for(i in 0 ... _sounds.length)
        {
            if(_sounds[i].name == name)
            {
                //_sounds[i].sound.play();
                tmpSnds.push(_sounds[i]);
            }
        }

        if(tmpSnds.length > 0){
            var randomNumber:Int = Std.int(Math.random()*tmpSnds.length);
            //tmpSnds[randomNumber].sound.play();

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
                //_sounds[i].sound.play();
                tmpSnds.push(_sounds[i]);
            }
        }

        if(tmpSnds.length > 0){
            var randomNumber:Int = Std.int(Math.random()*tmpSnds.length);
            snd = tmpSnds[randomNumber].sound;
            //tmpSnds[randomNumber].sound.play();
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
