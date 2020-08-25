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

package com.glasirgames.thword.signal;

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
