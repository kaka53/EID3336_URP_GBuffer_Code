using System;
using System.Reflection;
class P { static void Main(){var asm=Assembly.LoadFrom(@"D:\unity202235\2022.3.62f1c1\Editor\Data\Managed\UnityEngine\UnityEngine.CoreModule.dll"); foreach(var t in asm.GetTypes()){if(t.FullName.Contains("GraphicsFormat")){Console.WriteLine(t.FullName);if(t.IsEnum) foreach(var x in Enum.GetNames(t)) if(x.Contains("R11")||x.Contains("R16G16")) Console.WriteLine(x);}}}}
