//
//  FrameBoundsViewController.swift
//  UIKitStudy
//
//  Created by 0ofKim on 2023/10/25.
//

import UIKit

class FrameBoundsViewController: UIViewController {
    @IBOutlet weak var yellowView: UIView!
    @IBOutlet weak var blackView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
//        yellowView.frame.origin.y += 20
//        yellowView.bounds.origin.y += 10
        
        print("<frame>")
        print("yellowView.frame -> \(yellowView.frame)")
        print("blackView.frame -> \(blackView.frame)")
        print("<bounds>")
        print("yellowView.bounds -> \(yellowView.bounds)")
        print("blackView.bounds -> \(blackView.bounds)")
    }
}
