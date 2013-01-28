package com.gdata.services
{
    /**
     * ...<br>
     * 
     * @history create Mar 22, 2012 10:33:55 PM<br>
     * @author Smirnov Sergey
     */
    public interface IService
    {
        /**
         * Authorization for using google data API.
         * 
         * @param email your email
         * @param passwd your password
		 * @param logintoken (optional) Token representing the specific CAPTCHA challenge. Google supplies this token 
		 * and the CAPTCHA image URL in a login failed response with the error code "CaptchaRequired".
		 * @param logintoken (optional) String entered by the user as an answer to a CAPTCHA challenge.
         */   
        function login(email:String, passwd:String, logintoken:String = null, logincaptcha:String = null):void;
        
        /**
         * Service's name of the Google service you're requesting authorization for.
         * @return 
         */  
        function get alias():String;
    }
}