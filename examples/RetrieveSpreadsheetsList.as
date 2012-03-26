package
{
    import com.gdata.services.spreadsheet.SpreadsheetService;
    import com.gdata.services.spreadsheet.entries.IEntry;
    import com.gdata.services.spreadsheet.entries.spreadsheet.SpreadsheetAuthor;
    import com.gdata.services.spreadsheet.entries.spreadsheet.SpreadsheetEntry;
    import com.gdata.services.spreadsheet.events.ServiceErrorEvent;
    import com.gdata.services.spreadsheet.events.login.SuccessLoginEvent;
    import com.gdata.services.spreadsheet.feeds.IFeed;
    import com.gdata.services.spreadsheet.feeds.spreadsheet.SpreadsheetFeed;
    
    import flash.display.Sprite;
    import flash.events.Event;
    
    /**
     * Example #2.
     * Retrieving a list of spreadsheets.<br>
     * 
     * @history create Mar 26, 2012 10:47:21 PM<br>
     * @author Smirnov Sergey
     */	
    public class WorkingWithSpreadsheets extends Sprite
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
         * Spreadsheets service instance. 
         */        
        private var _service:SpreadsheetService;
        
        //----------------------------------------------------------------------------------------------
        //
        //  Constructor
        //
        //----------------------------------------------------------------------------------------------
        
        public function WorkingWithSpreadsheets()
        {
            // init the service
            _service = new SpreadsheetService();
            
            // init login event listeners
            _service.addEventListener(SuccessLoginEvent.ON_SUCCESSFUL_LOGIN, onSuccessLogin);
            //
            
            // login
            _service.login("yourEmail", "yourPassword");
        }
        
        //----------------------------------------------------------------------------------------------
        //
        //  Event handlers
        //
        //----------------------------------------------------------------------------------------------
        
        /**
         * Successful login handler.
         * @param event SuccessLoginEvent
         */        
        protected function onSuccessLogin(event:SuccessLoginEvent):void
        {
            // get new instance of spreadsheets feed
            var spreadsheetFeed:IFeed = _service.getFeed();
            
            // retrive the url of spreadsheets feed
            var spreadsheetFeedUrl:String = _service.getSpreadsheetFeedUrl();
            
            // load spreadsheets feed
            SpreadsheetFeed(spreadsheetFeed).addEventListener(Event.COMPLETE, onSpreadsheetFeedLoaded);
            SpreadsheetFeed(spreadsheetFeed).addEventListener(ServiceErrorEvent.ON_ERROR_FEED, onSpreadsheetFeedError);
            spreadsheetFeed.load(spreadsheetFeedUrl);
            //
        }
        
        /**
         * Successful loaded list of spreadsheets.
         * @param event Event
         */        
        protected function onSpreadsheetFeedLoaded(event:Event):void
        {
            var spreadsheet:IEntry;
            var author:SpreadsheetAuthor;
            
            // retrieve spreadsheets feed
            var spreadsheetFeed:IFeed = event.currentTarget as IFeed;
            
            // get specific spreadsheet by title 'Sheet1'
            spreadsheet = spreadsheetFeed.getEntry("Sheet1");
            
            // get spreadsheet title
            trace(SpreadsheetEntry(spreadsheet).getTitle());
            
            // get spreadsheet's author
            author = SpreadsheetEntry(spreadsheet).getAuthor();
            
            // get spreadsheet's author name
            trace(author.name);
            
            // get spreadsheet's author email
            trace(author.email);
            
            // ---------------------------------------------------------------
            
            // get all spreadsheets
            var spreadsheetsList:Vector.<IEntry> = spreadsheetFeed.getEntries();
            
            for each (spreadsheet in spreadsheetsList)
            {
                // get spreadsheet's author
                author = SpreadsheetEntry(spreadsheet).getAuthor();
                
                trace("title: " + spreadsheet.getTitle());
                trace("author name: " + author.name);
                trace("author email: " + author.email);
            }
        }
        
        /**
         * Error loading list of spreadsheets.
         * @param event ServiceErrorEvent
         */        
        protected function onSpreadsheetFeedError(event:ServiceErrorEvent):void
        {
            // get error message
            trace(event.text);
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
        //  Public Methods
        //
        //----------------------------------------------------------------------------------------------
        
        //----------------------------------------------------------------------------------------------
        //
        //  Accessors
        //
        //----------------------------------------------------------------------------------------------
    }
}