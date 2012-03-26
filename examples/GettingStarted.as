package
{
    import com.gdata.services.spreadsheet.SpreadsheetService;
    import com.gdata.services.spreadsheet.authorization.AuthorizationParams;
    import com.gdata.services.spreadsheet.events.ServiceErrorEvent;
    import com.gdata.services.spreadsheet.events.login.SuccessLoginEvent;
    import com.gdata.services.spreadsheet.feeds.IFeed;
    
    import flash.display.Sprite;
    
    /**
     * Example #1.
     * Try to login.
     * 
     * @history create Mar 26, 2012 10:47:21 PM<br>
     * @author Smirnov Sergey
     */	
    public class GettingStarted extends Sprite
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
         * Spreadsheets service instance. 
         */        
        private var _service:SpreadsheetService;
        
        //----------------------------------------------------------------------------------------------
        //
        //  Constructor
        //
        //----------------------------------------------------------------------------------------------
        
        public function GettingStarted()
        {
            // init the service
            _service = new SpreadsheetService();
            
            // init login event listeners
            _service.addEventListener(SuccessLoginEvent.ON_SUCCESSFUL_LOGIN, onSuccessLogin);
            _service.addEventListener(ServiceErrorEvent.ON_ERROR_LOGIN, onErrorLogin);
            //
            
            // login
            _service.login("yourEmail", "yourPassword");
        }
        
        //----------------------------------------------------------------------------------------------
        //
        //  Event handlers
        //
        //----------------------------------------------------------------------------------------------
        
        /**
         * Successful login handler.
         * @param event SuccessLoginEvent
         */        
        protected function onSuccessLogin(event:SuccessLoginEvent):void
        {
            // retrieve authorization parameters
            var authoriationParams:AuthorizationParams = event.params;
            
            // get user's authorization key
            trace(authoriationParams.auth);
            
            // get user's email
            trace(authoriationParams.email);
            
            // get user's password
            trace(authoriationParams.passwd);
        }
        
        /**
         * Error login handler.
         * @param event ServiceErrorEvent
         */        
        protected function onErrorLogin(event:ServiceErrorEvent):void
        {
            // get error message
            // to see all existing error messages, 
            //see Error codes at https://developers.google.com/accounts/docs/AuthForInstalledApps
            trace(event.text);
        }
        
        //----------------------------------------------------------------------------------------------
        //
        //  Private Methods
        //
        //----------------------------------------------------------------------------------------------
        
        //----------------------------------------------------------------------------------------------
        //
        //  Protected Methods
        //
        //----------------------------------------------------------------------------------------------
        
        //----------------------------------------------------------------------------------------------
        //
        //  Public Methods
        //
        //----------------------------------------------------------------------------------------------
        
        //----------------------------------------------------------------------------------------------
        //
        //  Accessors
        //
        //----------------------------------------------------------------------------------------------
    }
}