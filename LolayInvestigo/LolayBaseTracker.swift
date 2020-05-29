//
//  Copyright © 2020 Lolay, Inc.
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

public class LolayBaseTracker: LolayTracker {
    public func setIdentifier(_ identifier: String) { }
    public func setVersion(_ version: String) { }
    public func setEmail(_ email: String) { }
    public func setName(_ name: String) { }
    public func setGlobalParameters(_ globalParameters: [String:String]) { }
    public func setGlobalParameter(_ value: String, forKey key:String) { }
    public func removeGlobalParameterForKey(_ key:String) { }
    public func logEvent(_ name: String) { }
    public func logEvent(_ name: String, withDictionary dictionary: [String:String]) { }
    public func logPage(_ name: String) { }
    public func logPage(_ name: String, withDictionary dictionary: [String:String]) { }
    public func logError(_ error: Error) { }
    public func logError(_ error: NSError) { }
    public func logException(_ exception: NSException) { }
}
