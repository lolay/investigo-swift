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

import os.log

class LolayOSLogTracker: LolayBaseTracker {
    var log: OSLog
    
    init(bundleIdentifier: String) {
        let className = String(describing: type(of: self))
        log = OSLog.init(subsystem: bundleIdentifier, category: className)
    }
    
    override func logEvent(_ name: String) {
        os_log(.info, log: log, "event=%{PUBLIC}@", name)
    }
    
    override func logEvent(_ name: String, withDictionary dictionary: [String:String]) {
        os_log(.info, log: log, "event=%{PUBLIC}@, dictionary=%{PUBLIC}@", name, dictionary.description)
    }
    
    override func logPage(_ name: String) {
        os_log(.info, log: log, "page=%{PUBLIC}@", name)
    }
    
    override func logPage(_ name: String, withDictionary dictionary: [String:String]) {
        os_log(.info, log: log, "page=%{PUBLIC}@, dictionary=%{PUBLIC}@", name, dictionary.description)
    }
    
    override func logError(_ error: Error) {
        os_log(.error, log: log, "error=%{PUBLIC}@", error.localizedDescription)
    }
    
    override func logError(_ error: NSError) {
        os_log(.error, log: log, "error=%{PUBLIC}@", error.localizedDescription)
    }
    
    override func logException(_ exception: NSException) {
        os_log(.fault, log: log, "exception=%{PUBLIC}@", exception.debugDescription)
    }
}
