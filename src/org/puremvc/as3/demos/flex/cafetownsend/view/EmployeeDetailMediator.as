/*
 PureMVC AS3 Demo - Flex CafeTownsend
 Copyright (c) 2007-08 Michael Ramirez <michael.ramirez@puremvc.org>
 Parts Copyright (c) 2005-07 Adobe Systems, Inc. 
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.flex.cafetownsend.view
{
	import flash.events.Event
    import org.puremvc.as3.interfaces.*;
	import org.puremvc.as3.patterns.mediator.Mediator;

    import org.puremvc.as3.demos.flex.cafetownsend.ApplicationFacade;
	import org.puremvc.as3.demos.flex.cafetownsend.model.EmployeeProxy;
	import org.puremvc.as3.demos.flex.cafetownsend.model.vo.Employee;
	import org.puremvc.as3.demos.flex.cafetownsend.view.components.*;
    
    /**
     * A Mediator for interacting with the EmployeeDetail component.
     */
    public class EmployeeDetailMediator extends Mediator implements IMediator
    {
        // Cannonical name of the Mediator
        public static const NAME:String = "EmployeeDetailMediator";
        
        /**
         * Constructor. 
         */
        public function EmployeeDetailMediator( viewComponent:Object ) 
        {
            // pass the viewComponent to the superclass where 
            // it will be stored in the inherited viewComponent property
            super( NAME, viewComponent );
			
			// retrieve and cache a reference to frequently accessed proxys
            employeeProxy = EmployeeProxy( facade.retrieveProxy( EmployeeProxy.NAME ) );
			
			employeeDetail.addEventListener( EmployeeDetail.CANCEL_EDITS, cancelEdits );
			employeeDetail.addEventListener( EmployeeDetail.DELETE_EMPLOYEE, deleteEmployee );
			employeeDetail.addEventListener( EmployeeDetail.SAVE_EDITS, saveEdits );
        }

        /**
         * Get the Mediator name
         * <P>
         * Called by the framework to get the name of this
         * mediator. If there is only one instance, we may
         * define it in a constant and return it here. If
         * there are multiple instances, this method must
         * return the unique name of this instance.</P>
         * 
         * @return String the Mediator name
         */
        override public function getMediatorName():String
        {
            return EmployeeDetailMediator.NAME;
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
            return [ ApplicationFacade.UPDATE_EMPLOYEE,
					 ApplicationFacade.SAVE_EMPLOYEE,
					 ApplicationFacade.DELETE_EMPLOYEE,
					 ApplicationFacade.ADD_EMPLOYEE 
					];
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
				case ApplicationFacade.ADD_EMPLOYEE:
					employeeProxy.employee = new Employee();
					employeeDetail.resetForm();
					sendNotification( ApplicationFacade.VIEW_EMPLOYEE_DETAIL );
					break;
                
                case ApplicationFacade.UPDATE_EMPLOYEE:
                    var selectedItem:Object = note.getBody();
					//Update the model
					employeeProxy.employee = new Employee(	selectedItem.emp_id,
															selectedItem.firstname,
															selectedItem.lastname,
															selectedItem.email,
															new Date(Date.parse(selectedItem.startdate)) );
					//Update the view										
					employeeDetail.firstname.text = employeeProxy.employee.firstname;
					employeeDetail.lastname.text = employeeProxy.employee.lastname;
					employeeDetail.startdate.selectedDate = employeeProxy.employee.startdate;
					employeeDetail.email.text = employeeProxy.employee.email;
					employeeDetail.delete_btn.enabled = true;
					
					sendNotification( ApplicationFacade.VIEW_EMPLOYEE_DETAIL );
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
         * @return EmployeeDetail the viewComponent cast to EmployeeDetail
         */
        protected function get employeeDetail():EmployeeDetail
		{
            return viewComponent as EmployeeDetail;
        }
		
		private function cancelEdits( event:Event = null ):void
		{
			sendNotification( ApplicationFacade.VIEW_EMPLOYEE_LIST );
		}
		
		private function saveEdits( event:Event = null ):void
		{
			//Update the Model
			employeeProxy.employee.firstname = employeeDetail.firstname.text;
			employeeProxy.employee.lastname = employeeDetail.lastname.text;
			employeeProxy.employee.startdate = employeeDetail.startdate.selectedDate;
			employeeProxy.employee.email = employeeDetail.email.text;
			
			employeeProxy.saveEmployee();
			
			employeeProxy.employee = null;
			employeeDetail.resetForm();
			
			sendNotification( ApplicationFacade.LOAD_EMPLOYEES_SUCCESS );
			sendNotification( ApplicationFacade.VIEW_EMPLOYEE_LIST );
		}
		
		private function deleteEmployee( event:Event = null ):void
		{
			employeeProxy.deleteEmployee();
			sendNotification( ApplicationFacade.VIEW_EMPLOYEE_LIST );
		}
		
		private var employeeProxy:EmployeeProxy;
    }
}
