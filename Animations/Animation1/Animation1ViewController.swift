//
//  ViewController.swift
//  Animations
//
//  Created by 山本ののか on 2020/12/13.
//

import UIKit

final class Animation1ViewController: UIViewController {

    @IBOutlet private weak var animationView1: UIView! {
        didSet {
            let gestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(tapAnimationView1))
            animationView1.addGestureRecognizer(gestureRecognizer)
        }
    }

    private var isRotated: Bool = false
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

    @IBOutlet private weak var redDismissingConst: NSLayoutConstraint!
    // 左端に合わせる
    @IBOutlet private weak var redShowingConst: NSLayoutConstraint!

    @IBOutlet private weak var yellowDismissingConst: NSLayoutConstraint!
    // 中央に合わせる
    @IBOutlet private weak var yellowShowingConst: NSLayoutConstraint!

    @IBOutlet private weak var blueDismissingConst: NSLayoutConstraint!
    // 右端に合わせる
    @IBOutlet private weak var blueShowingConst: NSLayoutConstraint!

    @objc func tapAnimationView1() {
        UIView.animate(withDuration: 0.1, animations: {
            // 小さくする
            self.animationView1.transform = CGAffineTransform.init(scaleX: 0.9, y: 0.9)
        }) { _ in
            UIView.animate(withDuration: 0.1, animations: {
                // 大きくする
                self.animationView1.transform = CGAffineTransform.init(scaleX: 1.1, y: 1.1)
            }) { _ in
                UIView.animate(withDuration: 0.1, animations: {
                    // 元に戻す
                    self.animationView1.transform = .identity
                })
            }
        }
    }

    @objc func tapAnimationView2() {
        // 1周させる
        let angle = isRotated ? 0.0 : CGFloat(180 / 180 * Double.pi)
        isRotated.toggle()
        UIView.animate(withDuration: 0.3, animations: {
            self.animationView2.transform = CGAffineTransform.init(rotationAngle: angle)
        })
    }

    @objc func tapAnimationView3() {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            // y軸方向に50移動させる
            self.animationView3.transform = CGAffineTransform.init(translationX: 0, y: 50)
        }) { _ in
            UIView.animate(withDuration: 0.3, animations: {
                // 元に戻す
                self.animationView3.transform = .identity
            })
        }
    }

    @objc func tapAnimationView4() {
        isShowed.toggle()
        if isShowed {
            //制約を切り替える
            // 制約falseを先に設定しないと制約エラーが起きる
            redDismissingConst.isActive = false
            redShowingConst.isActive = true
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded()
            }) { _ in
                self.yellowDismissingConst.isActive = false
                self.yellowShowingConst.isActive = true
                UIView.animate(withDuration: 0.5, delay: 0.1, animations: {
                    self.view.layoutIfNeeded()
                }) { _ in
                    self.blueDismissingConst.isActive = false
                    self.blueShowingConst.isActive = true
                    UIView.animate(withDuration: 0.5, delay: 0.2, animations: {
                        self.view.layoutIfNeeded()
                    })
                }
            }
        } else {
            //制約を切り替える
            redShowingConst.isActive = false
            redDismissingConst.isActive = true

            yellowShowingConst.isActive = false
            yellowDismissingConst.isActive = true

            blueShowingConst.isActive = false
            blueDismissingConst.isActive = true

            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
}



// 制約の切り替えは不可が大きい
// Animation2VCで行っているconstantの変更の方が不可が小さいが、固定値を設定する必要がある
