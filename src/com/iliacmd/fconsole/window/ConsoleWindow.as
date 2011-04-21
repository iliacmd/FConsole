package com.iliacmd.fconsole.window
{
	import com.iliacmd.fconsole.FConsoleLayout;
	import com.iliacmd.fconsole.IConsole;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	
	public class ConsoleWindow extends Sprite
	{
		public var color:Number = 0x000000;
		public var bgalpha:Number = 1;
		public var console:IConsole;	
		public var isDragBar:Boolean = false;

		private var background:Sprite;
		private var container:Stage;
		private var dragBar:Sprite;
		private var _display:ConsoleDisplay;	
		private var _layout:String = FConsoleLayout.TOP;
		
		public function ConsoleWindow(console:IConsole, container:DisplayObjectContainer)
		{
			super();
			this.console = console;
			this.container = container as Stage;
			
			this.background = new SolidBackground();
			this.addChild( background );
			
			this.display = new ConsoleDisplay(this.console);
			
			this.dragBar = new DragBar(0x666666);
			this.dragBar.addEventListener(MouseEvent.MOUSE_DOWN, hMouseDownDragBar);
			this.dragBar.addEventListener(MouseEvent.MOUSE_UP, hMouseUpDragBar);			
			this.addChild( this.dragBar );
			
			this.addEventListener(Event.ADDED_TO_STAGE, hAddedToStage);
			this.addEventListener(Event.ENTER_FRAME, hEnterFrame);
			this.container.addChild( this );			
		}
		
		public function set display(value:ConsoleDisplay):void{
			if(_display && this.contains(_display)) this.removeChild( this._display );
			_display = value;			
			this.addChild( _display );			
		}		
		public function get display():ConsoleDisplay{
			return _display;
		}
		
		public function set layout(value:String):void{
			_layout = value;
			var h:Number = 0;
			switch(_layout){
				case FConsoleLayout.TOP:;
					h = (this.background.height > 1)?this.background.height:this.container.stageHeight*0.3;
					if(this.background.height > this.container.stageHeight) h =  this.container.stageHeight-this.dragBar.height;
					this.setSize(this.container.stageWidth, h);
					background.x = background.y = 0;			
					this.addChildAt( background, 0 );					
					this._display.x = background.x;
					this._display.y = background.y;	
					this.dragBar.height = 7;					
					this.dragBar.x = background.x;
					this.dragBar.y = background.y+background.height;
					this.dragBar.width = background.width;
				break;
				case FConsoleLayout.BOTTOM:
					h = (this.background.height > 1)?this.background.height:this.container.stageHeight*0.3;
					if(this.background.height > this.container.stageHeight) h =  this.container.stageHeight-this.dragBar.height;					
					this.setSize(this.container.stageWidth, h);
					background.x = 0
					background.y = this.container.stageHeight - background.height;			
					this.addChildAt( background, 0 );					
					this._display.x = background.x;
					this._display.y = background.y;		
					this.dragBar.height = 7;	
					this.dragBar.x = background.x;
					this.dragBar.y = background.y-this.dragBar.height;
					this.dragBar.width = background.width;				
				break;				
			}			
		}
		
		public function setSize(w:Number, h:Number):void{
			this.background.width = w; 
			this.background.height = h;	
			this._display.width = w; 
			this._display.height = h;
			this._display.restorePosition();			
		}
		
		public function print(msg:String):void{
			_display.out(msg);
		}
		
		public function println(msg:String):void{
			_display.out(msg, false);
		}
		
		private function hAddedToStage(e:Event):void{
			this.stage.addEventListener(Event.RESIZE, hStageResize);
			this.stage.addEventListener(MouseEvent.MOUSE_UP, hMouseUpDragBar);	
			this.stage.removeEventListener(Event.ADDED_TO_STAGE, hAddedToStage);		
			
			this.layout = _layout;
		} 			
		
		private function hStageResize(e:Event):void{
			this.layout = _layout;
		}			
		
		private function hMouseDownDragBar(e:MouseEvent):void{
			this.dragBar.startDrag(false, new Rectangle(0,0,0,this.container.stageHeight) );
			isDragBar = true;
		}
		
		private function hMouseUpDragBar(e:MouseEvent):void{
			this.stopDrag();	
			isDragBar = false;
			moveDragbar();
		}	
		
		private function moveDragbar():void{
			if(this._layout == FConsoleLayout.BOTTOM){
				this.background.y = display.y = dragBar.y+dragBar.height;
				this.setSize(this.background.width, this.container.stageHeight-this.dragBar.y);
			}else if(this._layout == FConsoleLayout.TOP){
				this.setSize(this.background.width, this.dragBar.y);
			}			
		}
		
		private function hEnterFrame(e:Event):void{
			if(isDragBar) this.moveDragbar();
		}

	}
}