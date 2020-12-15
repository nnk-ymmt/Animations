//
//  BaseViewController.swift
//  Animations
//
//  Created by 山本ののか on 2020/12/14.
//

import UIKit

final class BaseViewController: UIViewController {

    @IBAction private func showHalfModal(_ sender: Any) {
        guard let halfModalVC = UIStoryboard(name: "HalfModal", bundle: nil).instantiateInitialViewController() as? HalfModalViewController else {
            return
        }
        halfModalVC.modalPresentationStyle = .overCurrentContext
        halfModalVC.modalTransitionStyle = .crossDissolve
        present(halfModalVC, animated: false) {
            halfModalVC.showModal(isAnimated: true)
        }
    }

    @IBAction func dismiss(segue: UIStoryboardSegue) {
        
    }
}
