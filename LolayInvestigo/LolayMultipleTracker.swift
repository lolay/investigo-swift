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

class LolayMultipleTracker: LolayBaseTracker {
    var trackers: [LolayTracker]
    
    init(_ trackers: LolayTracker...) {
        self.trackers = trackers
    }
    
    
    override func setIdentifier(_ identifier: String) {
        for tracker in trackers {
            tracker.setIdentifier(identifier)
        }
    }
    
    override func setVersion(_ version: String) {
        for tracker in trackers {
            tracker.setVersion(version)
        }
    }
    
    override func setEmail(_ email: String) {
        for tracker in trackers {
            tracker.setEmail(email)
        }
    }
    
    override func setName(_ name: String) {
        for tracker in trackers {
            tracker.setName(name)
        }
    }
    
    override func setGlobalParameters(_ globalParameters: [String:String]) {
        for tracker in trackers {
            tracker.setGlobalParameters(globalParameters)
        }
    }
    
    override func setGlobalParameter(_ value: String, forKey key:String) {
        for tracker in trackers {
            tracker.setGlobalParameter(value, forKey: key)
        }
    }
    
    override func removeGlobalParameterForKey(_ key:String) {
        for tracker in trackers {
            tracker.removeGlobalParameterForKey(key)
        }
    }
    
    override func logEvent(_ name: String) {
        for tracker in trackers {
            tracker.logEvent(name)
        }
    }
    
    override func logEvent(_ name: String, withDictionary dictionary: [String:String]) {
        for tracker in trackers {
            tracker.logEvent(name, withDictionary: dictionary)
        }
    }
    
    override func logPage(_ name: String) {
        for tracker in trackers {
            tracker.logPage(name)
        }
    }
    override func logPage(_ name: String, withDictionary dictionary: [String:String]) {
        for tracker in trackers {
            tracker.logEvent(name, withDictionary: dictionary)
        }
    }
    
    override func logError(_ error: Error) {
        for tracker in trackers {
            tracker.logError(error)
        }
    }
    
    override func logError(_ error: NSError) {
        for tracker in trackers {
            tracker.logError(error)
        }
    }
    override func logException(_ exception: NSException) {
        for tracker in trackers {
            tracker.logException(exception)
        }
    }
}
