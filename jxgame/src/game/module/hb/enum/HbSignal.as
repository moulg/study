package game.module.hb.enum{
	/**
	 * liuhe
	 */
	public class HbSignal{
		
		/**休息准备**/
		public static const REST:String = "REST";
		/**启动**/
		public static const START:String = "START";
		/**玩家入座**/
		public static const PLAYER_JOIN:String = "PLAYER_JOIN";
		/**玩家离开**/
		public static const PLAYER_LEAVE:String = "PLAYER_LEAVE";
		/**下注**/
		public static const PLAYER_GOLD:String = "PLAYER_GOLD";
		/**游戏开始，是否参与规则制定**/
		public static const GETRULETIME:String = "GETRULETIME";
		/**参与制定规则**/
		public static const PLAYER_GETRULE:String = "PLAYER_GETRULE";
		/**不参与制定规则**/
		public static const CAN_JOIN:String = "CAN_JOIN";
		/**制定规则获胜人**/
		public static const PLAYER_INFO:String = "PLAYER_INFO";
		/**选择规则**/
		public static const SETRULETIME:String = "SETRULETIME";
		/**掷骰子**/
		public static const POINTTIME:String = "POINTTIME";
		/**骰子结果展示**/
		public static const SIEVERESULTS:String = "SIEVERESULTS";
		/**红包**/
		public static const GETMONEY:String = "GETMONEY";
		/**拆红包**/
		public static const ADDGOLD:String = "ADDGOLD";
		/**退回匹配状态**/
		public static const WAIT_TIME:String = "WAIT_TIME";
	}
}