package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class TopDownMover extends Entity
	{
		public var speed:Number;
		
		public function TopDownMover(speed:Number, x:Number = 0, y:Number = 0, graphic:Graphic = null) 
		{
			super(x, y, graphic);
			this.speed = speed;
			type = 'top_down_mover';
			layer = 0;
			
			// Initialize image, hitbox
			(graphic as Image).originX = (graphic as Image).width / 2;
			(graphic as Image).originY = (graphic as Image).height / 2;
			(graphic as Image).x = -(graphic as Image).originX;
			(graphic as Image).y = -(graphic as Image).originY;		
			setHitbox((graphic as Image).width - 1, (graphic as Image).height - 1, (graphic as Image).originX, (graphic as Image).originY);		
			
			Input.define('U', Key.UP);
			Input.define('D', Key.DOWN);
			Input.define('L', Key.LEFT);
			Input.define('R', Key.RIGHT);
		}
		
		override public function update():void
		{
			var xMove:Number = 0;
			var yMove:Number = 0;
			if (Input.check('U'))
				if (Input.check('L'))  
				{
					yMove = -speed * Math.sin(Math.PI/4) * FP.elapsed;					
					xMove = -speed * Math.cos(Math.PI / 4) * FP.elapsed;
				}
				else if (Input.check('R'))
				{
					yMove = -speed * Math.sin(Math.PI/4) * FP.elapsed;					
					xMove = speed * Math.cos(Math.PI/4) * FP.elapsed;					
				}
				else
					yMove = -speed * FP.elapsed;
			else if (Input.check('D'))
				if (Input.check('L')) 
				{
					yMove = speed * Math.sin(Math.PI/4) * FP.elapsed;					
					xMove = -speed * Math.cos(Math.PI/4) * FP.elapsed;
				}
				else if (Input.check('R'))
				{
					yMove = speed * Math.sin(Math.PI/4) * FP.elapsed;					
					xMove = speed * Math.cos(Math.PI/4) * FP.elapsed;					
				}
				else
					yMove = speed * FP.elapsed;
			else if (Input.check('L'))
				xMove = -speed * FP.elapsed;
			else if (Input.check('R'))
				xMove = speed * FP.elapsed;
			
			// Check collisions
			for (var i:int = 0; i <= Math.abs(xMove); i++)
			{
				if (!collide('solid', x + 1 * FP.sign(xMove), y))
					x = x + 1 * FP.sign(xMove);
			}
			for (i = 0; i <= Math.abs(yMove); i++)
			{
				if (!collide('solid', x, y + 1 * FP.sign(yMove)))
					y = y + 1 * FP.sign(yMove);
			}			
			
			
			//if (!collide('solid', x + xMove, y))
				//x += xMove;
			//if (!collide('solid', x, y + yMove))
				//y += yMove;
			super.update();
		}
		
	}

}