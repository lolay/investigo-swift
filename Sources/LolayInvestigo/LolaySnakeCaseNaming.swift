//
//  Copyright © 2026 Lolay, Inc.
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

/// Underscore-joined naming: all components lowercased.
/// Example: scope ["Search", "Result"], action "opened" → "search_result_opened"
public struct LolaySnakeCaseNaming: LolayTrackerNamingStrategy {
    public init() {}

    public func formatEventName(scope: LolayTrackerScope, action: String) -> String {
        let parts = scope.components.map { toSnakeCase($0) } + [toSnakeCase(action)]
        return parts.joined(separator: "_")
    }

    private func toSnakeCase(_ input: String) -> String {
        var result = ""
        for (index, character) in input.enumerated() {
            if character.isUppercase && index > 0 {
                result.append("_")
            }
            result.append(character.lowercased())
        }
        return result
    }
}
