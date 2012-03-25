package com.gdata.services.spreadsheet.entries.row
{
    import com.gdata.services.spreadsheet.SpreadsheetNamespaces;
    import com.gdata.services.spreadsheet.requests.GDataRequest;
    import com.gdata.services.spreadsheet.requests.IGDataRequest;
    import com.gdata.services.spreadsheet.requests.Remove;
    import com.gdata.services.spreadsheet.requests.Update;
    import com.gdata.services.spreadsheet.entries.IEntry;
    import com.gdata.services.spreadsheet.events.ServiceErrorEvent;
    import com.gdata.services.spreadsheet.events.entry.SuccessEntryEvent;
    
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.IOErrorEvent;
    
    /**
     * ...<br>
     * 
     * @history create Mar 25, 2012 2:39:41 PM<br>
     * @author Smirnov Sergey
     */	
    public class RowEntry extends EventDispatcher implements IEntry
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
         * Row entry's title.
         * Undertakes from column 'A'.
         */  
        protected var _title:String;
        
        /**
         * Custom elements of specific row. 
         */ 
        protected var _customElements:RowCustomElements;
        
        /**
         * Edit entry url. 
         */       
        protected var _rowEditUrl:String;
        
        //----------------------------------------------------------------------------------------------
        //
        //  Constructor
        //
        //----------------------------------------------------------------------------------------------
        
        public function RowEntry(rawData:XML)
        {
            _customElements = new RowCustomElements();
            init(rawData);
        }
        
        //----------------------------------------------------------------------------------------------
        //
        //  Event handlers
        //
        //----------------------------------------------------------------------------------------------
        
        /**
         * Successful remove handler.
         * @param event Event
         */        
        protected function onSuccessfulRemove(event:Event):void
        {
            destroyRemoveCommand(event.currentTarget as IGDataRequest);
            dispatchEvent(new SuccessEntryEvent(SuccessEntryEvent.ON_SUCCESSFUL_DELETE, this));
        }
        
        /**
         * Error remove handler.
         * @param event IOErrorEvent
         */   
        protected function onErrorRemove(event:IOErrorEvent):void
        {
            var errorMessage:String = event.currentTarget.loader.data;
            destroyRemoveCommand(event.currentTarget as IGDataRequest);
            
            var errorEvent:ServiceErrorEvent = new ServiceErrorEvent(ServiceErrorEvent.ON_ERROR_ENTRY, false, false, errorMessage);
            dispatchEvent(errorEvent);
        }
        
        /**
         * Successful update handler.
         * @param event Event
         */   
        protected function onSuccessfulUpdate(event:Event):void
        {
            init(XML(event.currentTarget.loader.data));
            destroyUpdateCommand(event.currentTarget as IGDataRequest);
            dispatchEvent(new SuccessEntryEvent(SuccessEntryEvent.ON_SUCCESSFUL_UPDATE, this));
        }
        
        /**
         * Error update handler.
         * @param event IOErrorEvent
         */  
        protected function onErrorUpdate(event:IOErrorEvent):void
        {
            var errorMessage:String = event.currentTarget.loader.data;
            destroyUpdateCommand(event.currentTarget as IGDataRequest);
            
            var errorEvent:ServiceErrorEvent = new ServiceErrorEvent(ServiceErrorEvent.ON_ERROR_ENTRY, false, false, errorMessage);
            dispatchEvent(errorEvent);
        }
        
        //----------------------------------------------------------------------------------------------
        //
        //  Private Methods
        //
        //----------------------------------------------------------------------------------------------
        
        private function destroyRemoveCommand(command:IGDataRequest):void
        {
            GDataRequest(command).removeEventListener(Event.COMPLETE, onSuccessfulRemove);
            GDataRequest(command).removeEventListener(IOErrorEvent.IO_ERROR, onErrorRemove);
            GDataRequest(command).destroy();
        }
        
        private function destroyUpdateCommand(command:IGDataRequest):void
        {
            GDataRequest(command).removeEventListener(Event.COMPLETE, onSuccessfulUpdate);
            GDataRequest(command).removeEventListener(IOErrorEvent.IO_ERROR, onErrorUpdate);
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
            
            var gsx:Namespace = SpreadsheetNamespaces.gsx;
            
            _title = rawData.title;
            _rowEditUrl = rawData.link.(@rel == "edit").@href;

            // init custom elements
            for each (var element:XML in rawData.gsx::*)
            {
                _customElements.setValue(element.localName(), element);
            }
        }
        
        /**
         * Generates the entry data to update the entry with api.
         * @return 
         */        
        protected function generateUpdatedRow():XML
        {
            default xml namespace = SpreadsheetNamespaces.ans;
            
            var gsx:Namespace = SpreadsheetNamespaces.gsx;
            var result:XML = new XML(<entry></entry>);
            
            result.addNamespace(gsx);
            
            result.appendChild(<title>{_title}</title>);
            
            for each (var tag:String in _customElements.getTags())
            {
                var value:String = _customElements.getValue(tag);
                var element:XML = new XML(<{tag}>{value}</{tag}>);
                element.setNamespace(gsx);
                
                result.appendChild(element);
            }
            
            return result;
        }
        
        //----------------------------------------------------------------------------------------------
        //
        //  Public Methods
        //
        //----------------------------------------------------------------------------------------------
        
        /**
         * Removes current entry with api.
         * You should wait when the entry is deleted.
         */
        public function remove():void
        {
            var command:IGDataRequest = new Remove(_rowEditUrl);
            GDataRequest(command).addEventListener(Event.COMPLETE, onSuccessfulRemove);
            GDataRequest(command).addEventListener(IOErrorEvent.IO_ERROR, onErrorRemove);
            command.send();
        }
        
        /**
         * Updates current entry with api.
         * You should wait when the entry is updated.
         */
        public function update():void
        {
            var data:XML = generateUpdatedRow();
            var command:IGDataRequest = new Update(_rowEditUrl, data);
            GDataRequest(command).addEventListener(Event.COMPLETE, onSuccessfulUpdate);
            GDataRequest(command).addEventListener(IOErrorEvent.IO_ERROR, onErrorUpdate);
            command.send();
        }
        
        /**
         * Custom elements of specific row. 
         * @return 
         */        
        public function getCustomElements():RowCustomElements
        {
            return _customElements;
        }
        
        /**
         * @inheritDoc
         */  
        public function getTitle():String
        {
            return _title;
        }
        
        /**
         * @inheritDoc
         */        
        public function destroy():void
        {
            _customElements.destroy();
            _customElements = null;
            _title = null;
            _rowEditUrl = null;
        }
        
        //----------------------------------------------------------------------------------------------
        //
        //  Accessors
        //
        //----------------------------------------------------------------------------------------------
    }
}