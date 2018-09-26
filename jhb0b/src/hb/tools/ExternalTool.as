/**
	@Name: ExternalTool
	@Author: HobisJung(jhb0b@naver.com)
	@Date: 2016-01-22
	@Comment:
	{
	}
	@Using:
	{
		import flash.events.MouseEvent;
		import hb.utils.ExternalUtil;

		// - window object added
		ExternalUtil.methodRegister
		(
			'window.customMethod = function(msg)' +
			'{' +
			'	alert(msg);' +
			'}'
		);

		this.stage.addEventListener
		(
			MouseEvent.CLICK,
			function(event:MouseEvent):void
			{
				// - ExternalInterface JavaScript Call
				ExternalUtil.callJS('alert', ['ExternalInterface JavaScript Call']);

				// - navigateToURL JavaScript Call
				//ExternalUtil.useEI = false;
				//ExternalUtil.callJS('alert', ['navigateToURL JavaScript Call']);

				// - Normal Calling
				var t_call:String =
					'window[\'customMethod\'](\'JavaScript Call\');';
				ExternalUtil.callJSNormal(t_call);
			}
		);
	}
*/
package hb.tools
{
	import flash.system.Capabilities;
	import flash.external.ExternalInterface;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.utils.setTimeout;
	import flash.utils.clearTimeout;
	import flash.system.Security;
	import hb.tools.DebugTool;

	public final class ExternalTool
	{
		public function ExternalTool()
		{
		}

		


		/*
		DebugUtil.test(Security.sandboxType);
		DebugUtil.test(Security.sandboxType == Security.LOCAL_TRUSTED);
		DebugUtil.test(Security.sandboxType == Security.LOCAL_WITH_FILE);
		DebugUtil.test(Security.sandboxType == Security.LOCAL_WITH_NETWORK);
		DebugUtil.test(Security.sandboxType == Security.REMOTE);*/
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// -
		private static var __delayId:int = -1;

		// -
		public static var delayNum:uint = 100;

		// - Use ExternalInterface
		public static var use_ei:Boolean = true;

		// -
		public static const IS_IN_BROWSER:Boolean = is_inBrowser();
		
		private static function p_toURL(s:String, target:String):void
		{
/*			if (Security.sandboxType == Security.LOCAL_TRUSTED)
			{
				var t_str:String =
					'javascript: ' +
					'	try ' +
					'	{' +
					'		' + s +
					'	} ' +
					'	catch(e)' +
					'	{' +
					'		alert(\'Null Error : \'+e);' +
					'	}';

				navigateToURL(new URLRequest(t_str), target);
			}*/

			try
			{
				var t_str:String =
					'javascript: ' +
					'	try ' +
					'	{' +
					'		' + s +
					'	} ' +
					'	catch(e)' +
					'	{' +
					'		alert(\'Null Error : \'+e);' +
					'	}';

				navigateToURL(new URLRequest(t_str), target);
			}
			catch (e:Error)
			{
			}
		}

		public static function is_inBrowser():Boolean
		{
			var t_rv:Boolean = false;
			var t_type:String = Capabilities.playerType;

			if (t_type == 'PlugIn' || t_type == 'ActiveX')
			{
				t_rv = true;
			}
			else if (t_type == 'StandAlone' || t_type == 'External')
			{
				t_rv = false;
			}

			return t_rv;
		}

		public static function call_js(method:String, args:Array=null, target:String = '_self'):void
		{
			if (!IS_IN_BROWSER)
			{
				DebugTool.test('ExternalUtil : Not In Browser');
				return;
			}

			if (use_ei && ExternalInterface.available)
			{
				ExternalInterface.call(method, args);
			}
			else
			{
				var t_call:String = method;
				var t_seri:String = '';

				if (args != null)
				{
					var t_len:int = args.length;
					for (var i:int = 0; i < t_len; i++)
					{
						if (i == (t_len - 1))
							t_seri += '\'' + args + '\'';
						else
							t_seri += '\'' + args + '\'' + ', ';
					}
				}

				t_call += '(';
				t_call += t_seri;
				t_call += ');';

				p_toURL(t_call, target);

			}

		}

		public static function call_js_normal(str:String, target:String = '_self'):void
		{
			if (!IS_IN_BROWSER)
			{
				DebugTool.test('ExternalUtil : Not In Browser');
				return;
			}

			p_toURL(str, target);
		}

		public static function add_method(str:String, callObj:Object = null, target:String = '_self'):void
		{
			if (!IS_IN_BROWSER)
			{
				DebugTool.test('ExternalUtil : Not In Browser');
				return;
			}

			p_toURL('void(' + str + ');', target);

			if (callObj != null)
			{
				clearTimeout(__delayId);
				__delayId = setTimeout(callObj['func'], delayNum, callObj['scope']);
			}
		}

		public static function remove_method(method:String):void
		{
			if (!IS_IN_BROWSER)
			{
				DebugTool.test('ExternalUtil : Not In Browser');
				return;
			}

			p_toURL('void(window.' + method + ' = null);', '_self');
		}

	}

}