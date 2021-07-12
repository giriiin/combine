//
//  ViewController.swift
//  combine_textfield_tutorial
//
//  Created by 구자혁 on 2021/07/12.
//  Copyright © 2021 구자혁. All rights reserved.
//

import UIKit
import Combine

class ViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    @IBOutlet weak var myButton: UIButton!
    
    var viewModel: MyViewModel!
    private var mySubscription = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.viewModel = MyViewModel()
        
        // 텍스트필드에서 나가는 이벤트를
        // 뷰모델의 프로퍼티가 구독
        self.passwordTextField
            .myTextpublisher
//            .print()
            // 스레드 - 메인에서 받겠다
            .receive(on: RunLoop.main)
            .assign(to: \.passwordInput, on: viewModel)
            .store(in: &self.mySubscription)
        
        self.passwordConfirmTextField
            .myTextpublisher
            //            .print()
            // 스레드 - 메인에서 받겠다
            .receive(on: RunLoop.main)
            .assign(to: \.passwordConfirmInput, on: viewModel)
            .store(in: &self.mySubscription)
        
        // 버튼이 뷰모델의 퍼블리셔를 구독
        self.viewModel.isMatchPasswordInput
            .print()
            .receive(on: RunLoop.main)
            .assign(to: \.isValid, on: self.myButton)
            .store(in: &self.mySubscription)
    }
}

extension UITextField {
    fileprivate var myTextpublisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: self)
//            .print()
            // UITextField 가져옴
            .compactMap{ $0.object as? UITextField }
            // String 가져옴
            .map{ $0.text ?? "" }
//            .print()
            .eraseToAnyPublisher()
    }
}

extension UIButton {
    var isValid: Bool {
        get {
            backgroundColor == .yellow
        }
        set {
            backgroundColor = newValue ? .yellow : .lightGray
            isEnabled = newValue
            setTitleColor(newValue ? .blue : .white, for: .normal)
        }
    }
}
