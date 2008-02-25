/*
 PureMVC AS3 Demo - Flex CafeTownsend
 Copyright (c) 2007-08 Michael Ramirez <michael.ramirez@puremvc.org>
 Parts Copyright (c) 2005-07 Adobe Systems, Inc. 
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.flex.cafetownsend
{
    import org.puremvc.as3.interfaces.*;
    import org.puremvc.as3.patterns.proxy.*;
    import org.puremvc.as3.patterns.facade.*;

    import org.puremvc.as3.demos.flex.cafetownsend.view.*;
    import org.puremvc.as3.demos.flex.cafetownsend.model.*;
    import org.puremvc.as3.demos.flex.cafetownsend.controller.*;

    /**
     * A concrete <code>Facade</code> for the <code>CafeTownsend</code> application.
     * <P>
     * The main job of the <code>ApplicationFacade</code> is to act as a single 
     * place for mediators, proxies and commands to access and communicate
     * with each other without having to interact with the Model, View, and
     * Controller classes directly. All this capability it inherits from 
     * the PureMVC Facade class.</P>
     * 
     * <P>
     * This concrete Facade subclass is also a central place to define 
     * notification constants which will be shared among commands, proxies and
     * mediators, as well as initializing the controller with Command to 
     * Notification mappings.</P>
     */
    public class ApplicationFacade extends Facade
    {
        
        // Notification name constants
        public static const STARTUP:String 					= "startup";
        public static const SHUTDOWN:String 				= "shutdown";
		public static const APP_LOGOUT:String 				= "appLogout";
		public static const APP_LOGIN:String 				= "appLogin";
		public static const LOAD_EMPLOYEES_SUCCESS:String	= "loadEmployeesSuccess";
        public static const LOAD_EMPLOYEES_FAILED:String	= "loadEmployeesFailed";
		public static const VIEW_EMPLOYEE_LOGIN:String		= "viewEmployeeLogin";
		public static const VIEW_EMPLOYEE_LIST:String		= "viewEmployeeList";
		public static const VIEW_EMPLOYEE_DETAIL:String		= "viewEmployeeDetail";
		public static const ADD_EMPLOYEE:String				= "addEmployee";
		public static const UPDATE_EMPLOYEE:String			= "updateEmployee";
		public static const SAVE_EMPLOYEE:String			= "saveEmployee";
		public static const DELETE_EMPLOYEE:String			= "deleteEmployee";
        /**
         * Singleton ApplicationFacade Factory Method
         */
        public static function getInstance() : ApplicationFacade 
		{
            if ( instance == null ) instance = new ApplicationFacade( );
            return instance as ApplicationFacade;
        }

        /**
         * Register Commands with the Controller 
         */
        override protected function initializeController( ) : void 
        {
            super.initializeController(); 
            registerCommand( STARTUP, ApplicationStartupCommand );
        }
        
        public function startup( app:CafeTownsend ):void
        {
        	sendNotification( STARTUP, app );
        }
    }
}
