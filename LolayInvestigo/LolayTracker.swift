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

protocol LolayTracker {
    func setIdentifier(_ identifier: String)
    func setVersion(_ version: String)
    func setEmail(_ email: String)
    func setName(_ name: String)
    func setGlobalParameters(_ globalParameters: [String:String])
    func setGlobalParameter(_ value: String, forKey key:String)
    func removeGlobalParameterForKey(_ key:String)
    func logEvent(_ name: String)
    func logEvent(_ name: String, withDictionary dictionary: [String:String])
    func logPage(_ name: String)
    func logPage(_ name: String, withDictionary dictionary: [String:String])
    func logError(_ error: Error)
    func logError(_ error: NSError)
    func logException(_ exception: NSException)
}
