//
//  ViewController.swift
//  Drawer
//
//  Created by Yashraj on 06/02/26.
//

import UIKit

class ViewController: UIViewController {

    private var sideMenuViewController: SideMenuViewController!
    private var sideMenuLeadingConstraint: NSLayoutConstraint!

    private let sideMenuWidth: CGFloat = 260
    private var isExpanded = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSideView()
    }
    func setUpSideView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        sideMenuViewController =
            storyboard.instantiateViewController(
                withIdentifier: "SideMenuView"
            ) as? SideMenuViewController

        sideMenuViewController.delegate = self

        addChild(sideMenuViewController)
        view.addSubview(sideMenuViewController.view)
        sideMenuViewController.didMove(toParent: self)

        sideMenuViewController.view.translatesAutoresizingMaskIntoConstraints =
            false

        //constraint we animate
        sideMenuLeadingConstraint = sideMenuViewController.view.leadingAnchor
            .constraint(
                equalTo: view.leadingAnchor,
                constant: -sideMenuWidth  // hidden initially
            )

        NSLayoutConstraint.activate([
            sideMenuLeadingConstraint,
            sideMenuViewController.view.topAnchor.constraint(
                equalTo: view.topAnchor
            ),
            sideMenuViewController.view.bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            ),
            // width already comes from storyboard (260)
        ])

    }

    @IBAction func btnAnimate(_ sender: UIButton) {
        isExpanded.toggle()
        sideMenuLeadingConstraint.constant = isExpanded ? 0 : -self.sideMenuWidth
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        
    }
}
extension ViewController: SideMenuViewControllerDelegate {
    func selectedCell(_ row: Int) {
        // close menu after selection
        switch row {
        case 0:
            print("Home")
        default :
            break
        }
    }
    
    
    
}
