package com.educationcurb.thword.config;

import com.educationcurb.thword.view.MainStarlingLayer;
import com.educationcurb.thword.view.MainStarlingMediator;
import com.educationcurb.thword.signal.MainNavSignal;
import com.educationcurb.thword.view.LoaderGlobalMediator;
import com.educationcurb.thword.view.LoaderGlobalView;
import com.educationcurb.thword.view.MainMenuMediator;
import com.educationcurb.thword.view.MainMenuView;
import com.educationcurb.thword.view.SinglePlayerMenuMediator;
import com.educationcurb.thword.view.SinglePlayerMenu;
import com.educationcurb.thword.view.SingleRampageMediator;
import com.educationcurb.thword.view.SingleRampage;
import com.educationcurb.thword.view.SingleEnduranceMediator;
import com.educationcurb.thword.view.SingleEndurance;
import com.educationcurb.thword.view.AboutMenuMediator;
import com.educationcurb.thword.view.AboutMenu;
import com.educationcurb.thword.view.InstructionMediator;
import com.educationcurb.thword.view.Instruction;


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
        //_starling.simulateMultitouch = true;
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