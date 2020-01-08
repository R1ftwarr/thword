package com.educationcurb.thword.view;

import com.educationcurb.thword.signal.MainNavSignal;
import robotlegs.bender.bundles.mvcs.Mediator;
import com.educationcurb.thword.model.GlobalVO;

@:rtti
@:keepSub
class MainStarlingMediator extends Mediator
{
    @inject public var view:MainStarlingLayer;

    @inject public var mainNavSignal:MainNavSignal;

    @inject public var globalVO:GlobalVO;

    //@inject public var gameModel:GameModel;

    public function new():Void
    {

    }

    override public function initialize():Void
    {
        view.init();
        addMediatorListeners();
    }

    private function addMediatorListeners():Void
    {
        mainNavSignal.showMainView.add(onShowMainMenu);
        mainNavSignal.showSinglePlayerMenu.add(onShowSinglePlayerMenu);
        mainNavSignal.showGame.add(onShowGame);
        mainNavSignal.showAbout.add(onShowAbout);
        mainNavSignal.showInstructions.add(onShowInstructions);
    }

    private function onShowMainMenu():Void
    {
        view.showMainMenu(globalVO);
    }

    private function onShowSinglePlayerMenu():Void
    {
        view.showSinglePlayerMenu();
    }

    private function onShowGame() {
        view.showGame();
    }

    private function onShowAbout() {
        view.showAbout();
    }

    private function onShowInstructions() {
        view.showInstructions();
    }
}