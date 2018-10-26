//
//  ViewGenerator.swift
//  HelloWorld
//
//  Created by 日高郁彦 on 2018/10/26.
//  Copyright © 2018 日高郁彦. All rights reserved.
//

import UIKit

protocol StoryboardType {
    static var storyboardName: String { get }
}

extension StoryboardType {
    static var storyboard: UIStoryboard {
        let name = self.storyboardName
        return UIStoryboard(name: name, bundle: nil)
    }
}

struct InitialSceneType<T: Any> {
    let storyboard: StoryboardType.Type
    
    func instantiate() -> T {
        guard let controller = storyboard.storyboard.instantiateInitialViewController() as? T else {
            fatalError("FatalError: ViewController not found.")
        }
        return controller
    }
}

enum StoryboardScene {
    enum MainViewController: StoryboardType {
        static let storyboardName = "Main"
        static let initialScene = InitialSceneType<HelloWorld.ViewController>(
            storyboard: MainViewController.self
        )
    }
    enum HelloWorldViewController: StoryboardType {
        static let storyboardName = "HelloWorldStoryboard"
        static let initialScene = InitialSceneType<HelloWorld.HelloWorldViewController>(
            storyboard: HelloWorldViewController.self
        )
    }
}
