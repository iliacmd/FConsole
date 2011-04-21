package com.iliacmd.fconsole{
	import com.iliacmd.fconsole.window.ConsoleDisplay;
	import com.iliacmd.fconsole.window.ConsoleWindow;
	import com.iliacmd.fconsole.window.InputRange;
	
	import flash.display.AVM1Movie;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.geom.Point;
	import flash.net.LocalConnection;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import flash.utils.ByteArray;
	
	import mx.core.ByteArrayAsset;
	
	/**
	 * Формат ввода для использования плагинов
	 *  name_plugin -command param1 param2 paramN
	 **/
	
	public class FConsole extends Sprite implements IConsole{	
		
		public static var instance:FConsole;

		private var cmdManager:PluginManager;
		private var _welcome:String = '$>';
		private var _buffer:String = '';
		
		public var window:ConsoleWindow;
		
		//[Embed(source="../lib/AS2Terminal.swf", mimeType="application/octet-stream")]
		//public var Terminal:Class;		
		
		public function FConsole()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, hAddedToStage);
			
			cmdManager = PluginManager.getInstance(this);
			
			if(instance == null) instance = this; else throw new Error("Can't create class FConsole");

		}
		
		public static function attach(container:DisplayObjectContainer):void{
			if(!container.contains(getInstance())){
				container.addChild( getInstance() );
			}
		}
		
		public static function getInstance():FConsole{
			return (instance == null)?new FConsole:instance;
		}
		
		public static function write(msg:String, from:Object=null):void{
			var otputFrom:String = (from!=null)?String(from)+' ':'fc';
			instance._buffer += "\n" + otputFrom + "$> " + msg;			
		}
		
		public function write(msg:String, from:Object=null):void{
			var otputFrom:String = (from!=null)?String(from):'';
			_buffer += otputFrom + msg		
			if(msg == '') window.print( '' );
		}
		
		public function writeOut(msg:String):void{		
			window.println( msg );
		}		
		
		public function setupDisplay(display:ConsoleDisplay):void{
			window.display = display;
		}
		
		private function hAddedToStage(e:Event):void{
			
			stage.addEventListener(Event.ENTER_FRAME, hEnterFrame);
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			window = new ConsoleWindow(this, this.stage);
			window.layout = FConsoleLayout.TOP;
			window.print("Welcome to FConsole!!!");	
			this.stage.focus = window.display;

		}
		
		private function hEnterFrame(e:Event):void{
			if(_buffer != ''){
				window.print( _buffer );
				_buffer = '';
			}
		}	
	
		
	}
}