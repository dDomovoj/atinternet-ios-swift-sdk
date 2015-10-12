/*
This SDK is licensed under the MIT license (MIT)
Copyright (c) 2015- Applied Technologies Internet SAS (registration number B 403 261 258 - Trade and Companies Register of Bordeaux – France)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/





//
//  Offline.swift
//  Tracker
//

import UIKit

public class Offline {
    /// Tracker instance
    var tracker: Tracker
    
    /**
    Offline initializer
    - parameter tracker: the tracker instance
    - returns: Offline instance
    */
    init(tracker: Tracker) {
        self.tracker = tracker;
    }
    
    /**
    Send offline hits
    */
    public func dispatch() {
        Sender.sendOfflineHits(self.tracker, forceSendOfflineHits: true, async: true)
    }
    
    /**
    Get all offline hits stored in database
    
    - returns: array of offline hits
    */
    public func get() -> [Hit] {
        let storage = Storage()
        
        return storage.get()
    }
    
    /**
    Get the number of offline hits stored in database
    
    - returns: number of offline hits
    */
    public func count() -> Int {
        let storage = Storage()
        
        return storage.count()
    }
    
    /**
    Delete all offline hits stored in database
    
    - returns: number of deleted hits (-1 if an error occured)
    */
    public func delete() -> Int {
        let storage = Storage()
        
        return storage.delete()
    }
    
    /**
    Delete offline hits older than the number of days passed in parameter
    
    :params: Number of days of offline hits to keep in database
    
    - returns: number of deleted hits (-1 if an error occured)
    */
    public func delete(olderThan: Int) -> Int {
        let storage = Storage()
        
        let now = NSDate()
        let dateComponent = NSDateComponents()
        dateComponent.day = -olderThan
        
        let past = NSCalendar.currentCalendar().dateByAddingComponents(dateComponent, toDate: now, options: NSCalendarOptions(rawValue: 0))
        
        return storage.delete(past!)
    }
    
    /**
    Delete offline hits older than the date passed in parameter
    
    :params: Date from which the hits will be deleteddelet
    
    - returns: number of deleted hits (-1 if an error occured)
    */
    public func delete(olderThan: NSDate) -> Int {
        let storage = Storage()
        
        return storage.delete(olderThan)
    }
    
    /**
    Get the first hit stored in database
    
    - returns: the oldest hit
    */
    public func oldest() -> Hit? {
        let storage = Storage()
        
        return storage.first()
    }
    
    /**
    Get the latest hit stored in database
    
    - returns: the latest hit
    */
    public func latest() -> Hit? {
        let storage = Storage()
        
        return storage.last()
    }
}
