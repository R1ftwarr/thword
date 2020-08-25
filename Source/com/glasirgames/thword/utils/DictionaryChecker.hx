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

class DictionaryChecker
{
    private static var instance : DictionaryChecker;
    
    private var dictArr : Array<Dynamic>;
    private var points : Array<Dynamic> = [0, 10, 20, 40, 60, 80, 100, 200, 300, 400, 500, 700, 800, 1000, 1000, 1000, 2000, 5000, 5000, 5000, 5000, 5000, 5000, 5000, 5000, 5000, 5000];
    
    private var timePoints : Array<Dynamic> = [2, 4, 6, 12, 16, 18, 20, 24, 28, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30];
    
    private var aArr : Array<Dynamic> = new Array<Dynamic>();
    private var bArr : Array<Dynamic> = new Array<Dynamic>();
    private var cArr : Array<Dynamic> = new Array<Dynamic>();
    private var dArr : Array<Dynamic> = new Array<Dynamic>();
    private var eArr : Array<Dynamic> = new Array<Dynamic>();
    private var fArr : Array<Dynamic> = new Array<Dynamic>();
    private var gArr : Array<Dynamic> = new Array<Dynamic>();
    private var hArr : Array<Dynamic> = new Array<Dynamic>();
    private var iArr : Array<Dynamic> = new Array<Dynamic>();
    private var jArr : Array<Dynamic> = new Array<Dynamic>();
    private var kArr : Array<Dynamic> = new Array<Dynamic>();
    private var lArr : Array<Dynamic> = new Array<Dynamic>();
    private var mArr : Array<Dynamic> = new Array<Dynamic>();
    private var nArr : Array<Dynamic> = new Array<Dynamic>();
    private var oArr : Array<Dynamic> = new Array<Dynamic>();
    private var pArr : Array<Dynamic> = new Array<Dynamic>();
    private var qArr : Array<Dynamic> = new Array<Dynamic>();
    private var rArr : Array<Dynamic> = new Array<Dynamic>();
    private var sArr : Array<Dynamic> = new Array<Dynamic>();
    private var tArr : Array<Dynamic> = new Array<Dynamic>();
    private var uArr : Array<Dynamic> = new Array<Dynamic>();
    private var vArr : Array<Dynamic> = new Array<Dynamic>();
    private var wArr : Array<Dynamic> = new Array<Dynamic>();
    private var xArr : Array<Dynamic> = new Array<Dynamic>();
    private var yArr : Array<Dynamic> = new Array<Dynamic>();
    private var zArr : Array<Dynamic> = new Array<Dynamic>();
    
    public function new()
    {
    }
    
    public static function getInstance() : DictionaryChecker
    {
        if (instance == null)
        {
            instance = new DictionaryChecker();
        }
        return instance;
    }
    
    public function startLoad(dictStr:String) : Void
    {
        dictArr = new Array<Dynamic>();

        dictArr = dictStr.split("\n");
        var i : Int = 0;
        while (i < dictArr.length)
        {
            buildArray(StringTools.trim(dictArr[i]));
            i++;
        }
        dictArr = null;
    }
    
    public function checkWord(word : String) : Bool
    {
        var found : Bool = false;
        
        var lt : String = word.charAt(0).toUpperCase();
        found = checkArrays(lt, word);
        
        return found;
    }
    
    public function checkPoints(wordLength : Int) : Int
    {
        return points[wordLength];
    }
    
    public function checkTimePoints(wordLength : Int) : Int
    {
        return timePoints[wordLength];
    }
    
    private function checkArrays(lt : String, word : String) : Bool
    {
        var found : Bool = false;
        
        switch (lt)
        {
            case "A":
                found = checkSingleArray(word, aArr);
            case "B":
                found = checkSingleArray(word, bArr);
            case "C":
                found = checkSingleArray(word, cArr);
            case "D":
                found = checkSingleArray(word, dArr);
            case "E":
                found = checkSingleArray(word, eArr);
            case "F":
                found = checkSingleArray(word, fArr);
            case "G":
                found = checkSingleArray(word, gArr);
            case "H":
                found = checkSingleArray(word, hArr);
            case "I":
                found = checkSingleArray(word, iArr);
            case "J":
                found = checkSingleArray(word, jArr);
            case "K":
                found = checkSingleArray(word, kArr);
            case "L":
                found = checkSingleArray(word, lArr);
            case "M":
                found = checkSingleArray(word, mArr);
            case "N":
                found = checkSingleArray(word, nArr);
            case "O":
                found = checkSingleArray(word, oArr);
            case "P":
                found = checkSingleArray(word, pArr);
            case "Q":
                found = checkSingleArray(word, qArr);
            case "R":
                found = checkSingleArray(word, rArr);
            case "S":
                found = checkSingleArray(word, sArr);
            case "T":
                found = checkSingleArray(word, tArr);
            case "U":
                found = checkSingleArray(word, uArr);
            case "V":
                found = checkSingleArray(word, vArr);
            case "W":
                found = checkSingleArray(word, wArr);
            case "X":
                found = checkSingleArray(word, xArr);
            case "Y":
                found = checkSingleArray(word, yArr);
            case "Z":
                found = checkSingleArray(word, zArr);
        }
        
        return found;
    }
    
    private function checkSingleArray(word : String, arr : Array<Dynamic>) : Bool
    {
        var found : Bool = false;
        var i : Int = 0;
        while (i < arr.length)
        {
            if (word.toUpperCase() == arr[i].toUpperCase())
            {
                found = true;
                break;
            }
            i++;
        }
        return found;
    }
    
    private function buildArray(word : String) : Void
    {
        var lt : String = word.charAt(0).toUpperCase();
        
        switch (lt)
        {
            case "A":
                aArr.push(word);
            case "B":
                bArr.push(word);
            case "C":
                cArr.push(word);
            case "D":
                dArr.push(word);
            case "E":
                eArr.push(word);
            case "F":
                fArr.push(word);
            case "G":
                gArr.push(word);
            case "H":
                hArr.push(word);
            case "I":
                iArr.push(word);
            case "J":
                jArr.push(word);
            case "K":
                kArr.push(word);
            case "L":
                lArr.push(word);
            case "M":
                mArr.push(word);
            case "N":
                nArr.push(word);
            case "O":
                oArr.push(word);
            case "P":
                pArr.push(word);
            case "Q":
                qArr.push(word);
            case "R":
                rArr.push(word);
            case "S":
                sArr.push(word);
            case "T":
                tArr.push(word);
            case "U":
                uArr.push(word);
            case "V":
                vArr.push(word);
            case "W":
                wArr.push(word);
            case "X":
                xArr.push(word);
            case "Y":
                yArr.push(word);
            case "Z":
                zArr.push(word);
        }
    }
}
