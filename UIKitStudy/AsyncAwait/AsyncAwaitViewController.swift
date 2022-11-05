//
//  AsyncAwaitViewController.swift
//  UIKitStudy
//
//  Created by 0ofKim on 2022/11/02.
//

import UIKit

enum DownloadError: Error {
    case badImage
    case unknown
}

typealias Completion = (Result<Int, DownloadError>) -> Void

class AsyncAwaitViewController: UIViewController {
    @IBAction func clickedCompletionHandlerButton(_ sender: Any) {
        saveChanges { result in
            switch result {
            case .success(let response):
                print("response: \(response)")
            case .failure(let error):
                print("error: \(error)")
            }
        }
        saveChanges2 { result in
            switch result {
            case .success(let response):
                print("response2: \(response)")
            case .failure(let error):
                print("error2: \(error)")
            }
        }

        print("hello")
    }

    @IBAction func clickedAsyncAwaitButton(_ sender: Any) {
//        Task {
//            defer {
//                print("cleanup code")
//            }
//
//            do {
//                //단일
////                let result = try await saveChangesAsync()
////                print("result: \(result)")
//
//                //다중(한번에 처리)
//                async let result1 = try saveChangesAsync()
//                async let result2 = try saveChangesAsync2()
//
//                let results = try await [result1, result2]
//                for (index, result) in results.enumerated() {
//                    print("result\(index): \(result)")
//                }
//            } catch {
//                if error is DownloadError {
//                    print("error")
//                } else {
//                    print("other error")
//                }
//            }
//        }

        Task {
            do {
//                print("first1?")
                let result1 = try await saveChangesAsync()
                print("result1: \(result1)")
            } catch {
                if error is DownloadError {
                    print("error")
                } else {
                    print("other error")
                }
            }
        }

        Task {
            do {
//                print("first2?")
                let result2 = try await saveChangesAsync2()
                print("result2: \(result2)")
            } catch {
                if error is DownloadError {
                    print("error")
                } else {
                    print("other error")
                }
            }
        }

        print("==================")
    }

    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func saveChanges(completion: Completion) {
        let randomNumber = Int.random(in: 0..<5)
        Thread.sleep(forTimeInterval: Double(randomNumber))

        if randomNumber == 0 {
            completion(.failure(.unknown))
            return
        }
        completion(.success(randomNumber))
    }

    func saveChanges2(completion: Completion) {
        let randomNumber = Int.random(in: 0..<5)
        Thread.sleep(forTimeInterval: Double(randomNumber))

        if randomNumber == 0 {
            completion(.failure(.unknown))
            return
        }
        completion(.success(randomNumber))
    }

    func saveChangesAsync() async throws -> Int {
        let randomNumber = Int.random(in: 0..<5)
        Thread.sleep(forTimeInterval: Double(randomNumber))

        if randomNumber == 0 {
            throw DownloadError.unknown
        }

        return randomNumber
    }

    func saveChangesAsync2() async throws -> Int {
        let randomNumber = Int.random(in: 0..<5)
        Thread.sleep(forTimeInterval: Double(randomNumber))

        if randomNumber == 0 {
            throw DownloadError.unknown
        }

        return randomNumber
    }
}
