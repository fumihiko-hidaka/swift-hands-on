//
// Created by 日高郁彦 on 2019/01/06.
// Copyright (c) 2019 日高郁彦. All rights reserved.
//

import Foundation

struct GoogleVision {
    let labels: [String]

    init?(dictionary: [String: AnyObject]) {
        print(dictionary)
        let responses = dictionary["responses"]?[0] as? [String: AnyObject]
        let test = responses?["labelAnnotations"] as? [[String: AnyObject]]
        guard let labelObjects = responses?["labelAnnotations"] as? [[String: AnyObject]] else {
            return nil
        }

        self.labels = labelObjects.map {
            $0["description"] as! String
        }
    }
}
