package com.educationcurb.thword.config;

import com.educationcurb.thword.signal.LoadGlobalSignal;
import com.educationcurb.thword.commands.LoadGlobalCommand;
//import com.educationcurb.thword.commands.LoadGameCommand;
//import com.educationcurb.thword.signal.LoadGameSignal;
import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
import robotlegs.bender.framework.api.IConfig;


@:rtti
@:keepSub
class CommandConfig implements IConfig
{
    @inject public var commandMap:ISignalCommandMap;
    //@inject public var injector:IInjector;

    public function new() { }

    public function configure():Void
    {
        commandMap.map(LoadGlobalSignal).toCommand(LoadGlobalCommand);
        //commandMap.map(LoadGameSignal).toCommand(LoadGameCommand);
    }
}