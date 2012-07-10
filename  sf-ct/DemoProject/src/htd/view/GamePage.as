package htd.view
{
	import cn.sftech.www.view.SFContainer;
	import cn.sftech.www.view.SFMovieClip;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	import htd.event.KindleEndEvent;
	import htd.model.Information;
	import htd.object.CustomerCharacter;
	import htd.object.DollarNumber;
	import htd.object.FoodObject;
	import htd.object.MoneyCount;
	import htd.object.ServeFoodObject;
	import htd.util.BaseUI;
	import htd.util.DataManager;
	
	import org.osmf.events.TimeEvent;


	public class GamePage extends SFContainer
	{
		
		//// Score Pane		
		private var numberPane : NumberPane;
		////  game board
		private var gamePane : GamePane;
		////////////   Food Pane
		private var FoodPan: SFContainer;
		//////////    Collect of selected foods
		private var TablePan : SFContainer;
		/////   Buttton  reset , back , etc
		private var ButtonPan : SFContainer;
		private var gameBackButton :  GameBackButton;
		private var gameMealButton : GameMealButton;
		private var gamePropButton :  GameProp;
		private var gameRestartPlate : GameRestartPlate;
		////////mouse click point 鼠标点击的点
		private var clickPoint :  Point;
		//////   food package.食物打包
		private var packageBag : Packaged;
//		private var pauseBtn : PauseBtn;
		///////
		private var viceMeal : GameViceMeal;
		/**
		 * Food's array (Right table )
		 */		
		private var foodArr :Vector.<FoodObject>;
		/**
		 * selected food's array.
		 */		
		private var foodServeArr : Vector.<ServeFoodObject>;
		private var selectFoodArr:Vector.<int>;
		///////   select food 
		private var selectFoodIndex : int ;
		////     mouse click check
		private var isClickServePane :  Boolean;
		private var isCallPackage :Boolean;
		private var isPickPackage :Boolean;
		///////   game time		
		private var gameTime:int;
		private var customNum:int;
		private var timeSymbol:MovieClip;
		private var gameTimer:Timer;
		// 两种顾客速度的计时器
		private var customerTimer:Timer;
//		// 两种顾客速度的计时器
//		private var secondcustomerTimer:Timer;
		private var isReset : Boolean;
		//private var customPan: EasyCustomerPanes;
		//////    customer's pane
		private var customPan:CustomerPanes;
		
		private var gameMode :int = 0;
		
		// if player select food this pane's number is increased.
		private var selectFoodMoney:MoneyCount;
		
		public function GamePage()
		{
			super();
		}
		
		public function init() : void
		{
			gamePane = new GamePane();
			selectFoodMoney = new MoneyCount();
			//gamePane.GameBackButton.addEventListener(MouseEvent.MOUSE_DOWN, ClickMouseBackButton);
			addChild(gamePane);
			
			numberPane = new NumberPane();
			gamePane.addChild(numberPane);
			
			numberPane.goldCount = 0;
			numberPane.heartCount = 0;
//			numberPane.moneyCount = 0;
			
			gameTime = 0;
			gameTimer = new Timer(1000);
			
			customerTimer = new Timer(1000);
//			secondcustomerTimer =new Timer(8000);
			
			customPan= new CustomerPanes();
			customPan.mouseChildren = false;
			customPan.mouseEnabled = false;	
			gamePane.board.addChild(customPan);		
			
			FoodPan = new SFContainer();
			FoodPan.percentHeight = 100;
			FoodPan.percentWidth = 100;
			FoodPan.backgroundColor = 0x000000;
			FoodPan.backgroundAlpha = 0 ;
			this.addChild(FoodPan);
			
			TablePan = new SFContainer();
			TablePan.percentHeight = 100;
			TablePan.percentWidth = 100;
			TablePan.backgroundColor = 0x000000;
			TablePan.backgroundAlpha = 0 ;
			this.addChild(TablePan);
			
			ButtonPan = new SFContainer();
			ButtonPan.percentHeight = 100;
			ButtonPan.percentWidth = 100;
			ButtonPan.backgroundColor = 0x000000;
			ButtonPan.backgroundAlpha = 0 ;
			this.addChild(ButtonPan);
			
			ButtonPan.addChild(selectFoodMoney);
			selectFoodMoney.moneyCount = 0;
//			updateTimeData();
			
			initData();
			initUI();
			initEvent();
		}
		
		private function initData():void
		{
			this.gameMode =Information.GameMode;
			customNum =0;
			isPickPackage = false;
			isCallPackage= false;
			selectFoodIndex = -1;
			isClickServePane= false;
			isReset =false;
			foodArr=new Vector.<FoodObject>(Information.foodBufferNum);
			selectFoodArr =new Vector.<int>();
			foodServeArr  =  new Vector.<ServeFoodObject>();
		}
		
		/// UI init
		private function initUI():void
		{
			timeSymbol = new TimeSymbol();
			TablePan.addChild(timeSymbol);
			CreateFood();
			CreateButtons();
		}
		
		// this is method to initionalize Event
		private function initEvent():void{
			//			gameTimer.addEventListener(TimerEvent.TIMER, onGameTime);
			customerTimer.start();
			customerTimer.addEventListener(TimerEvent.TIMER , onCustomerStart);
			
			gameTimer.start();
			gameTimer.addEventListener(TimerEvent.TIMER, onGameTime);
			
			updateTimeData();
			this.addEventListener(MouseEvent.MOUSE_DOWN, ClickMouseBackButton);
			this.addEventListener(MouseEvent.MOUSE_MOVE, MovePackage);
			this.addEventListener(MouseEvent.MOUSE_UP,CheckMouseUpOnFood);
			
		}
		
		private function isPickPackaged():void
		{
			if((mouseX > packageBag.x) && (mouseX < packageBag.x+ packageBag.width) 
				&& (mouseY > packageBag.y) &&  (mouseY < packageBag.y + packageBag.height))
			{
				isPickPackage = true;
			}
		}
		
		private function MovePackage(event :MouseEvent):void
		{
			
			if( checkMovePane())
			{
				//isClickServePane = true;
				CallPackage();
				//return;
			}
			
			if(isPickPackage)
			{
				var xPos:int =mouseX - packageBag.width/2 ;
				var yPos:int =mouseY - packageBag.height/2;
				
				if(xPos<0)
					xPos =0;
				if((xPos + packageBag.width ) >480)
					xPos =480 - packageBag.width;
				if(yPos<0)
					yPos =0;
				if((yPos + packageBag.height ) >320)
					yPos =320 - packageBag.height;	
				this.packageBag.x = xPos;
				this.packageBag.y = yPos;
			}
		}
		
		private function ClickMouseBackButton(event:MouseEvent):void
		{
			if(Information.isGameOver)
				return;
			if(!Information.CanClickMouse && Information.GameMode ==  Information.EasyGameMode)
				return;
			if(isCallPackage)
			{
				isPickPackaged();
				
				return;
			}
			
			
			if( (selectFoodArr.length== Information.selectMaxNum) && (this.CheckClickServePan()))
			{
				isClickServePane = true;
				this.clickPoint =new Point(mouseX, mouseY);
			}
				
			
			for(var i:int=0; i<Information.foodBufferNum; i++)
			{
				var col:int = i%(Information.foodBufferNum/2);
				var rol:int = i/(Information.foodBufferNum/2);
				var xPos:int = Information.foodPaneBaseX + (col)*Information.foodWidth;
				var yPos:int = Information.foodPaneBaseY+ (rol)*Information.foodPaneHeight;
				//var xPos:int = Information.foodPaneBaseX + (i%(Information.foodBufferNum/2))*Information.foodWidth;
				//var yPos:int = Information.foodPaneBaseY+ (i/(Information.foodBufferNum/2))*Information.foodPaneHeight;
				var width:int = Information.foodPaneWidth;
				var height:int = Information.foodHeight;
				if((mouseX>xPos) && (mouseX<(xPos+width)) && (mouseY>yPos) && (mouseY<(yPos+height)))
				{
					
					for(var j:int=0; j<selectFoodArr.length; j++)
					{
						if(this.selectFoodArr[j] == i)
						{
							
							//foodArr[selectFoodIndex].goToStartState();
							//selectFoodIndex=-1;
							return;
						}								
					}
					selectFoodIndex=i;
					var clickFood:FoodObject = foodArr[i];
					//clickFood.palyAndStopEnd();
					
				}
				
			}
			
		}
		
		private function checkMovePane():Boolean
		{
			if(isClickServePane)
			{
				//var value :  int = Math.abs(mouseX-this.clickPoint.x)+Math.abs(mouseY-this.clickPoint.y);
				//if(value >5)
				{
					isClickServePane=false;
					return true;
				}
			}
			//isClickServePane=false;
			
			return false;
		}
		
		// this is method to appear bag including food.
		
		
		private function CallPackage():void
		{
			reset();
			isCallPackage= true;
			this.isPickPackage = true;
			packageBag =new Packaged();
			var DollorNum:DollarNumber = new DollarNumber();
			DollorNum.dollarInBag = selectFoodMoney.moneyCount;
			packageBag.addChild(DollorNum);
			packageBag.x= Information.servePanBaseX+25;
			packageBag.y= Information.servePanBaseY-10;
			this.ButtonPan.addChild(packageBag);
		}
		
		//this is bag come back and appear food on serve
		private function ComeBackFood():void
		{
			for(var i:int; i<foodServeArr.length; i++)
			{
				var servCol:int = i%2;
				var servRol:int = i/2;
				foodServeArr[i].x=Information.servePanBaseX+Information.servePanWidth*servCol;
				foodServeArr[i].y=Information.servePanBaseY +Information.servePanHeight*servRol;	
				//foodServeArr.push(serveFood);								
				this.TablePan.addChild(foodServeArr[i]);
			}
		}
		
		
		private function checkCustomHappy():void
		{
			if(Information.isGameOver)
			{
				if(packageBag)
				{
					this.ButtonPan.removeChild(packageBag);
					packageBag=null;
				}
				return;
			}
			
			for(var i:int =0 ; i<4; i++)
			{
				if( customPan.customArr[0].happyFood == this.foodServeArr[i].type )					
				{
					if(customPan.customArr[0].canGiveMoney >=selectFoodMoney.moneyCount)
					{
						//customPan.customArr[0].addEventListener(KindleEndEvent.KINDLE_END_EVENT, GoNextMember);
						
						customPan.customArr[0].Happy(true);
						numberPane.heartCount +=1;
						numberPane.goldCount +=  selectFoodMoney.moneyCount;
						customPan.goToEndPlace();
						return;
					}
					else
					{
						customPan.customArr[0].Happy(false);
						numberPane.goldCount +=  customPan.customArr[0].canGiveMoney;
						customPan.goToEndPlace();
						return;
					}
					
				}
			}
			
			customPan.customArr[0].Happy(false);
			customPan.goToEndPlace();
			
		}
		
	/*	private function GoNextMember(event : KindleEndEvent):void{
			
			//customPan.removeChild(event.target as CustomerCharacter);
			Information.CustomerCharacterIndex++;
			this.customPan.gotolastState(Information.CustomerCharacterIndex);
		}
		
		*/
		
		
		/// select  customer to recieve food (near person from mouse)
		
		private function checkCustom():void{
			if(Information.isGameOver)
				return;
			var index:int = 0;
			var distance:int =500;
			var isContainIndex:Boolean = false;
			for (var i:int =0 ; i<this.customPan.customArr.length; i++)
			{
				if((customPan.customArr[i] != null)&& (customPan.customArr[i].CanBuyFood))
					isContainIndex = true;
			}
			if(!isContainIndex)return;
			
			for ( i =0 ; i<this.customPan.customArr.length; i++)
			{
				if((customPan.customArr[i] != null)&& (customPan.customArr[i].CanBuyFood) && ( Math.abs(this.mouseX-customPan.customArr[i].x) < distance))
				{
					index = i;
					distance =Math.abs(this.mouseX-customPan.customArr[i].x);
				}
			}
			
			for( i =0 ; i<4; i++)
			{
				if(( customPan.customArr[index].happyFood == this.foodServeArr[i].type) )					
				{
					if(customPan.customArr[index].canGiveMoney >=selectFoodMoney.moneyCount)
					{
						//customPan.customArr[0].addEventListener(KindleEndEvent.KINDLE_END_EVENT, GoNextMember);
						
						customPan.customArr[index].Happy(true);
						numberPane.heartCount +=1;
						numberPane.goldCount +=  selectFoodMoney.moneyCount;
						customPan.goToRandomEndPlaceEvery(index);
						return;
					}
					else
					{
						customPan.customArr[index].Happy(false);
						numberPane.goldCount +=  customPan.customArr[index].canGiveMoney;
						customPan.goToRandomEndPlaceEvery(index);
						return;
					}
					
				}
			}
			
			customPan.customArr[index].Happy(false);
			customPan.goToRandomEndPlaceEvery(index);
			
			
			
		}
		
		///////  Raal logic  selection food and pick package
		private function CheckMouseUpOnFood(event:MouseEvent):void
		{
			
			
			gameRestartPlate.gotoAndStop(1);
			if(selectFoodIndex != -1)
				foodArr[selectFoodIndex].goToStartState();
			
			if(isPickPackage)
			{
				
				if(this.mouseY< (Information.servePanBaseY-this.packageBag.height/2))
				{
					this.ButtonPan.removeChild(packageBag);
					packageBag=null;
					if(Information.GameMode == Information.EasyGameMode)
						checkCustomHappy();	
					else if (Information.GameMode == Information.RandomGameMode)
					{
						checkCustom();
					}
					
					selectFoodMoney.moneyCount = 0;
					resetData();
					isPickPackage=false;
					isCallPackage =false;
					Information.CanClickMouse =  false;
					
					return;
				}
				else
				{
					this.ButtonPan.removeChild(packageBag);
					packageBag=null;
					isPickPackage=false;
					isCallPackage =false;
					///packageBag.x= Information.servePanBaseX+30;
					///packageBag.y= Information.servePanBaseY-20;
					ComeBackFood();
					//isCallPackage =false;
					return;
				}
					
					
			}
			
			isPickPackage=false;
			
			
			
			for(var i:int=0; i<Information.foodBufferNum; i++)
			{
				var col:int = i%(Information.foodBufferNum/2);
				var rol:int = i/(Information.foodBufferNum/2);
				var xPos:int = Information.foodPaneBaseX + (col)*Information.foodWidth;
				var yPos:int = Information.foodPaneBaseY+ (rol)*Information.foodPaneHeight;
				var width:int = Information.foodPaneWidth;
				var height:int = Information.foodHeight;
				if((mouseX>xPos) && (mouseX<(xPos+width)) && (mouseY>yPos) && (mouseY<(yPos+height)))
					{
						if((selectFoodIndex == i) && (selectFoodArr.length<Information.selectMaxNum)) 
						{
							
							
							/*
							if you want player must 
							*/
//							if((selectFoodArr.length == 0) && (i != 0))
//							{
//								selectFoodIndex=-1;
//								return;
//							}
							for(var j:int=0; j<selectFoodArr.length; j++)
							{
								if(this.selectFoodArr[j] == i)
								{
									
									//foodArr[selectFoodIndex].goToStartState();
									selectFoodIndex=-1;
									return;
								}								
							}
							
							{
								var serveFood:ServeFoodObject =new ServeFoodObject();
								serveFood.type =foodArr[i].type;								
								selectFoodMoney.moneyCount += foodArr[i].price;
								var servCol:int = (foodServeArr.length)%2;
								var servRol:int = foodServeArr.length/2;
								serveFood.x=Information.servePanBaseX+Information.servePanWidth*servCol;
								serveFood.y=Information.servePanBaseY +Information.servePanHeight*servRol;	
								foodServeArr.push(serveFood);								
								this.TablePan.addChild(serveFood);
								selectFoodArr.push(i);
								//foodArr[selectFoodIndex].state = 3;;
								selectFoodIndex = -1;
								return;
							}
						}
						else
						{
							//foodArr[selectFoodIndex].goToStartState();
							selectFoodIndex = -1;
							return;
						}
						
					}
				
				
			}
			
			selectFoodIndex = -1;
			
		}
		
		/////  
		/*
				Insert food on the table for waiting to select
		*/
		
		private function CreateFood():void
		{
			for(var i:int =0; i<Information.foodBufferNum; i++)
			{
				var foodMember:FoodObject =new FoodObject();
				var col:int=i%(Information.foodBufferNum/2);
				var rol:int=i/(Information.foodBufferNum/2);
				foodMember.type = i;
				foodMember.x= Information.foodBaseX + Information.foodWidth * (col);
				foodMember.y= Information.foodBaseY + Information.foodHeight * (rol);
				
				foodArr[i] = foodMember;
				FoodPan.addChild(foodMember);
				var numMovi: DollarNumber=new DollarNumber();
				numMovi.x=foodMember.x - 8;
				if(rol == 1)
					numMovi.y=foodMember.y -31;
				else
					numMovi.y=foodMember.y -32;
				numMovi.valueNum = foodMember.price;
				FoodPan.addChild(numMovi);
			}
		}
		
		//////  insert Button
		private function CreateButtons():void
		{
			gameBackButton =  new GameBackButton();			
			gameBackButton.x= Information.gameBackButton_Xpos  ;
			ButtonPan.addChild(gameBackButton);
			gameMealButton = new GameMealButton();
			gameMealButton.x =Information.gameMealButton_Xpos
			gameMealButton.y =Information.gameMealButton_Ypos
			ButtonPan.addChild(gameMealButton);
			gamePropButton =  new GameProp();
			gamePropButton.x = Information.gameMealButton_Xpos;
			gamePropButton.y = Information.gamePropButton_Ypos;		
			ButtonPan.addChild(gamePropButton);
			viceMeal =new  GameViceMeal();
			viceMeal.x =Information.gameMealButton_Xpos;
			viceMeal.y =Information.gameViceButton_Ypos;
			ButtonPan.addChild(viceMeal);
			gameRestartPlate= new GameRestartPlate();
			gameRestartPlate.x=Information.gameRestartPlateButton_Xpos;
			gameRestartPlate.y=Information.gameRestartPlateButton_Ypos;
			
			gameRestartPlate.addEventListener(MouseEvent.MOUSE_DOWN, ClickRestartButton);
			gameRestartPlate.addEventListener(MouseEvent.MOUSE_UP, UpRestartButton);
			
//			pauseBtn =new PauseBtn();
			ButtonPan.addChild(gameRestartPlate);
			
		}
		
		///////  Click and Over RestartButton
		
		private function ClickRestartButton(event :MouseEvent):void
		{
			this.isReset = true ;
			gameRestartPlate.gotoAndStop(2);
			//viceMeal.gotoAndStop(2);
		}
		
		
		
		private function UpRestartButton(event :MouseEvent):void
		{
			if(isReset)
			{
				if(!isCallPackage)
					selectFoodMoney.moneyCount =0
				reset();
				resetData();
				
			}
			
		}
		
		///// If customer pick Package
		private function CheckClickServePan():Boolean
		{
			if((mouseX > Information.moveAblePositionX) && (mouseX < Information.moveAblePositionX+ Information.moveAblePositionWidth) 
			&& (mouseY > Information.moveAblePositionY) &&  (mouseY < Information.moveAblePositionY + Information.moveAblePositionHeight))
			{
				return true;
			}
			
			return false;
		}
		
	
		
		/////// Reset All food on the package table(on the left)
		
		private function resetData():void
		{
			selectFoodArr =new Vector.<int>();
			foodServeArr  =  new Vector.<ServeFoodObject>();
		}
		
		////// reset All
		private function reset():void
		{
			this.isReset = false ;			
			gameRestartPlate.gotoAndStop(1);
			selectFoodIndex = -1;
			isReset =false;
//			for(var index:int; index<foodArr.length; index++)
//				foodArr[index].state=1;
			for(var index:int =0; index<foodServeArr.length; index++)
			{
				if(!this.isCallPackage && !this.isPickPackage )
					TablePan.removeChild(foodServeArr[index]);
				//foodServeArr[index] =null;
			}
			//foodArr=new Vector.<FoodObject>(Information.foodBufferNum);
			
		}
		
		/////  Remove serve food
		
		private function removePane():void
		{
			selectFoodMoney.moneyCount =0;
			if(foodServeArr.length>0)
			{
				for(var index:int =0; index<foodServeArr.length; index++)
				{
					if(!this.isCallPackage && !this.isPickPackage  && (foodServeArr[index] != null))
					{
						TablePan.removeChild( foodServeArr[index]);
						foodServeArr[index] =null;
					}
				}
			}
		}
		
		/////// count time
		private function updateTimeData():void
		{
			
			var str:String = "";
			var useTime:int;
			var minute:int;
			var second:int;
			if(Information.GameMode == Information.EasyGameMode)
				useTime = Information.Easy_TIME_LINE-gameTime;
			else 
				useTime = Information.Random_TIME_LINE-gameTime;
			minute = int(useTime/60);
			second = (useTime%60);
			
			str += minute.toString();
			if (second < 10)
				str += "0" + second.toString();
			else
				str += second.toString();
			BaseUI.showInfo(timeSymbol, str, "timeNum", 3);
			timeSymbol.x = Information.timeSymbol_x;
			timeSymbol.y = Information.timeSymbol_y;
			
		}
		
		/////// timer event function
		private function onGameTime(event:TimerEvent):void
		{
			gameTime++;
			var timeLineOfGame: int  = 0;
			if(Information.GameMode == Information.EasyGameMode)
				timeLineOfGame= Information.Easy_TIME_LINE;
			else
				timeLineOfGame= Information.Random_TIME_LINE;
			
			
			if(gameTime>timeLineOfGame)
			{
				gameTimer.removeEventListener(TimerEvent.TIMER,onGameTime);
				Information.isGameOver=true;
				this.reset();
				this.resetData();
				removePane();
				if(gameMode == Information.EasyGameMode)
					this.customPan.removeAll();
				else if (this.gameMode ==  Information.RandomGameMode)
					customPan.removeRandomAll();
				//new DataManager
				DataManager.saveScore(numberPane.goldCount);
			}
			else
				updateTimeData();
		}
		/////Customer start comming
		private function onCustomerStart(event : TimerEvent):void
		{
			customerTimer.stop();
			if(this.gameMode == Information.EasyGameMode)
				this.customPan.goTofirstPlace();
			else if (this.gameMode ==  Information.RandomGameMode)
				this.customPan.goToRandomfirstPlace();
			
		}
		
		
		
	}
}