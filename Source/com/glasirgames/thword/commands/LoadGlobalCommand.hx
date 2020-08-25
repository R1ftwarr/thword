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

package com.glasirgames.thword.commands;

import com.glasirgames.thword.signal.LoadGlobalSignal;
import com.glasirgames.thword.services.LoadGlobalService;
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
