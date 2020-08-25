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

import openfl.utils.Object;
import msignal.Signal.Signal0;
import com.glasirgames.thword.model.SoundVO;

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