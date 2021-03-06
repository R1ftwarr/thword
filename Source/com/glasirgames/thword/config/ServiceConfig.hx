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

package com.glasirgames.thword.config;

import com.glasirgames.thword.services.LoadGlobalService;

import robotlegs.bender.framework.api.IConfig;
import robotlegs.bender.framework.api.IInjector;

@:rtti
@:keepSub
class ServiceConfig implements IConfig
{
    @inject public var injector:IInjector;

    public function new() { }

    public function configure():Void
    {
        injector.map(LoadGlobalService).asSingleton();
    }
}