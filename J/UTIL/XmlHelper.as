package J.UTIL
{
	import flash.xml.XMLDocument;
	import flash.xml.XMLNode;
	
	/** @author Feyyaz */
	
	public class XmlHelper 
	{
		
		public function XmlHelper() { }
		
		public static function FirstNodes(XmlSource:XML):Array {
			var XmlDoc:XMLDocument = new XMLDocument();
			XmlDoc.ignoreWhite = true;
			XmlDoc.parseXML(XmlSource.toXMLString());
			return XmlDoc.firstChild.childNodes;
		}
		
		public static function ConvertAttributesToObject(arrList:Array):Array {
			var obj:Object;
			var arr:Array = new Array();
			var i:Number = 0;
			for each(var Item:XMLNode in arrList) {
				obj = Item.attributes;
				arr[i] = obj;
				i++;
            }
			return arr;
		}
	}	
}