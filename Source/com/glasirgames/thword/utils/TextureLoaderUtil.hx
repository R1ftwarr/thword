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

import openfl.utils.Assets;
import msignal.Signal.Signal1;
import msignal.Signal.Signal0;

class TextureLoaderUtil
{
    public var complete:Signal0;
    public var failed:Signal1<String>;

    private var _beanmachine:Array<Dynamic>;
    public var beanmachine(get, null):Array<Dynamic>;
    private function get_beanmachine():Array<Dynamic>
    {
        return _beanmachine;
    }

    private var _textureUrls:Array<String>;
    public var textureUrls(get, null):Array<String>;
    private function get_textureUrls():Array<String>
    {
        return _textureUrls;
    }

    public function new()
    {
        complete = new Signal0();
        failed = new Signal1<String>();
    }

    public function loadTextureArray(dataUrl:String):Void
    {
        var http = new haxe.Http(dataUrl);
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
        _textureUrls = new Array<String>();

        var json = haxe.Json.parse(data);

        if(json.data.beanmachine != null)
            _beanmachine = json.data.beanmachine.sublevels;

        var textureAssets:Array<String> = json.data.textureassets;
        _textureUrls = textureAssets;
        
        if(_textureUrls.length > 0)
            complete.dispatch();
        else
            loadDataFailed("Error! Please add texture urls to the data file!");
    }


    private function loadDataFailed(data:String):Void
    {
        failed.dispatch(data);
    }

    public function destroy():Void
    {
        complete.removeAll();
        complete = null;

        failed.removeAll();
        failed = null;
    }
}
