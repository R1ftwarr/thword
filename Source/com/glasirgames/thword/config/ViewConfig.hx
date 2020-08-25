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

import com.glasirgames.thword.view.MainStarlingLayer;
import com.glasirgames.thword.view.MainStarlingMediator;
import com.glasirgames.thword.signal.MainNavSignal;
import com.glasirgames.thword.view.LoaderGlobalMediator;
import com.glasirgames.thword.view.LoaderGlobalView;
import com.glasirgames.thword.view.MainMenuMediator;
import com.glasirgames.thword.view.MainMenuView;
import com.glasirgames.thword.view.SinglePlayerMenuMediator;
import com.glasirgames.thword.view.SinglePlayerMenu;
import com.glasirgames.thword.view.SingleRampageMediator;
import com.glasirgames.thword.view.SingleRampage;
import com.glasirgames.thword.view.SingleEnduranceMediator;
import com.glasirgames.thword.view.SingleEndurance;
import com.glasirgames.thword.view.AboutMenuMediator;
import com.glasirgames.thword.view.AboutMenu;
import com.glasirgames.thword.view.InstructionMediator;
import com.glasirgames.thword.view.Instruction;


import openfl.display3D.Context3DRenderMode;
import openfl.system.Capabilities;
import robotlegs.bender.extensions.contextView.ContextView;
import robotlegs.bender.extensions.display.base.api.IRenderer;
import robotlegs.bender.extensions.display.base.api.IStack;
import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
import robotlegs.bender.framework.api.IConfig;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.api.IInjector;
import starling.core.Starling;
import starling.events.Event;
import starling.utils.AssetManager;

@:rtti
@:keepSub
class ViewConfig implements IConfig
{
    @inject public var context:IContext;
    @inject public var commandMap:ISignalCommandMap;
    @inject public var mediatorMap:IMediatorMap;
    @inject public var stack:IStack;
    @inject public var renderer:IRenderer;
    @inject public var contextView:ContextView;

    @inject public var navInjector:IInjector;

    private var _starling:Starling;
    private var _assets:AssetManager;
    private var settings:Settings = Settings.getInstance();

    public function new()
    {

    }

    public function configure():Void
    {
        context.afterInitializing(init);
    }

    private function init():Void
    {
        initStarling();
    }

    private function mapMediators():Void
    {
        mediatorMap.map(MainStarlingLayer).toMediator(MainStarlingMediator);
        mediatorMap.map(LoaderGlobalView).toMediator(LoaderGlobalMediator);
        mediatorMap.map(MainMenuView).toMediator(MainMenuMediator);
        mediatorMap.map(SinglePlayerMenu).toMediator(SinglePlayerMenuMediator);
        mediatorMap.map(SingleRampage).toMediator(SingleRampageMediator);
        mediatorMap.map(SingleEndurance).toMediator(SingleEnduranceMediator);
        mediatorMap.map(AboutMenu).toMediator(AboutMenuMediator);
        mediatorMap.map(Instruction).toMediator(InstructionMediator);
    }

    private function initNav():Void
    {
        navInjector.map(MainNavSignal).asSingleton();
    }

    private function initStarling():Void
    {
        _starling = new Starling(MainStarlingLayer, contextView.view.stage, null, null, Context3DRenderMode.AUTO, "auto");
        _starling.stage.stageWidth = settings.stageWidth;
        _starling.stage.stageHeight = settings.stageHeight;
        _starling.enableErrorChecking = Capabilities.isDebugger;
        _starling.skipUnchangedFrames = true;
        _starling.supportBrowserZoom = true;
        _starling.supportHighResolutions = true;
        _starling.addEventListener(Event.ROOT_CREATED, onStarlingReady);
        _starling.start();
        
    }

    private function onStarlingReady(e:Event):Void
    {
        mapMediators();
        initView();
        initNav();
        _starling.start();
    }

    private function initView():Void
    {
        stack.addLayer(MainStarlingLayer);     
    }
}