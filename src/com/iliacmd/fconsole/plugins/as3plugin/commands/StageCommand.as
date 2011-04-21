package com.iliacmd.fconsole.plugins.as3plugin.commands
{
	import com.iliacmd.fconsole.FConsole;
	import com.iliacmd.fconsole.IConsole;
	import com.iliacmd.fconsole.plugins.ICommandPlugin;
	import com.iliacmd.fconsole.plugins.IConsolePlugin;
	
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	
	public class StageCommand extends EventDispatcher implements ICommandPlugin
	{
		private var output:String = '';
		private var console:FConsole;
		
		public function StageCommand(plugin:IConsolePlugin)
		{
		}
		
		public function get out():String{
			return output;
		}
		
		public function execute(args:Array):void
		{
			console = FConsole.getInstance();
			switch(args[0]){
				case 'align':
					this.alignStage(args[1]);
				break;		
				case 'scale':
					this.scaleStage(args[1]);
					break;					
				default:
					output += 'Неверно указаны параметры команды';
				break;
			}
		}
		
		private function alignStage(stageAlign:String):void{
			//T,L,R,B,TL,BL,TR,BR
			try{
				output += 'align:' + console.stage.align+"\n";
				console.stage.align = stageAlign;
				output += 'Now align:' + console.stage.align+"\n";
			}catch(e:Error){
				
			}
		}
		
		private function scaleStage(stageScale:String):void{
			//noScale, showAll, exactFit, noBorder
			try{
				output += "\n"+'Old scale mode: ' + console.stage.scaleMode+"\n";
				console.stage.scaleMode = stageScale;
				output += 'New scale mode: ' + console.stage.scaleMode+"\n";	
			}catch(e:Error){
				output += "Warning: Can't setup this value is not valid"+"\n";
			}
		}		
		

	}
}