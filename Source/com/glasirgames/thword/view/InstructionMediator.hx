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

import robotlegs.bender.bundles.mvcs.Mediator;
import com.glasirgames.thword.model.GlobalVO;
import com.glasirgames.thword.signal.MainNavSignal;

@:rtti
@:keepSub
class InstructionMediator extends Mediator
{
    @inject public var view:Instruction;
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
    }

    private function onNavBack():Void
    {
        mainNavSignal.showMainView.dispatch();
    }
}