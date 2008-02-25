/*
 PureMVC AS3 Demo - Flex CafeTownsend
 Copyright (c) 2007-08 Michael Ramirez <michael.ramirez@puremvc.org>
 Parts Copyright (c) 2005-07 Adobe Systems, Inc. 
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.flex.cafetownsend.model
{
	import org.puremvc.as3.interfaces.*;
    import org.puremvc.as3.patterns.proxy.Proxy;
	import org.puremvc.as3.demos.flex.cafetownsend.model.vo.User;
    
    /**
     * A proxy for the User data
     */
    public class UserProxy extends Proxy implements IProxy
    {
		public static const NAME:String = "UserProxy";

		public function UserProxy ( data:Object = null ) 
        {
            super ( NAME, data );
        }
		
		public function validate( username:String, password:String ):Boolean
		{
			if( username == "Flex" && password == "PureMVC" )
			{
				data = new User(username,password);
				return true;
			}
			else
			{
				return false;
			}
		}
		
		public function get user():User
		{
			return data as User;
		}

	}
}