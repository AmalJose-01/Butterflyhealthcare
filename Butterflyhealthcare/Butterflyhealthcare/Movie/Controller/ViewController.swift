//
//  ViewController.swift
//  Butterflyhealthcare
//
//  Created by Gerald George on 29/12/2023.
//

import UIKit
import SVProgressHUD
import CoreData

class ViewController: UIViewController, NSFetchedResultsControllerDelegate {
    @IBOutlet weak var searchBarHeightConstraint: NSLayoutConstraint!
    private var viewModelClass = MovieViewModel()
    private var Obj_MovieViewModel = MovieViewModel.MovieViewModelStruct()
    var isSearch = false
    var isOfflineMode = false
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>?

    @IBOutlet weak var searchBar: UISearchBar!
    
    var isDataLoading:Bool=false
    var activityIndicator=UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate //Singlton instance
       var context:NSManagedObjectContext!
    
    var pageNo:Int=1
    var limit:Int=20
    var offset:Int=0
    var connectionCount:Int=0
    
    @IBOutlet weak var tbl_MovieList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Movie"
        
        
        let utilReach = UtilReach()
        if (utilReach.connectionStatus()) {
             isOfflineMode = false
            searchBarHeightConstraint.constant = 58
            searchBar.isHidden = false
            self.getMovieList()
        }else{
             isOfflineMode = true
            searchBarHeightConstraint.constant = 0
            searchBar.isHidden = true
            context = appDelegate.persistentContainer.viewContext
            fetchedResultsController = NSFetchedResultsController(fetchRequest: viewModelClass.allEmployeesFetchRequest(), managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
                fetchedResultsController?.delegate = self
            do {
                try fetchedResultsController?.performFetch()
            } catch {
//                print("Storing data Failed")
            }
        }
        
       
        self.registerCells()
    }
    
    func registerCells(){
        self.tbl_MovieList.register(cellType: MovieListCell.self)
        
        
    }
    
    func getMovieList(){
        //let inputData = Data()
        SVProgressHUD.show(withStatus: "Loding Movie....")
        
        self.viewModelClass.getMovieList() { result, outputData in
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
                self.setMovieListDataViewModel(outputData: data)
            }
        }
    }
    
    func setMovieListDataViewModel(outputData:Data){
        
        do {
            let MovieResponse = try JSONDecoder().decode(MovieModel.MovieResponse.self, from: outputData)
            
            
            self.Obj_MovieViewModel.MovieList.value = MovieResponse.results?.compactMap({
                MovieViewModel.MovieResultViewModelStruct(adult: $0.adult ?? true, backdropPath: $0.backdropPath ?? "", genreids: $0.genreids , id: $0.id ?? 0, originalLanguage: $0.originalLanguage , originalTitle: $0.originalTitle ?? "", overview: $0.overview ?? "", popularity: $0.popularity ?? 0, posterPath: $0.posterPath ?? "",releaseDate: $0.releaseDate ?? "" , title: $0.title ?? "", video: $0.video ?? true, voteAverage: $0.voteAverage ?? 0, voteCount: $0.voteCount ?? 0)
            })
            
            self.viewModelClass.OfflineSave_AfterOnlineSave(inputArray: MovieResponse.results)
            
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
    
    
    
    
    
    func fetchData()
        {
            print("Fetching Data..")
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
            request.returnsObjectsAsFaults = false
            do {
                let result = try context.fetch(request)
//                fetchedResultsController  = result
            } catch {
                print("Fetching data Failed")
            }
        }
    
    
    
    
    
}


// MARK: TABLEVIEW DELEGATES STARTS
extension ViewController:UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (isOfflineMode){
            return fetchedResultsController?.sections?[section].numberOfObjects ?? 0
        }else{
            if(isSearch){
                return  self.Obj_MovieViewModel.SerMovieList.value?.count ?? 0 ;
            }else{
                return  self.Obj_MovieViewModel.MovieList.value?.count ?? 0 ;
            }
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
            if (isOfflineMode){
                let customCell: MovieListCell = tableView.dequeueReusableCell(for: indexPath)
                customCell.selectionStyle = UITableViewCell.SelectionStyle.none
                customCell.accessoryType = UITableViewCell.AccessoryType.none
                //          customCell.delegate=self
                
                if let cellContact = fetchedResultsController?.object(at: indexPath) as? Movie {
                    customCell.configureForOffline(with: cellContact, indexpath: indexPath as NSIndexPath, isfirstObject: true, isLastObject: true)
                }
                return customCell
            }else{
                
                
                let customCell: MovieListCell = tableView.dequeueReusableCell(for: indexPath)
                customCell.selectionStyle = UITableViewCell.SelectionStyle.none
                customCell.accessoryType = UITableViewCell.AccessoryType.none
                //          customCell.delegate=self
                var CurrentMFAobject : MovieViewModel.MovieResultViewModelStruct?
                if(isSearch){
                    CurrentMFAobject = self.Obj_MovieViewModel.SerMovieList.value?[indexPath.row]
                }else{
                    CurrentMFAobject = self.Obj_MovieViewModel.MovieList.value?[indexPath.row]
                }
                customCell.configure(with: CurrentMFAobject, indexpath: indexPath as NSIndexPath, isfirstObject: true, isLastObject: true)
                
                return customCell
            }
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
       
        

        if (isOfflineMode){
            
            if let cellContact = fetchedResultsController?.object(at: indexPath) as? Movie {
                self.clickRedirectActionOffline(MovieResult: cellContact)

            }
            
        }else{
            var CurrentMFAobject : MovieViewModel.MovieResultViewModelStruct?
            if(isSearch){
                CurrentMFAobject = self.Obj_MovieViewModel.SerMovieList.value?[indexPath.row]
            }else{
                CurrentMFAobject = self.Obj_MovieViewModel.MovieList.value?[indexPath.row]
            }
            self.clickRedirectAction(MovieResult: CurrentMFAobject)
        }


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
        manageSubscriptionViewController.fromClass = NSStringFromClass(type(of: self))
        manageSubscriptionViewController.isOfflineMode = false
        self.navigationController?.view.layer.add(transition, forKey: kCATransition)
        self.navigationController?.pushViewController(manageSubscriptionViewController, animated: false)
    }
    
    
    func clickRedirectActionOffline(MovieResult: Movie) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let manageSubscriptionViewController = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewControllerID")
        as! MovieDetailViewController
        manageSubscriptionViewController.isOfflineMode = true

        manageSubscriptionViewController.MovieResult = MovieResult
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = .fade
        manageSubscriptionViewController.fromClass = NSStringFromClass(type(of: self))

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
            
            self.Obj_MovieViewModel.SerMovieList.value = self.Obj_MovieViewModel.MovieList.value!.filter{ ($0.originalTitle!.localizedCaseInsensitiveContains(searchText)) }
            
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

