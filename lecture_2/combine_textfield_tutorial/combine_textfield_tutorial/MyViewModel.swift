//
//  MyViewModel.swift
//  combine_textfield_tutorial
//
//  Created by 구자혁 on 2021/07/12.
//  Copyright © 2021 구자혁. All rights reserved.
//

import Foundation
import Combine

class MyViewModel {
    // published 어노테이션을 통해 구독이 가능하도록 설정
    @Published var passwordInput: String = "" {
        didSet {
            print("MyViewModel / passwordInput: \(passwordInput)")
        }
    }
    @Published var passwordConfirmInput: String = "" {
        didSet {
            print("MyViewModel / passwordConfirmInput: \(passwordConfirmInput)")
        }
    }
    // 들어온 퍼블리셔들의 값 일치 여부를 반환 하는 퍼블리셔
    lazy var isMatchPasswordInput: AnyPublisher<Bool, Never> = Publishers
        .CombineLatest($passwordInput, $passwordConfirmInput)
        .map({ (password: String, passwordConfirm: String) in
            if password == "" || passwordConfirm == "" {
                return false
            }
            if password == passwordConfirm {
                return true
            }
            else {
                return false
            }
        })
        .print()
        .eraseToAnyPublisher()
}
