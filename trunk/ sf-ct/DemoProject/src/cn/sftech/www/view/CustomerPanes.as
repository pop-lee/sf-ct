package cn.sftech.www.view
{
	import cn.sftech.www.util.MathUtil;
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	import flashx.textLayout.formats.Float;
	
	import cn.sftech.www.event.KindleEndEvent;
	import cn.sftech.www.event.WaitPersonFinishEvent;
	import cn.sftech.www.model.Information;
	import cn.sftech.www.object.CustomerCharacter;
	
	
	public class CustomerPanes extends SFMovieClip
	{
		//Customer Buffer		
		public var customArr:Vector.<CustomerCharacter>;
		
		private var secondPlaceTimer:Timer;
		private var thirdPlaceTimer:Timer;
		private var newCustomTimer:Timer;
		private var newfirstWaitTimer:Timer;
		private var newsecondWaitTimer:Timer;
		private var newthirdWaitTimer:Timer;
		private var removedIndex:int;
		private var removedwaitIndex:int;
		private var firstPersonWaitingTimer: Timer;
		private var secondPersonWaitingTimer: Timer;
		private var thirdPersonWaitingTimer: Timer;
//		private var endTalk : Boolean = false;
		private var isGetingPos:Boolean ;		
		private var newendTalk : Boolean = false;
		private var isCanGetPos: Boolean = true;
		//private var firstendTalk : Boolean = false;
		//private var secondendTalk : Boolean = false;
		//private var thirdendTalk : Boolean = false;
		
		private var isCallRemainNum:int = -1;
		
		private var fourthPlaceTimer:Timer;
		private var fifthPlaceTimer:Timer;
		
		//private var i:  TimerEvent
		
		
		public function CustomerPanes()
		{
			if(Information.GameMode == Information.EasyGameMode)
			{
				secondPlaceTimer = new Timer(Information.EasyFrontTime);
				thirdPlaceTimer  = new Timer(Information.EasyFrontTime);
				fourthPlaceTimer = new Timer(Information.EasyFrontTime);
				fifthPlaceTimer  = new Timer(Information.EasyFrontTime);
				secondPlaceTimer.addEventListener(TimerEvent.TIMER , onSecondCustomerStart);			
				thirdPlaceTimer.addEventListener(TimerEvent.TIMER , onthirdCustomerStart);
				fourthPlaceTimer.addEventListener(TimerEvent.TIMER , onfourthCustomerStart);
				fifthPlaceTimer.addEventListener(TimerEvent.TIMER , onfifthCustomerStart);
			}
			else if(Information.GameMode == Information.RandomGameMode)
			{
				secondPlaceTimer = new Timer(Information.RandomFrontTime);
				thirdPlaceTimer  = new Timer(Information.RandomBackTime);
				secondPlaceTimer.addEventListener(TimerEvent.TIMER , onRandomSecondCustomerStart);			
				thirdPlaceTimer.addEventListener(TimerEvent.TIMER , onthirdRandomCustomerStart);
				newCustomTimer    = new Timer(Information.CalulateTime);
				newCustomTimer.addEventListener(TimerEvent.TIMER , onNewRandomCustomerStart);
				newfirstWaitTimer    =new Timer(Information.RandomFrontTime);
				newfirstWaitTimer.addEventListener(TimerEvent.TIMER , onNewFirstRandomCustomerStart);
				newsecondWaitTimer    =new Timer(Information.RandomFrontTime);
				newsecondWaitTimer.addEventListener(TimerEvent.TIMER , onNewSecondRandomCustomerStart);
				newthirdWaitTimer    =new Timer(Information.RandomFrontTime);
				newthirdWaitTimer.addEventListener(TimerEvent.TIMER , onNewThirdRandomCustomerStart);
			}
			removedIndex = -1;
			removedwaitIndex =-1;
			customArr =new Vector.<CustomerCharacter>(3);
			newendTalk  = false;
			isCanGetPos = true;
			//firstendTalk = false;
			//secondendTalk = false;
			//thirdendTalk = false;
			isGetingPos= false;
			isCallRemainNum = -1;
			super();
		}
		
		private function onSecondCustomerStart(event:TimerEvent):void
		{
			
			secondPlaceTimer.stop();
			goTosecondPlace();
		}
		
		
		private function onfourthCustomerStart(event:TimerEvent):void
		{
			
			fourthPlaceTimer.stop();
			goToFourthPlace();
		}
		
		
		private function onfifthCustomerStart(event:TimerEvent):void
		{
			
			fifthPlaceTimer.stop();
			goToFifthPlace();
		}
		
		private function onRandomSecondCustomerStart(event:TimerEvent):void
		{
			secondPlaceTimer.stop();
			goTosecondRandomPlace();
		}
		
		
		private function onthirdCustomerStart(event:TimerEvent):void
		{
			thirdPlaceTimer.stop();
			goToThirdPlace();
			
		}
		
		private function onthirdRandomCustomerStart(event:TimerEvent):void
		{
			thirdPlaceTimer.stop();
			this.goTothirdRandomPlace();
			
		}
		
		/*
		 * creat customer 
		*/
		
		public function CreateCustomerArr():void
		{
			if(Information.GameMode == Information.EasyGameMode)
			{
				for(var i:int =0; i< 4; i++)
				{
					var customer:CustomerCharacter =new CustomerCharacter();
					customer.type = MathUtil.random(0,4);
					customer.orderNums = i;
					customArr[i] = customer;
					customArr[i] .y= Information.personCharaterY;
					customArr[i] .x= Information.personCharaterX;
					addChild(customer);
					this.setChildIndex(customArr[i],0);
				}
			}
			
			if(Information.GameMode == Information.RandomGameMode)
			{
				for( i =0; i< 3; i++)
				{
					customer =new CustomerCharacter();
					customer.type = MathUtil.random(0,4);
					customer.orderNums = i;
					customArr[i] = customer;			
					customArr[i] .y= Information.personCharaterY;
					customArr[i] .x= Information.personCharaterX;
					customArr[i].arrivedPosition = new Point(Information.personCharaterX,Information.personCharaterY);
					//  		customArr[i].addEventListener(WaitPersonFinishEvent.NOT_WAIT_FINISH,NoWait);
					addChild(customer);
					this.setChildIndex(customArr[i],0);
				}
			}
		}
		
		/*
		 *   In easy mode 
		*/
		
		public function goTofirstPlace():void
		{
			if(Information.isGameOver)
				return;
			var posX:int =customArr[0].firstPos + Information.easy_mod_firstPosOffset;
			var timeLine:Number =  (customArr[0].x-posX)/Information.characterInSpeed;
			TweenLite.to(customArr[0], timeLine,
				{
					x:posX, y:customArr[0].y,
					ease:Linear.easeNone, delay:0, onComplete:StartFirstPersonTalk
				}
			);	
			
		}
		
		
		
		public function goTosecondPlace():void
		{
			if(Information.isGameOver)
				return;
			var posX:int =customArr[0].x+customArr[0].personOfWidth-20;
			var timeLine:Number =  (customArr[1].x-posX)/Information.characterInSpeed;
			TweenLite.to(customArr[1], timeLine,
				{
					x:posX, y:customArr[1].y,
					ease:Linear.easeNone, delay:0, onComplete:StartSecondPersonMove
				}
			);	
			
		}
		
		
		
		public function goToThirdPlace():void
		{
			if(Information.isGameOver)
				return;
			var posX:int =customArr[1].x+customArr[1].personOfWidth-20;
			var timeLine:Number =  (customArr[2].x-posX)/Information.characterInSpeed;
			TweenLite.to(customArr[2], timeLine,
				{
					x:posX, y:customArr[2].y,
					ease:Linear.easeNone, delay:0, onComplete:StartThirdPersonMove
				}
			);	
			
		}
		
		
		public function StartThirdPersonMove():void
		{
			if(Information.isGameOver)
				return;
			fourthPlaceTimer.start();
		}
		
		
		public function goToFourthPlace():void
		{
			if(Information.isGameOver)
				return;
			var posX:int =customArr[2].x+customArr[2].personOfWidth-20;
			var timeLine:Number =  (customArr[3].x-posX)/Information.characterInSpeed;
			TweenLite.to(customArr[3], timeLine,
				{
					x:posX, y:customArr[3].y,
					ease:Linear.easeNone, delay:0/*, onComplete:StartForthPersonMove*/
				}
			);	
			
		}
		
		public function StartForthPersonMove():void
		{
			if(Information.isGameOver)
				return;
			fifthPlaceTimer.start();
		}
		
		
		
		public function goToFifthPlace():void
		{
			if(Information.isGameOver)
				return;
			var posX:int =customArr[3].x+customArr[3].personOfWidth-20;
			var timeLine:Number =  (customArr[4].x-posX)/Information.characterInSpeed;
			TweenLite.to(customArr[4], timeLine,
				{
					x:posX, y:customArr[3].y,
					ease:Linear.easeNone, delay:0/*, onComplete:goToEndPlace*/
				}
			);	
			
		}
		
		
		
		
		public function goToEndPlace():void
		{
			if(Information.isGameOver)
				return;
			
			customArr[0].removeTalk();
			var posX:int =-150;
			var timeLine:Number =  (customArr[0].x-posX)/Information.characterExitSpeed;
			TweenLite.to(customArr[0], timeLine,
				{
					x:posX, y:customArr[0].y,
					ease:Linear.easeNone, delay:0.7, onComplete:resetPerSonArray
				}
			);	
			
		}
		
		//public function 
		
		public function StartSecondPersonMove():void
		{
			if(Information.isGameOver)
				return;
			thirdPlaceTimer.start();
		}
		
		
		public function StartFirstPersonTalk():void
		{
			if(Information.isGameOver)
				return;
			customArr[0].addEventListener(KindleEndEvent.KINDLE_END_EVENT, OnCompleteAppTalk);
			customArr[0].kindlTalkAnimation();
		}
		
		/**
		 * 移动到指定位置后，显示对话
		 * @param event
		 * 
		 */		
		private function OnCompleteAppTalk(event : Event):void
		{
			
			if(Information.isGameOver)
				return;
			customArr[0].addTalk();
			
			if(Information.GameMode == Information.RandomGameMode)
			{
				if(this.firstPersonWaitingTimer)firstPersonWaitingTimer = null;
				this.firstPersonWaitingTimer = new Timer(customArr[0].WaitingTime);
				firstPersonWaitingTimer.start();
				firstPersonWaitingTimer.addEventListener(TimerEvent.TIMER, OnFirstWaitComp);
			}
			if(Information.GameMode == Information.EasyGameMode)
			{
				secondPlaceTimer.start();				
			}
			else if(Information.GameMode == Information.RandomGameMode)
			{
				secondPlaceTimer.start();
			}
		}
		/**
		 * 等待结束时间之后调用触发
		 * @param event
		 * 
		 */		
		private function OnFirstWaitComp(event : TimerEvent):void
		{
			firstPersonWaitingTimer.stop();
			goToWaitRandomEndPlaceEvery(0);
			
		}
		
		private function OnSecondWaitComp(event : TimerEvent):void
		{
			
			secondPersonWaitingTimer.stop();
			goToWaitRandomEndPlaceEvery(1);
			
		}
		private function OnThirdWaitComp(event : TimerEvent):void
		{
			thirdPersonWaitingTimer.stop();
			goToWaitRandomEndPlaceEvery(2);
			
			
		}
		
		public function kindleCustomer(index:int):void
		{
		
				customArr[index].addEventListener(KindleEndEvent.KINDLE_END_EVENT, onCompletFireWorks);
				customArr[index].gotofirstPlace();
		
			
		}
		
	
		
		
		public function  onCompletFireWorks(event : KindleEndEvent):void
		{
			//event.target.
			event.target.addEventListener(KindleEndEvent.KINDLE_END_EVENT, onCompletsecondWorks);
			event.target.waitForSecondPosition();
		}
		
		
		public function  onCompletsecondWorks(event : KindleEndEvent):void
		{
			//var test:int =0 ;
			event.target.addTalk();
			if(Information.GameMode == Information.RandomGameMode)
			{
				switch(event.target.orderNums)
				{
					case 0:
					{
						//this.firstendTalk = false
						newendTalk =false;
					}break;
					
					case 1:
					{
						//this.secondendTalk = false
						newendTalk =false;
					}break;
					
					case 2:
					{
						//thirdendTalk = false
						newendTalk =false;
					}break;
				}
			}

		}
		
		

		
		public function  gotolastState(index:int):void
		{
			var ind:int = index-1;
			if(ind>=1)
				this.removeChild(customArr[ind]);
			
			if(index>3)
				return;
			customArr[index].addEventListener(KindleEndEvent.KINDLE_END_EVENT, onCompletsecondWorks);
			customArr[index].golastPlace();
		}
		
		
		public function resetPerSonArray():void{
			if(Information.isGameOver)
				return;
			this.removeChild(customArr[0]);
			customArr[0]= null;			
			var i:int =0;
			while(i<3)
			{
				customArr[i]= customArr[i+1];
				customArr[i].orderNums = i;
				i++;
			}
			
			var customer:CustomerCharacter =new CustomerCharacter();
			customer.type = MathUtil.random(0,4);
			customer.orderNums = 2;
			customArr[3] = customer;			   
			customArr[3] .y= Information.personCharaterY;
			customArr[3] .x= Information.personCharaterX;	
			//var rate:int = 0;
			//rate =MathUtil.random(80,101);
			//customArr[i].talkSize  = (new Point(Information.talkBoxWidth * rate /100, Information.talkBoxHeight * rate /100));
			
			addChild(customer);
			this.setChildIndex(customer,0);
			goTofirstPlace();
			
		}
		
		
		public function removeAll():void
		{
			for(var i:int =0; i< 4; i++)
			{
				goToEndPlaceEvery(i);
					
				
				
			}
		}
		
		
		public function removeRandomAll():void
		{
			if(newfirstWaitTimer)
			{
				newfirstWaitTimer.stop();//    =new Timer(Information.RandomFrontTime);
				newfirstWaitTimer = null;
			}
			if(newsecondWaitTimer)
			{
				newsecondWaitTimer.stop();//    =new Timer(Information.RandomFrontTime);
				newsecondWaitTimer = null;
			}
			
			if(newthirdWaitTimer)
			{
				newthirdWaitTimer.stop();//    =new Timer(Information.RandomFrontTime);
				newthirdWaitTimer = null;
			}
			
			
			for(var i:int =0; i< 3; i++)
			{
				goToEndPlaceEvery(i);
				
				
				
			}
		}
		
		
		public function goToEndPlaceEvery(index :  int):void
		{
			if((customArr[index] !=null) && (customArr[index].x >480))				
			{
				if(customArr[index])
				{
					this.removeChild(customArr[index]);
					customArr[index] = null;
				}
			}
			
			
			if(customArr[index])
			{
				customArr[index].removeTalk();
				customArr[index].Happy(false);
			
				var posX:int =-150;
				var timeLine:Number =  (customArr[index].x-posX)/Information.characterExitSpeed;
				TweenLite.to(customArr[index], timeLine,
					{
						x:posX, y:customArr[index].y,
						ease:Linear.easeNone, delay:0.5, onComplete:reMoveCustomer, onCompleteParams:[index]
					}
				);	
			}
		}
		
		public function reMoveCustomer(index:int):void
		{
			if(customArr[index])
			{
				this.removeChild(customArr[index]);
				customArr[index] = null;
			}
				
		}
		
		
		public function goToRandomEndPlaceEvery(index :  int):void
		{
			removedIndex = index;		
			
			if(customArr[index].x >480)				
			{
				if(customArr[index])
				{
					this.removeChild(customArr[index]);
					customArr[index] = null;
				}
			}
			
			
			if(customArr[index])
			{
				customArr[index].removeTalk();
				
				//customArr[index].Happy(false);
				
				var posX:int =-150;
				var timeLine:Number =  (customArr[index].x-posX)/Information.characterExitSpeed;
				var point:Point = new Point(posX, customArr[index].y);
				TweenLite.to(customArr[index], 0.7,
					{
						x:customArr[index].x, y:customArr[index].y,
						ease:Linear.easeNone, delay:0, onComplete:goToEndPlaceRandomOfIndex, onCompleteParams:[index, timeLine, point]
					}
				);	
			}
		}
		
		public function goToEndPlaceRandomOfIndex(index:int, timeLine:Number, point:Point):void{
			
			this.setChildIndex(customArr[index],0);
			TweenLite.to(customArr[index], timeLine,
				{
					x:point.x, y:point.y,
					ease:Linear.easeNone, delay:0, onComplete:reMoveRandomCustomer, onCompleteParams:[index]
				}
			);	
		}
		
		
		
		
		
		public function reMoveRandomCustomer(index:int):void
		{
			if(Information.isGameOver)
				return;
			if(customArr[index])
			{
				this.removeChild(customArr[index]);
				customArr[index] = null;
			}
		//	this.newCustomTimer.start();
			switch(index)
			{
				case 0:
				{
					
					this.newfirstWaitTimer.start();
				}
					break;
				case 1:
				{
					this.newsecondWaitTimer.start();
					
				}
					break;
				case 2:
				{
					this.newthirdWaitTimer.start();
				}
					break;
			}
			
		}
		
		
		public function onNewFirstRandomCustomerStart(event :TimerEvent):void{
			
			if(Information.isGameOver)
				return;
			//if(newendTalk) return;
			if(customArr[0] == null)
			{
				var customer:CustomerCharacter =new CustomerCharacter();
				customer.type = MathUtil.random(0,4);
				customer.orderNums = 0;
				customArr[0] = customer;			   
				customArr[0].y= Information.personCharaterY;
				customArr[0].x= Information.personCharaterX;	
				//var rate:int = 0;
				//rate =MathUtil.random(80,101);
				//customArr[removedIndex].talkSize  = (new Point(Information.talkBoxWidth * rate /100, Information.talkBoxHeight * rate /100));
				addChild(customArr[0]);
				this.setChildIndex(customArr[0],0);
			}
			
			var remainedIndex:int =-1;
			
			for(var index:int; index<customArr.length; index++)
			{
				if((customArr[index])&& (this.customArr[index].x >480) && (!customArr[index].IsMoveing))
					remainedIndex = index;
			}
			if(remainedIndex != -1)
			{
				if(!customArr[remainedIndex].IsMoveing)
				{
					
					newendTalk =true;
					
					var beginPosX:int = getpos(customArr[remainedIndex] , remainedIndex);
					isGetingPos = false;
					if(beginPosX > 0)
					{
						
						switch(remainedIndex)
						{
							case 0:
							{
								if(newfirstWaitTimer)newfirstWaitTimer.stop();
							};
								break;
							case 1:
							{
								if(newsecondWaitTimer)newsecondWaitTimer.stop();
							};
								break;
							case 2:
							{
								if(newthirdWaitTimer)newthirdWaitTimer.stop();
							};
								break;
							
						}
						customArr[remainedIndex].IsMoveing = true;
						customArr[remainedIndex].arrivedPosition = new Point(beginPosX, customArr[remainedIndex].y);
						isCallRemainNum = 0;
						var timeLine:Number =  (customArr[remainedIndex].x-beginPosX)/Information.characterInSpeed;
						setChildIndex(customArr[remainedIndex],0);
						TweenLite.to(customArr[remainedIndex], timeLine,
							{
								x:beginPosX, y:customArr[remainedIndex].y,
								ease:Linear.easeNone, delay:0, onComplete:StartRandomPersonTalk, onCompleteParams:[customArr[remainedIndex]] 
							}
						);	
					}
				}
			}
			else
			{
				if((customArr[0] !=null) && (!customArr[0].IsMoveing))
				{
					//if((newendTalk)/* ||  (secondendTalk) ||(thirdendTalk) */)
						//return;
					//firstendTalk =true;
					newendTalk =true;
					//customArr[removedIndex] =new CustomerCharacter();
					
					customArr[0].IsMoveing = true;
					beginPosX = getpos(customArr[0] , 0);
					isGetingPos = false;
					if(beginPosX > 0)
					{
						newfirstWaitTimer.stop();
						//var endPosX:int = customArr[0].x
						//var posX:int =MathUtil.random( beginPosX, endPosX);
						customArr[0].arrivedPosition = new Point(beginPosX, customArr[0].y);
						timeLine =  (customArr[0].x-beginPosX)/Information.characterInSpeed;
						setChildIndex(customArr[0],0);
						TweenLite.to(customArr[0], timeLine,
							{
								x:beginPosX, y:customArr[0].y,
								ease:Linear.easeNone, delay:0, onComplete:StartRandomPersonTalk, onCompleteParams:[customArr[0]] 
							}
						);	
					}
					
					//removedwaitIndex = -1;
				}
				
			}
			//this.customArr.length
			
			
			
		}
		
		
		public function onNewSecondRandomCustomerStart(event :TimerEvent):void{
			
			if(Information.isGameOver)
				return;
			//if(newendTalk) return;
			if(customArr[1] == null)
			{
				var customer:CustomerCharacter =new CustomerCharacter();
				customer.type = MathUtil.random(0,4);
				customer.orderNums = 1;
				customArr[1] = customer;			   
				customArr[1].y= Information.personCharaterY;
				customArr[1].x= Information.personCharaterX;	
				//var rate:int = 0;
				//rate =MathUtil.random(80,101);
				//customArr[removedIndex].talkSize  = (new Point(Information.talkBoxWidth * rate /100, Information.talkBoxHeight * rate /100));
				addChild(customArr[1]);
				this.setChildIndex(customArr[1],0);
			}
			
			var remainedIndex:int =-1;
			
			for(var index:int; index<customArr.length; index++)
			{
				if((customArr[index])&& (this.customArr[index].x >480) && (!customArr[index].IsMoveing))
					remainedIndex = index;
			}
			if(remainedIndex != -1)
			{
				if(!customArr[remainedIndex].IsMoveing)
				{
					newendTalk =true;
					var beginPosX:int = getpos(customArr[remainedIndex] , remainedIndex);
					isGetingPos = false;
					if(beginPosX > 0)
					{
						switch(remainedIndex)
						{
							case 0:
							{
								if(newfirstWaitTimer)newfirstWaitTimer.stop();
							};
								break;
							case 1:
							{
								if(newsecondWaitTimer)newsecondWaitTimer.stop();
							};
								break;
							case 2:
							{
								if(newthirdWaitTimer)newthirdWaitTimer.stop();
							};
								break;
							
						}
						customArr[remainedIndex].IsMoveing = true;
						customArr[remainedIndex].arrivedPosition = new Point(beginPosX, customArr[remainedIndex].y);
						isCallRemainNum = 1;
						var timeLine:Number =  (customArr[remainedIndex].x-beginPosX)/Information.characterInSpeed;
						setChildIndex(customArr[remainedIndex],0);
						TweenLite.to(customArr[remainedIndex], timeLine,
							{
								x:beginPosX, y:customArr[remainedIndex].y,
								ease:Linear.easeNone, delay:0, onComplete:StartRandomPersonTalk, onCompleteParams:[customArr[remainedIndex]] 
							}
						);	
					}
				}
			}
			else
			{
				if((customArr[1] !=null) && (!customArr[1].IsMoveing))
				{
					//if((newendTalk)/* ||  (firstendTalk) ||(thirdendTalk)  */  )
					//	return;
					//secondendTalk =true;
					newendTalk = true;
					//endTalk =true;
					//customArr[removedIndex] =new CustomerCharacter();
					
					
					beginPosX = getpos(customArr[1] , 1);
					isGetingPos = false;
					if(beginPosX > 0)
					{
						newsecondWaitTimer.stop();
						customArr[1].IsMoveing = true;
						customArr[1].arrivedPosition = new Point(beginPosX, customArr[1].y);
						timeLine =  (customArr[1].x-beginPosX)/Information.characterInSpeed;
						setChildIndex(customArr[1],0);
						TweenLite.to(customArr[1], timeLine,
							{
								x:beginPosX, y:customArr[1].y,
								ease:Linear.easeNone, delay:0, onComplete:StartRandomPersonTalk, onCompleteParams:[customArr[1]] 
							}
						);	
					}
					
					//removedwaitIndex = -1;
				}
				
			}
			//this.customArr.length
			
			
			
		}
		
	
		
		public function onNewThirdRandomCustomerStart(event :TimerEvent):void{
			if(Information.isGameOver)
				return;
			//if(newendTalk) return;
			if(customArr[2] == null)
			{
				var customer:CustomerCharacter =new CustomerCharacter();
				customer.type = MathUtil.random(0,4);
				customer.orderNums = 2;
				customArr[2] = customer;			   
				customArr[2].y= Information.personCharaterY;
				customArr[2].x= Information.personCharaterX;	
				//var rate:int = 0;
				//rate =MathUtil.random(80,101);
				//customArr[removedIndex].talkSize  = (new Point(Information.talkBoxWidth * rate /100, Information.talkBoxHeight * rate /100));
				addChild(customArr[2]);
				this.setChildIndex(customArr[2],0);
			}
			
			var remainedIndex:int =-1;
			
			for(var index:int; index<customArr.length; index++)
			{
				if((customArr[index])&& (this.customArr[index].x >480) && (!customArr[index].IsMoveing))
					remainedIndex = index;
			}
			if(remainedIndex != -1)
			{
				if(!customArr[remainedIndex].IsMoveing)
				{
					newendTalk =true;
					
					var beginPosX:int = getpos(customArr[remainedIndex] , remainedIndex);
					isGetingPos = false;
					if(beginPosX > 0)
					{
						switch(remainedIndex)
						{
							case 0:
							{
								if(newfirstWaitTimer)newfirstWaitTimer.stop();
							};
								break;
							case 1:
							{
								if(newsecondWaitTimer)newsecondWaitTimer.stop();
							};
								break;
							case 2:
							{
								if(newthirdWaitTimer)newthirdWaitTimer.stop();
							};
								break;
							
						}
						customArr[remainedIndex].IsMoveing = true;
						customArr[remainedIndex].arrivedPosition = new Point(beginPosX, customArr[remainedIndex].y);
						isCallRemainNum = 2;
						var timeLine:Number =  (customArr[remainedIndex].x-beginPosX)/Information.characterInSpeed;
						setChildIndex(customArr[remainedIndex],0);
						TweenLite.to(customArr[remainedIndex], timeLine,
							{
								x:beginPosX, y:customArr[remainedIndex].y,
								ease:Linear.easeNone, delay:0, onComplete:StartRandomPersonTalk, onCompleteParams:[customArr[remainedIndex]] 
							}
						);	
					}
				}
			}
			else
			{
				if((customArr[2] !=null) && (!customArr[2].IsMoveing))
				{
				//	if((newendTalk)/* ||  (secondendTalk) ||(firstendTalk)    */)
					//	return;
					//return;
					//thirdendTalk =true;
					newendTalk =true;
					//customArr[removedIndex] =new CustomerCharacter();
					
					
					beginPosX = getpos(customArr[2] , 2);
					isGetingPos = false;
					if(beginPosX > 0)
					{
						newthirdWaitTimer.stop();
						customArr[2].IsMoveing = true;
						customArr[2].arrivedPosition = new Point(beginPosX, customArr[2].y);
						timeLine =  (customArr[2].x-beginPosX)/Information.characterInSpeed;
						setChildIndex(customArr[2],0);
						TweenLite.to(customArr[2], timeLine,
							{
								x:beginPosX, y:customArr[2].y,
								ease:Linear.easeNone, delay:0, onComplete:StartRandomPersonTalk, onCompleteParams:[customArr[2]] 
							}
						);	
					}
					
					//removedwaitIndex = -1;
				}
				
			}
			//this.customArr.length
			
			
			
		}
		
		
		public function onNewRandomCustomerStart(event :TimerEvent):void{
			
			
		//	if(newendTalk/*(firstendTalk) ||  (secondendTalk) ||(thirdendTalk)  */  )
		//		return;
			newCustomTimer.stop();
			
			isCanGetPos =true;
			
			
			
		}
		
		
		
		public function goToRandomfirstPlace():void
		{
			if(Information.isGameOver) return;
			var beginPosX:int = customArr[0].firstPos;
			var endPosX:int = 480-customArr[0].width-20
			var posX:int = MathUtil.random( beginPosX, endPosX);
			var timeLine:Number =  (customArr[0].x-posX)/Information.characterInSpeed;
			
			customArr[0].arrivedPosition = new Point(posX, customArr[0].y)
			TweenLite.to(customArr[0], timeLine,
				{
					x:posX, y:customArr[0].y,
					ease:Linear.easeNone, delay:0, onComplete:StartFirstPersonTalk
				}
			);	
			
		}
		
		public function getpos(custom:CustomerCharacter, index:int):int{
			//if(endTalk)
			//	return -1;
			//if(isGetingPos)
				//return -1;
			if(!isCanGetPos)
				return -1;
			isCanGetPos= false;
			this.newCustomTimer.start();
			isGetingPos = true;
			var firstPoint:int =500;
			var endPoint:int =0;
			var firstIndex:int = -1;
			var endIndex : int = -1;
			for(var i:int =0; i<customArr.length; i++)
			{
				if((i != index) && (customArr[i] != null) &&(customArr[i].arrivedPosition != null))
				{
					if((customArr[i].arrivedPosition.x-customArr[i].firstPos) <firstPoint)
					{
						firstPoint = customArr[i].arrivedPosition.x-customArr[i].firstPos;
						firstIndex = i;
					}
					if( (customArr[i].x <480) && (endPoint <customArr[i].arrivedPosition.x+customArr[i].personOfWidth) )
					{
						endPoint = customArr[i].arrivedPosition.x+customArr[i].personOfWidth;
						endIndex = i;
					}
				}
			}
			
			
			if((firstIndex == -1) && (endIndex == -1))
				return MathUtil.random(150, 300);
						
			var posArr:Vector.<int> = new Vector.<int>();
			var beginPos:int =0;
			var endPos:int =0;
			if((firstPoint != 500) &&(firstPoint > customArr[index].bodyWidth))
			{
				beginPos = MathUtil.random(5+customArr[index].firstPos, (firstPoint-customArr[index].personOfWidth));
				posArr.push(beginPos);
			}
			if((endPoint != 0) &&((480-endPoint) > customArr[index].bodyWidth))
			{
				beginPos = MathUtil.random((endPoint+ customArr[index].firstPos), (480-customArr[index].personOfWidth));
				posArr.push(beginPos);
			}
			if(endIndex != -1 )
			{
				var buffWidth:int =customArr[endIndex].arrivedPosition.x-customArr[endIndex].firstPos-customArr[firstIndex].arrivedPosition.x-customArr[firstIndex].personOfWidth;
				if((endPoint != 0) && (buffWidth>customArr[index].bodyWidth))
				{
					beginPos = customArr[firstIndex].arrivedPosition.x+customArr[firstIndex].personOfWidth +customArr[index].firstPos+ MathUtil.random(0, (buffWidth-customArr[index].bodyWidth));
					posArr.push(beginPos);
				}
				
				for( i =0; i<customArr.length; i++)
				{
					if((i != index) && (i != firstIndex))
					{
						
					}
				}
			}
			var insertIndex : int =-1;
			if(posArr.length>0)
				insertIndex  =MathUtil.random(0, posArr.length);
			
			if(insertIndex != -1)
				return posArr[insertIndex];
			
			return -1;
		}
		
		public function goTosecondRandomPlace():void
		{
			var beginPosX:int = getpos(customArr[1] , 1);
			this.isGetingPos = false;
			if(beginPosX > 0)
			{
			//var endPosX:int = customArr[0].x
			//var posX:int =MathUtil.random( beginPosX, endPosX);
				customArr[1].arrivedPosition = new Point(beginPosX, customArr[1].y);
				var timeLine:Number =  (customArr[1].x-beginPosX)/Information.characterInSpeed;
				TweenLite.to(customArr[1], timeLine,
					{
						x:beginPosX, y:customArr[1].y,
						ease:Linear.easeNone, delay:0, onComplete:StartAnyPersonTalk, onCompleteParams:[customArr[1]] 
					}
				);	
			}
			
		}
		
		
		
		
		public function goTothirdRandomPlace():void
		{
			
			
			var beginPosX:int = getpos(customArr[2] , 2);
			this.isGetingPos = false;
			//newthirdWaitTimer.start();
			
			
			if(beginPosX > 0)
			{
				//var endPosX:int = customArr[0].x
				//var posX:int =MathUtil.random( beginPosX, endPosX);
				customArr[2].arrivedPosition = new Point(beginPosX, customArr[2].y);
				var timeLine:Number =  (customArr[2].x-beginPosX)/Information.characterInSpeed;
				TweenLite.to(customArr[2], timeLine,
					{
						x:beginPosX, y:customArr[2].y,
						ease:Linear.easeNone, delay:0, onComplete:StartAnyPersonTalk, onCompleteParams:[customArr[2]] 
					}
				);	
			}
			
		}
		
		
		
		public function StartAnyPersonTalk(custom:CustomerCharacter):void
		{
			if(Information.isGameOver)
				return;
			custom.addEventListener(KindleEndEvent.KINDLE_END_EVENT, OnCompleteAnyTalk);
			custom.kindlTalkAnimation();
		}
		
		
		
		public function StartRandomPersonTalk(custom:CustomerCharacter):void
		{
			
			if(Information.isGameOver)
				return;
			
			custom.addEventListener(KindleEndEvent.KINDLE_END_EVENT, OnCompleteRandomTalk);
			custom.kindlTalkAnimation();
		}
		
		
		
		private function OnCompleteRandomTalk(event : Event):void
		{
			if(Information.isGameOver)
				return;			
			event.target.addTalk();	
			event.target.IsMoveing = false;
			//if(newendTalk)
			newendTalk = false;	
			{
				switch(event.target.orderNums)
				{
					case 0:
					{
						//this.firstendTalk = false
						newendTalk =false;
					}break;
					
					case 1:
					{
						//this.secondendTalk = false
						newendTalk =false;
					}break;
					
					case 2:
					{
						//thirdendTalk = false
						newendTalk =false;
					}break;
				}
			}
			if(Information.GameMode == Information.RandomGameMode)
			{
				//if(this.secondPersonWaitingTimer)secondPersonWaitingTimer = null;
				var indexs:int = event.target.orderNums;
				switch(indexs )
				{
					case 0:
					{
						if(customArr[0].x<480)	
						{
							if(customArr[0])
							{
								if(firstPersonWaitingTimer)
								{
									firstPersonWaitingTimer.stop();
									firstPersonWaitingTimer = null;
								}
								this.firstPersonWaitingTimer = new Timer(customArr[0].WaitingTime);
								firstPersonWaitingTimer.start();
								firstPersonWaitingTimer.addEventListener(TimerEvent.TIMER, OnFirstWaitComp);
							}
						}
					}
						break;
					
					case 1:
					{
						if(customArr[1].x<480)	
						{
							if(customArr[1])
							{
								if(secondPersonWaitingTimer)
								{
									secondPersonWaitingTimer.stop();
									secondPersonWaitingTimer = null;
								}
								this.secondPersonWaitingTimer = new Timer(customArr[1].WaitingTime);
								secondPersonWaitingTimer.start();
								secondPersonWaitingTimer.addEventListener(TimerEvent.TIMER, OnSecondWaitComp);
							}
						}
					}
						break;
					case 2:
					{
						
						if(customArr[2].x<480)	
						{
							if(customArr[2])
							{
								if(thirdPersonWaitingTimer)
								{
									thirdPersonWaitingTimer.stop();
									thirdPersonWaitingTimer = null;
								}
								this.thirdPersonWaitingTimer = new Timer(customArr[2].WaitingTime);
								thirdPersonWaitingTimer.start();
								thirdPersonWaitingTimer.addEventListener(TimerEvent.TIMER, OnThirdWaitComp);
							}
						}
						
					}
						break;
				}
			}
			
						
			var remainedIndex:int =-1;
			
			for(var index:int = 0; index<customArr.length; index++)
			{
				if((this.customArr[index]) && (this.customArr[index].x >480))
					remainedIndex = index;
			}
			
			if((remainedIndex != -1) && ((!this.newendTalk)/* && (!firstendTalk) &&  (!secondendTalk) && (!thirdendTalk) */   ))
			{
				
				var beginPosX:int = getpos(customArr[remainedIndex] , remainedIndex);
				if(beginPosX > 0)
				{
					//var endPosX:int = customArr[0].x
					//var posX:int =MathUtil.random( beginPosX, endPosX);
					customArr[remainedIndex].arrivedPosition = new Point(beginPosX, customArr[remainedIndex].y);
					var timeLine:Number =  (customArr[remainedIndex].x-beginPosX)/Information.characterInSpeed;
					TweenLite.to(customArr[remainedIndex], timeLine,
						{
							x:beginPosX, y:customArr[remainedIndex].y,
							ease:Linear.easeNone, delay:0, onComplete:StartRandomPersonTalk, onCompleteParams:[customArr[remainedIndex]] 
						}
					);	
				}
			}
			
		}
		
		private function OnCompleteAnyTalk(event : Event):void
		{
			if(Information.isGameOver)
				return;
			event.target.addTalk();	
			newendTalk =false;

			if(Information.GameMode == Information.RandomGameMode)
			{
				//if(this.secondPersonWaitingTimer)secondPersonWaitingTimer = null;
				var indexs:int = event.target.orderNums;
				switch(indexs )
				{
					case 0:
					{
						if(customArr[0])
						{
							this.firstPersonWaitingTimer = new Timer(customArr[0].WaitingTime);
							firstPersonWaitingTimer.start();
							firstPersonWaitingTimer.addEventListener(TimerEvent.TIMER, OnFirstWaitComp);
						}
					}
						break;
					
					case 1:
					{
						if(customArr[1])
						{
							this.secondPersonWaitingTimer = new Timer(customArr[1].WaitingTime);
							secondPersonWaitingTimer.start();
							secondPersonWaitingTimer.addEventListener(TimerEvent.TIMER, OnSecondWaitComp);
						}
					}
						break;
					case 2:
					{
						if(customArr[2])
						{
							this.thirdPersonWaitingTimer = new Timer(customArr[2].WaitingTime);
							thirdPersonWaitingTimer.start();
							thirdPersonWaitingTimer.addEventListener(TimerEvent.TIMER, OnThirdWaitComp);
						}
						
					}
						break;
				}
			}
			
			
			
			
			if(event.target ==customArr[1] )
				thirdPlaceTimer.start();
		}
		
	
		
		public function goToWaitRandomEndPlaceEvery(index :  int):void
		{
			//removedwaitIndex = index;
			
			if((customArr[index]) && (customArr[index].IsMoveing))
				return;
			if((customArr[index]) && (customArr[index].x >480))				
			{
				if(customArr[index])
				{
					this.removeChild(customArr[index]);
					customArr[index] .removeAll();
					customArr[index] = null;
				}
			}
			
			
			if(customArr[index])
			{
				customArr[index].removeTalk();
				
				customArr[index].Happy(false);
				
				var posX:int =-150;
				var timeLine:Number =  (customArr[index].x-posX)/Information.characterExitSpeed;
				var point:Point = new Point(posX, customArr[index].y);
				TweenLite.to(customArr[index], 0.7,
					{
						x:customArr[index].x, y:customArr[index].y,
						ease:Linear.easeNone, delay:0, onComplete:gotoEndPlaceOfRandomCustomerIndex, onCompleteParams:[index,timeLine,point]
					}
				);	
			}
		}
		
		public function gotoEndPlaceOfRandomCustomerIndex(index:int,timeLine:Number, point:Point):void
		{
			this.setChildIndex(customArr[index],0);
			TweenLite.to(customArr[index], timeLine,
				{
					x:point.x, y:point.y,
					ease:Linear.easeNone, delay:0, onComplete:reWaitMoveRandomCustomer, onCompleteParams:[index]
				}
			);	
			
			
		}
		
		
		
		public function reWaitMoveRandomCustomer(index:Number):void
		{
			if(Information.isGameOver)
				return;
			if(customArr[index])
			{
				this.removeChild(customArr[index]);
				customArr[index] = null;
			}
			switch(index)
			{
				case 0:
				{
					
					this.newfirstWaitTimer.start();
				}
					break;
				case 1:
				{
					this.newsecondWaitTimer.start();
					
				}
					break;
				case 2:
				{
					
					this.newthirdWaitTimer.start();
				}
					break;
			}
			
			
			
		}
		
		
	}
}