//
//  HalfModalViewController.swift
//  Animations
//
//  Created by 山本ののか on 2020/12/14.
//

import UIKit

final class HalfModalViewController: UIViewController {

    @IBOutlet private weak var slideViewYConstraint: NSLayoutConstraint!
    @IBOutlet private weak var modalViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var slideView: UIView! {
        didSet {
            let gestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(tapSlideView))
            slideView.addGestureRecognizer(gestureRecognizer)
        }
    }
    @IBOutlet private weak var modalView: UIView!

    private var isExtended: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaultPosition()
    }

    func showModal(isAnimated: Bool = true) {
        // slideViewを中央に設定
        slideViewYConstraint.constant = 0
        if isAnimated {
            UIView.animate(withDuration: 0.2) {
                self.view.layoutIfNeeded()
            }
        } else {
            view.layoutIfNeeded()
        }
    }

    @IBAction func changeHeight(_ sender: Any) {
        isExtended.toggle()
        if isExtended {
            modalViewHeightConstraint.constant = 300
            UIView.animate(withDuration: 0.2) {
              self.view.layoutIfNeeded()
            }
        } else {
            modalViewHeightConstraint.constant = self.view.frame.height * 0.5
            UIView.animate(withDuration: 0.2) {
              self.view.layoutIfNeeded()
            }
        }
    }
}

private extension HalfModalViewController {
    func setDefaultPosition() {
        // 制約のconstantをデフォルトにする
        slideViewYConstraint.constant = view.frame.height / 2
        modalViewHeightConstraint.constant = 300
        modalView.layer.cornerRadius = 10
        view.layoutIfNeeded()
    }

    @objc func tapSlideView() {
        dismissModal(isAnimated: true)
    }

    func dismissModal(isAnimated: Bool = true) {
        // constantをviewの高さ分にして画面外に移動させる
        slideViewYConstraint.constant = self.view.frame.height / 2

        if isAnimated {
            UIView.animate(withDuration: 0.2, animations: {
                self.view.layoutIfNeeded()
            }) { _ in
                // アニメーションが終了したらVC自体をdismiss
                self.performSegue(withIdentifier: "dismiss", sender: nil)
            }
        } else {
            //アニメーションなしでVC自体をdismiss
            performSegue(withIdentifier: "dismiss", sender: nil)
        }
    }
}



// BaseVCを半透明にして、その上に透明のslideViewを置く
// slideViewの上にmodalViewを置き、slideViewのyConstraintのconstantを変更する事によって、画面外に移動させる
// slideViewと同階層にBottomSafeAreaView(SafeAreaと同じ高さ)を置き、modalViewの中にもBottomSafeAreaInSlideViewを同じ高さで置く事で
// modalViewの中にも仮想のSafeArea(BottomSafeAreaInSlideView)ができる
// modalView上のボタンをSafeArea・BottomSafeAreaView基準で位置を設定すると、yConstraintを変更してdisimissした際に
// bottomが決まらず、ボタンが画面上に残ってしまうので、BottomSafeAreaInSlideView基準でボタンを配置する必要がある
