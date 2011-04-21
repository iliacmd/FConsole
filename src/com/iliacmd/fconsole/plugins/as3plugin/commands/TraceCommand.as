package com.iliacmd.fconsole.plugins.as3plugin.commands
{
	import com.iliacmd.fconsole.plugins.ConsolePluginEvent;
	import com.iliacmd.fconsole.plugins.ICommandPlugin;
	import com.iliacmd.fconsole.plugins.IConsolePlugin;
	import com.iliacmd.fconsole.plugins.PluginCommandEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.osmf.utils.URL;
	
	public class TraceCommand extends EventDispatcher implements ICommandPlugin
	{
		private var plugin:IConsolePlugin;
		private var output:String = '';
		
		public function TraceCommand(plugin:IConsolePlugin)
		{
			this.plugin = plugin;
		}
		
		public function execute(args:Array):void
		{
				switch(args[0]){
					case 'file':
						traceFile(args[1]);
					break;
					default:
						output += 'Неверно указаны параметры комманды';	
						dispatchEvent( new PluginCommandEvent(PluginCommandEvent.COMMAND_STOP, out) );							
					break;
				}					

		}
		
		private function traceFile(file:String):void{
			try{
				//http://www.filmz.ru/videos/list_playlist.php
				var loader:URLLoader = new URLLoader( new URLRequest(file) );
				loader.addEventListener(Event.COMPLETE, hCompleteLoadTraceFile);	
				loader.addEventListener(IOErrorEvent.IO_ERROR, hIOError );
				output = 'Идёт загрузка файла '+file+'...';
				dispatchEvent( new PluginCommandEvent(PluginCommandEvent.COMMAND_PROGRESS, out) );				
			}catch(e:Error){
				output = 'Ошибка при загрузке файла '+file+'...';
				dispatchEvent( new PluginCommandEvent(PluginCommandEvent.COMMAND_STOP, out) );				
			}
		}
		private function hCompleteLoadTraceFile(e:Event):void{
			var loader:URLLoader = e.target as URLLoader;
			output = "\n";
			output += 'Загрузка файла завершена!'+"\n";
			output += '------------ Begin'+"\n";
			output += loader.data;			
			output += "\n";
			dispatchEvent( new PluginCommandEvent(PluginCommandEvent.COMMAND_STOP, out) );			
		}
		private function hIOError(e:IOErrorEvent):void{
			output = 'Ошибка при загрузке файла !';
			dispatchEvent( new PluginCommandEvent(PluginCommandEvent.COMMAND_STOP, out) );	
		}
		
		
		public function get out():String{
			return output;
		}
	}
}