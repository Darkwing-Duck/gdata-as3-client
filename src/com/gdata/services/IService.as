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
         */   
        function login(email:String, passwd:String):void;
        
        /**
         * Service's name of the Google service you're requesting authorization for.
         * @return 
         */  
        function get alias():String;
    }
}