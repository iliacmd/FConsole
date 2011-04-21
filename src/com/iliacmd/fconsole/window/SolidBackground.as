package com.iliacmd.fconsole.window
{
	import flash.display.Sprite;

	public class SolidBackground extends Sprite
	{
		public function SolidBackground(color:uint = 0x000000, alpha:Number = 1)
		{
			with( this.graphics ){
				clear();
				beginFill( color, alpha);
				drawRect(0, 0, 1, 1);
				endFill();
			}	
		}
	}
}