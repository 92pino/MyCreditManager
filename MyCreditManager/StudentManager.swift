//
//  StudentManager.swift
//  MyCreditManager
//
//  Created by EE201201 on 2022/11/15.
//

import Foundation

struct Student {
    var name: String
    var subject: [String: Double]
}

class StudentManger {
    static let shared = StudentManger()

    var students = [Student]()

    // 학생 추가
    func addStudent() {
        print("추가할 학생의 이름을 입력해주세요.")
        let input = readLine()!

        if input.isEmpty {
            errorPrint()
        }

        students.forEach { student in
            if input.uppercased() == student.name.uppercased() {
                print("\(input) 학생은 이미 존재합니다. 추가하지 않습니다.")
                return
            }
        }

        students.append(.init(name: input, subject: [:]))
    }

    // 학생 삭제
    func removeStudent() {
        print("삭제할 학생의 이름을 입력해주세요.")
        let input = readLine()!

        if input.isEmpty {
            errorPrint()
        }

        for (index, student) in students.enumerated() {
            if input.uppercased() == student.name.uppercased() {
                students.remove(at: index)
                print("\(student.name) 학생을 삭제하였습니다.")
                return
            }
        }

        print("\(input) 학생을 찾지 못했습니다.")
    }

    // 성적 추가
    func addGrade() {
        print("성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요 \n입력예) Mickey Swift A+ \n만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.")
        let input = readLine()!.split(separator: " ").map { String($0) }

        if input.count != 3 { return errorPrint() }

        let name = input[0], subject = input[1], grade = input[2].uppercased()

        for (index, student) in students.enumerated() {
            if student.name == name {
                students[index].subject.updateValue(convertGrade(grade), forKey: subject)
                print("\(name) 학생의 \(subject) 과목이 \(grade)로 추가(변경)되었습니다.")
                return
            }
        }

        print("\(name) 학생을 찾지 못했습니다.")

        return
    }

    func convertGrade(_ grade: String) -> Double {
        switch grade {
        case "A+":
            return 4.5
        case "A":
            return 4
        case "B+":
            return 3.5
        case "B":
            return 3
        case "C+":
            return 2.5
        case "C":
            return 2
        case "D+":
            return 1.5
        case "D":
            return 1
        case "F":
            return 0
        default:
            errorPrint()
            return 0
        }
    }

    // 성적 삭제
    func removeGrade() {
        print("성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.\n입력예) Mickey Swift")

        let input = readLine()!.split(separator: " ").map { String($0) }

        if input.count != 2 { return errorPrint() }

        let name = input[0], subject = input[1]

        for (index, student) in students.enumerated() {
            if student.name == name {
                if student.subject.contains(where: { element in
                    element.key == subject
                }) {
                    students[index].subject.removeValue(forKey: subject)
                    print("\(name) 학생의 \(subject) 과목의 성적이 삭제되었습니다.")
                    return
                }
            }
        }

        print("\(name) 학생을 찾지 못했습니다.")
    }

    func getAverage() {
        print("평점을 알고싶은 학생의 이름을 입력해주세요")
        let input = readLine()!
        if input.isEmpty {
            errorPrint()
        }

        if students.contains(where: { student in
            student.name != input
        }) || students.isEmpty {
            print("\(input) 학생을 찾지 못했습니다.")
            return
        }

        var sum: Double = 0

        for student in students where input == student.name {
            if student.subject.isEmpty {
                print("\(student.name) 학생의 성적이 존재하지 않습니다.")
                return
            } else {
                for subject in student.subject {
                    print("\(subject.key): \(subject.value)")
                    sum += subject.value
                }

                sum /= Double(student.subject.count)
                print("평점 : \(sum)")

                return
            }
        }
    }

    func errorPrint() {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
        return
    }
}
