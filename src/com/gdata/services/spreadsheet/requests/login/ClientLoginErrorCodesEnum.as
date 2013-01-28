package com.gdata.services.spreadsheet.requests.login
{
	
	/**
	 * Client Login error codes enumeration.<br>
	 * 
	 * @history create Jan 28, 2013 12:03:24 PM<br>
	 * @author darkwing_duck
	 */	
	public class ClientLoginErrorCodesEnum
	{
		//----------------------------------------------------------------------------------------------
		//
		//  Class constants
		//
		//----------------------------------------------------------------------------------------------
		
		/**
		 * The login request used a username or password that is not recognized. 
		 */		
		public static const BAD_AUTHENTICATION:String = "BadAuthentication";
		
		/**
		 * The account email address has not been verified. The user will need to access their Google account 
		 * directly to resolve the issue before logging in using a non-Google application. 
		 */		
		public static const NOT_VERIFIED:String = "NotVerified";
		
		/**
		 * The user has not agreed to terms. The user will need to access their Google account directly to resolve 
		 * the issue before logging in using a non-Google application. 
		 */		
		public static const TERMS_NOT_AGREED:String = "TermsNotAgreed";
		
		/**
		 * A CAPTCHA is required. (A response with this error code will also contain an image URL and a CAPTCHA token.) 
		 */		
		public static const CAPTCHA_REQUIRED:String = "CaptchaRequired";
		
		/**
		 * The error is unknown or unspecified; the request contained invalid input or was malformed. 
		 */		
		public static const UNKNOWN:String = "Unknown";
		
		/**
		 * The user account has been deleted. 
		 */		
		public static const ACCOUNT_DELETED:String = "AccountDeleted";
		
		/**
		 * The user account has been disabled. 
		 */		
		public static const ACCOUNT_DISABLED:String = "AccountDisabled";
		
		/**
		 * The user's access to the specified service has been disabled. (The user account may still be valid.) 
		 */		
		public static const SERVICE_DISABLED:String = "ServiceDisabled";
		
		/**
		 * The service is not available; try again later. 
		 */		
		public static const SERVICE_UNAVAILABLE:String = "ServiceUnavailable";
		
		//----------------------------------------------------------------------------------------------
	}
}