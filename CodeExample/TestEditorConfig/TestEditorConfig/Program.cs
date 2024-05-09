// This code has been made by Simon VRANA.
// Please ask by email (simon.vrana.pro@gmail.com) before reusing for commercial purpose.

// This class contains example of code that should be caught by the .editorconfig file

Console.WriteLine("Hello, World!");

int test = 4;
var test2 = 4;

// Not working: dotnet_style_operator_placement_when_wrapping = beginning_of_line:suggestion
if (true &&
	true)
{
	test++;
	test2++;
}

if (true)
	test++;

ClassThatCanBeNull? TestNullOperator(ClassThatCanBeNull? classThatCanBeNull)

{
	if (classThatCanBeNull == null)
	{
		classThatCanBeNull = new ClassThatCanBeNull();
	}
	if (classThatCanBeNull != null)
	{
		classThatCanBeNull.Test();
	}

	return classThatCanBeNull;
}
TestNullOperator(null);

internal class ClassThatCanBeNull
{
	private int value;

	public int Test()
	{
		var test = value;
		test++;

		return test;
	}
}