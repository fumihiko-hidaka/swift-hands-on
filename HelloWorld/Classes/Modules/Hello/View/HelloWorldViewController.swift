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
import APIKit

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
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        //　撮影が完了時した時に呼ばれる
        let captureImage = info[.originalImage] as? UIImage

        guard let image = captureImage,
              var imageData = captureImage?.pngData() else {
            print("画像データがないみたい☠️")
            return
        }

        if (imageData.count > 2097152) {
            let oldSize: CGSize = image.size
            let newSize: CGSize = CGSize(width: 800, height: oldSize.height / oldSize.width * 800)
            imageData = resizeImage(newSize, image: image)
        }

        var request = VisionRequest()
        request.base64image = imageData.base64EncodedString(options: .endLineWithCarriageReturn)

        Session.send(request) {
            result in
            switch result {
            case .success(let response):
                print("成功したみたい")
                print(response.labels)
            case .failure(let error):
                print("error: \(error)")
            }
        }

        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // 撮影がキャンセルされた時に呼ばれる
        picker.dismiss(animated: true, completion: nil)
        print("🍣🍣🍣")
    }


    func resizeImage(_ imageSize: CGSize, image: UIImage) -> Data {
        UIGraphicsBeginImageContext(imageSize)
        image.draw(in: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        let resizedImage = newImage!.pngData()
        UIGraphicsEndImageContext()
        return resizedImage!
    }
}

extension HelloWorldViewController: UINavigationControllerDelegate {

}
