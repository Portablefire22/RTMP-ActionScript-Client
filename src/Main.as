package
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.events.NetStatusEvent;
	import mx.messaging.ChannelSet;
	import RTMPChannel;
	import mx.messaging.events.ChannelEvent;
	import mx.rpc.events.InvokeEvent;
	import mx.logging.Log;
	import mx.logging.targets.TraceTarget;
	import mx.logging.LogEventLevel;
	import flash.text.TextFieldAutoSize;
	import flash.events.Event;

	public class Main extends Sprite
	{

		private var cs:ChannelSet = new ChannelSet;
		private var c:RTMPChannel;

		private var txt_holder:Sprite = new Sprite();
		private var tf:TextField = new TextField();

		public function Main()
		{
			
			var logTarget:TraceTarget = new TraceTarget();
			logTarget.level = LogEventLevel.ALL
			logTarget.includeDate = true;
			logTarget.includeTime = true;
			logTarget.includeCategory = true;
			logTarget.includeLevel = true;
			Log.addTarget(logTarget);

			
			tf.text = "Hello, World!";
			stage.addChild(txt_holder);
			txt_holder.addChild(tf);

			stage.addEventListener(Event.RESIZE, onStageResize);

			var c:RTMPChannel = new SecureRTMPChannel("my-rtmps", "rtmps://prod.eu.lol.riotgames.com:2099");
			c.addEventListener(NetStatusEvent.NET_STATUS, netStatusHelper);
			c.addEventListener(ChannelEvent.CONNECT, handleConnect);
			
			cs.addEventListener(NetStatusEvent.NET_STATUS, netStatusHelper);

			c.connect(cs);
			

			//c.connect(cs);
			

			// Wait for a connection

		}

		public function handleConnect(event:ChannelEvent):void {
			trace(event.channel);
			trace(event.toString());
			tf.text = event.toString();
			
			tf.autoSize = TextFieldAutoSize.LEFT;
		}

		public function onStageResize(e:Event):void {
			txt_holder.width = stage.stageWidth * 0.8; // 80% width relative to stage
			txt_holder.scaleY = txt_holder.scaleX; // To keep aspectratio
			txt_holder.x = stage.stageWidth / 2;
			txt_holder.y = 10; 
		}

		public function onRemoteObjectInvoke(event:InvokeEvent):void {
			trace (event.toString());
		}

public function onDisconnect(event:ChannelEvent):void {
			trace(event.toString());
		}
		public function netStatusHelper(event:NetStatusEvent):void {
			trace(event.info.code);
		}
	}
}