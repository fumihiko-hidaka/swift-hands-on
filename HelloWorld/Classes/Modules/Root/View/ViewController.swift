//
//  ViewController.swift
//  HelloWorld
//
//  Created by 日高郁彦 on 2018/10/26.
//  Copyright © 2018 日高郁彦. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var changeButton: UIButton!

    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        changeButton.rx.tap.asDriver().drive(
            onNext: { [weak self] _ in
                print("🍤")
                
                let vc = StoryboardScene.HelloWorldViewController.initialScene.instantiate()
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        ).disposed(by: bag)
        
        /*
        changeButton.addTarget(
            self,
            action: #selector(self.changeEvent(sender:)),
            for: .touchUpInside
        )
        */
    }

    /*
    @objc func changeEvent(sender: Any) {
        print("🍣")
    }
    */

}

