package com.iliacmd.fconsole.plugins{
	import flash.events.Event;
	
	public class ConsolePluginEvent extends Event{
		
		public static const WRITE_OUTPUT:String = "WRITE_OUTPUT";
		public static const COMPLETE:String = "COMPLETE"		
		public static const UNKNOW_COMMAND:String = "UNKNOW_COMMAND";		
		
		private var _data:Object;
		
		public function ConsolePluginEvent(type:String, data:Object=null, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_data = data;
			
		}
		
		public  function get data():Object{
			return _data;
		}
	}
}