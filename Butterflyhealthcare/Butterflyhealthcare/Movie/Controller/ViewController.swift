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
    private var Obj_MovieViewModel = MovieViewModel.MovieViewModelStruct()
    var isSearch = false
    @IBOutlet weak var searchBar: UISearchBar!

    var isDataLoading:Bool=false
    var activityIndicator=UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)

    
    var pageNo:Int=1
    var limit:Int=20
    var offset:Int=0
    var connectionCount:Int=0
    
    @IBOutlet weak var tbl_MovieList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Movie"
        self.getMovieList()
        self.registerCells()
    }
    
    func registerCells(){
        self.tbl_MovieList.register(cellType: MovieListCell.self)
       
        
    }
        
func getMovieList(){
  //let inputData = Data()
    SVProgressHUD.show(withStatus: "Loding Movie....")
    

//    DispatchQueue.global(qos: .default).async {
//        // time-consuming task
//        DispatchQueue.main.async {
//            SVProgressHUD.dismiss()
//        }
//    }

  
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
            
            
            self.Obj_MovieViewModel.MovieList.value = MovieResponse.results?.compactMap({
                MovieViewModel.MovieResultViewModelStruct(adult: $0.adult ?? true, backdropPath: $0.backdropPath ?? "", genreids: $0.genreids , id: $0.id ?? 0, originalLanguage: $0.originalLanguage , originalTitle: $0.originalTitle ?? "", overview: $0.overview ?? "", popularity: $0.popularity ?? 0, posterPath: $0.posterPath ?? "",releaseDate: $0.releaseDate ?? "" , title: $0.title ?? "", video: $0.video ?? true, voteAverage: $0.voteAverage ?? 0, voteCount: $0.voteCount ?? 0)
            })
            
                
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
                self.tbl_MovieList.reloadData()
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


// MARK: TABLEVIEW DELEGATES STARTS
extension ViewController:UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(isSearch){
            return  self.Obj_MovieViewModel.SearchMovieList.value?.count ?? 0 ;
        }else{
            return  self.Obj_MovieViewModel.MovieList.value?.count ?? 0 ;
        }
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
        if (indexPath.section == 0)
        {
            let customCell: MovieListCell = tableView.dequeueReusableCell(for: indexPath)
            customCell.selectionStyle = UITableViewCell.SelectionStyle.none
            customCell.accessoryType = UITableViewCell.AccessoryType.none
            //          customCell.delegate=self
            var CurrentMFAobject : MovieViewModel.MovieResultViewModelStruct?
            if(isSearch){
                CurrentMFAobject = self.Obj_MovieViewModel.SearchMovieList.value?[indexPath.row]
            }else{
                CurrentMFAobject = self.Obj_MovieViewModel.MovieList.value?[indexPath.row]
            }
            customCell.configure(with: CurrentMFAobject, indexpath: indexPath as NSIndexPath, isfirstObject: true, isLastObject: true)
            
            return customCell
        }else{
            let customCell: MovieListCell = tableView.dequeueReusableCell(for: indexPath)
            customCell.selectionStyle = UITableViewCell.SelectionStyle.none
            customCell.accessoryType = UITableViewCell.AccessoryType.none
//            customCell.delegate=self
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
        var CurrentMFAobject : MovieViewModel.MovieResultViewModelStruct?
        if(isSearch){
            CurrentMFAobject = self.Obj_MovieViewModel.SearchMovieList.value?[indexPath.row]
        }else{
            CurrentMFAobject = self.Obj_MovieViewModel.MovieList.value?[indexPath.row]
        }

        self.clickRedirectAction(MovieResult: CurrentMFAobject)
    }
}


extension ViewController{
  func clickRedirectAction(MovieResult:MovieViewModel.MovieResultViewModelStruct?) {
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      let manageSubscriptionViewController = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewControllerID")
      as! MovieDetailViewController
      manageSubscriptionViewController.CurrentMFAobject = MovieResult
      let transition = CATransition()
      transition.duration = 0.3
      transition.type = .fade
      self.navigationController?.view.layer.add(transition, forKey: kCATransition)
      self.navigationController?.pushViewController(manageSubscriptionViewController, animated: false)
  }
}

extension ViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText.isEmpty){
            isSearch = false
        }else{
            isSearch = true
            
            self.Obj_MovieViewModel.SearchMovieList.value = self.Obj_MovieViewModel.MovieList.value!.filter{ ($0.originalTitle!.localizedCaseInsensitiveContains(searchText)) }
        
        }
        DispatchQueue.main.async {
            self.tbl_MovieList.reloadData()
        }
        
   }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
        //isSearch = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
       isSearch = false
       searchBar.showsCancelButton = false
       searchBar.text = ""
       searchBar.resignFirstResponder()
       DispatchQueue.main.async {
            self.tbl_MovieList.reloadData()
       }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}


extension ViewController:UIScrollViewDelegate{
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        print("scrollViewWillBeginDragging")
        //  isDataLoading = false
    }
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        print("scrollViewWillBeginDecelerating")
    }
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        print("scrollViewDidEndScrollingAnimation")
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("scrollViewDidEndDecelerating")
    }
    //Pagination
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        print("scrollViewDidEndDragging")
        if ((tbl_MovieList.contentOffset.y + tbl_MovieList.frame.size.height) >= tbl_MovieList.contentSize.height)
        {
            if !isDataLoading{
                DispatchQueue.main.async {
                    self.activityIndicator.startAnimating()
                }
                //isDataLoading = true
                var dataCount : Int
                if(isSearch){
                    dataCount =  self.Obj_MovieViewModel.SearchMovieList.value?.count ?? 0
                }else{
                    dataCount =   self.Obj_MovieViewModel.MovieList.value?.count ?? 0
                }
                
                
                if dataCount > 20 {
                    self.offset=tempArr.count
                    self.limit=self.offset+20
                    
                    
                    addContactsList(offset: self.offset, limit: self.limit)
                    
                }
                
            }
            
            
        }
        
        
    }
    
    func addContactsList(offset:Int,limit:Int){
        if self.results.count > limit{
            
            for i in offset..<limit{
                tempArr.append(results[i])
            }
            self.tableView.reloadData()
        }else{
            for i in offset..<self.results.count{
                tempArr.append(results[i])
            }
            self.tableView.reloadData()
            self.tableView.tableFooterView?.isHidden=true
            self.isDataLoading = true
            
        }
    }
}
