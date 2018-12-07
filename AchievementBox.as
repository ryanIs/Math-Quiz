package {
	
	import flash.display.*;
	import flash.events.MouseEvent;
	
	public class AchievementBox extends MovieClip {
		
		public var achievement:String;
		
		public function AchievementBox(achiStr:String):void {
			
			achievement = achiStr
			
		}
		
		public function continueBTN(e:MouseEvent) {
			
			play();
			
		}
		
		public function removeMe():void {
			
			this.parent.removeChild(this);
			
		}
		
	}
	
}