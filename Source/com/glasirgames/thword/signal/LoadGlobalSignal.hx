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

import msignal.Signal.Signal1;
import msignal.Signal.Signal0;

@:rtti
@:keepSub
class LoadGlobalSignal extends Signal0
{
    public var completed:Signal0;
    public var failed:Signal1<Dynamic>;
    public var percent:Signal1<Float>;

    public function new()
    {
        super();
        completed = new Signal0();
        failed = new Signal1<Dynamic>();
        percent = new Signal1<Float>();
    }
}
