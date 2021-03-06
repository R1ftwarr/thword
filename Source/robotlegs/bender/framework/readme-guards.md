# Guards

Guards say "yes" or "no". They are typically used by extensions to guard against certain actions based on environmental conditions.

## Guard Forms

A guard can exist in one of three forms:

* Function
* Object
* Class

### Function Guards

A function guard is expected to return a Boolean value:

```haxe
function randomGuard():Boolean {
	return Math.random() < 0.5;
}
```

### Object Guards

An object guard is expected to expose an "approve" method that returns a Boolean value:

```haxe
public class HappyGuard
{
	public function approve():Boolean
	{
		return true;
	}
}
```

### Class Guards

Instantiating a Class guard should result in an object that exposes an "approve" method which returns a Boolean value:

```haxe
public class SomeGuard
{
	@inject public var someModel:SomeModel;

	public function approve():Boolean
	{
		return someModel.enabled;
	}
}
```
