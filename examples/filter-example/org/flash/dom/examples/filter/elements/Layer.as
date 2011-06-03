package org.flash.dom.examples.filter.elements
{
	import flash.text.TextFieldAutoSize;
	import flash.display.Graphics;
	import flash.text.TextFormat;
	import org.osflash.dom.element.displayadapaters.DOMSpriteNode;

	import flash.display.Sprite;
	import flash.text.TextField;

	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public final class Layer extends DOMSpriteNode
	{

		public function Layer(name : String)
		{
			super(name);
		}
		
		public function draw() : void
		{
			const context : Sprite = displayObject as Sprite;
			
			const textFormat : TextFormat = new TextFormat();
			textFormat.font = "_sans";
			textFormat.size = 16;
			textFormat.color = 0xffffff;
			
			const textField : TextField = new TextField();
			textField.defaultTextFormat = textFormat;
			textField.autoSize = TextFieldAutoSize.LEFT;
			textField.text = id;
			textField.x = (75 - textField.width) * 0.5;
			textField.y = (75 - textField.height) * 0.5;
			
			context.addChild(textField);
			
			const graphics : Graphics = context.graphics;
			graphics.beginFill(0xfff * Math.random());
			graphics.drawRect(0, 0, 75, 75);
			graphics.endFill();
		}

		override public function toString() : String
		{
			return "[Layer]";
		}
	}
}
