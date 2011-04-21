package com.iliacmd.fconsole.plugins.as3plugin{
	import com.iliacmd.fconsole.PluginManager;
	import com.iliacmd.fconsole.plugins.ConsolePlugin;
	import com.iliacmd.fconsole.plugins.ConsolePluginEvent;
	import com.iliacmd.fconsole.plugins.ICommandPlugin;
	import com.iliacmd.fconsole.plugins.IConsolePlugin;
	import com.iliacmd.fconsole.plugins.as3plugin.commands.StageCommand;
	import com.iliacmd.fconsole.plugins.as3plugin.commands.TraceCommand;
	
	import flash.system.System;
	import com.iliacmd.fconsole.plugins.PluginCommandEvent;
	
	public class AS3Plugin extends ConsolePlugin implements IConsolePlugin{
		
		public static const FULL_PLUGIN_NAME:String = "AS3CommandPlugin";
		
		private var buffer:String = '';
		private var commands:Object= {};
		
		public function AS3Plugin()
		{
			this._name = "as3";
			this.registerCommand('trace', TraceCommand);
			this.registerCommand('stage', StageCommand);
		}
		
		public function registerCommand(name:String, command:Class):void{
			commands[name] = new command(this);
			ICommandPlugin(commands[name]).addEventListener(PluginCommandEvent.COMMAND_START, hStartCommand);
			ICommandPlugin(commands[name]).addEventListener(PluginCommandEvent.COMMAND_STOP, hStopCommand);	
			ICommandPlugin(commands[name]).addEventListener(PluginCommandEvent.COMMAND_PROGRESS, hProgressCommand);				
		}
		
		public function printHelp(command:String=null):void{
			if(command == null){
				for each( var cmd:ICommandPlugin in commands){
					buffer += cmd;
				}
				dispatchEvent( new ConsolePluginEvent(ConsolePluginEvent.WRITE_OUTPUT, buffer) );			
			}
		}
		
		override public function execute(command:String, args:Array):void{	
			if(command == '?'){
				this.printHelp();
				return;
			}
			if(!commands[command]){
				dispatchEvent( new ConsolePluginEvent(ConsolePluginEvent.UNKNOW_COMMAND, {nameCommand: command}) )
				return;
			} 
			ICommandPlugin(commands[command]).execute(args);
			
		}
		
		private function hStartCommand(e:PluginCommandEvent):void{
			dispatchEvent( new ConsolePluginEvent(ConsolePluginEvent.WRITE_OUTPUT, e.buffer) );
		}
		private function hStopCommand(e:PluginCommandEvent):void{
			dispatchEvent( new ConsolePluginEvent(ConsolePluginEvent.COMPLETE, e.buffer) );
		}	
		private function hProgressCommand(e:PluginCommandEvent):void{
			dispatchEvent( new ConsolePluginEvent(ConsolePluginEvent.WRITE_OUTPUT, e.buffer) );
		}			
	
		
		
		
	}
}