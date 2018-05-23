package 
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	/**
	 * ...
	 * @author 
	 */
	public class Container extends Sprite 
	{
		private var _textFieldList:Array/*TextField*/ = [];
		private var _capStage:Sprite = new Sprite();
		private var _bitmap:Bitmap;
		public function Container() 
		{
			init();
		}
		private function init():void 
		{
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}

		private function onInit(event:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			// entry point
			
			graphics.beginFill(0x000000);
			graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			graphics.endFill();
			
			_bitmap = new Bitmap(new BitmapData(stage.stageWidth, stage.stageHeight, true, 0x0));
			//addChild(_capStage);
			addChild(_bitmap);
			
			var n:int = 6;
			for (var i:int = 0; i < n; i++) 
			{
				var textField:TextField = new TextField();
				textField.defaultTextFormat = new TextFormat("_sans", 94, 0xFFFFFF, true, null, null, null, null, TextFormatAlign.LEFT);
				textField.text = "Lawson";
				textField.width = 300;
				textField.height = 500;
				textField.x = stage.stageWidth >> 1;
				textField.y = i*72;// stage.stageHeight >> 2;
				_capStage.addChild(textField);
				_textFieldList.push(textField);
			}
			addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		private function enterFrame(e:Event):void 
		{
			var date:Date = new Date();
			var textList:Array/*int*/ = [date.fullYear, (date.month + 1), date.date, date.hours, date.minutes, date.seconds];
			var n:int = 6;
			for (var i:int = 0; i < n; i++) 
			{
				var textField:TextField = _textFieldList[i];
				if(date.seconds%3 == i){
					textField.rotationY = (date.milliseconds / 1000) * 360;
				}else if(3 == i){
					textField.rotationY = date.hours * (360/24);
				}else if(4 == i){
					textField.rotationY = date.minutes * 6;
				}else if(5 == i){
					textField.rotationY = date.seconds * 6;
				}
	
				textField.text = textList[i];
			}
			//var text:String = "";
			//text += date.fullYear + "\n";
			//text += (date.month+1) + "\n";
			//text += date.date + "\n";
			//text += date.hours + "\n";
			//text += date.minutes + "\n";
			//text += date.seconds + "\n";
			//_textFieldList[0].text = text;
			
			
			if (date.seconds%2 == 0) {
				Glitch.type4(_bitmap.bitmapData, _capStage,new Matrix(),new ColorTransform());
			}else {
				Glitch.type8(_bitmap.bitmapData, _capStage,new Matrix(),new ColorTransform());
			}
		}
		
	}
	
}