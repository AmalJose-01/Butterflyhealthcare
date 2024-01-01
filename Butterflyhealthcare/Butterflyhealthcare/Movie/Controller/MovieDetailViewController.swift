//
//  MovieDetailViewController.swift
//  Butterflyhealthcare
//
//  Created by Gerald George on 1/1/2024.
//

import Foundation
import UIKit


class MovieDetailViewController: UIViewController {
//    private var viewModelClass = MovieViewModel()
//    private var Obj_MovieViewModel = MovieViewModel.MovieViewModelStruct()
    var CurrentMFAobject : MovieViewModel.MovieResultViewModelStruct?

    @IBOutlet weak var tbl_MovieList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Movie Detail"
        self.registerCells()
    }
    
    func registerCells(){
        self.tbl_MovieList.register(cellType: MovieDetailBanner.self)
        self.tbl_MovieList.register(cellType: MoviedetailOverviewCell.self)

    }
  
}


// MARK: TABLEVIEW DELEGATES STARTS
extension MovieDetailViewController:UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        if ( section == 0) {
            return 30
        }else if (section == 2 ) {
            return 40
        }else{
            return 10;
        }
    }
    
    func tableView(_ tableView: UITableView,cellForRowAt indexPath: IndexPath)-> UITableViewCell {
        if (indexPath.row == 0)
        {
            let customCell: MovieDetailBanner = tableView.dequeueReusableCell(for: indexPath)
            customCell.selectionStyle = UITableViewCell.SelectionStyle.none
            customCell.accessoryType = UITableViewCell.AccessoryType.none
            //          customCell.delegate=self
            
            customCell.configure(with: CurrentMFAobject, indexpath: indexPath as NSIndexPath, isfirstObject: true, isLastObject: true)
            
            return customCell
        }else{
            let customCell: MoviedetailOverviewCell = tableView.dequeueReusableCell(for: indexPath)
            customCell.selectionStyle = UITableViewCell.SelectionStyle.none
            customCell.accessoryType = UITableViewCell.AccessoryType.none
//            customCell.delegate=self
            customCell.configure(with: CurrentMFAobject, indexpath: indexPath as NSIndexPath, isfirstObject: true, isLastObject: true)

            return customCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
  


