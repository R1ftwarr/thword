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

package com.glasirgames.thword.filemanagement;

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
