package com.iliacmd.fconsole{
	import com.iliacmd.fconsole.plugins.ConsolePlugin;
	import com.iliacmd.fconsole.plugins.ConsolePluginEvent;
	import com.iliacmd.fconsole.plugins.IConsolePlugin;
	import com.iliacmd.fconsole.plugins.as3plugin.AS3Plugin;
	
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class PluginManager extends EventDispatcher{
		
		private var _console:FConsole;
		
		private static var _plugins:Object;
		private static var _instance:PluginManager;
		
		
		public function PluginManager(console:FConsole)
		{
			super(console);
			//TODO: Сделать запре на создание более одно экземпляра
			_console = console;
			_console.addEventListener(FConsoleEvent.CONSOLE_INPUT, hGETConsoleInput);
			installDefaultPlugins();
		}
		
		public static function getInstance(console:FConsole=null):PluginManager{
			_instance = (_instance != null)?_instance:new PluginManager(console);
			return _instance;
		}
		
		private function installDefaultPlugins():void{
			installPlugin( AS3Plugin );
		}
		
		public static function installPlugin(plugin:Class):void{
			//TODO: Сделать проверку на уникальность плагинов
			var cmdPlugin:IConsolePlugin = new plugin;			
			if(!_plugins) _plugins = new Object;
			_plugins[cmdPlugin.name] = cmdPlugin;			
		}
		
		private function hGETConsoleInput(e:FConsoleEvent):void{
			var result:Array = String(e.data).split(" ");
			if(result){
				var namePlugin:String = result[0];
				if(namePlugin == ''){
					this._console.write('Введите имя плагина');
					return;
				}
				if(_plugins[namePlugin]){					
					var args:Array = [];
					var command:String = '';
					if( String(result[1]) != '' ){
						command = String(result[1]).substr(0, String(result[1]).length);
						for(var i:uint=2; i < result.length; i++){
							args.push( result[i] );
						}
					}else{
						this._console.write('Введите название комманды');
						return;
					}
					ConsolePlugin(_plugins[ namePlugin ]).addEventListener(ConsolePluginEvent.WRITE_OUTPUT, hOutputPlugin);	
					ConsolePlugin(_plugins[ namePlugin ]).addEventListener(ConsolePluginEvent.COMPLETE, hCompletePlugin);						
					ConsolePlugin(_plugins[ namePlugin ]).addEventListener(ConsolePluginEvent.UNKNOW_COMMAND, hUnkonowCommandPlugin);					
					ConsolePlugin(_plugins[ namePlugin ]).execute(command, args);
				}else{
					this._console.write('Плагин с именем "' + e.data+ '" не найден!');
				}
			} 
			
		}
		
		private function hOutputPlugin(e:ConsolePluginEvent):void{
			this._console.writeOut( e.data as String );
		}
		private function hCompletePlugin(e:ConsolePluginEvent):void{
			this._console.write( e.data as String );
		}		
		
		private function hUnkonowCommandPlugin(e:ConsolePluginEvent):void{
			this._console.write('Неизвестная комманда "'+e.data.nameCommand+'"');
		}
		
	}
}