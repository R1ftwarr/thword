package com.educationcurb.thword.utils;

import openfl.utils.Object;
import msignal.Signal.Signal0;
import com.educationcurb.thword.model.SoundVO;

class SoundLoaderUtil
{
    public var complete:Signal0;
    public var failed:Signal0;

    private var sndUrl:String;
    private var _soundArray:Array<SoundVO> = new Array<SoundVO>();
    public var soundArray(get, set):Array<SoundVO>;
    private function get_soundArray():Array<SoundVO>
    {
        return _soundArray;
    }
    private function set_soundArray(soundArray:Array<SoundVO>):Array<SoundVO>
    {
        if (_soundArray == soundArray) return soundArray;
        _soundArray = soundArray;
        return soundArray;
    }

    public function new()
    {
        complete = new Signal0();
        failed = new Signal0();
    }

    public function getSoundAssetObjects(dataUrl:String, soundUrl:String):Void
    {
        //sndUrl = "assets/audio/exercise/level" + level + "/" + game + "/";
        //var dataUrl:String = "assets/data/exercises/level" + level + "/" + game + "/asset-data.json";

        sndUrl = soundUrl;

        var http = new haxe.Http(dataUrl);
        http.setHeader("Access-Control-Allow-Origin", "*");
        http.onData = function (data) {
            loadDataComplete(Std.string(data));
        };
        http.onError = function (error) {
            loadDataFailed(Std.string(error));
        };
        http.request(false);
    }

    private function loadDataComplete(data:String):Void
    {
        var json = haxe.Json.parse(data);

        

        var soundAssets:Array<Dynamic> = json.data.soundassets;
        var sndObj:Object;
        for (i in 0 ... soundAssets.length)
        {
            sndObj = soundAssets[i];
            var vo:SoundVO = new SoundVO();
            vo.name = sndObj.name;
            vo.url = sndUrl + sndObj.sound;
            _soundArray.push(vo);
        }
        complete.dispatch();
    }

    private function loadDataFailed(data:String):Void
    {
        failed.dispatch();
    }

    public function destroy():Void
    {
        complete.removeAll();
        complete = null;

        failed.removeAll();
        failed = null;
    }
}