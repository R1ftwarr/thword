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

package com.glasirgames.thword.view;

import com.glasirgames.thword.signal.LoadGlobalSignal;
import com.glasirgames.thword.signal.MainNavSignal;
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
        removeMediatorListeners();
        mainNavSignal.showMainView.dispatch();
    }

    private function onLoadFailed(err:Dynamic):Void
    {
        removeMediatorListeners();
    }
}
