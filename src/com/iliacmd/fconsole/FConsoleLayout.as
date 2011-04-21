package com.iliacmd.fconsole
{
	import flash.errors.IllegalOperationError;

	public class FConsoleLayout
	{
		public static const TOP:String = "top";
		public static const LEFT:String = "left";
		public static const RIGHT:String = "right";
		public static const BOTTOM:String = "BOTTOM";		
		
		public function FConsoleLayout()
		{
			throw new IllegalOperationError("This is class can't create!");
		}
	}
}