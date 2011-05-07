package{
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.utils.getTimer;
	import worlds.MyWorld;
	import Math;

    public class MyCounter extends Sprite{
        private var last:uint = getTimer();
        private var ticks:uint = 0;
        private var tf:TextField;

        public function MyCounter(xPos:int=0, yPos:int=0, color:uint=0xffffff, fillBackground:Boolean=false, backgroundColor:uint=0x000000) {
            x = xPos;
            y = yPos;
            tf = new TextField();
            tf.textColor = color;
            tf.text = "-----";
            tf.selectable = false;
            tf.background = fillBackground;
            tf.backgroundColor = backgroundColor;
            tf.autoSize = TextFieldAutoSize.LEFT;
            addChild(tf);
            width = tf.textWidth;
            height = tf.textHeight;
            addEventListener(Event.ENTER_FRAME, tick);
        }

        public function tick(evt:Event):void {
            ticks++;
            var now:uint = getTimer();
            var delta:uint = now - last;
            if (delta >= 1000) {
                //trace(ticks / delta * 1000+" ticks:"+ticks+" delta:"+delta);
                var fps:Number = ticks / delta * 1000;
				tf.text = MyWorld.river.riverVol;
                //tf.text = String(1 / (Math.abs(MyWorld.river.x - MyWorld.player.x) / 500.00 + 1));
                ticks = 0;
                last = now;
            }
        }
    }
}