//
//  ImageListViewModel.swift
//  Mindvalley Test
//
//  Created by Venugopalan, Vimal on 11/28/18.
//  Copyright © 2018 Venugopalan, Vimal. All rights reserved.
//

import UIKit
import CellAnimator

class ImageListViewModel: NSObject {
    var data:[ImageDataModel] = []
    var delegate: DataSourceStatusUpdater?
    
    func fetchDataFromAPI(){
        delegate?.startLoaderAnimation()
        CacheAPI.getImagesDetails(completion: {[unowned self](imageDataArray, error) in
            self.delegate?.stopLoaderAnimation()
            if error == nil{
                self.data += imageDataArray
                self.delegate?.reloadTableView()
            }
            else if error != nil {
                print(error as Any)
            }
        })
    }
}

extension ImageListViewModel:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: kImageCellReuseIdentifier, for: indexPath) as! ImageTableViewCell
        cell.tag = indexPath.row
        let imageData = self.data[indexPath.row]
        cell.setCellData(data: imageData, forIndex: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = self.data.count - 1
        if indexPath.row == lastElement {
            // handle your logic here to get more items, add it to dataSource and reload tableview
        }
    }
    
}
