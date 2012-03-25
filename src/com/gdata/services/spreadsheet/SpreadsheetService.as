package com.gdata.services.spreadsheet
{
    import com.gdata.services.IService;
    import com.gdata.services.ServiceAliasesEnum;
    import com.gdata.services.spreadsheet.authorization.AuthorizationProxy;
    import com.gdata.services.spreadsheet.requests.GDataRequest;
    import com.gdata.services.spreadsheet.requests.IGDataRequest;
    import com.gdata.services.spreadsheet.requests.Login;
    import com.gdata.services.spreadsheet.events.ServiceErrorEvent;
    import com.gdata.services.spreadsheet.events.login.SuccessLoginEvent;
    import com.gdata.services.spreadsheet.feeds.IFeed;
    import com.gdata.services.spreadsheet.feeds.spreadsheet.SpreadsheetFeed;
    
    import flash.events.EventDispatcher;
    
    /**
     * Spreadsheets service. Necessary to login and start working with spreadsheets api.<br>
     * 
     * @history create Mar 22, 2012 12:09:03 AM<br>
     * @author Smirnov Sergey
     */	
    public class SpreadsheetService extends EventDispatcher implements IService
    {	
        //----------------------------------------------------------------------------------------------
        //
        //  Class constants
        //
        //----------------------------------------------------------------------------------------------
        
        //----------------------------------------------------------------------------------------------
        //
        //  Class variables
        //
        //----------------------------------------------------------------------------------------------
        
        /**
         * Url to get request a feed containing a list of the currently authenticated user's spreadsheets.
         */        
        protected const _spreadsheetFeedUrl:String = "https://spreadsheets.google.com/feeds/spreadsheets/private/full";
        
        //----------------------------------------------------------------------------------------------
        //
        //  Constructor
        //
        //----------------------------------------------------------------------------------------------
        
        public function SpreadsheetService()
        {
            super();
        }
        
        //----------------------------------------------------------------------------------------------
        //
        //  Public Methods
        //
        //----------------------------------------------------------------------------------------------
        
        /**
         * @inheritDoc
         */ 
        public function login(email:String, passwd:String):void
        {
            var command:IGDataRequest = new Login(email, passwd, alias);
            GDataRequest(command).addEventListener(SuccessLoginEvent.ON_SUCCESSFUL_LOGIN, onSuccessfulLoginEvent);
            GDataRequest(command).addEventListener(ServiceErrorEvent.ON_ERROR_LOGIN, onErrorLoginEvent);
            command.send();
        }
        
        /**
         * New instance of spreadsheet feed.
         * @return 
         */        
        public function getFeed():IFeed
        {
            return new SpreadsheetFeed();
        }
        
        /**
         * Spreadsheet feed's url.
         * @return 
         */        
        public function getSpreadsheetFeedUrl():String
        {
            return _spreadsheetFeedUrl;
        }
        
        //----------------------------------------------------------------------------------------------
        //
        //  Private Methods
        //
        //----------------------------------------------------------------------------------------------
        
        private function destroyCommand(command:IGDataRequest):void
        {
            GDataRequest(command).removeEventListener(SuccessLoginEvent.ON_SUCCESSFUL_LOGIN, onSuccessfulLoginEvent);
            GDataRequest(command).removeEventListener(ServiceErrorEvent.ON_ERROR_LOGIN, onErrorLoginEvent);
            GDataRequest(command).destroy();
        }
        
        //----------------------------------------------------------------------------------------------
        //
        //  Protected Methods
        //
        //----------------------------------------------------------------------------------------------
        
        //----------------------------------------------------------------------------------------------
        //
        //  Event handlers
        //
        //----------------------------------------------------------------------------------------------
        
        /**
         * Successful login handler.
         * @param event SuccessLoginEvent
         */        
        protected function onSuccessfulLoginEvent(event:SuccessLoginEvent):void
        {
            AuthorizationProxy.getInstance().init(event.params);
            destroyCommand(GDataRequest(event.currentTarget));
            dispatchEvent(event);
        }
        
        /**
         * Error login handler.
         * @param event ErrorLoginEvent
         */
        protected function onErrorLoginEvent(event:ServiceErrorEvent):void
        {
            destroyCommand(GDataRequest(event.currentTarget));
            dispatchEvent(event);
        }
        
        //----------------------------------------------------------------------------------------------
        //
        //  Accessors
        //
        //----------------------------------------------------------------------------------------------
        
        /**
         * @inheritDoc
         */        
        public function get alias():String
        {
            return ServiceAliasesEnum.SPREADSHEET;
        }
    }
}