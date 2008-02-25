/*
 PureMVC AS3 Demo - Flex CafeTownsend
 Copyright (c) 2007-08 Michael Ramirez <michael.ramirez@puremvc.org>
 Parts Copyright (c) 2005-07 Adobe Systems, Inc. 
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.flex.cafetownsend.controller
{

    import org.puremvc.as3.interfaces.*;
    import org.puremvc.as3.patterns.command.*;
    import org.puremvc.as3.patterns.observer.*;
    
    import org.puremvc.as3.demos.flex.cafetownsend.*;
    import org.puremvc.as3.demos.flex.cafetownsend.model.*;
    
    /**
     * Create and register <code>Proxy</code>s with the <code>Model</code>.
     */
    public class ModelPrepCommand extends SimpleCommand
    {
        override public function execute( note:INotification ) :void    
		{
            facade.registerProxy(new EmployeeProxy());
			facade.registerProxy(new UserProxy());
        }
    }
}