package  
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Pixelmask;
	
	public class Bank extends Entity
	{
		/**
		 * Embedded river graphic.
		 */
		[Embed(source = '../assets/bank.png')] private static const S_BANK:Class;
		[Embed(source = '../assets/bank_mask.png')] private static const S_MASK:Class;
		
		public var image:Image = new Image(S_BANK);
		
		/**
		 * Constructor.
		 */		
		public function Bank() 
		{
			type = "solid"

			graphic = image;
			
			image.originX = image.width / 2;
			image.originY = 0;
			image.x = -image.originX;
			image.y = 0				
			
			mask = new Pixelmask(S_MASK, image.x, image.y);
			
			layer = 90;			
		}
			
		
	}

}