package com.educationcurb.thword.filemanagement;

//import flash.filesystem.File;
//import flash.filesystem.FileMode;
//import flash.filesystem.FileStream;
//import flash.utils.ByteArray;

import openfl.utils.ByteArray;

class BandaidData
{
    private static var instance : BandaidData;
    
    //@:meta(Embed(source="../assets/data/bandaid-data.js",mimeType="application/octet-stream"))
    //private static var bandaidFile : Class<Dynamic>;
    
    private var bandaidJSON : Dynamic;
    
    public function new()
    {
    }
    
    public static function getInstance() : BandaidData
    {
        if (instance == null)
        {
            instance = new BandaidData();
        }
        return instance;
    }
    
    /*
    private function loadFile() : Void
    {
        var f : File = File.applicationStorageDirectory.resolvePath("bandaid-data.js");
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
            bandaidJSON = haxe.Json.parse(sContent);
        }
        else
        {
            var barScore : ByteArray;
            barScore = Type.createInstance(bandaidFile, []);
            var str : String = barScore.readMultiByte(barScore.bytesAvailable, barScore.endian);
            bandaidJSON = haxe.Json.parse(str);
        }


    }
    
    public function getBandaidCount() : Int
    {

        loadFile();
        var bandaidCount : Int = as3hx.Compat.parseFloat(bandaidJSON.data.count);
        
        trace("bandaidCount=" + bandaidCount);
        
        return bandaidCount;

    }
    
    public function removeBandaid() : Void
    {
        loadFile();
        
        if (bandaidJSON.data.count > 0)
        {
            bandaidJSON.data.count = as3hx.Compat.parseFloat(bandaidJSON.data.count) - 1;
            bandaidJSON.data.totalused = as3hx.Compat.parseFloat(bandaidJSON.data.totalused) + 1;
            
            
            var saveFile : File = File.applicationStorageDirectory.resolvePath("bandaid-data.js");
            var stream : FileStream = new FileStream();
            stream.open(saveFile, FileMode.WRITE);
            stream.writeUTFBytes(haxe.Json.stringify(bandaidJSON));
            stream.close();
            saveFile = null;
            stream = null;
        }
    }
    
    public function addBandaids(cnt : Int, purchased : Bool = false) : Void
    {
        loadFile();
        
        bandaidJSON.data.count = as3hx.Compat.parseFloat(bandaidJSON.data.count) + cnt;
        if (purchased)
        {
            bandaidJSON.data.totalPurchased = as3hx.Compat.parseFloat(bandaidJSON.data.totalPurchased) + cnt;
        }
        else
        {
            bandaidJSON.data.totalWon = as3hx.Compat.parseFloat(bandaidJSON.data.totalWon) + cnt;
        }
        
        var saveFile : File = File.applicationStorageDirectory.resolvePath("bandaid-data.js");
        var stream : FileStream = new FileStream();
        stream.open(saveFile, FileMode.WRITE);
        stream.writeUTFBytes(haxe.Json.stringify(bandaidJSON));
        stream.close();
        saveFile = null;
        stream = null;
    }
    
    public function getEndurance() : Bool
    {
        loadFile();
        var result : Bool = bandaidJSON.data.endurance;
        return result;
    }
    
    public function setEndurance() : Void
    {
        loadFile();
        bandaidJSON.data.endurance = true;
        //bandaidJSON.data.endurance = false;
        var saveFile : File = File.applicationStorageDirectory.resolvePath("bandaid-data.js");
        var stream : FileStream = new FileStream();
        stream.open(saveFile, FileMode.WRITE);
        stream.writeUTFBytes(haxe.Json.stringify(bandaidJSON));
        stream.close();
        saveFile = null;
        stream = null;
    }
    */
}
