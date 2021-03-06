//------------------------------------------------------------------------------
//  Copyright (c) 2009-2013 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.commandCenter.api;

import robotlegs.bender.framework.impl.Guard;
import robotlegs.bender.framework.impl.Hook;

/**
 * @private
 */
interface ICommandMapping {
	/**
	 * The concrete Command Class<Dynamic> for this mapping
	 */
	public var commandClass(get, null):Class<Dynamic>;

	/**
	 * The "execute" method to invoke on the Command instance
	 */
	public var executeMethod(get, null):String;

	/**
	 * A list of Guards to query before execution
	 */
	public var guards(get, null):Array<Guard>;

	/**
	 * A list of Hooks to run during execution
	 */
	public var hooks(get, null):Array<Dynamic>;

	/**
	 * Unmaps a Command after a successful execution
	 */
	public var fireOnce(get, null):Bool;

	/**
	 * Supply the payload values via instance injection
	 */
	public var payloadInjectionEnabled(get, null):Bool;

	/**
	 * The "execute" method to invoke on the Command instance
	 */
	function setExecuteMethod(name:String):ICommandMapping;

	/**
	 * A list of Guards to query before execution
	 */
	function addGuards(?guards:Array<Guard>, ?guard:Guard):ICommandMapping;

	/**
	 * A list of Hooks to run during execution
	 */
	function addHooks(?hooks:Array<Hook>, ?hook:Hook):ICommandMapping;

	/**
	 * Unmaps a Command after a successful execution
	 */
	function setFireOnce(value:Bool):ICommandMapping;

	/**
	 * Supply the payload values via instance injection
	 */
	function setPayloadInjectionEnabled(value:Bool):ICommandMapping;
}
