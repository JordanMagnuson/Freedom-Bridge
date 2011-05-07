package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class Photo extends Entity
	{
		[Embed(source = '../assets/bridge_photo.jpg')] private const S_PHOTO:Class;
		public var image:Image = new Image(S_PHOTO);
		
		public function Photo() 
		{
			graphic = image;
		}
		
	}

}