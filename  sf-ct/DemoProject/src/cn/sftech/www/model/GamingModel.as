package cn.sftech.www.model
{
	import cn.sftech.www.object.FoodObject;

	public class GamingModel extends ResMenuData
	{
		/**
		 * 游戏进行中的食物候选列表
		 */		
		public var gameingFoods : Vector.<FoodObject> = new Vector.<FoodObject>(Information.foodBufferNum);
		
		public function GamingModel()
		{
		}
		
		public function getFoodPrice(index : int) : int
		{
			return gameingFoods[index].price;
		}
	}
}