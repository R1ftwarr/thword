package com.educationcurb.thword.view;

import robotlegs.bender.bundles.mvcs.Mediator;
import com.educationcurb.thword.model.GlobalVO;
import com.educationcurb.thword.signal.MainNavSignal;

@:rtti
@:keepSub
class SinglePlayerMenuMediator extends Mediator
{
    @inject public var view:SinglePlayerMenu;
    @inject public var globalVO:GlobalVO;
    @inject public var mainNavSignal:MainNavSignal;

    public function new():Void
    {

    }

    override public function initialize():Void
    {
        view.init(globalVO);
        addMediatorListeners();
    }

    private function addMediatorListeners():Void
    {
        view.navBack.add(onNavBack);
        view.startGame.add(onStartGame);
    }

    private function onNavBack():Void
    {
        mainNavSignal.showMainView.dispatch();
    }

    private function onStartGame():Void
    {
        mainNavSignal.showGame.dispatch();
    }
}