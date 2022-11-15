//
//  main.swift
//  MyCreditManager
//
//  Created by EE201201 on 2022/11/15.
//

import Foundation

enum CreditManager: String {
    case addStudent     = "1"
    case removeStudent  = "2"
    case addGrade       = "3"
    case removeGrade    = "4"
    case showAverage    = "5"
    case finish         = "X"
    case other
}

func inputReadline() -> CreditManager {
    return CreditManager(rawValue: readLine()!.uppercased()) ?? .other
}

func initSetting() {
    while true {
        print("원하는 기능을 입력해주세요.\n1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료")
        switch inputReadline() {
        case .addStudent:
            StudentManger.shared.addStudent()
            break
        case .removeStudent:
            StudentManger.shared.removeStudent()
            break
        case .addGrade:
            StudentManger.shared.addGrade()
            break
        case .removeGrade:
            StudentManger.shared.removeGrade()
            break
        case .showAverage:
            StudentManger.shared.getAverage()
            break
        case .finish:
            print("프로그램을 종료합니다...")
            return
        default:
            print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.")
        }
    }
}

initSetting()

