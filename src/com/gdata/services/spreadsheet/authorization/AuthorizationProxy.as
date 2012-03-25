package com.gdata.services.spreadsheet.authorization
{
    /**
     * User authorization singleton object.<br>
     * 
     * @history create Mar 23, 2012 12:23:47 AM<br>
     * @author Smirnov Sergey
     */	
    public class AuthorizationProxy
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
         * User's email. 
         */        
        private var _email:String;
        
        /**
         * User's password. 
         */ 
        private var _passwd:String;
        
        /**
         * User's authorization key. 
         */ 
        private var _auth:String;
          
        private static var _instance:AuthorizationProxy = new AuthorizationProxy();
        
        //----------------------------------------------------------------------------------------------
        //
        //  Constructor
        //
        //----------------------------------------------------------------------------------------------
        
        public function AuthorizationProxy()
        {
        }
        
        //----------------------------------------------------------------------------------------------
        //
        //  Public Methods
        //
        //----------------------------------------------------------------------------------------------
        
        public function init(params:AuthorizationParams):void
        {
            _email = params.email;
            _passwd = params.passwd;
            _auth = params.auth;
            
            params = null;
        }
        
        /**
         * User'authorization key.
         * @return 
         */        
        public function getAuth():String
        {
            return _auth;
        }
        
        /**
         * User's email.
         * @return 
         */ 
        public function getEmail():String
        {
            return _email;
        }
        
        /**
         * User's password.
         * @return 
         */ 
        public function getPassword():String
        {
            return _passwd;
        }
        
        /**
         * Singleton method to get AuthorizationProxy instance.
         * @return 
         */        
        public static function getInstance():AuthorizationProxy
        {
            return _instance;
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
        //  Event handlers
        //
        //----------------------------------------------------------------------------------------------
        
        //----------------------------------------------------------------------------------------------
        //
        //  Accessors
        //
        //----------------------------------------------------------------------------------------------
    }
}