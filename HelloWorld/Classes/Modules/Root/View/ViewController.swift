//
//  ViewController.swift
//  HelloWorld
//
//  Created by 日高郁彦 on 2018/10/26.
//  Copyright © 2018 日高郁彦. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var changeButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        changeButton.addTarget(
            self,
            action: #selector(self.changeEvent(sender:)),
            for: .touchUpInside
        )
    }

    @objc func changeEvent(sender: Any) {
        print("🍣")
    }

}

