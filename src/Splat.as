package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import worlds.*;
	
	public class Splat extends Entity
	{
		[Embed(source = '../assets/splat.png')] private const S_SPLAT:Class;
		public var image:Image = new Image(S_SPLAT);
		
		public function Splat() 
		{
			graphic = image;
			layer = 1;

			image.originX = image.width / 2;
			image.originY = image.height / 2;
			image.x = -image.originX;
			image.y = -image.originY;			
			
			setHitbox(image.width, image.height, image.originX, image.originY);
			
			x = MyWorld.player.x;
			y = MyWorld.player.y;
			
		}
		
	}

}