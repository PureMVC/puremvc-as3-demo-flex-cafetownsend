/*
 PureMVC AS3 Demo - Flex CafeTownsend
 Copyright (c) 2007-08 Michael Ramirez <michael.ramirez@puremvc.org>
 Parts Copyright (c) 2005-07 Adobe Systems, Inc. 
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.flex.cafetownsend.model.business
{
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.http.HTTPService;

	public class LoadEmployeesDelegate 
	{
		private var responder : IResponder;
		private var service : HTTPService;

		public function LoadEmployeesDelegate( responder : IResponder ) 
		{
			// constructor will store a reference to the service we're going to call
			this.service = new HTTPService();
			this.service.url="assets/Employees.xml";
			
			// and store a reference to the proxy that created this delegate
			this.responder = responder;
		}

		public function loadEmployeesService() : void 
		{
			// call the service
			var token:AsyncToken = service.send();
			
			// notify this responder when the service call completes
			token.addResponder( responder );
		}
	}
}