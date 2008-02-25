/*
 PureMVC AS3 Demo - Flex CafeTownsend
 Copyright (c) 2007-08 Michael Ramirez <michael.ramirez@puremvc.org>
 Parts Copyright (c) 2005-07 Adobe Systems, Inc. 
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.flex.cafetownsend.view
{
	import flash.events.Event;
    import org.puremvc.as3.interfaces.*;
	import org.puremvc.as3.patterns.mediator.Mediator;

    import org.puremvc.as3.demos.flex.cafetownsend.ApplicationFacade;
	import org.puremvc.as3.demos.flex.cafetownsend.view.components.*;
	import org.puremvc.as3.demos.flex.cafetownsend.model.EmployeeProxy;
    
    /**
     * A Mediator for interacting with the EmployeeList component
     */
    public class EmployeeListMediator extends Mediator implements IMediator
    {
        // Cannonical name of the Mediator
        public static const NAME:String = "EmployeeListMediator";
        
        /**
         * Constructor. 
         */
        public function EmployeeListMediator( viewComponent:Object ) 
        {
            // pass the viewComponent to the superclass where 
            // it will be stored in the inherited viewComponent property
            super( NAME, viewComponent );
			
			employeeProxy = EmployeeProxy( facade.retrieveProxy( EmployeeProxy.NAME ) );
			
			employeeList.addEventListener( EmployeeList.APP_LOGOUT, logout );
			employeeList.addEventListener( EmployeeList.ADD_EMPLOYEE, addEmployee );
			employeeList.addEventListener( EmployeeList.UPDATE_EMPLOYEE, updateEmployee );
        }

        /**
         * List all notifications this Mediator is interested in.
         * <P>
         * Automatically called by the framework when the mediator
         * is registered with the view.</P>
         * 
         * @return Array the list of Nofitication names
         */
        override public function listNotificationInterests():Array 
        {
            return [ ApplicationFacade.LOAD_EMPLOYEES_SUCCESS,
					ApplicationFacade.LOAD_EMPLOYEES_FAILED ];
        }

        /**
         * Handle all notifications this Mediator is interested in.
         * <P>
         * Called by the framework when a notification is sent that
         * this mediator expressed an interest in when registered
         * (see <code>listNotificationInterests</code>.</P>
         * 
         * @param INotification a notification 
         */
        override public function handleNotification( note:INotification ):void 
        {
            switch ( note.getName() ) 
			{
                case ApplicationFacade.LOAD_EMPLOYEES_SUCCESS:
                    employeeList.employees_li.dataProvider = employeeProxy.employeeListDP;
                    break;
				case ApplicationFacade.LOAD_EMPLOYEES_FAILED:
					employeeList.error.text = employeeProxy.errorStatus;
					break;
            }
        }
                    
        /**
         * Cast the viewComponent to its actual type.
         * 
         * <P>
         * This is a useful idiom for mediators. The
         * PureMVC Mediator class defines a viewComponent
         * property of type Object. </P>
         * 
         * <P>
         * Here, we cast the generic viewComponent to 
         * its actual type in a protected mode. This 
         * retains encapsulation, while allowing the instance
         * (and subclassed instance) access to a 
         * strongly typed reference with a meaningful
         * name.</P>
         * 
         * @return EmployeeList the viewComponent cast to EmployeeList
         */
        protected function get employeeList():EmployeeList
		{
            return viewComponent as EmployeeList;
        }
		
		private function logout( event:Event = null ):void
		{
			sendNotification( ApplicationFacade.APP_LOGOUT );
		}
		
		private function addEmployee( event:Event = null ):void
		{
			sendNotification( ApplicationFacade.ADD_EMPLOYEE );
		}
		
		private function updateEmployee( event:Event = null ):void
		{
			sendNotification( ApplicationFacade.UPDATE_EMPLOYEE, employeeList.employees_li.selectedItem);
		}
		
		private var employeeProxy:EmployeeProxy;
    }
}
