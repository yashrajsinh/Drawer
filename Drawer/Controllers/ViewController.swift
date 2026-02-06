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

    //To dim the view
    private var dimmingView: UIView!

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

        // 1️⃣ Add side menu first
        addChild(sideMenuViewController)
        view.addSubview(sideMenuViewController.view)
        sideMenuViewController.didMove(toParent: self)

        sideMenuViewController.view.translatesAutoresizingMaskIntoConstraints =
            false

        sideMenuLeadingConstraint = sideMenuViewController.view.leadingAnchor
            .constraint(
                equalTo: view.leadingAnchor,
                constant: -sideMenuWidth
            )

        NSLayoutConstraint.activate([
            sideMenuLeadingConstraint,
            sideMenuViewController.view.topAnchor.constraint(
                equalTo: view.topAnchor
            ),
            sideMenuViewController.view.bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            ),
            sideMenuViewController.view.widthAnchor.constraint(
                equalToConstant: sideMenuWidth
            ),
        ])

        // Add dimming view ABOVE main view but BELOW menu
        dimmingView = UIView()
        dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        dimmingView.alpha = 0
        dimmingView.translatesAutoresizingMaskIntoConstraints = false

        view.insertSubview(
            dimmingView,
            belowSubview: sideMenuViewController.view
        )

        NSLayoutConstraint.activate([
            dimmingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dimmingView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        // Tap to close menu
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(closeMenu)
        )
        dimmingView.addGestureRecognizer(tapGesture)

    }
    //MARK: Close menu
    @objc func closeMenu() {
        isExpanded = false
        sideMenuLeadingConstraint.constant = -sideMenuWidth

        UIView.animate(
            withDuration: 0.25,
            delay: 0,
            options: .curveEaseIn
        ) {
            self.dimmingView.alpha = 0
            self.view.layoutIfNeeded()
        }
    }

    //MARK: To open menu with animations
    @objc func openMenu() {
        isExpanded = true
        sideMenuLeadingConstraint.constant = 0

        UIView.animate(
            withDuration: 0.35,
            delay: 0,
            usingSpringWithDamping: 0.85,
            initialSpringVelocity: 0.5,
            options: .curveEaseOut
        ) {
            self.dimmingView.alpha = 1
            self.view.layoutIfNeeded()
        }
    }

    @IBAction func btnShow(_ sender: UIButton) {
        isExpanded ? closeMenu() : openMenu()
    }
    
    //MARK: Update button state

    //MARK: open different screen
    func openScreen(id: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let newVC = storyboard.instantiateViewController(withIdentifier: id)

        addChild(newVC)
        newVC.view.frame = view.bounds
        view.insertSubview(
            newVC.view,
            belowSubview: dimmingView
        )
        newVC.didMove(toParent: self)
    }
}
extension ViewController: SideMenuViewControllerDelegate {
    func selectedCell(_ row: Int) {
        closeMenu()
        // close menu after selection
        switch row {
        case 0:
            openScreen(id: "HomeController")
        case 1:
            openScreen(id: "RPGController")
        case 2:
            openScreen(id: "RaceController")
        case 3:
            openScreen(id: "GunController")
        case 4:
            openScreen(id: "3DController")
        default:
            break
        }
    }

}
