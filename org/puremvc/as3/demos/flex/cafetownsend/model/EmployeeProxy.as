/*
 PureMVC AS3 Demo - Flex CafeTownsend
 Copyright (c) 2007-08 Michael Ramirez <michael.ramirez@puremvc.org>
 Parts Copyright (c) 2005-07 Adobe Systems, Inc. 
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.flex.cafetownsend.model
{
	import mx.rpc.IResponder;
	import mx.collections.ArrayCollection;

	import org.puremvc.as3.interfaces.*;
    import org.puremvc.as3.patterns.proxy.Proxy;

	import org.puremvc.as3.demos.flex.cafetownsend.vo.Employee;
	import org.puremvc.as3.demos.flex.cafetownsend.business.LoadEmployeesDelegate;
	import org.puremvc.as3.demos.flex.cafetownsend.*;
    
    /**
     * A proxy for the Employee data
     */
    public class EmployeeProxy extends Proxy implements IProxy, IResponder
    {
		public static const NAME:String = "EmployeeProxy";

		public function EmployeeProxy ( data:Object = null ) 
        {
            super ( NAME, data );
        }
		
		public function loadEmployees():void
		{
			// create a worker who will go get some data
			// pass it a reference to this proxy so the delegate knows where to return the data
			var delegate : LoadEmployeesDelegate = new LoadEmployeesDelegate( this );
			// make the delegate do some work
			delegate.loadEmployeesService();
		}
		
		// this is called when the delegate receives a result from the service
		public function result( rpcEvent : Object ) : void
		{
			// populate the employee list in the proxy with the results from the service call
			data = rpcEvent.result.employees.employee as ArrayCollection;
			sendNotification( ApplicationFacade.LOAD_EMPLOYEES_SUCCESS );
		}
		
		// this is called when the delegate receives a fault from the service
		public function fault( rpcEvent : Object ) : void 
		{
			data = new ArrayCollection();
			// store an error message in the proxy
			// labels, alerts, etc can bind to this to notify the user of errors
			errorStatus = "Could Not Load Employee List!";
			sendNotification( ApplicationFacade.LOAD_EMPLOYEES_FAILED );
			
		}
		
		public function saveEmployee():void
		{
			// assume the edited fields are not an existing employee, but a new employee
			// and set the ArrayCollection index to -1, which means this employee is not in our existing
			// employee list anywhere
			var dpIndex : int = -1;
			// loop thru the employee list
			for ( var x : uint = 0; x < employeeListDP.length; x++ ) 
			{
				// if the emp_id of the incoming employee matches an employee already in the list
				if ( employeeListDP[x].emp_id == employee.emp_id ) 
				{
					// set our ArrayCollection index to that employee position
					dpIndex = x;
				}
			}
			// if it was an existing employee already in the ArrayCollection
			if ( dpIndex >= 0 ) 
			{
				// update that employee's values
				employeeListDP.setItemAt( employee, dpIndex );
			}
			// otherwise, if it didn't match any existing employees
			else
			{
				// add the temp employee to the ArrayCollection
				employeeListDP.addItem( employee );
			}
			
		}
		
		public function deleteEmployee():void
		{
			if( employee != null )
			{
				for ( var i : uint = 0; i < employeeListDP.length; i++ ) 
				{
					// if the emp_id stored in the temp employee matches one of the emp_id's in the employee list
					if ( employee.emp_id == employeeListDP[i].emp_id ) 
					{
						// remove that item from the ArrayCollection
						employeeListDP.removeItemAt( i );
					}
				}
			}
		}
		
		public function get employeeListDP():ArrayCollection
		{
			return data as ArrayCollection;
		}
		
		public var employee:Employee = new Employee();
		public var errorStatus:String;

	}
}