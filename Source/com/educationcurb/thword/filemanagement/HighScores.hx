package com.educationcurb.thword.filemanagement;

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
