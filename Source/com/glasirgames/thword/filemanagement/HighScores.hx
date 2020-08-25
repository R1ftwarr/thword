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

import js.Browser;

class HighScores
{
    private static var instance : HighScores;
   
    public function new()
    {
    }
    
    public static function getInstance() : HighScores
    {
        if (instance == null)
        {
            instance = new HighScores();
        }
        return instance;
    }
       
    //RAMPAGE ---------------------------------------------------------------------------------------
    public function getRampageScore(letters : Int, difficulty : Int) : Int
    {
        var score : Int = 0;

        var scoreKey:String = "RTS" + Std.string(letters) + "L" + Std.string(difficulty);
        if(Browser.getLocalStorage().getItem(scoreKey) != null)
        {
            score = Std.parseInt(Browser.getLocalStorage().getItem(scoreKey));
        } else {
            score = 0;
            Browser.getLocalStorage().setItem(scoreKey, "0");
        }
        return score;
    }
    
    public function saveRampageScore(letters : Int, difficulty : Int, score : Int) : Bool
    {
        var beatHighScore : Bool = false;

        var scoreKey:String = "RTS" + Std.string(letters) + "L" + Std.string(difficulty);

        var topScore:Int = Std.parseInt(Browser.getLocalStorage().getItem(scoreKey));

        if(topScore == null || topScore < score)
        {
            Browser.getLocalStorage().setItem(scoreKey, Std.string(score));
            beatHighScore = true;
        }
        return beatHighScore;
    }
    
    //ENDURANCE --------------------------------------------------------------------------------
    public function getEnduranceScore(letters : Int) : Int
    {     
        var score : Int = 0;
        var scoreKey:String = "ETS" + Std.string(letters) + "L";
        if(Browser.getLocalStorage().getItem(scoreKey) != null)
        {
            score = Std.parseInt(Browser.getLocalStorage().getItem(scoreKey));
        } else {
            score = 0;
            Browser.getLocalStorage().setItem(scoreKey, "0");
        }
        return score;
    }
    
    public function saveEnduranceScore(letters : Int, score : Int) : Bool
    {
        var beatHighScore : Bool = false;
        var scoreKey:String = "ETS" + Std.string(letters) + "L";

        var topScore:Int = Std.parseInt(Browser.getLocalStorage().getItem(scoreKey));

        if(topScore == null || topScore < score)
        {
            Browser.getLocalStorage().setItem(scoreKey, Std.string(score));
            beatHighScore = true;
        }
        return beatHighScore;
    }
}
