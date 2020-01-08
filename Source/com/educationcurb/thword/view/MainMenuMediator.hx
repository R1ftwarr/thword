package com.educationcurb.thword.view;

import com.educationcurb.thword.model.GlobalVO;
//import com.educationcurb.spellnow.model.GameModel;
import com.educationcurb.thword.signal.MainNavSignal;
import robotlegs.bender.bundles.mvcs.Mediator;

@:rtti
@:keepSub
class MainMenuMediator extends Mediator
{
    @inject public var view:MainMenuView;
    @inject public var mainNavSignal:MainNavSignal;

    //@inject public var model:GameModel;
    @inject public var globalVO:GlobalVO;

    public function new() {}

    override public function initialize():Void
    {
        view.init(globalVO);
        view.showSinglePlayerMenu.add(onShowSingleMenu);
        view.aboutMenu.add(onShowAbout);
        view.showIntructions.add(onShowInstuctions);
    }

    private function onShowSingleMenu():Void 
    {
        mainNavSignal.showSinglePlayerMenu.dispatch();
    }

    private function onShowAbout() 
    {
        mainNavSignal.showAbout.dispatch();
    }

    private function onShowInstuctions() 
    {
        mainNavSignal.showInstructions.dispatch();
    }

    private function onStartGame():Void
    {
        mainNavSignal.showLoaderView.dispatch();
    }
}