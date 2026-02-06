//
//  SideMenuViewController.swift
//  Drawer
//
//  Created by Yashraj on 06/02/26.
//

import UIKit

//MARK: To detect which cell was tapped
protocol SideMenuViewControllerDelegate {
    func selectedCell(_ row: Int)
}

class SideMenuViewController: UIViewController {

    @IBOutlet weak var imgHeader: UIImageView!
    @IBOutlet weak var lblFooter: UILabel!
    @IBOutlet weak var tblCategories: UITableView!

    var defaultHighlightedCell: Int = 0
    var delegate: SideMenuViewControllerDelegate?

    var categories: [SideMenuModel] = [
        SideMenuModel(icon: UIImage(named: "imgAction")!,title: "Action"),
        SideMenuModel(icon: UIImage(named: "imgRPG")!,title: "RPG"),
        SideMenuModel(icon: UIImage(named: "imgRacing")!,title: "Racing"),
        SideMenuModel(icon: UIImage(named: "imgShooting")!,title: "Shooting"),
        SideMenuModel(icon: UIImage(named: "img3d")!,title: "3D gaming"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        //Table delegates
        self.tblCategories.delegate = self
        self.tblCategories.dataSource = self

        //Register our cell to table
        self.tblCategories.register(
            SideMenuTableCell.nib,
            forCellReuseIdentifier: SideMenuTableCell.identifier
        )

        //Update tableview with data
        self.tblCategories.reloadData()
    }
}
extension SideMenuViewController: UITableViewDelegate, UITableViewDataSource {
    //Table height
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return 44
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return self.categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        let cell: SideMenuTableCell =
            tableView.dequeueReusableCell(
                withIdentifier: SideMenuTableCell.identifier,
                for: indexPath
            ) as! SideMenuTableCell
        cell.imgIcon.image = self.categories[indexPath.row].icon
        cell.lblTitle.text = self.categories[indexPath.row].title
        return cell
    }
    
    //Delegate to detect selcted item 
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        self.delegate?.selectedCell(indexPath.row)
    }
}
