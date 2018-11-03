//
// Created by 日高郁彦 on 2018/10/27.
// Copyright (c) 2018 日高郁彦. All rights reserved.
//

import Foundation
import APIKit

//: Step 1: Define request protocol
protocol GitHubRequest: Request {

}

extension GitHubRequest {
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
}
