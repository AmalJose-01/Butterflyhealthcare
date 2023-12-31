//
//  ViewController.swift
//  Butterflyhealthcare
//
//  Created by Gerald George on 29/12/2023.
//

import UIKit
import SVProgressHUD

class ViewController: UIViewController {
    private var viewModelClass = MovieViewModel()
    private var MFAviewModel = MovieViewModel.MovieViewModelStruct()

    @IBOutlet weak var tbl_MovieList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.getMovieList()
        self.registerCells()
    }
    
    func registerCells(){
        self.tbl_MovieList.register(cellType: MovieListCell.self)
       
        
    }

    
func getMovieList(){
  //let inputData = Data()
    SVProgressHUD.show()
    DispatchQueue.global(qos: .default).async {
        // time-consuming task
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
    }

  
//  self.isFetchCompletedOnce = false
  self.viewModelClass.getMovieList() { result, outputData in
//      self.isFetchCompletedOnce = true
      DispatchQueue.main.async {
          guard let data = outputData else {
              DispatchQueue.main.async {
                  SVProgressHUD.dismiss()
              }
              return
          }
          DispatchQueue.main.async {
              SVProgressHUD.dismiss()
          }
          self.setRefrentialDataViewModel(outputData: data)
      }
  }
}
    
     func setRefrentialDataViewModel(outputData:Data){
        
        do {
            let MovieResponse = try JSONDecoder().decode(MovieModel.MovieResponse.self, from: outputData)
            
            
//            self.MFAviewModel.MovieList.value = MovieResponse.results?.compactMap({
//                MovieViewModel.MovieResultViewModelStruct(adult: $0.adult ?? true, backdropPath: $0.backdropPath ?? "", genreids: $0.genreids , id: $0.id ?? 0, originalLanguage: $0.originalLanguage , originalTitle: $0.originalTitle ?? "", overview: $0.overview ?? "", popularity: $0.popularity ?? 0, posterPath: $0.posterPath ?? "",releaseDate: $0.releaseDate ?? "" , title: $0.title ?? "", video: $0.video ?? true, voteAverage: $0.voteAverage ?? 0, voteCount: $0.voteCount ?? 0)
//            })
            
                
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
            }
        } catch {
              print("Error print \(error.localizedDescription)")
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
            }
              return
         }
    }

}

//
//// MARK: TABLEVIEW DELEGATES STARTS
//extension ViewController:UITableViewDataSource,UITableViewDelegate{
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1;
//    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1;
//    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return CGFloat.leastNonzeroMagnitude
//    }
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
//        if ( section == 0) {
//            return 30
//        }else if (section == 2 ) {
//            return 40
//        }else{
//            return 10;
//        }
//    }
//    
//    func tableView(_ tableView: UITableView,cellForRowAt indexPath: IndexPath)-> UITableViewCell {
//        if (indexPath.section == 0) // Profile Header
//        {
//            let customCell: MovieListCell = tableView.dequeueReusableCell(for: indexPath)
//            customCell.selectionStyle = UITableViewCell.SelectionStyle.none
//            customCell.accessoryType = UITableViewCell.AccessoryType.none
//            //          customCell.delegate=self
//            return customCell
//        }else{
//            let customCell: MovieListCell = tableView.dequeueReusableCell(for: indexPath)
////            customCell.configure(with: "START", indexpath: indexPath as NSIndexPath , keyboardType: .default, fromClass: "", isViewMode: 0)
//            customCell.selectionStyle = UITableViewCell.SelectionStyle.none
//            customCell.accessoryType = UITableViewCell.AccessoryType.none
////            customCell.delegate=self
//            return customCell
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//        
//    }
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    }
//}
