//
//  Copyright © 2019 Lolay, Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import Foundation

public class LolayMultipleTracker: LolayBaseTracker {
    public var trackers: [LolayTracker]
    
    public init(_ trackers: LolayTracker...) {
        self.trackers = trackers
    }
    
    override public func setIdentifier(_ identifier: String) {
        for tracker in trackers {
            tracker.setIdentifier(identifier)
        }
    }
    
    override public func setVersion(_ version: String) {
        for tracker in trackers {
            tracker.setVersion(version)
        }
    }
    
    override public func setEmail(_ email: String) {
        for tracker in trackers {
            tracker.setEmail(email)
        }
    }
    
    override public func setName(_ name: String) {
        for tracker in trackers {
            tracker.setName(name)
        }
    }
    
    override public func setGlobalParameters(_ globalParameters: [String:String]) {
        for tracker in trackers {
            tracker.setGlobalParameters(globalParameters)
        }
    }
    
    override public func setGlobalParameter(_ value: String, forKey key:String) {
        for tracker in trackers {
            tracker.setGlobalParameter(value, forKey: key)
        }
    }
    
    override public func removeGlobalParameterForKey(_ key:String) {
        for tracker in trackers {
            tracker.removeGlobalParameterForKey(key)
        }
    }
    
    override public func logEvent(_ name: String) {
        for tracker in trackers {
            tracker.logEvent(name)
        }
    }
    
    override public func logEvent(_ name: String, withDictionary dictionary: [String:String]) {
        for tracker in trackers {
            tracker.logEvent(name, withDictionary: dictionary)
        }
    }
    
    override public func logPage(_ name: String) {
        for tracker in trackers {
            tracker.logPage(name)
        }
    }
    
    override public func logPage(_ name: String, withDictionary dictionary: [String:String]) {
        for tracker in trackers {
            tracker.logEvent(name, withDictionary: dictionary)
        }
    }
    
    override public func logError(_ error: Error) {
        for tracker in trackers {
            tracker.logError(error)
        }
    }
    
    override public func logError(_ error: NSError) {
        for tracker in trackers {
            tracker.logError(error)
        }
    }
    override public func logException(_ exception: NSException) {
        for tracker in trackers {
            tracker.logException(exception)
        }
    }
}
