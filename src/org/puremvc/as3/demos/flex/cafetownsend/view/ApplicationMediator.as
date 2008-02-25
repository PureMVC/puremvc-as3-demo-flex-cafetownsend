/*
 PureMVC AS3 Demo - Flex CafeTownsend
 Copyright (c) 2007-08 Michael Ramirez <michael.ramirez@puremvc.org>
 Parts Copyright (c) 2005-07 Adobe Systems, Inc. 
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.flex.cafetownsend.view
{
    import org.puremvc.as3.interfaces.*;
    
    import org.puremvc.as3.demos.flex.cafetownsend.view.components.*;
    import org.puremvc.as3.demos.flex.cafetownsend.ApplicationFacade;
    import org.puremvc.as3.demos.flex.cafetownsend.model.*;
    import org.puremvc.as3.patterns.mediator.Mediator;
    
    /**
     * A Mediator for interacting with the top level Application.
     * 
     * <P>
     * In addition to the ordinary responsibilities of a mediator
     * the MXML application (in this case) built all the view components
     * and so has a direct reference to them internally. Therefore
     * we create and register the mediators for each view component
     * with an associated mediator here.</P>
     * 
     * <P>
     * Then, ongoing responsibilities are: 
     * <UL>
     * <LI>listening for events from the viewComponent (the application)</LI>
     * <LI>sending notifications on behalf of or as a result of these 
     * events or other notifications.</LI>
     * <LI>direct manipulating of the viewComponent by method invocation
     * or property setting</LI>
     * </UL>
     */
    public class ApplicationMediator extends Mediator implements IMediator
    {
        // Cannonical name of the Mediator
        public static const NAME:String = "ApplicationMediator";
		// available values for the main viewstack
		// defined as contants to help uncover errors at compile time instead of run time
		public static const EMPLOYEE_LOGIN : Number =	0;
		public static const EMPLOYEE_LIST : Number =	1;
		public static const EMPLOYEE_DETAIL : Number =	2;
        
        /**
         * Constructor. 
         * 
         * <P>
         * On <code>applicationComplete</code> in the <code>Application</code>,
         * the <code>ApplicationFacade</code> is initialized and the 
         * <code>ApplicationMediator</code> is created and registered.</P>
         * 
         * <P>
         * The <code>ApplicationMediator</code> constructor also registers the 
         * Mediators for the view components created by the application.</P>
         * 
         * @param object the viewComponent (the CafeTownsend instance in this case)
         */
        public function ApplicationMediator( viewComponent:Object ) 
        {
            // pass the viewComponent to the superclass where 
            // it will be stored in the inherited viewComponent property
            super( NAME, viewComponent );

            // Create and register Mediators for the Employee
            // components that were instantiated by the mxml application
            facade.registerMediator( new EmployeeDetailMediator( app.employeeDetail ) );    
            facade.registerMediator( new EmployeeListMediator( app.employeeList ) );    
			facade.registerMediator( new EmployeeLoginMediator( app.employeeLogin ) );
            
            // retrieve and cache a reference to frequently accessed proxys
            employeeProxy = EmployeeProxy( facade.retrieveProxy( EmployeeProxy.NAME ) );
			userProxy = UserProxy( facade.retrieveProxy( UserProxy.NAME ) );

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
            
            return [ ApplicationFacade.VIEW_EMPLOYEE_LOGIN,
					 ApplicationFacade.VIEW_EMPLOYEE_LIST,
					 ApplicationFacade.VIEW_EMPLOYEE_DETAIL,
					 ApplicationFacade.APP_LOGOUT,
					 ApplicationFacade.UPDATE_EMPLOYEE
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
                
				case ApplicationFacade.VIEW_EMPLOYEE_LOGIN:
					app.vwStack.selectedIndex = EMPLOYEE_LOGIN;
					break;
				
				case ApplicationFacade.VIEW_EMPLOYEE_LIST:
					employeeProxy.employee = null;
					app.vwStack.selectedIndex = EMPLOYEE_LIST;
					break;
				
				case ApplicationFacade.VIEW_EMPLOYEE_DETAIL:
					app.vwStack.selectedIndex = EMPLOYEE_DETAIL;
					break;
				
				case ApplicationFacade.APP_LOGOUT:
					app.vwStack.selectedIndex = EMPLOYEE_LOGIN;
					break;
				
				case ApplicationFacade.UPDATE_EMPLOYEE:
					app.vwStack.selectedIndex = EMPLOYEE_DETAIL;
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
         * @return app the viewComponent cast to CafeTownsend
         */
        protected function get app():CafeTownsend
		{
            return viewComponent as CafeTownsend
        }

		// Cached references to needed proxies
		private var employeeProxy:EmployeeProxy;
		private var userProxy:UserProxy;
    }
}
