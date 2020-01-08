package com.educationcurb.thword.view;

import com.educationcurb.thword.signal.LoadGlobalSignal;
import com.educationcurb.thword.signal.MainNavSignal;
import robotlegs.bender.bundles.mvcs.Mediator;

class LoaderGlobalMediator extends Mediator
{
    @inject public var view:LoaderGlobalView;
    @inject public var mainNavSignal:MainNavSignal;
    @inject public var loaderSignal:LoadGlobalSignal;

    public function new() {}

    override public function initialize():Void
    {
        view.init();
        addMediatorListeners();
        loaderSignal.dispatch();
    }

    private function addMediatorListeners():Void
    {
        loaderSignal.completed.add(onLoadSuccessful);
        loaderSignal.failed.add(onLoadFailed);
        loaderSignal.percent.add(onPercent);
    }

    private function removeMediatorListeners():Void
    {
        loaderSignal.completed.removeAll();
        loaderSignal.failed.removeAll();
        loaderSignal.percent.removeAll();
    }

    private function onPercent(percent:Float):Void
    {
        view.setPercentage(percent);
    }

    private function onLoadSuccessful():Void
    {
        trace("LOAD SUCCESSFUL");
        removeMediatorListeners();
        mainNavSignal.showMainView.dispatch();
    }

    private function onLoadFailed(err:Dynamic):Void
    {
        trace("LOAD FAILED");
        removeMediatorListeners();
    }
}
