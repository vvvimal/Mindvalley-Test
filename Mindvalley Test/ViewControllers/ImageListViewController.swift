//
//  ImageListViewController.swift
//  Mindvalley Test
//
//  Created by Venugopalan, Vimal on 12/2/18.
//  Copyright © 2018 Venugopalan, Vimal. All rights reserved.
//

import UIKit
import Toast_Swift

protocol DataSourceStatusUpdater {
    func reloadTableView()
    func startLoaderAnimation()
    func stopLoaderAnimation()
}

let kImageCellReuseIdentifier = "ImageCellIdentifier"


class ImageListViewController: UIViewController, UITableViewDelegate {
    
    let viewModel = ImageListViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        viewModel.delegate = self
        setupTableView()
        viewModel.fetchDataFromAPI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func setupTableView() {
        tableView.dataSource = viewModel
        tableView.delegate = self
        tableView.accessibilityLabel = "imageListTableView"
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    
}

extension ImageListViewController: DataSourceStatusUpdater {
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    func startLoaderAnimation(){
        DispatchQueue.main.async {
            self.view.makeToastActivity(.center)
        }
    }
    func stopLoaderAnimation(){
        DispatchQueue.main.async {
            self.view.hideToastActivity()
        }
    }
    
}
