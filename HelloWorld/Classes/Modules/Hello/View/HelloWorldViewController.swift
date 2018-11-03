//
//  HelloWorldViewController.swift
//  HelloWorld
//
//  Created by 日高郁彦 on 2018/10/26.
//  Copyright © 2018 日高郁彦. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HelloWorldViewController: UIViewController {
    @IBOutlet weak var cameraButton: UIButton!

    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        cameraButton.rx.tap.asDriver().drive(
            onNext: { [weak self] _ in
                self?.startCamera()
            }
        ).disposed(by: bag)
    }

    func startCamera() {
        // カメラが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            // インスタンスの作成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = .camera
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
        }
    }
}

extension HelloWorldViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //　撮影が完了時した時に呼ばれる
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // 撮影がキャンセルされた時に呼ばれる
        picker.dismiss(animated: true, completion: nil)
        print("🍣🍣🍣")
    }
}

extension HelloWorldViewController: UINavigationControllerDelegate {
    
}
