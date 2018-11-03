//
// Created by 日高郁彦 on 2018/10/27.
// Copyright (c) 2018 日高郁彦. All rights reserved.
//

import Foundation
import APIKit

struct GetRateLimitRequest: GitHubRequest {
    typealias Response = RateLimit

    var method: HTTPMethod {
        return .get
    }

    var path: String {
        return "/rate_limit"
    }

    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        guard let dictionary = object as? [String: AnyObject],
              let rateLimit = RateLimit(dictionary: dictionary) else {
            throw ResponseError.unexpectedObject(object)
        }

        return rateLimit
    }
}
