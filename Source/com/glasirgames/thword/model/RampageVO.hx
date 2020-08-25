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

package com.glasirgames.thword.model;

class RampageVO
{
    private static var instance : RampageVO;
    
    public var selectedLevel : Int;
    public var letterCount : Int;
    
    private var mixedLetters : Array<Dynamic>;
    
    private var selectedLetters : Array<Dynamic>;
    private var selectedU : Bool;
    
    private var vowels : Array<Dynamic> = ["A", "E", "I", "O", "U"];
    private var regular : Array<Dynamic> = ["L", "N", "R", "S", "T", "D", "G", "B", "C", "M", "P"];
    private var irregular : Array<Dynamic> = ["F", "H", "V", "W", "Y", "K", "J", "X", "Q", "Z"];
    
    private var cCount : Int = 0;
    private var uCount : Int = 0;
    private var jCount : Int = 0;
    private var qCount : Int = 0;
    private var xCount : Int = 0;
    private var yCount : Int = 0;
    private var zCount : Int = 0;
    
    public function new()
    {
    }
    
    public static function getInstance() : RampageVO
    {
        if (instance == null)
        {
            instance = new RampageVO();
        }
        return instance;
    }
    
    public function getLetters() : Array<Dynamic>
    {
        cCount = 0;
        uCount = 0;
        jCount = 0;
        qCount = 0;
        xCount = 0;
        yCount = 0;
        zCount = 0;
        
        selectedLetters = new Array<Dynamic>();
        mixedLetters = new Array<Dynamic>();
        selectedU = false;
        
        switch (letterCount)
        {
            case 9:
                generateNine();
            case 12:
                generateTwelve();
        }
        randomise();
        
        vowels = ["A", "E", "I", "O", "U"];
        regular = ["L", "N", "R", "S", "T", "D", "G", "B", "C", "M", "P"];
        irregular = ["F", "H", "V", "W", "Y", "K", "J", "X", "Q", "Z"];
        
        return mixedLetters;
    }
    
    public function getNewLetter(oldLetter : String) : String
    {
        var newLetter : String = "";
        var isVowel : Bool = false;
        var isRegular : Bool = false;
        var isIrregular : Bool = false;
        var i : Int = 0;
        while (i < vowels.length)
        {
            if (oldLetter == vowels[i])
            {
                isVowel = true;
                break;
            }
            i++;
        }
        
        var ii : Int = 0;
        while (ii < regular.length)
        {
            if (oldLetter == regular[ii])
            {
                isRegular = true;
                break;
            }
            ii++;
        }
        
        var iii : Int = 0;
        while (iii < irregular.length)
        {
            if (oldLetter == irregular[iii])
            {
                isIrregular = true;
                break;
            }
            iii++;
        }
        
        if (isVowel)
        {
            newLetter = getNewVowel(oldLetter);
        }
        else if (isRegular)
        {
            newLetter = getNewRegular(oldLetter);
        }
        else if (isIrregular)
        {
            newLetter = getNewIrregular(oldLetter);
        }
        
        return newLetter;
    }
    
    private function getNewVowel(oldLetter : String) : String
    {
        minusCrazyLetters(oldLetter);
        var tmp : Array<Dynamic> = getTrimmedVowelArr();
        var ran : Int = Std.int(Math.random() * tmp.length);
        checkLetterType(tmp[ran]);
        return tmp[ran];
    }
    
    private function getNewRegular(oldLetter : String) : String
    {
        minusCrazyLetters(oldLetter);
        var tmp : Array<Dynamic> = getTrimmedRegularArr();
        var ran : Int = Std.int(Math.random() * tmp.length);
        checkLetterType(tmp[ran]);
        return tmp[ran];
    }
    
    private function getNewIrregular(oldLetter : String) : String
    {
        minusCrazyLetters(oldLetter);
        var tmp : Array<Dynamic> = getTrimmedIrregularArr();
        var ran : Int = Std.int(Math.random() * tmp.length);
        checkLetterType(tmp[ran]);
        return tmp[ran];
    }
    
    private function getTrimmedVowelArr() : Array<Dynamic>
    {
        var tmp : Array<Dynamic> = ["A", "E", "I", "O", "U"];
        
        if (uCount == 2)
        {
            tmp = trimArray(tmp, "U");
        }
        
        return tmp;
    }
    
    private function getTrimmedRegularArr() : Array<Dynamic>
    {
        var tmp : Array<Dynamic> = ["L", "N", "R", "S", "T", "D", "G", "B", "C", "M", "P"];
        
        if (cCount == 2)
        {
            tmp = trimArray(tmp, "C");
        }
        
        return tmp;
    }
    
    private function getTrimmedIrregularArr() : Array<Dynamic>
    {
        var tmp : Array<Dynamic> = ["F", "H", "V", "W", "Y", "K", "J", "X", "Q", "Z"];
        
        if (jCount == 1)
        {
            tmp = trimArray(tmp, "J");
        }
        
        if (qCount == 1)
        {
            tmp = trimArray(tmp, "Q");
        }
        
        if (xCount == 1)
        {
            tmp = trimArray(tmp, "X");
        }
        
        if (yCount == 1)
        {
            tmp = trimArray(tmp, "Y");
        }
        
        if (zCount == 2)
        {
            tmp = trimArray(tmp, "Z");
        }
        
        return tmp;
    }
    
    private function trimArray(tmp : Array<Dynamic>, ltr : String) : Array<Dynamic>
    {
        var i : Int = 0;
        while (i < tmp.length)
        {
            if (tmp[i] == ltr)
            {
                tmp.splice(i, 1);
                break;
            }
            i++;
        }
        return tmp;
    }
    
    private function minusCrazyLetters(oldLetter : String) : Void
    {
        switch (oldLetter)
        {
            case "U":
                uCount--;
            case "C":
                cCount--;
            case "J":
                jCount--;
            case "Q":
                qCount--;
            case "X":
                xCount--;
            case "Y":
                yCount--;
            case "Z":
                zCount--;
        }
    }
    
    private function generateNine() : Void
    {
        switch (selectedLevel)
        {
            case 1:
                getVowels(4);
                getRegular(5);
                getIrregular(0);
            case 2:
                getVowels(3);
                getRegular(6);
                getIrregular(0);
            case 3:
                getVowels(3);
                getRegular(5);
                getIrregular(1);
            case 4:
                getVowels(3);
                getRegular(4);
                getIrregular(2);
            case 5:
                getVowels(3);
                getRegular(3);
                getIrregular(3);
            case 6:
                getVowels(3);
                getRegular(3);
                getIrregular(3);
            case 7:
                getVowels(3);
                getRegular(2);
                getIrregular(4);
            case 8:
                getVowels(3);
                getRegular(1);
                getIrregular(5);
            case 9:
                getVowels(4);
                getRegular(0);
                getIrregular(5);
            case 10:
                getVowels(3);
                getRegular(0);
                getIrregular(6);
        }
    }
    
    private function generateTwelve() : Void
    {
        switch (selectedLevel)
        {
            case 1:
                getVowels(4);
                getRegular(8);
                getIrregular(0);
            case 2:
                getVowels(4);
                getRegular(7);
                getIrregular(1);
            case 3:
                getVowels(4);
                getRegular(6);
                getIrregular(2);
            case 4:
                getVowels(4);
                getRegular(5);
                getIrregular(3);
            case 5:
                getVowels(4);
                getRegular(4);
                getIrregular(4);
            case 6:
                getVowels(4);
                getRegular(3);
                getIrregular(5);
            case 7:
                getVowels(4);
                getRegular(2);
                getIrregular(6);
            case 8:
                getVowels(4);
                getRegular(1);
                getIrregular(7);
            case 9:
                getVowels(4);
                getRegular(0);
                getIrregular(8);
            case 10:
                getVowels(3);
                getRegular(1);
                getIrregular(8);
        }
    }
    
    private function getVowels(num : Int) : Void
    {
        var tmp : Array<Dynamic> = vowels;
        for (i in 0...num)
        {
            var ran : Int = Std.int(Math.random() * tmp.length);
            checkLetterType(tmp[ran]);
            selectedLetters.push(tmp[ran]);
            tmp.splice(ran, 1);
        }
    }
    
    private function getRegular(num : Int) : Void
    {
        var tmp : Array<Dynamic> = regular;
        for (i in 0...num)
        {
            var ran : Int = Std.int(Math.random() * tmp.length);
            checkLetterType(tmp[ran]);
            selectedLetters.push(tmp[ran]);
            tmp.splice(ran, 1);
        }
    }
    
    private function getIrregular(num : Int) : Void
    {
        var tmp : Array<Dynamic> = irregular;
        for (i in 0...num)
        {
            var ran : Int = Std.int(Math.random() * tmp.length);
            checkLetterType(tmp[ran]);
            selectedLetters.push(tmp[ran]);
            tmp.splice(ran, 1);
        }
    }
    
    private function checkLetterType(ltr : String) : Void
    {
        switch (ltr)
        {
            case "C":
                cCount++;
            case "U":
                uCount++;
            case "J":
                jCount++;
            case "Q":
                qCount++;
            case "X":
                xCount++;
            case "Y":
                yCount++;
            case "Z":
                zCount++;
        }
    }
    
    private function randomise() : Void
    {
        for (i in 0...letterCount)
        {
            var ran : Int = Std.int(Math.random() * selectedLetters.length);
            mixedLetters.push(selectedLetters[ran]);
            selectedLetters.splice(ran, 1);
        }
    }
}
