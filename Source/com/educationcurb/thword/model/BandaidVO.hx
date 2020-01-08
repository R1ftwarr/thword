package com.educationcurb.thword.model;


class BandaidVO
{
    private static var instance : BandaidVO;
    
    public var enabled : Bool = false;
    public var count : Int = 0;
    
    public function new()
    {
    }
    
    public static function getInstance() : BandaidVO
    {
        if (instance == null)
        {
            instance = new BandaidVO();
        }
        return instance;
    }
}
