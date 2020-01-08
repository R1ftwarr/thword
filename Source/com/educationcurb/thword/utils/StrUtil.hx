package com.educationcurb.thword.utils;
class StrUtil {
    //public function new() {}

    inline public static function CleanWord(word:String):String
    {
        //word = word.replace("/", "").replace(".", "").replace("?", "").replace("!", "").replace(",", "").replace("'", "");
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
        //word = word.replace("/", "").replace(".", "").replace("?", "").replace("!", "").replace(",", "").replace(" ","");
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
        //word = word.replace("1", "");
        //word = word.replace("/", "");
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
