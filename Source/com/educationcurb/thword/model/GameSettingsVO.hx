package com.educationcurb.thword.model;


class GameSettingsVO
{
    private static var instance : GameSettingsVO;
    
    public var gameType : String;
    public var letterCount : Int;
    public var difficultyLevel : Int;
    
    public var musicIndexMenu : Int = 1;
    public var musicIndexGame : Int = 0;
    
    public function new()
    {
    }
    
    public static function getInstance() : GameSettingsVO
    {
        if (instance == null)
        {
            instance = new GameSettingsVO();
        }
        return instance;
    }
}
