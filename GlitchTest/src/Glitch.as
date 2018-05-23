package  
{
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.display.IBitmapDrawable;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author umhr
	 */
	public class Glitch 
	{
		static private var _noiseBitmapData:BitmapData;
		static private var _count:int = 0;
		public function Glitch() 
		{
			
		}
		
		static private function getNoiseBitmapData(width:int, height:int):BitmapData {
			if (_noiseBitmapData) {
				return _noiseBitmapData;
			}else {
				_noiseBitmapData = new BitmapData(width, height, false, 0xFF000000);
				var n:int = _noiseBitmapData.width;
				for (var i:int = 0; i < n; i++) 
				{
					var m:int = _noiseBitmapData.height;
					for (var j:int = 0; j < m; j++) 
					{
						var r:int = Math.random() * 0xFF;
						var rgb:int = (r << 16) + (r << 8) + r;
						_noiseBitmapData.setPixel(i, j, rgb);
					}
				}
				return _noiseBitmapData;
			}
		}
		
		static public function none(target:BitmapData, source:IBitmapDrawable, matrix:Matrix = null, colorTransform:ColorTransform = null):void {
			target.draw(source, matrix, colorTransform);
		}
		
		static public function type0(target:BitmapData, source:IBitmapDrawable, matrix:Matrix = null, colorTransform:ColorTransform = null):void {
			var width:int = target.width;
			var height:int = target.height;
			target.draw(source, matrix, colorTransform, null, new Rectangle(0, Math.random() * height * 0.9, width, height * 0.1));
			target.draw(source, matrix, colorTransform, null, new Rectangle(0, Math.random() * height * 0.9, width, height * 0.1));
		}
		
		static public function type1(target:BitmapData, source:IBitmapDrawable, matrix:Matrix = null, colorTransform:ColorTransform = null):void {
			var width:int = target.width;
			var height:int = target.height;
			var blendMode:String = BlendMode.DIFFERENCE;
			target.draw(source, null, new ColorTransform(colorTransform.redMultiplier, 0, 0), blendMode, new Rectangle(0, Math.random() * height * 0.9, width, width * 0.1));
			target.draw(source, null, new ColorTransform(0, colorTransform.greenMultiplier, 0), blendMode, new Rectangle(0, Math.random() * height * 0.9, width, width * 0.1));
			target.draw(source, null, new ColorTransform(0, 0, colorTransform.blueMultiplier), blendMode, new Rectangle(0, Math.random() * height * 0.9, width, width * 0.1));
		}
		static public function type2(target:BitmapData, source:IBitmapDrawable, matrix:Matrix = null, colorTransform:ColorTransform = null):void {
			var width:int = target.width;
			var height:int = target.height;
			var blendMode:String = BlendMode.NORMAL;
			target.draw(source, null, new ColorTransform(colorTransform.redMultiplier, 0, 0), blendMode, new Rectangle(0, Math.random() * height * 0.9, width, width * 0.1));
			blendMode = BlendMode.ADD;
			target.draw(source, null, new ColorTransform(0, colorTransform.greenMultiplier, 0), blendMode, new Rectangle(0, Math.random() * height * 0.9, width, width * 0.1));
			target.draw(source, null, new ColorTransform(0, 0, colorTransform.blueMultiplier), blendMode, new Rectangle(0, Math.random() * height * 0.9, width, width * 0.1));
		}
		
		static public function type3(target:BitmapData, source:IBitmapDrawable, matrix:Matrix = null, colorTransform:ColorTransform = null):void {
			var width:int = target.width;
			var height:int = target.height;
			_count ++;
			
			var tempBitmapData:BitmapData = new BitmapData(width, height, false, 0xFF000000);
			tempBitmapData.draw(source, matrix, colorTransform);
			
			target.fillRect(new Rectangle(0, 0, width, height), 0x0);
			var w:Number = width * 0.05 * Math.sin(_count * 0.2);
			var blendMode:String = BlendMode.NORMAL;
			var ma:Matrix = new Matrix();
			ma.tx = -1 * w;
			target.draw(tempBitmapData, ma, new ColorTransform(colorTransform.redMultiplier, 0, 0), blendMode, new Rectangle(0,0, width, height));
			ma.tx = 0 * w;
			blendMode = BlendMode.ADD;
			target.draw(tempBitmapData, ma, new ColorTransform(0, colorTransform.greenMultiplier, 0), blendMode, new Rectangle(0,0, width, height));
			ma.tx = 1 * w;
			target.draw(tempBitmapData, ma, new ColorTransform(0, 0, colorTransform.blueMultiplier), blendMode, new Rectangle(0, 0, width, height));
		}
		
		static public function type4(target:BitmapData, source:IBitmapDrawable, matrix:Matrix = null, colorTransform:ColorTransform = null):void {
			var width:int = target.width;
			var height:int = target.height;
			_count ++;
			
			var tempBitmapData:BitmapData = new BitmapData(width, height, false, 0xFF000000);
			tempBitmapData.draw(source, matrix, colorTransform);
			
			target.draw(tempBitmapData, null, colorTransform, null, new Rectangle(0, 0, width, height));
			var w:Number = 18 * Math.sin(_count * 0.2);
			var blendMode:String = BlendMode.NORMAL;
			var rectangle:Rectangle = new Rectangle(0, Math.random() * height * 0.75, width, height * 0.5 * Math.random());
			var ma:Matrix = new Matrix();
			ma.tx = -1 * w;
			target.draw(tempBitmapData, ma, new ColorTransform(colorTransform.redMultiplier, 0, 0), blendMode, rectangle);
			ma.tx = 0 * w;
			blendMode = BlendMode.ADD;
			target.draw(tempBitmapData, ma, new ColorTransform(0, colorTransform.greenMultiplier, 0), blendMode, rectangle);
			ma.tx = 1 * w;
			target.draw(tempBitmapData, ma, new ColorTransform(0, 0, colorTransform.blueMultiplier), blendMode, rectangle);
		}
		
		static public function type5(target:BitmapData, source:IBitmapDrawable, matrix:Matrix = null, colorTransform:ColorTransform = null):void {
			var width:int = target.width;
			var height:int = target.height;
			
			var noiseBitmapData:BitmapData = getNoiseBitmapData(width, height);
			
			target.draw(source, matrix, colorTransform, null, new Rectangle(0, 0, width, height));
			var ma:Matrix = new Matrix();
			var scale:int = 3;
			ma.scale(scale, scale);
			ma.translate( -Math.random() * width * (scale-1), -Math.random() * height * (scale-1));
			target.draw(noiseBitmapData, ma, colorTransform, BlendMode.SUBTRACT);
		}
		static public function type6(target:BitmapData, source:IBitmapDrawable, matrix:Matrix = null, colorTransform:ColorTransform = null):void {
			var width:int = target.width;
			var height:int = target.height;
			var noiseBitmapData:BitmapData = getNoiseBitmapData(width, height);
			
			target.draw(source, matrix, colorTransform, null, new Rectangle(0, 0, width, height));
			var ma:Matrix = new Matrix();
			var scale:int =  1 + Math.random() * 7;
			ma.scale(scale, scale);
			ma.translate( -Math.random() * width * (scale-1), -Math.random() * height * (scale-1));
			target.draw(noiseBitmapData, ma, colorTransform, BlendMode.MULTIPLY);
		}
		static private var _tempBitmapData:BitmapData;
		static public function type7(target:BitmapData, source:IBitmapDrawable, matrix:Matrix = null, colorTransform:ColorTransform = null):void {
			var width:int = target.width;
			var height:int = target.height;
			
			if (!_tempBitmapData) {
				_tempBitmapData = new BitmapData(Math.ceil(width / 8), Math.ceil(height / 8), false, 0xFF000000);
			}
			
			var scale:int = Math.random() * 32;
			_tempBitmapData.fillRect(_tempBitmapData.rect, 0x000000);
			_tempBitmapData.draw(source, new Matrix(1 / scale, 0, 0, 1 / scale), null,null);
			
			var rectangle:Rectangle = new Rectangle(0, Math.random() * height * 0.75, width, height * 0.5 * Math.random());
			target.draw(_tempBitmapData, new Matrix(scale, 0, 0, scale), colorTransform, null, rectangle);
		}
		
		static public function type8(target:BitmapData, source:IBitmapDrawable, matrix:Matrix = null, colorTransform:ColorTransform = null):void {
			var width:int = target.width;
			var height:int = target.height;
			var tempBitmapData:BitmapData = new BitmapData(width + 20, height+10, false, 0xFF000000);
			tempBitmapData.draw(source, matrix, colorTransform);
			
			var scale:int = Math.random() * 32;
			
			if (!_tempBitmapData) {
				_tempBitmapData = new BitmapData(Math.ceil(width / 8), Math.ceil(height / 8), false, 0xFF000000);
			}
			_tempBitmapData.draw(tempBitmapData, new Matrix(1 / scale, 0, 0, 1 / scale), null, null);
			
			target.draw(tempBitmapData, null, colorTransform, null, new Rectangle(0, 0, width, height));
			
			var rectangle:Rectangle = new Rectangle(0, Math.random() * height * 0.75, width, height * 0.5 * Math.random());
			target.draw(_tempBitmapData, new Matrix(scale, 0, 0, scale), colorTransform, null, rectangle);
		}
	}

}