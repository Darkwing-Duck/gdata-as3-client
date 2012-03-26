package com.gdata.services.spreadsheet.authorization
{
    /**
     * User authorization params.<br>
     * Necessary to transfer authorization info.
     * 
     * @history create Mar 23, 2012 1:10:50 AM<br>
     * @author Smirnov Sergey
     */	
    public class AuthorizationParams
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
        protected var _email:String;
        
        /**
         * User's password. 
         */
        protected var _passwd:String;
        
        /**
         * User's authorization key. 
         */
        protected var _auth:String;
        
        //----------------------------------------------------------------------------------------------
        //
        //  Constructor
        //
        //----------------------------------------------------------------------------------------------
        
        public function AuthorizationParams()
        {
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

        /**
         * User's email.
         * @return 
         */ 
        public function get email():String
        {
            return _email;
        }

        public function set email(value:String):void
        {
            _email = value;
        }

        /**
         * User's password.
         * @return 
         */ 
        public function get passwd():String
        {
            return _passwd;
        }

        public function set passwd(value:String):void
        {
            _passwd = value;
        }

        /**
         * User'authorization key.
         * @return 
         */ 
        public function get auth():String
        {
            return _auth;
        }

        public function set auth(value:String):void
        {
            _auth = value;
        }


    }
}