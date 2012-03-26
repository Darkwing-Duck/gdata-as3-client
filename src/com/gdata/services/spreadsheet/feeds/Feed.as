package com.gdata.services.spreadsheet.feeds
{
    import com.gdata.services.spreadsheet.requests.GDataRequest;
    import com.gdata.services.spreadsheet.requests.GetFeed;
    import com.gdata.services.spreadsheet.requests.IGDataRequest;
    import com.gdata.services.spreadsheet.entries.IEntry;
    import com.gdata.services.spreadsheet.events.ServiceErrorEvent;
    
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.IOErrorEvent;
    
    /**
     * ...<br>
     * 
     * @history create Mar 25, 2012 12:29:28 AM<br>
     * @author Smirnov Sergey
     */	
    public class Feed extends EventDispatcher implements IFeed
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
         * List of feed's entries. 
         */        
        protected var _entries:Vector.<IEntry>;
        
        //----------------------------------------------------------------------------------------------
        //
        //  Constructor
        //
        //----------------------------------------------------------------------------------------------
        
        public function Feed()
        {
            // init list
            _entries = new Vector.<IEntry>();
        }

        //----------------------------------------------------------------------------------------------
        //
        //  Event handlers
        //
        //----------------------------------------------------------------------------------------------
        
        /**
         * Successful feed loaded hadler.
         * @param event Event
         */        
        protected function onSuccessfulResult(event:Event):void
        {
            init(XML(event.currentTarget.loader.data));
            destroyCommand(GDataRequest(event.currentTarget));
            dispatchEvent(new Event(Event.COMPLETE));
        }
        
        /**
         * Error feed loaded hadler.
         * @param event IOErrorEvent
         */ 
        protected function onErrorResult(event:IOErrorEvent):void
        {
            var errorMessage:String = event.currentTarget.loader.data;
            destroyCommand(GDataRequest(event.currentTarget));
            
            var errorEvent:ServiceErrorEvent = new ServiceErrorEvent(ServiceErrorEvent.ON_ERROR_FEED, false, false, errorMessage);
            dispatchEvent(errorEvent);
        }
        
        //----------------------------------------------------------------------------------------------
        //
        //  Private Methods
        //
        //----------------------------------------------------------------------------------------------
        
        private function destroyCommand(command:IGDataRequest):void
        {
            GDataRequest(command).removeEventListener(Event.COMPLETE, onSuccessfulResult);
            GDataRequest(command).removeEventListener(IOErrorEvent.IO_ERROR, onErrorResult);
            GDataRequest(command).destroy();
        }
        
        //----------------------------------------------------------------------------------------------
        //
        //  Protected Methods
        //
        //----------------------------------------------------------------------------------------------
        
        /**
         * Initializes the feed.
         * @param rawFeed raw data of feed
         */        
        protected function init(rawFeed:XML):void
        {
            // should be overriden by subclass
        }
        
        //----------------------------------------------------------------------------------------------
        //
        //  Public Methods
        //
        //----------------------------------------------------------------------------------------------
        
        /**
         * @inheritDoc
         */ 
        public function load(url:String):void
        {
            _entries.splice(0, _entries.length);
            
            var command:IGDataRequest = new GetFeed(url);
            GDataRequest(command).addEventListener(Event.COMPLETE, onSuccessfulResult);
            GDataRequest(command).addEventListener(IOErrorEvent.IO_ERROR, onErrorResult);
            command.send();
        }
        
        /**
         * @inheritDoc
         */ 
        public function getEntries():Vector.<IEntry>
        {
            return _entries;
        }
        
        /**
         * @inheritDoc
         */ 
        public function getEntry(title:String):IEntry
        {
            var result:IEntry;
            
            for each (var entry:IEntry in _entries)
            {
                if (entry.getTitle() == title)
                {
                    result = entry;
                    break;
                }
            }
            
            return result;
        }
        
        /**
         * @inheritDoc
         */ 
        public function destroy():void
        {
            _entries.splice(0, _entries.length);
            _entries = null;
        }
        
        //----------------------------------------------------------------------------------------------
        //
        //  Accessors
        //
        //----------------------------------------------------------------------------------------------
    }
}