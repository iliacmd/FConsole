package com.iliacmd.fconsole{
	import flash.events.Event;
	
	public class FConsoleEvent extends Event{
		
		public static const CONSOLE_INPUT:String = "FCONSOLE_INPUT";
		public static const CONSOLE_OUTPUT:String = "FCONSOLE_OUTPUT";		
		
		private var _data:Object;
		
		public function FConsoleEvent(type:String, data:Object=null, bubbles:Boolean=true, cancelable:Boolean=true)
		{
			super(type, bubbles, cancelable);
			_data = data;
		}
		
		public function get data():Object{
			return _data;
		}
	}
}