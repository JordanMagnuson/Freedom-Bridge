package
{
	import net.flashpunk.*;
	import worlds.*;
	import flash.ui.Mouse;
	
	/**
	 * Main game class.
	 */
	public class Main extends Engine
	{
		
		/**
		 * Constructor. Start the game and set the starting world.
		 */
		public function Main() 
		{
			super(800, 400, 60);
			FP.screen.color = Colors.WHITE;
			FP.world = new MyWorld;
			//FP.world = new Preloader("MyWorld");
			Mouse.hide();
		}
		
		override public function update():void 
		{
			super.update();
			//trace("current world", FP.world);
		}
	}
}