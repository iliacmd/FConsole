package com.iliacmd.fconsole.window
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	
	public class DragBar extends Sprite
	{
		public function DragBar(color:uint=0x000000, alpha:uint=1)
		{
			super();
			with( this.graphics ){
				clear();
				beginFill(color, alpha);
				drawRect(0,0, 1, 1);
				endFill();
			}
			this.addEventListener(MouseEvent.MOUSE_OVER, hMouseOver);
			this.addEventListener(MouseEvent.MOUSE_OUT, hMouseOut);
			this.addEventListener(MouseEvent.MOUSE_DOWN, hMouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, hMouseUp);
		}
		
		private function hMouseOver(e:MouseEvent):void{
			Mouse.cursor = MouseCursor.BUTTON;
		}
		private function hMouseOut(e:MouseEvent):void{
			Mouse.cursor = MouseCursor.AUTO;
		}		
		
		private function hMouseDown(e:MouseEvent):void{
			Mouse.cursor = MouseCursor.HAND;
		}
		
		private function hMouseUp(e:MouseEvent):void{
			Mouse.cursor = MouseCursor.BUTTON;		
		}			
	}
}