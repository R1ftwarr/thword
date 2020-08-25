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

class StrUtil {
    inline public static function CleanWord(word:String):String
    {
        word = StringTools.replace(word, "/", "");
        word = StringTools.replace(word, ".", "");
        word = StringTools.replace(word, "?", "");
        word = StringTools.replace(word, "!", "");
        word = StringTools.replace(word, ",", "");
        word = StringTools.replace(word, "'", "");

        return word;
    }

    inline public static function CleanWordSlash(word:String):String
    {
        word = StringTools.replace(word, "/", "");
        word = StringTools.replace(word, ".", "");
        word = StringTools.replace(word, "?", "");
        word = StringTools.replace(word, "!", "");
        word = StringTools.replace(word, ",", "");
        word = StringTools.replace(word, "'", "");
        return word;
    }


    inline public static function CleanEscapeChar(word:String):String
    {
        word = StringTools.replace(word, "/", "");
        word = StringTools.replace(word, "1", "");
        return word;
    }

    inline public static function CleanEscapeCharFromSentence(sentence:String):String
    {
        sentence = sentence.split("/'").join("'");
        return sentence;
    }

    inline public static function CleanCrazyChars(txt:String):String
    {
        txt = txt.split("ƒ").join("");
        return txt;
    }
}