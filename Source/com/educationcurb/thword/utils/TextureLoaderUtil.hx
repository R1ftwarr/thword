package com.educationcurb.thword.utils;

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
        //trace(dataUrl);
        var http = new haxe.Http(dataUrl);
        http.onData = function (data) {
            loadDataComplete(Std.string(data));
            //trace(data);
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

        //trace("JSON PARSE!!!!!!!!!!!!!!!! : " + json.data.beanmachine);

        var textureAssets:Array<String> = json.data.textureassets;
        //trace(textureAssets);
        /*for (i in 0 ... textureAssets.length)
        {
            _textureUrls.push(Assets.getPath(textureAssets[i]));
        }*/
        _textureUrls = textureAssets;
        
        //trace(_textureUrls);

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
