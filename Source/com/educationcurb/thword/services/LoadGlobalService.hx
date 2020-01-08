package com.educationcurb.thword.services;

import openfl.system.Capabilities;
import com.educationcurb.thword.utils.TextureLoaderUtil;
import starling.utils.AssetManager;
import openfl.errors.Error;
import openfl.events.Event;
import openfl.net.URLRequest;
import openfl.media.Sound;

import com.educationcurb.thword.utils.SoundLoaderUtil;
import com.educationcurb.thword.model.SoundVO;
import com.educationcurb.thword.model.GlobalVO;
import com.educationcurb.thword.utils.DictionaryChecker;

import msignal.Signal.Signal1;
import msignal.Signal.Signal0;

@:rtti
@:keepSub
class LoadGlobalService
{
    @inject private var model:GlobalVO;

    public var completed:Signal0;
    public var failed:Signal1<Dynamic>;
    public var percent:Signal1<Float>;

    private var _sndUtil:SoundLoaderUtil;
    private var _soundsArr:Array<SoundVO>;
    private var soundAssetUrls:Array<String>;
    private var filesDownloaded:Int = 0;
    private var snd:Sound;

    private var _texUtil:TextureLoaderUtil;
    private var _assets:AssetManager;

    private static var totalPercentSound:Float = 20;
    private static var totalPercentTexture:Float = 80;
    private var currentPercent:Float = 0;

    public function new()
    {
        completed = new Signal0();
        failed = new Signal1<Dynamic>();
        percent = new Signal1<Float>();
    }

    public function loadGlobalAssets():Void
    {
        loadSounds();
    }

    //LOAD SOUNDS
    private function loadSounds():Void
    {
        _soundsArr = new Array<SoundVO>();

        _sndUtil = new SoundLoaderUtil();
        _sndUtil.complete.add(soundDataComplete);
        _sndUtil.failed.add(soundDataError);

        var dataUrl:String = "assets/data/asset-data.json";
        var sndUrl:String = "assets/audio/";
        _sndUtil.getSoundAssetObjects(dataUrl, sndUrl);
    }

    private function soundDataComplete():Void
    {
        _soundsArr =_sndUtil.soundArray;
        _sndUtil.destroy();
        _sndUtil = null;

        loadSoundFiles();
    }

    private function soundDataError():Void
    {
        failed.dispatch("Failed loading asset data file!");
    }

    private function loadSoundFiles():Void
    {
        filesDownloaded = 0;
        for(i in 0 ... _soundsArr.length)
        {
            try
            {
                _soundsArr[i].sound = new Sound(new URLRequest(_soundsArr[i].url));
                _soundsArr[i].sound.addEventListener(Event.COMPLETE, loadFileComplete);
            }
            catch(e:Error)
            {
                loadSoundFileFailed(e);
            }
        }
    }

    private function loadFileComplete(data:Dynamic):Void
    {
        filesDownloaded++;

        var sndPerc:Float = filesDownloaded/_soundsArr.length * 100;
        currentPercent = sndPerc*totalPercentSound/100;
        percent.dispatch(currentPercent);

        if(filesDownloaded == _soundsArr.length)
        {
            model.soundsArr = _soundsArr;
            loadTextures();
        }
    }

    private function loadSoundFileFailed(error:Dynamic):Void
    {
        failed.dispatch(error);
    }

    //LOAD TEXTURES
    private function loadTextures():Void
    {
        _texUtil = new TextureLoaderUtil();
        _texUtil.complete.add(loadTextureDataAssetsComplete);
        _texUtil.failed.add(loadTextureDataAssetsError);

        var dataUrl:String = "assets/data/asset-data.json";
        _texUtil.loadTextureArray(dataUrl);
    }

    private function loadTextureDataAssetsComplete():Void
    {
        loadTextureAssets(_texUtil.textureUrls);
        _texUtil.destroy();
        _texUtil = null;
    }

    private function loadTextureDataAssetsError(err:String):Void
    {
        _texUtil.destroy();
        failed.dispatch("Error loading texture data: " + err);
    }

    private function loadTextureAssets(urls:Array<String>):Void
    {
        try
        {
            _assets = new AssetManager();
            _assets.verbose = Capabilities.isDebugger;
            _assets.enqueue(urls);
            _assets.loadQueue(function(ratio:Float):Void
            {
                if (ratio == 1)
                    onTextureAssetLoadComplete();
                else
                    onTextureAssetLoadProgress(ratio);
            });
        }
        catch(e:Error)
        {
            onTextureAssetLoadError("Error loading texture data!");
        }
    }

    private function onTextureAssetLoadComplete():Void
    {
        model.assets = _assets;
        //completed.dispatch();
        loadDictionary();
    }

    private function onTextureAssetLoadProgress(ratio:Float):Void
    {
        var texturePercent:Float = totalPercentTexture*ratio;
        percent.dispatch(currentPercent + texturePercent);
    }

    private function onTextureAssetLoadError(err:String):Void
    {
        if(_texUtil != null)
        {
            _texUtil.destroy();
            _texUtil = null;
        }
        failed.dispatch(err);
    }


    //LOAD DICTIONARY
    private function loadDictionary():Void
	{
		var http = new haxe.Http("assets/data/dictionary.txt");

		http.onData = function (data) {
			dictionaryLoaded(Std.string(data));
		};

		http.onError = function (error) {
			failed.dispatch(error);
		};

		http.request(false);
	}

	private function dictionaryLoaded(txt:String):Void
	{
		DictionaryChecker.getInstance().startLoad(txt);
		completed.dispatch();
	}



}
