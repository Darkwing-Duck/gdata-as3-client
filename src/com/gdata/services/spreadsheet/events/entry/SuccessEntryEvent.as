package com.gdata.services.spreadsheet.events.entry
{
    import com.gdata.services.spreadsheet.entries.IEntry;
    
    import flash.events.Event;
    
    /**
     * ...<br>
     * 
     * @history create Mar 24, 2012 5:14:10 PM<br>
     * @author Smirnov Sergey
     */	
    public class SuccessEntryEvent extends Event
    {	
        //----------------------------------------------------------------------------------------------
        //
        //  Class constants
        //
        //----------------------------------------------------------------------------------------------
        
        public static const ON_SUCCESSFUL_INSERT:String = "on_successful_insert";
        public static const ON_SUCCESSFUL_UPDATE:String = "on_successful_update";
        public static const ON_SUCCESSFUL_DELETE:String = "on_successful_delete";
        
        //----------------------------------------------------------------------------------------------
        //
        //  Class variables
        //
        //----------------------------------------------------------------------------------------------
        
        protected var _entry:IEntry;
        
        //----------------------------------------------------------------------------------------------
        //
        //  Constructor
        //
        //----------------------------------------------------------------------------------------------
        
        public function SuccessEntryEvent(type:String, entry:IEntry, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            _entry = entry;
            super(type, bubbles, cancelable);
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
        
        override public function clone():Event
        {
            return new SuccessEntryEvent(type, _entry, bubbles, cancelable);
        }

        public function get entry():IEntry
        {
            return _entry;
        }

        //----------------------------------------------------------------------------------------------
        //
        //  Accessors
        //
        //----------------------------------------------------------------------------------------------
    }
}