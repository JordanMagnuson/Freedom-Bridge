package  
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Pixelmask;
	
	public class Bridge extends Entity
	{
		/**
		 * Embedded river graphic.
		 */
		[Embed(source='../assets/bridge_fg.png')] private static const S_BRIDGE:Class;
		[Embed(source='../assets/bridge_mask.png')] private static const S_MASK:Class;
		
		public var image:Image = new Image(S_BRIDGE);
		
		/**
		 * Constructor.
		 */		
		public function Bridge() 
		{
			type = "solid"
			
			graphic = image;

			image.originX = image.width / 2;
			image.originY = 0;
			image.x = -image.originX;
			image.y = 0				
			
			mask = new Pixelmask(S_MASK, image.x, image.y);
			
			layer = -10;			
		}
			
		
	}

}