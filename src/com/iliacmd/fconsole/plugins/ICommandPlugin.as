package com.iliacmd.fconsole.plugins
{
	import flash.events.IEventDispatcher;

	public interface ICommandPlugin extends IEventDispatcher
	{
		function get out():String; 
		function execute(args:Array):void;
	}
}