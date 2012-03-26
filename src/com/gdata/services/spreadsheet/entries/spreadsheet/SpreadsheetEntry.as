package com.gdata.services.spreadsheet.entries.spreadsheet
{
    import com.gdata.services.spreadsheet.SpreadsheetNamespaces;
    import com.gdata.services.spreadsheet.requests.GDataRequest;
    import com.gdata.services.spreadsheet.requests.IGDataRequest;
    import com.gdata.services.spreadsheet.requests.Insert;
    import com.gdata.services.spreadsheet.entries.IEntry;
    import com.gdata.services.spreadsheet.entries.worksheet.WorksheetCreationParams;
    import com.gdata.services.spreadsheet.entries.worksheet.WorksheetEntry;
    import com.gdata.services.spreadsheet.events.ServiceErrorEvent;
    import com.gdata.services.spreadsheet.events.entry.SuccessEntryEvent;
    import com.gdata.services.spreadsheet.feeds.IFeed;
    import com.gdata.services.spreadsheet.feeds.worksheet.WorksheetFeed;
    
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.IOErrorEvent;
    
    /**
     * ...<br>
     * 
     * @history create Mar 24, 2012 12:09:23 AM<br>
     * @author Smirnov Sergey
     */	
    public class SpreadsheetEntry extends EventDispatcher implements IEntry
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
         * Entry's title. 
         */  
        protected var _title:String;
        
        /**
         * Worksheets feed url. 
         */        
        protected var _worksheetFeedUrl:String;
        
        /**
         * Spreadsheet's author. 
         */        
        protected var _author:SpreadsheetAuthor;
        
        //----------------------------------------------------------------------------------------------
        //
        //  Constructor
        //
        //----------------------------------------------------------------------------------------------
        
        public function SpreadsheetEntry(rawData:XML)
        {
            init(rawData);
        }
        
        //----------------------------------------------------------------------------------------------
        //
        //  Event handlers
        //
        //----------------------------------------------------------------------------------------------
        
        /**
         * Successful insert new worksheet handler.
         * @param event Event
         */        
        protected function onSuccessfulResult(event:Event):void
        {
            var rawEntry:XML = XML(event.currentTarget.loader.data);
            var entry:IEntry = new WorksheetEntry(rawEntry);
            
            var entryEvent:SuccessEntryEvent = new SuccessEntryEvent(SuccessEntryEvent.ON_SUCCESSFUL_INSERT, entry);
            dispatchEvent(entryEvent);
        }
        
        /**
         * Error insert new worksheet handler.
         * @param event IOErrorEvent
         */ 
        protected function onErrorResult(event:IOErrorEvent):void
        {
            var errorMessage:String = event.currentTarget.loader.data;
            destroyCommand(event.currentTarget as IGDataRequest);
            
            var errorEvent:ServiceErrorEvent = new ServiceErrorEvent(ServiceErrorEvent.ON_ERROR_ENTRY, false, false, errorMessage);
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
         * Initializes the entry.
         * @param rawData raw data of entry
         */         
        protected function init(rawData:XML):void
        {
            default xml namespace = SpreadsheetNamespaces.ans;
            
            var category:String = rawData.category.@scheme;
            var authorInfo:XMLList = rawData.author;
            
            _title = rawData.title;
            _worksheetFeedUrl = rawData.link.(@rel == category + "#worksheetsfeed").@href;
            _author = new SpreadsheetAuthor(authorInfo.name, authorInfo.email);
        }
        
        /**
         * Generates the entry data to create new worksheet with api.
         * @return 
         */
        protected function generateNewWorksheet(params:WorksheetCreationParams):XML
        {
            default xml namespace = SpreadsheetNamespaces.ans;
            
            var gs:Namespace = SpreadsheetNamespaces.gs;
            var result:XML = new XML(<entry></entry>);
            
            result.addNamespace(gs);

            result.appendChild(<title>{params.title}</title>);
            result.appendChild(<rowCount>{params.rowCount}</rowCount>);
            result.appendChild(<colCount>{params.columnCount}</colCount>);
            
            result.rowCount.setNamespace(gs);
            result.colCount.setNamespace(gs);

            return result;
        }
        
        //----------------------------------------------------------------------------------------------
        //
        //  Public Methods
        //
        //----------------------------------------------------------------------------------------------
        
        /**
         * New worksheet feed instance.
         * @return 
         */
        public function getFeed():IFeed
        {
            return new WorksheetFeed();
        }
        
        /**
         * Inserts new worksheet's entry with api.
         * You should wait when the worksheet's entry is inserted.
         */
        public function insert(params:WorksheetCreationParams):void
        {
            var data:XML = generateNewWorksheet(params);
            var command:IGDataRequest = new Insert(_worksheetFeedUrl, data);
            GDataRequest(command).addEventListener(Event.COMPLETE, onSuccessfulResult);
            GDataRequest(command).addEventListener(IOErrorEvent.IO_ERROR, onErrorResult);
            command.send();
        }
        
        /**
         * @inheritDoc 
         */  
        public function getTitle():String
        {
            return _title;
        }
        
        /**
         * Worksheets feed url.
         * @return  
         */        
        public function getWorksheetFeedUrl():String
        {
            return _worksheetFeedUrl;
        }
        
        /**
         * Spreadsheet's author.
         * @return 
         */        
        public function getAuthor():SpreadsheetAuthor
        {
            return _author;
        }
        
        /**
         * @inheritDoc 
         */
        public function destroy():void
        {
            _title = null;
            _worksheetFeedUrl = null;
            _author = null;
        }
        
        //----------------------------------------------------------------------------------------------
        //
        //  Accessors
        //
        //----------------------------------------------------------------------------------------------
    }
}