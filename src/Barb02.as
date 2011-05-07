package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Mask;
	import net.flashpunk.masks.Pixelmask;
	import net.flashpunk.FP;
	
	public class Barb02 extends Barb
	{
		[Embed(source = '../assets/barb02.png')] private const S_BARB_02:Class;
		public var image:Image = new Image(S_BARB_02);
		
		public function Barb02() 
		{
			graphic = image;
			
			image.originX = image.width / 2;
			image.originY = 0;
			image.x = -image.originX;
			image.y = 0	
			
			setHitbox(image.width, image.height, image.originX, image.originY);

			mask = new Pixelmask(S_BARB_02, image.x, image.y);
			
			//x = FP.width - 160;
			y = 0;
		}
	}
}