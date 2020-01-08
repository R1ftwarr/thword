package com.educationcurb.thword.signal;

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
