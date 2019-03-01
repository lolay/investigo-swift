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

import FirebaseAnalytics

class LolayFirebaseTracker: LolayBaseTracker {
    override func setIdentifier(_ identifier: String) {
        Analytics.setUserID(identifier)
    }
    
    override func setGlobalParameters(_ globalParameters: [String:String]) {
        for (key, value) in globalParameters {
            Analytics.setUserProperty(value, forName: key)
        }
    }
    
    override func setGlobalParameter(_ value: String, forKey key:String) {
        Analytics.setUserProperty(value, forName: key)
    }
    
    override func removeGlobalParameterForKey(_ key:String) {
        Analytics.setUserProperty(nil, forName: key)
    }
    
    override func logEvent(_ name: String) {
        Analytics.logEvent(name, parameters: nil)
    }
    
    override func logEvent(_ name: String, withDictionary dictionary: [String:String]) {
        Analytics.logEvent(name, parameters: dictionary)
    }
    
    override func logPage(_ name: String) {
        Analytics.setScreenName(name, screenClass: name)
        Analytics.logEvent(name + "-page", parameters: nil)
    }
    
    override func logPage(_ name: String, withDictionary dictionary: [String:String]) {
        Analytics.setScreenName(name, screenClass: name)
        Analytics.logEvent(name + "-page", parameters: dictionary)
    }
}