package com.iliacmd.fconsole.stdio
{
	public class ConsoleOut implements IConsoleIO
	{
		private var _buffer:Array;
		
		public function ConsoleOut()
		{
			_buffer = [];
		}
		
		public function write(data:Object){
			_buffer.push( data );
		}
	}
}