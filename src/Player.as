package  
{
	import flash.geom.Rectangle;
	import net.flashpunk.*;
	import net.flashpunk.graphics.Canvas;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	import flash.geom.Point;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.Sfx;
	import worlds.*;
	
	public class Player extends Moveable
	{
		/**
		 * Player graphic
		 */
		[Embed(source = '../assets/player.png')] private const S_PLAYER:Class;
		public var image:Image = new Image(S_PLAYER);
		public var bloodCanvas:Canvas = new Canvas(MyWorld.width, MyWorld.height);		
		
		[Embed(source = '../assets/splat.png')] private const S_SPLAT:Class;
		public var splatImage:Image = new Image(S_SPLAT);		
		
		/**
		 * Gunshot sound
		 */
		[Embed(source='../assets/gunshot.mp3')] private const SND_GUN:Class;
		public var sndGun:Sfx = new Sfx(SND_GUN);
		
		/**
		 * Movement constants.
		 */
		public const SPEED_MAX:Number = 110;
		public const ACCEL:Number = 800;
		public const DRAG:Number = 800;
		
		/**
		 * Movement properties.
		 */
		public var spdMax:Number = 0;
		public var spdX:Number = 0;
		public var spdY:Number = 0;		
		
		/**
		 * Other Properties.
		 */		
		public var health:Number = 100;
		public var bloodHeight:Number = 0;
		public var bloodX:Number = 0;
		public var finished:Boolean = false;
		public var dead:Boolean = false;
		
		// Time between gunshot and splatter
		public var splatterAlarm:Alarm = new Alarm(0.3, splatter);
		
		// Time until fade.
		public var fadeAlarm:Alarm = new Alarm(20, startFade);
		
		public var testAlarm:Alarm = new Alarm(2, startFade);
		
		public function Player() 
		{
			type = "player";
			graphic = image;
			layer = 0;
			
			image.originX = image.width / 2;
			image.originY = image.height / 2;
			image.x = -image.originX;
			image.y = -image.originY;	
			
			splatImage.originX = image.width / 2;
			splatImage.originY = image.height / 2;
			splatImage.x = -image.originX;
			splatImage.y = -image.originY;	
			
			setHitbox(image.width, image.height, image.originX, image.originY);
			
			Input.define("U", Key.UP);
			Input.define("D", Key.DOWN);			
			Input.define("L", Key.LEFT);	
			Input.define("R", Key.RIGHT);
			
			// add alarms
			addTween(splatterAlarm);		
			addTween(fadeAlarm);
			//addTween(testAlarm, true);
		}
		
		/**
		 * Update the player.
		 */		
		override public function update():void 
		{
			checkSplatter();
			bloodTrail();
			if (!dead)
			{
				setSpdMax();
				acceleration();
				move(spdX * FP.elapsed, spdY * FP.elapsed);
			}		
		}
		
		/**
		 * Render the player.
		 */
		override public function render():void 
		{
			// render blood
			bloodCanvas.render(new Point(0, 0), FP.camera);
			
			// render the entity
			super.render();
		}					
	
		/**
		 * Check splatter.
		 */
		private function checkSplatter():void
		{
			if (x >= MyWorld.bridge.x -20 && !finished)
			{
				sndGun.play(1,0);
				finished = true;
				splatterAlarm.start();
			}
		}	
	
		/**
		 * Splatter.
		 */
		private function splatter():void
		{
			dead = true;
			graphic = splatImage;
			fadeAlarm.start();
		}	
		
		/**
		 * Start fade.
		 */
		private function startFade():void
		{
			trace("start fade");
			FP.world.add(new FadeOut(new PhotoWorld, Colors.BLACK, 15, 3));
		}
		
		/**
		 * Blood Trail
		 */
		private function bloodTrail():void
		{
			if (FP.rand(100) > health)
			{
				// chance of blood trail changing y
				if (FP.rand(100) > 50)
				{
					if (FP.rand(2) == 1)
					{
						bloodHeight -= 1;
					}
					else 
					{
						bloodHeight += 1;
					}
				}
				
				// chance of blood trail changing x
				if (FP.rand(100) > 50)
				{
					if (FP.rand(2) == 1)
					{
						bloodX -= 1;
					}
					else 
					{
						bloodX += 1;
					}
				}				
				
				// variation in bloodHeight
				if (bloodHeight < -image.height / 4)
				{
					bloodHeight = -image.height / 4;
				}
				else if (bloodHeight > image.height / 4)
				{
					bloodHeight = image.height / 4;
				}
				
				// variation in bloodX
				if (bloodX < -image.width / 4)
				{
					bloodX = -image.width / 4;
				}
				else if (bloodX > image.width / 4)
				{
					bloodX = image.width / 4;
				}				
				
				// leave blood
				leaveBlood(x + bloodX, y + bloodHeight);
			}
		}
		
		/**
		 * Leave blood
		 */
		private function leaveBlood(x:uint, y:uint):void
		{
			var rect:Rectangle = new Rectangle(x, y, 1, 1);
			bloodCanvas.fill(rect, Colors.BLOOD_RED);
		}
		
		/**
		 * Speed
		 */
		private function setSpdMax():void
		{
			// slow down over barbed wire
			if (collide("barb", x, y))
			{
				spdMax = SPEED_MAX / 8;
			}
			else
			{
				spdMax = SPEED_MAX * (health / 100);
			}			
		}
		
		/**
		 * Accelerates the player based on input.
		 */
		private function acceleration():void
		{
			// evaluate input
			var accelX:Number = 0;
			var accelY:Number = 0;
			if (Input.check("U")) accelY -= ACCEL;
			if (Input.check("D")) accelY += ACCEL;
			if (Input.check("L")) accelX -= ACCEL;				
			if (Input.check("R")) accelX += ACCEL;		
			
			// handle acceleration
			if (accelX != 0)
			{
				if (accelX > 0)
				{
					// accelerate right
					if (spdX < spdMax)
					{
						spdX += accelX * FP.elapsed;
						if (spdX > spdMax) spdX = spdMax;
					}
					else accelX = 0;
				}
				else
				{
					// accelerate left
					if (spdX > -spdMax)
					{
						spdX += accelX * FP.elapsed;
						if (spdX < -spdMax) spdX = -spdMax;
					}
					else accelX = 0;
				}
			}
			if (accelY != 0)
			{
				if (accelY > 0)
				{
					// accelerate right
					if (spdY < spdMax)
					{
						spdY += accelY * FP.elapsed;
						if (spdY > spdMax) spdY = spdMax;
					}
					else accelY = 0;
				}
				else
				{
					// accelerate left
					if (spdY > -spdMax)
					{
						spdY += accelY * FP.elapsed;
						if (spdY < -spdMax) spdY = -spdMax;
					}
					else accelY = 0;
				}
			}		
			
			// handle decelleration
			if (accelX == 0)
			{
				if (spdX > 0)
				{
					spdX -= DRAG * FP.elapsed;
					if (spdX < 0) spdX = 0;
				}
				else
				{
					spdX += DRAG * FP.elapsed;
					if (spdX > 0) spdX = 0;
				}
			}
			if (accelY == 0)
			{
				if (spdY > 0)
				{
					spdY -= DRAG * FP.elapsed;
					if (spdY < 0) spdY = 0;
				}
				else
				{
					spdY += DRAG * FP.elapsed;
					if (spdY > 0) spdY = 0;
				}
			}			
		}		
		
	}
}