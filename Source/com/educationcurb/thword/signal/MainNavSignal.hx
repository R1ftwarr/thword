package com.educationcurb.thword.signal;
import msignal.Signal.Signal0;

@:rtti
@:keepSub
class MainNavSignal
{   
    public var showLoaderView:Signal0;
    public var showMainView:Signal0;
    public var showSinglePlayerMenu:Signal0;    
    public var showGame:Signal0;
    public var showAbout:Signal0;
    public var showInstructions:Signal0;

    public function new()
    {
        showMainView = new Signal0();
        showSinglePlayerMenu = new Signal0();
        showGame  = new Signal0();
        showAbout = new Signal0();
        showInstructions = new Signal0();
    }
}
