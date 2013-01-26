package com.gdata.services.spreadsheet.requests
{
    import com.gdata.services.spreadsheet.authorization.AuthorizationParams;
    import com.gdata.services.spreadsheet.events.ServiceErrorEvent;
    import com.gdata.services.spreadsheet.events.login.SuccessLoginEvent;
    
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.net.URLRequestMethod;
    import flash.net.URLVariables;

    /**
     * Login request command.<br>
     * 
     * @history create Mar 22, 2012 11:05:54 PM<br>
     * @author Smirnov Sergey
     */	
    public class Login extends GDataRequest
    {	
        //----------------------------------------------------------------------------------------------
        //
        //  Class constants
        //
        //----------------------------------------------------------------------------------------------
        
        protected const LOGIN_URL:String = "https://www.google.com/accounts/ClientLogin";
        
        //----------------------------------------------------------------------------------------------
        //
        //  Class variables
        //
        //----------------------------------------------------------------------------------------------
        
        /**
         * Gdata service alias. 
         */        
        protected var _alias:String;
        
        /**
         * User's email. 
         */        
        protected var _email:String;
        
        /**
         * User's password.
         */        
        protected var _passwd:String;
        
        //----------------------------------------------------------------------------------------------
        //
        //  Constructor
        //
        //----------------------------------------------------------------------------------------------
        
        public function Login(email:String, passwd:String, alias:String)
        {
            _email = email;
            _passwd = passwd;
            _alias = alias;
            
            super(LOGIN_URL);
        }
        
        //----------------------------------------------------------------------------------------------
        //
        //  Public Methods
        //
        //----------------------------------------------------------------------------------------------
        
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
        
        /**
         * @inheritDoc
         */        
        override protected function init():void
        {
            super.init();
            
            var urlVariables:URLVariables = new URLVariables();
            urlVariables.accountType = "HOSTED_OR_GOOGLE";
            urlVariables.Email = _email;
            urlVariables.Passwd = _passwd;
            urlVariables.service = _alias;
            
            _urlRequest.data = urlVariables;
            _urlRequest.method = URLRequestMethod.POST;
        }
        
        //----------------------------------------------------------------------------------------------
        //
        //  Event handlers
        //
        //----------------------------------------------------------------------------------------------
        
        /**
         * Successful login handler.
         * @param event Event
         */        
        override protected function onSuccessfulResponse(event:Event):void
        {
            // remove the '\n' symbols from responce
            var auth:String = event.currentTarget.data.replace(/\u000A/gm, "");  
            
            // get the Auth(authorization key) string from the response
            auth = auth.replace(/.+Auth=/, ""); 
            
            // creat the login params
            var loginParams:AuthorizationParams = new AuthorizationParams();
            loginParams.email = _email;
            loginParams.passwd = _passwd;
            loginParams.auth = auth;
            //
            
            var loginEvent:SuccessLoginEvent = new SuccessLoginEvent(SuccessLoginEvent.ON_SUCCESSFUL_LOGIN, loginParams);
            dispatchEvent(loginEvent);
        }
        
        /**
         * Error login handler.
         * @param event IOErrorEvent
         */        
        override protected function onIOError(event:IOErrorEvent):void
        {
            var errorMessage:String = "Authorization Error!";
            var loginEvent:ServiceErrorEvent = new ServiceErrorEvent(ServiceErrorEvent.ON_ERROR_LOGIN, false, false, errorMessage);
            dispatchEvent(loginEvent);
        }
        
        /**
         * @inheritDoc
         */    
        override public function destroy():void
        {
            super.destroy();
            
            _email = null;
            _passwd = null;
            _alias = null;
        }
        
        //----------------------------------------------------------------------------------------------
        //
        //  Accessors
        //
        //----------------------------------------------------------------------------------------------
    }
}