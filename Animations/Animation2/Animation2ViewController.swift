//
//  Animation2ViewController.swift
//  Animations
//
//  Created by 山本ののか on 2020/12/14.
//

import UIKit

final class Animation2ViewController: UIViewController {

    @IBOutlet private weak var animationView1: UIView! {
        didSet {
            let gestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(tapAnimationView1))
            animationView1.addGestureRecognizer(gestureRecognizer)
        }
    }

    @IBOutlet private weak var animationView2: UIView! {
        didSet {
            let gestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(tapAnimationView2))
            animationView2.addGestureRecognizer(gestureRecognizer)
        }
    }

    @IBOutlet private weak var animationView3: UIView! {
        didSet {
            let gestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(tapAnimationView3))
            animationView3.addGestureRecognizer(gestureRecognizer)
        }
    }

    private var isShowed: Bool = false
    @IBOutlet private weak var animationView4: UIView! {
        didSet {
            let gestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(tapAnimationView4))
            animationView4.addGestureRecognizer(gestureRecognizer)
        }
    }

    // 左端に合わせる
    @IBOutlet private weak var redShowingConst: NSLayoutConstraint!
    // 中央に合わせる
    @IBOutlet private weak var yellowShowingConst: NSLayoutConstraint!
    // 右端に合わせる
    @IBOutlet private weak var blueShowingConst: NSLayoutConstraint!
    @IBOutlet private weak var blueView: UIView!

    @objc func tapAnimationView1() {
        UIView.animate(withDuration: 1.0, animations: {
            // 背景色を変更
            self.animationView1.backgroundColor = .systemBlue
        }) { _ in
            UIView.animate(withDuration: 1.0, animations: {
                // 元に戻す
                self.animationView1.backgroundColor = .systemRed
            })
        }
    }

    @objc func tapAnimationView2() {
        UIView.animate(withDuration: 1.0, animations: {
            // 角を丸くする
            self.animationView2.layer.cornerRadius = self.animationView2.frame.height / 2
        }) { _ in
            UIView.animate(withDuration: 1.0, animations: {
                // 元に戻す
                self.animationView2.layer.cornerRadius = 0
            })
        }
    }

    @objc func tapAnimationView3() {
        UIView.animate(withDuration: 1.0, animations: {
            // alphaを変更
            self.animationView3.alpha = 0
        }) { _ in
            UIView.animate(withDuration: 1.0, animations: {
                // 元に戻す
                self.animationView3.alpha = 1
            })
        }
    }

    @objc func tapAnimationView4() {
        isShowed.toggle()
        if isShowed {
            //制約のconstantを変更
            redShowingConst.constant = 0
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded()
            }) { _ in
                self.yellowShowingConst.constant = 0
                UIView.animate(withDuration: 0.5, delay: 0.1, animations: {
                    self.view.layoutIfNeeded()
                }) { _ in
                    self.blueShowingConst.constant = 0
                    UIView.animate(withDuration: 0.5, delay: 0.2, animations: {
                        self.view.layoutIfNeeded()
                    })
                }
            }
        } else {
            //制約のconstantを変更
            redShowingConst.constant = view.frame.width - 30
            yellowShowingConst.constant = (view.frame.width - blueView.frame.width) / 2 + blueView.frame.width - 30
            blueShowingConst.constant = -(blueView.frame.width - 30)

            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
}
