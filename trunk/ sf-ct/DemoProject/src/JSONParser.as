package
{
	import cn.sftech.www.object.FoodObject;
	
	import flash.display.Sprite;
	import flash.utils.describeType;
	
	public class JSONParser extends Sprite
	{
		public function JSONParser()
		{
			var foodObj : FoodObject = new FoodObject();
			
			var abc : Object = new Object();
			abc.cccc = "aa";
			abc.dddd = "dd";
			
			var class1 : Class = FoodObject;
			
			getOneJsonObject(foodObj);
			
			for(var oo : Object in abc) {
				trace(abc[oo]);
			}
			
			super();
		}
		
		public static function getOneJsonObject(obj:Object):String  
		{  
			if(obj == null)  
			{  
				return "";  
			}  
			var jsonInfo:String = "{";  
			// 反射出传入对象的属性  
			
			var xml : XML = describeType(obj);
			
			var properties:XMLList = describeType(obj).variable;
			for each(var propertyInfo:XML in properties)
			{
				var propertyName:String = propertyInfo.@name;  
				jsonInfo += "\"" + propertyName + "\":\"" + obj[propertyName] + "\",";
			}
			jsonInfo = jsonInfo.substring(0, jsonInfo.length - 1);  
			jsonInfo += "}"  
			return jsonInfo;  
		}  
	}
}