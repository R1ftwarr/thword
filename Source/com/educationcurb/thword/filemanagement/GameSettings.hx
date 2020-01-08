package com.educationcurb.thword.filemanagement;

class GameSettings
{
    private static var instance : GameSettings;
    
    @:meta(Embed(source="../assets/data/settings-data.js",mimeType="application/octet-stream"))

    private static var settingsData : Class<Dynamic>;
    
    private var settingsJSON : Dynamic;
    
    public function new()
    {
    }
    
    public static function getInstance() : GameSettings
    {
        if (instance == null)
        {
            instance = new GameSettings();
        }
        return instance;
    }
    
    private function loadFile() : Void
    {

        /*
        var f : File = File.applicationStorageDirectory.resolvePath("settings-data.js");
        if (f.exists)
        {
            var sContent : String;
            var fDataStream : FileStream;
            fDataStream = new FileStream();
            fDataStream.open(f, FileMode.READ);
            sContent = fDataStream.readUTFBytes(fDataStream.bytesAvailable);
            fDataStream.close();
            fDataStream = null;
            f = null;
            settingsJSON = haxe.Json.parse(sContent);
        }
        else
        {
            var barScore : ByteArray;
            barScore = Type.createInstance(settingsData, []);
            var str : String = barScore.readMultiByte(barScore.bytesAvailable, barScore.endian);
            settingsJSON = haxe.Json.parse(str);
        }
        */
    }
    
    public function getSoundSetting() : Int
    {
        trace("getSoundSetting");

        #if sys
            trace("file system can be accessed");
        #end


        /*
        loadFile();
        var sndSetting : Int = as3hx.Compat.parseFloat(settingsJSON.data.soundstate);
        
        trace("sndSetting=" + sndSetting);
        
        return sndSetting;
        */

        return 0;
    }
    
    public function setSoundSetting(sndSetting : Int) : Void
    {

        /*
        loadFile();
        settingsJSON.data.soundstate = sndSetting;
        
        var saveFile : File = File.applicationStorageDirectory.resolvePath("settings-data.js");
        var stream : FileStream = new FileStream();
        stream.open(saveFile, FileMode.WRITE);
        stream.writeUTFBytes(haxe.Json.stringify(settingsJSON));
        stream.close();
        saveFile = null;
        stream = null;
        */
    }
}
