package laya.filters {
	
	/**
	 * 默认的FILTER,什么都不做
	 * @private
	 */
	public class FilterAction implements IFilterAction {
		public var data:*;
		
		public function apply(data:*):* {
			return null;
		}
	}
}