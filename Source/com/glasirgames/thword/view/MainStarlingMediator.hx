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

import com.glasirgames.thword.signal.MainNavSignal;
import robotlegs.bender.bundles.mvcs.Mediator;
import com.glasirgames.thword.model.GlobalVO;

@:rtti
@:keepSub
class MainStarlingMediator extends Mediator
{
    @inject public var view:MainStarlingLayer;

    @inject public var mainNavSignal:MainNavSignal;

    @inject public var globalVO:GlobalVO;

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