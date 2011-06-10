package org.flash.dom.examples.filter
{
	import com.greensock.TweenLite;

	import org.flash.dom.examples.filter.elements.Layer;
	import org.osflash.dom.element.DOMDocument;
	import org.osflash.dom.element.IDOMDocument;
	import org.osflash.dom.element.IDOMNode;

	import flash.display.Sprite;
	import flash.utils.setTimeout;

	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	[SWF(backgroundColor="#1d1d1d", frameRate="60", width="800", height="800")]
	public class FilterExample extends Sprite
	{
		
		public static const NUM_ROWS : int = 25;
		
		public static const NUM_COLUMNS : int = 25;
		
		public static const NUM_LAYERS : int = NUM_ROWS * NUM_COLUMNS;
		
		private var _document : IDOMDocument;

		public function FilterExample()
		{
			super();

			_document = new DOMDocument();
			
			const layerWidth : int = 32;
			const layerHeight : int = 32;
			
			for(var i : int = 0; i<NUM_LAYERS; i++)
			{
				const layer : Layer = new Layer("layer");
				layer.id = "" + i;
				layer.displayObject.x = Math.random() * (800 - layerWidth);
				layer.displayObject.y = Math.random() * (800 - layerHeight);
				layer.displayObject.alpha = 0.0;
				layer.width = layerWidth;
				layer.height = layerHeight;
				layer.draw();
				
				_document.add(layer);
				
				this.addChild(layer.displayObject);
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
								query = _document.select("layer.(@index < 50 || @index > 206)");
								position(query);
									
								setTimeout(function() : void
								{
									query = _document.select("layer.(@index > 100 && @index < 200)");
									position(query);
									
									setTimeout(function() : void
									{
										query = _document.select("layer.(@index < 100)");
										position(query);
										
										setTimeout(function() : void
										{
											query = _document.select("layer.(@index >= 150)");
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
			for(var i : int = 0; i<NUM_LAYERS; i++)
			{
				const layer : Layer = _document.getAt(i) as Layer;
				if(nodes.indexOf(layer) >= 0)
				{
					new TweenLite(layer.displayObject, 0.45, {
						x: (ix % NUM_COLUMNS) * layer.width,
						y: iy * layer.height,
						alpha: 1.0,
						delay: Math.random() * 0.4
					});
										
					ix++;
					if(ix % NUM_ROWS == 0) iy++;
				}
				else
				{
					new TweenLite(layer.displayObject, 0.45, {
						alpha: 0.0,
						delay: Math.random() * 0.5,
						onComplete: function(layer : Layer) : void
						{
							layer.displayObject.x = Math.random() * (800 - layer.width);
							layer.displayObject.y = Math.random() * (800 - layer.height);
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
