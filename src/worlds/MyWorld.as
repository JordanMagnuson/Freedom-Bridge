package worlds
{
	import flash.geom.Point;
	import net.flashpunk.*;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.World;
	import worlds.PhotoWorld;
	
	public class MyWorld extends World
	{
		/**
		 * Size of the level (so it knows where to keep the player + camera in).
		 */
		public static var width:uint;
		public static var height:uint;
		
		public static var player:Player;	
		public static var barb01:Barb01;
		public static var barb02:Barb02;
		public static var barb03:Barb03;
		public static var barb04:Barb04;		
		public static var river:River;
		public static var bank:Bank;
		public static var bridge:Bridge;
		
		/**
		 * Camera following information.
		 */
		public const FOLLOW_TRAIL:Number = 0;
		public const FOLLOW_RATE:Number = 1;		
		
		public function MyWorld() 
		{
			width = 4000;
			height = 400;
			
			player = new Player;
			barb01 = new Barb01;
			barb02 = new Barb02;
			barb03 = new Barb03;
			barb04 = new Barb04;
			river = new River;
			bank = new Bank;
			bridge = new Bridge;
			add(player);
			add(barb01);
			add(barb02);
			add(barb03);
			add(barb04);			
			add(river);
			add(bank);
			add(bridge);
			//add(new FadeOut(new PhotoWorld, Colors.BLACK, 3, 10));
			
			player.x = 120;
			player.y = height / 2;
			
			barb01.x = FP.width - player.x;
			barb02.x = 2100;
			river.x = 3200;
			
			bank.x = river.x;
			bridge.x = river.x;
			bank.y = -100;
			bridge.y = bank.y + 228;
			
			barb03.x = bridge.x - 320;
			barb04.x = bridge.x + 280;
		}
		
		/**
		 * Begin.
		 */		
		override public function begin():void
		{
			//counter
			//FP.stage.addChild(new MyCounter(0, 0, Colors.BLACK));			
		}
		
		/**
		 * Update the world.
		 */
		override public function update():void 
		{			
			// update entities
			super.update();
			
			// camera following
			cameraFollow();
		}		
		
		/**
		 * Makes the camera follow the player object.
		 */
		private function cameraFollow():void
		{
			// make camera follow the player
			FP.point.x = FP.camera.x - targetX;
			FP.point.y = FP.camera.y - targetY;
			var dist:Number = FP.point.length;
			if (dist > FOLLOW_TRAIL) dist = FOLLOW_TRAIL;
			FP.point.normalize(dist * FOLLOW_RATE);
			FP.camera.x = int(targetX + FP.point.x);
			FP.camera.y = int(targetY + FP.point.y);
			
			// keep camera in room bounds
			FP.camera.x = FP.clamp(FP.camera.x, 0, width - FP.width);
			FP.camera.y = FP.clamp(FP.camera.y, 0, height - FP.height);
		}
		
		/**
		 * Getter functions used to get the position to place the camera when following the player.
		 */
		private function get targetX():Number { return player.x - FP.width / 2; }
		private function get targetY():Number { return player.y - FP.height / 2; }		

	}
}