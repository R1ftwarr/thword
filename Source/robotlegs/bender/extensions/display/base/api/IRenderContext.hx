package robotlegs.bender.extensions.display.base.api;

import robotlegs.signal.Signal.Signal0;
import openfl.display.BitmapData;

/**
 * @author P.J.Shand
 */
interface IRenderContext 
{
	var antiAlias:Int;
	var contextDisposed(default, set):Null<Bool>;
	var contextDisposeChange:Signal0;
	
	var onReady(default, null):Signal0;
	var available(get, null):Bool;
	
	function setup(options:Dynamic):Void;
	function begin():Void;
	function end():Void;
	function checkVisability():Void;
	function snap(width:Int, height:Int):BitmapData;
}