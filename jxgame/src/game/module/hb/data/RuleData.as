package game.module.hb.data{
	import game.module.hb.HbConfig;
	

	public class RuleData{
		/**
		 * liuhe
		 */
		private var _ruleList:Array=[
			"投掷点数最小的玩家，获得红包全部金额",
			"投掷点数最大的玩家，获得红包全部金额",
			"所有投掷点数为小的玩家，每个人开启后获取金额随机",
			"所有投掷点数为大的玩家，每个人开启后获取金额随机"
		];
		private var _rule:String;
		private var _resultlist:Array=[];
		private var resultI:int=0;
		public function RuleData(){
			
		}
		
		/***规则列表***/
		public function get ruleList():Array{
			return _ruleList;
		}
		
		
		/**设置最后的规则**/
		public function set setRule(index:int):void{
			_rule=_ruleList[index-1];
			/**决定出规则后清除玩家选定规则的列表**/
		}
		/**最后的规则**/
		public function get getRule():String{
			return _rule;
		}
		
		/**保存游戏记录**/
		public function set setResult(data:Object):void{
			_resultlist.push({
				index:resultI,
				number:data.point,
				profit:data.money/HbConfig.goldrate,
				rule:_ruleList[data.ruleid-1]
			});
			resultI++;
		}
		
		/**游戏记录**/
		public function get getResult():Array{
			return _resultlist||[];
		}
	}
}