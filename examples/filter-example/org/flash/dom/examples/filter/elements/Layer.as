package org.flash.dom.examples.filter.elements
{
	import org.osflash.dom.element.displayadapaters.DOMSpriteNode;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public final class Layer extends DOMSpriteNode
	{

		private var _width : int;

		private var _height : int;
		
		private var _textField : TextField;
		
		private var _bitmap : Bitmap;

		public function Layer(name : String)
		{
			super(name);
			
			const textFormat : TextFormat = new TextFormat();
			textFormat.font = "_sans";
			textFormat.size = 12;
			textFormat.color = 0xcfcfcf;
			
			_textField = new TextField();
			_textField.defaultTextFormat = textFormat;
			_textField.autoSize = TextFieldAutoSize.LEFT;
			
			_bitmap = new Bitmap();

			const context : Sprite = displayObject as Sprite;
			context.addChild(_bitmap);
		}
		
		public function draw() : void
		{
			_bitmap.bitmapData = new BitmapData(width, height, true, 0x000000);
			_bitmap.bitmapData.fillRect(new Rectangle(1, 1, _width - 2, _height - 2), 0xff3c3c3c);
			
			_textField.text = id;
						
			const matrix : Matrix = new Matrix();
			matrix.tx = (_width - _textField.width) * 0.5;
			matrix.ty = (_height - _textField.height) * 0.5;
			
			_bitmap.bitmapData.draw(_textField, matrix);
			
			_textField = null;
		}

		public function get width() : int
		{
			return _width;
		}

		public function set width(value : int) : void
		{
			_width = value;
		}

		public function get height() : int
		{
			return _height;
		}

		public function set height(value : int) : void
		{
			_height = value;
		}
		
		override public function toString() : String
		{
			return "[Layer]";
		}
	}
}
