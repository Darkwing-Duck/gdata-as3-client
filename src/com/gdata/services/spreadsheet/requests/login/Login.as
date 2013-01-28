package com.gdata.services.spreadsheet.requests.login
{
    import com.gdata.services.spreadsheet.authorization.AuthorizationParams;
    import com.gdata.services.spreadsheet.events.ServiceErrorEvent;
    import com.gdata.services.spreadsheet.events.login.SuccessLoginEvent;
    import com.gdata.services.spreadsheet.requests.GDataRequest;
    
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
		
		/**
		 * (optional) Token representing the specific CAPTCHA challenge. Google supplies this token and the CAPTCHA 
		 * image URL in a login failed response with the error code "CaptchaRequired".
		 */        
		protected var _logintoken:String;
		
		/**
		 * (optional) String entered by the user as an answer to a CAPTCHA challenge.
		 */        
		protected var _logincaptcha:String;
        
        //----------------------------------------------------------------------------------------------
        //
        //  Constructor
        //
        //----------------------------------------------------------------------------------------------
        
        public function Login(email:String, passwd:String, alias:String, logintoken:String = null, logincaptcha:String = null)
        {
            _email = email;
            _passwd = passwd;
            _alias = alias;
			_logintoken = logintoken;
			_logincaptcha = logincaptcha;
            
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
			
			if (_logintoken)
			{
				urlVariables.logintoken = _logintoken;
			}
            
			if (_logincaptcha)
			{
				urlVariables.logincaptcha = _logincaptcha;
			}

            _urlRequest.data = urlVariables;
            _urlRequest.method = URLRequestMethod.POST;
        }
		
		/**
		 * Parses the response to object.
		 * 
		 * @param rawResponse raw data from response
		 */		
		protected function parseResponse(rawResponse:String):Object
		{
			var result:Object = {};
			var splitArray_1:Array = rawResponse.split("\u000A");
			splitArray_1.pop();
			
			for each (var str:String in splitArray_1)
			{
				var splitArray_2:Array = str.split("=");
				result[splitArray_2[0]] = splitArray_2[1];
			}
			
			return result;
		}
		
		protected function processError(response:Object):void
		{
			var errorMessage:String;
			
			switch(response.Error)
			{
				case ClientLoginErrorCodesEnum.BAD_AUTHENTICATION:
				{
					errorMessage = "The login request used a username or password that is not recognized.";
					break;
				}
				case ClientLoginErrorCodesEnum.NOT_VERIFIED:
				{
					errorMessage = "The account email address has not been verified. The user will need to access their Google account directly to resolve the issue before logging in using a non-Google application.";
					break;
				}
				case ClientLoginErrorCodesEnum.TERMS_NOT_AGREED:
				{
					errorMessage = "The user has not agreed to terms. The user will need to access their Google account directly to resolve the issue before logging in using a non-Google application.";
					break;
				}
				case ClientLoginErrorCodesEnum.CAPTCHA_REQUIRED:
				{
					errorMessage = "A CAPTCHA is required. (A response with this error code will also contain an image URL and a CAPTCHA token.)";
					break;
				}
				case ClientLoginErrorCodesEnum.UNKNOWN:
				{
					errorMessage = "The error is unknown or unspecified; the request contained invalid input or was malformed.";
					break;
				}
				case ClientLoginErrorCodesEnum.ACCOUNT_DELETED:
				{
					errorMessage = "The user account has been deleted.";
					break;
				}
				case ClientLoginErrorCodesEnum.ACCOUNT_DISABLED:
				{
					errorMessage = "The user account has been disabled.";
					break;
				}
				case ClientLoginErrorCodesEnum.SERVICE_DISABLED:
				{
					errorMessage = "The user's access to the specified service has been disabled. (The user account may still be valid.)";
					break;
				}
				case ClientLoginErrorCodesEnum.SERVICE_UNAVAILABLE:
				{
					errorMessage = "The service is not available; try again later.";
					break;
				}
				default:
				{
					errorMessage = ClientLoginErrorCodesEnum.UNKNOWN;
					break;
				}
			}
			
			var loginEvent:ServiceErrorEvent = new ServiceErrorEvent(ServiceErrorEvent.ON_ERROR_LOGIN, response, false, false, errorMessage);
			dispatchEvent(loginEvent);
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
			trace("response: " + event.currentTarget.data);
			var response:Object = parseResponse(event.currentTarget.data);
			
			if (response.Error)
			{
				processError(response);
			}
			else
			{
				// creat the login params
				var loginParams:AuthorizationParams = new AuthorizationParams();
				loginParams.email = _email;
				loginParams.passwd = _passwd;
				loginParams.auth = response.Auth;
				//
				
				var loginEvent:SuccessLoginEvent = new SuccessLoginEvent(SuccessLoginEvent.ON_SUCCESSFUL_LOGIN, loginParams);
				dispatchEvent(loginEvent);
			}
        }
        
        /**
         * Error login handler.
         * @param event IOErrorEvent
         */        
        override protected function onIOError(event:IOErrorEvent):void
        {
            var errorMessage:String = "Authorization Error!";
            var loginEvent:ServiceErrorEvent = new ServiceErrorEvent(ServiceErrorEvent.ON_ERROR_LOGIN, null, false, false, errorMessage);
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