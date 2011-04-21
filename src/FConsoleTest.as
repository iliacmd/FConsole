package{
	import com.exa4lib.utils.Utils;
	import com.iliacmd.fconsole.FConsole;
	import com.iliacmd.fconsole.FConsoleLayout;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	public class FConsoleTest extends Sprite{
		
		private var _console:FConsole;
		
		public function FConsoleTest()
		{
		
			FConsole.attach( this );				
			FConsole.write("A", this);	
			FConsole.write("ASDASDASD", this);	
			
			var test:Object = {ass:'s', asdas:'asdsd'};
			test.nnn = {prop:'asdsad'};
			Utils.dumpObject( test );

		}

	}
}