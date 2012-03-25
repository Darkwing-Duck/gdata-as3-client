package com.gdata.services.spreadsheet.entries.worksheet
{
    /**
     * Describes the parameters needed to create new worksheet.<br>
     * 
     * @history create Mar 24, 2012 2:57:38 PM<br>
     * @author Smirnov Sergey
     */	
    public class WorksheetCreationParams
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
         * Worksheet's title. 
         */        
        protected var _title:String;
        
        /**
         * Columns count. 
         */        
        protected var _columnCount:int;
        
        /**
         * Rows count. 
         */
        protected var _rowCount:int;
        
        //----------------------------------------------------------------------------------------------
        //
        //  Constructor
        //
        //----------------------------------------------------------------------------------------------
        
        /**
         * Creates the params.<br>
         * The constructor sets by default:<br>
         * <ul><li>rowCount 100</li>
         * <li>columnCount 20</li></ul>
         * @param title worksheet's title
         */        
        public function WorksheetCreationParams(title:String)
        {
            _title = title;
            _columnCount = 20;
            _rowCount = 100;
        }
        
        //----------------------------------------------------------------------------------------------
        //
        //  Event handlers
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
        //  Public Methods
        //
        //----------------------------------------------------------------------------------------------
        
        //----------------------------------------------------------------------------------------------
        //
        //  Accessors
        //
        //----------------------------------------------------------------------------------------------

        /**
         * Worksheet's title.
         * @return 
         */        
        public function get title():String
        {
            return _title;
        }

        public function set title(value:String):void
        {
            _title = value;
        }

        /**
         * Worksheet's columns count.
         * @return 
         */  
        public function get columnCount():int
        {
            return _columnCount;
        }

        public function set columnCount(value:int):void
        {
            _columnCount = value;
        }

        /**
         * Worksheet's rows count.
         * @return 
         */
        public function get rowCount():int
        {
            return _rowCount;
        }

        public function set rowCount(value:int):void
        {
            _rowCount = value;
        }
    }
}