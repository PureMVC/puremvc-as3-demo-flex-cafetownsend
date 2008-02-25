/*
 PureMVC AS3 Demo - Flex CafeTownsend
 Copyright (c) 2007-08 Michael Ramirez <michael.ramirez@puremvc.org>
 Parts Copyright (c) 2005-07 Adobe Systems, Inc. 
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package  org.puremvc.as3.demos.flex.cafetownsend.model.vo 
{
	public class User 
	{

		public var username : String;
		public var password : String;

		public function User( username : String, password : String ) 
		{
			this.username = username;
			this.password = password;
		}
	}
}