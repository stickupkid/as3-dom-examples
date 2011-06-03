package org.flash.dom.examples.filter
{
	import org.flash.dom.examples.filter.elements.Layer;
	import org.osflash.dom.element.IDOMDocument;
	import org.osflash.dom.element.IDOMNode;
	import org.osflash.dom.element.displayadapaters.DOMSpriteDocument;

	import flash.display.Sprite;

	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	[SWF(backgroundColor="#1d1d1d", frameRate="60", width="800", height="800")]
	public class FilterExample extends Sprite
	{

		private var _document : IDOMDocument;

		public function FilterExample()
		{
			super();

			_document = new DOMSpriteDocument(stage);
			
			
			for(var i : int = 0; i<100; i++)
			{
				const layer : Layer = new Layer("layer");
				layer.id = "layer" + i;
				layer.draw();
				
				_document.add(layer);
			}
			
			const query : Vector.<IDOMNode> = _document.select("layer.(@index < 25 || @index > 75)");
			
			position(query);
		}
		
		protected function position(nodes : Vector.<IDOMNode>) : void
		{
			var ix : int = 0;
			var iy : int = 0;
			for(var i : int = 0; i<100; i++)
			{
				const layer : Layer = _document.getAt(i) as Layer;
				if(nodes.indexOf(layer) >= 0)
				{
					layer.displayObject.x = (ix % 10) * 75;
					layer.displayObject.y = iy * 75;
					layer.displayObject.alpha = 1.0;
					
					ix++;
					if(ix % 10 == 0) iy++;
				}
				else
				{
					layer.displayObject.x = 0;
					layer.displayObject.y = 0;
					layer.displayObject.alpha = 0.0;
				}
			}
		}
		
		override public function toString() : String
		{
			return "[FilterExample]";
		}
	}
}
