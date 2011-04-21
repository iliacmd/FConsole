package com.iliacmd.fconsole.plugins
{
	import flash.events.IEventDispatcher;

	public interface IConsolePlugin extends IEventDispatcher{
		function get name():String;
		function execute(command:String, args:Array):void;	
	}
	
}