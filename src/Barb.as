package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Mask;
	import net.flashpunk.masks.Pixelmask;
	
	public class Barb extends Entity
	{	
		private var injured:Boolean = false;
		
		public function Barb() 
		{
			type = "barb";
		}
		
		override public function update():void 
		{
			var p:Player = collide("player", x, y) as Player;
			if (p)
			{
				if (!injured)
				{
					trace("injury!");
					injured = true;
					p.health -= 25;
				}
			}
		}
	}
}