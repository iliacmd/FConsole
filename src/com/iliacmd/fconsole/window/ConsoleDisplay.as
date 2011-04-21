package com.iliacmd.fconsole.window
{
	import com.iliacmd.fconsole.FConsoleEvent;
	import com.iliacmd.fconsole.IConsole;
	
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	
	public class ConsoleDisplay extends TextField
	{
		private var enabledInput:InputRange = new InputRange;
		private var lastInput:String;
		protected var welcomeStr:String = '$fc:>';
		protected var console:IConsole;
		
		public function ConsoleDisplay(console:IConsole)
		{
			super();
			this.console = console;
			this.defaultTextFormat = new TextFormat("_typewriter", 12, 0x00cc00);
			this.type = TextFieldType.INPUT;
			this.addEventListener(KeyboardEvent.KEY_DOWN, hKeyDownInput);
			this.addEventListener(TextEvent.TEXT_INPUT, hTextInput);
			this.addEventListener(MouseEvent.MOUSE_OVER, hMouseOver);
			this.addEventListener(MouseEvent.MOUSE_OUT, hMouseOut);				
		}
		
		internal function out(msg:String, welcome:Boolean=true):void{
			if(msg)	this.text += (msg + "\n");
			if(welcome) this.text += this.welcomeStr;
			this.enabledInput.start = this.length;
			this.setSelection(this.length, this.length);	
			this.console.dispatchEvent( new FConsoleEvent(FConsoleEvent.CONSOLE_OUTPUT, msg) );			
		}
		
		public function restorePosition():void{
			this.scrollV = this.numLines;
			//this.setSelection(this.length, this.length);
		}
		
		private function hKeyDownInput(e:KeyboardEvent):void{
			if(e.keyCode == Keyboard.ENTER){
				this.lastInput = this.text.substr( this.enabledInput.start );
				this.appendText("\n");
				this.setSelection(this.length, this.length);
				this.enabledInput.start = this.length; 
				this.console.dispatchEvent( new FConsoleEvent(FConsoleEvent.CONSOLE_INPUT, this.lastInput, true) );
			}		
			if(e.keyCode == Keyboard.BACKSPACE && this.selectionBeginIndex-1 < this.enabledInput.start ){
				this.setSelection(0,0); 
			}
		}
		
		private function hTextInput(e:TextEvent):void{
			if(this.selectionBeginIndex < this.enabledInput.start)
				e.preventDefault();			
		}
		
		private function hMouseOver(e:MouseEvent):void{
			Mouse.cursor = MouseCursor.ARROW;
		}
		
		private function hMouseOut(e:MouseEvent):void{
			Mouse.cursor = MouseCursor.AUTO;
		}	
		
	}
}