package {
	
	import flash.display.*;
	import flash.events.*;
	
	public class MathFlyer extends MovieClip {
		public var spawnSide:Number;
		public var speed:Number = random(3) + 1;
		public var rotationSpeed:Number = random(4);
		public var rotationSpin:Number = random(2);
		private var scaleNumber:Number = Math.random();
		public var goalCoord:Number;
		
		public function MathFlyer(Side:Number) {
			stop();
			spawnSide = Side;
			this.rotation = random(360);
			this.gotoAndStop(random(this.totalFrames) + 1);
			this.scaleX = scaleNumber + scaleNumber;
			this.scaleY = scaleNumber + scaleNumber;
			
			if(Side == 0) {
				this.y = -50;
				this.x = Math.random() * 550;
				goalCoord = 700;
			}
			
			else if(Side == 1) {
				this.y = Math.random() * 550;
				this.x = 600;
				goalCoord = -250;
			}
			
			else if(Side == 2) {
				this.y = 450;
				this.x = Math.random() * 550;
				goalCoord = -250;
			}
			
			else if(Side == 3) {
				this.y = Math.random() * 550;
				this.x = -50;
				goalCoord = 700;
			}
			else {
				this.y = Math.random() * 550;
				this.x = -50;
				goalCoord = 700;
			}
			
		}
		
		public function random(n:Number):Number {
			
			var N:Number = Math.floor( Math.random() * n );
			return N;
			
		}
		
		public function removeThis() {
			this.removeEventListener(Event.ENTER_FRAME, handleThis);
			this.parent.removeChild(this);
		}
		
		public function handleThis(e:Event) {
			
			if(rotationSpin == 0) // clockwise
			this.rotation += rotationSpeed;
			
			if(rotationSpin == 1) // counter-clockwise
			this.rotation -= rotationSpeed;
			
			if(spawnSide == 0) {
				this.y += speed;
				if(y > goalCoord) {
					removeThis();
				}
			}
			
			else if(spawnSide == 1) {
				this.x -= speed;
				if(x < goalCoord) {
					removeThis();
				}
			}
			
			else if(spawnSide == 2) {
				this.y -= speed;
				if(y < goalCoord) {
					removeThis();
				}
			}
			
			else if(spawnSide == 3) {
				this.x += speed;
				if(x > goalCoord) {
					removeThis();
				}
			}
			else {
				this.x += speed;
				if(x > goalCoord) {
					removeThis();
				}
			}
			
		}
		
	}
	
}