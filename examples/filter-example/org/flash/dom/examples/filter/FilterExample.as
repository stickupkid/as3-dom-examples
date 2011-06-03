package org.flash.dom.examples.filter
{
	import com.greensock.TweenLite;

	import org.flash.dom.examples.filter.elements.Layer;
	import org.osflash.dom.element.IDOMDocument;
	import org.osflash.dom.element.IDOMNode;
	import org.osflash.dom.element.displayadapaters.DOMSpriteDocument;

	import flash.display.Sprite;
	import flash.utils.setTimeout;

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
				layer.displayObject.x = Math.random() * 720;
				layer.displayObject.y = Math.random() * 720;
				layer.draw();
				
				_document.add(layer);
			}
			
			cycle();
		}
		
		protected function cycle() : void
		{
			var query : Vector.<IDOMNode>;
			var delay : int = 1000;
			
			setTimeout(function() : void
						{
							query = _document.select("*");
							position(query);
							
							setTimeout(function() : void
							{
								query = _document.select("layer.(@index < 25 || @index > 75)");
								position(query);
									
								setTimeout(function() : void
								{
									query = _document.select("layer.(@index > 25 && @index < 75)");
									position(query);
									
									setTimeout(function() : void
									{
										query = _document.select("layer.(@index < 50)");
										position(query);
										
										setTimeout(function() : void
										{
											query = _document.select("layer.(@index >= 50)");
											position(query);
											
											cycle();
										}, delay);
									}, delay);
								}, delay);
							}, delay);
						}, delay);
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
					new TweenLite(layer.displayObject, 0.45, {
						x: (ix % 10) * 80,
						y: iy * 80,
						alpha: 1.0	
					});
										
					ix++;
					if(ix % 10 == 0) iy++;
				}
				else
				{
					new TweenLite(layer.displayObject, 0.45, {
						alpha: 0.0,
						onComplete: function(layer : Layer) : void
						{
							layer.displayObject.x = Math.random() * 720;
							layer.displayObject.y = Math.random() * 720;
						},
						onCompleteParams: [layer]
					});
				}
			}
		}
		
		override public function toString() : String
		{
			return "[FilterExample]";
		}
	}
}
