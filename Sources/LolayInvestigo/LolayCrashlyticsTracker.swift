//
//  Copyright © 2020, 2023 Lolay, Inc.
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
import FirebaseCrashlytics

public class LolayCrashlyticsTracker: LolayBaseTracker {
    override public init() {
        super.init()
    }
    
    override public func setIdentifier(_ identifier: String) {
        Crashlytics.crashlytics().setUserID(identifier)
    }
    
    override public func setGlobalParameters(_ globalParameters: [String:String]) {
        let crashlytics = Crashlytics.crashlytics()
        for (key, value) in globalParameters {
            crashlytics.setCustomValue(value, forKey: key)
        }
    }
    
    override public func setGlobalParameter(_ value: String, forKey key:String) {
        Crashlytics.crashlytics().setCustomValue(value, forKey: key)
    }
    
    override public func removeGlobalParameterForKey(_ key:String) {
        Crashlytics.crashlytics().setCustomValue("", forKey: key)
    }
    
    override public func logEvent(_ name: String) {
        Crashlytics.crashlytics().log(name)
    }
    
    override public func logEvent(_ name: String, withDictionary dictionary: [String:String]) {
        Crashlytics.crashlytics().log(name + " " + dictionary.description)
    }
    
    override public func logPage(_ name: String) {
        Crashlytics.crashlytics().log(name + "-page")
    }
    
    override public func logPage(_ name: String, withDictionary dictionary: [String:String]) {
        Crashlytics.crashlytics().log(name + "-page" + " " + dictionary.description)
    }
    
    override public func logError(_ error: Error) {
        Crashlytics.crashlytics().record(error: error)
    }
    
    override public func logError(_ error: NSError) {
        Crashlytics.crashlytics().record(error: error)
    }
}
