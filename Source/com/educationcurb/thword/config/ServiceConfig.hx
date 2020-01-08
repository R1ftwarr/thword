package com.educationcurb.thword.config;

import com.educationcurb.thword.services.LoadGlobalService;

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