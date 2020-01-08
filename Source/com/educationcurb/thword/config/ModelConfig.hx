package com.educationcurb.thword.config;

import com.educationcurb.thword.model.GlobalVO;
import robotlegs.bender.framework.api.IConfig;
import robotlegs.bender.framework.api.IInjector;

@:rtti
@:keepSub
class ModelConfig implements IConfig
{
    @inject public var injector:IInjector;

    public function new() { }

    public function configure():Void
    {
        injector.map(GlobalVO).asSingleton();
    }
}