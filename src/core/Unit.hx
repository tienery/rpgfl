package core;


class Unit
{

	private var _health:Int;
	public var health(get, null):Int;
	@:noCompletion function get_health()
	{
		return _health;
	}
	
	private var _maxHealth:Int;
	public var maxHealth(get, null):Int;
	@:noCompletion function get_maxHealth()
	{
		return _maxHealth;
	}
	
	@:noCompletion private var _attr:Attributes;
	public var attr(get, null):Attributes;
	@:noCompletion function get_attr()
	{
		if (_attr == null)
			_attr = new Attributes();
			
		return _attr;
	}
	
	public function new() 
	{
		
	}
	
}