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
    import org.puremvc.as3.demos.flex.cafetownsend.view.ApplicationMediator;
    
    /**
     * Prepare the View for use.
     * 
     * <P>
     * The <code>Notification</code> was sent by the <code>Application</code>,
     * and a reference to that view component was passed on the note body.
     * The <code>ApplicationMediator</code> will be created and registered using this
     * reference. The <code>ApplicationMediator</code> will then register 
     * all the <code>Mediator</code>s for the components it created.</P>
     * 
     */
    public class ViewPrepCommand extends SimpleCommand
    {
        override public function execute( note:INotification ) :void    
		{
            // Register the ApplicationMediator
             facade.registerMediator( new ApplicationMediator( note.getBody() ) );            
            
            // Get the EmployeeProxy
            var employeeProxy:EmployeeProxy = facade.retrieveProxy( EmployeeProxy.NAME ) as EmployeeProxy;
            employeeProxy.loadEmployees();

            sendNotification( ApplicationFacade.VIEW_EMPLOYEE_LOGIN );

        }

        
    }
}
