package com.iliacmd.fconsole.plugins
{
	import flash.events.Event;
	
	public class PluginCommandEvent extends Event
	{
		public static const COMMAND_START:String = 'COMMAND_START';
		public static const COMMAND_STOP:String = 'COMMAND_STOP';
		public static const COMMAND_PROGRESS:String = 'COMMAND_PROGRESS';		
		
		private var _buffer:String = '';
		public function PluginCommandEvent(type:String, buffer:String='', bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_buffer = buffer;
		}
		
		public function get buffer():String{
			return _buffer;
		}
	}
}