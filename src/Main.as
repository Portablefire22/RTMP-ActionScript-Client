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

	public class Main extends Sprite
	{

		private var cs:ChannelSet = new ChannelSet;
		private var c:RTMPChannel;

		public function Main()
		{
			
			var logTarget:TraceTarget = new TraceTarget();
			logTarget.level = LogEventLevel.ALL
			logTarget.includeDate = true;
			logTarget.includeTime = true;
			logTarget.includeCategory = true;
			logTarget.includeLevel = true;
			Log.addTarget(logTarget);

			var tf:TextField = new TextField();
			tf.text = "Hello, World!";
			stage.addChild(tf);

			var c:RTMPChannel = new SecureRTMPChannel("my-rtmps", "rtmp://prod.eu.lol.riotgames.com:2099");
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