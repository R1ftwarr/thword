package com.educationcurb.thword.commands;

import com.educationcurb.thword.signal.LoadGlobalSignal;
import com.educationcurb.thword.services.LoadGlobalService;
import robotlegs.bender.bundles.mvcs.Command;


@:rtti
@:keepSub
class LoadGlobalCommand  extends Command
{
   @inject public var service:LoadGlobalService;
   @inject public var signal:LoadGlobalSignal;

    public function new() {}

    override public function execute():Void
    {
        addServiceListeners();
        service.loadGlobalAssets();
    }


    private function addServiceListeners():Void
    {
        service.completed.addOnce(onGetAssetsSuccessful);
        service.failed.addOnce(onGetAssetsFailed);
        service.percent.add(onPercent);
    }

    private function onPercent(percent:Float):Void
    {
        signal.percent.dispatch(percent);
    }

    private function onGetAssetsSuccessful():Void
    {
        service.percent.removeAll();
        service.failed.removeAll();
        signal.completed.dispatch();
    }

    private function onGetAssetsFailed(err:Dynamic):Void
    {
        service.percent.removeAll();
        service.completed.removeAll();
        signal.failed.dispatch(err);
    }
}
