package com.iliacmd.fconsole.plugins{
	import flash.events.EventDispatcher;

	public class ConsolePlugin extends EventDispatcher implements IConsolePlugin{
		
		protected var _name:String;
		
		public function ConsolePlugin()
		{
		}
		
		public function get name():String{
			return _name;
		}
		
		public function execute(command:String, args:Array):void
		{
		}


	}
}