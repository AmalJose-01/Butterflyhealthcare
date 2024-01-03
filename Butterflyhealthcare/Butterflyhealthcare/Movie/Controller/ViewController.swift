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
            self.getMovieList()
        }else{
             isOfflineMode = true
            context = appDelegate.persistentContainer.viewContext
            fetchedResultsController = NSFetchedResultsController(fetchRequest: allEmployeesFetchRequest(), managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
                fetchedResultsController?.delegate = self
            do {
                try fetchedResultsController?.performFetch()
            } catch {
                print("Storing data Failed")
            }
//            self.fetchData()
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
            
            self.OfflineSave_AfterOnlineSave(inputArray: MovieResponse.results)
            
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
    
    
    func OfflineSave_AfterOnlineSave(inputArray:[MovieModel.Result]?){
        self.deleteAllData("Movie")
        guard let valuesArray = inputArray else { return }
        for input in valuesArray {
            
            context = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "Movie", in: context)
            let newUser = NSManagedObject(entity: entity!, insertInto: context)
            saveData(UserDBObj: newUser, CurrentMFAobject: input)
        }
    }
    
    
    func saveData(UserDBObj:NSManagedObject, CurrentMFAobject : MovieViewModel.MovieResultViewModelStruct?)
       {
           UserDBObj.setValue(CurrentMFAobject?.originalTitle, forKey: "originalTitle")
           UserDBObj.setValue(CurrentMFAobject?.overview, forKey: "overview")
           UserDBObj.setValue(CurrentMFAobject?.posterPath, forKey: "posterPath")
           UserDBObj.setValue(CurrentMFAobject?.releaseDate, forKey: "releaseDate")
           UserDBObj.setValue(CurrentMFAobject?.title, forKey: "title")
           UserDBObj.setValue(CurrentMFAobject?.voteAverage, forKey: "voteAverage")
           UserDBObj.setValue(CurrentMFAobject?.voteCount, forKey: "voteCount")

           print("Storing Data..")
           do {
               try context.save()
           } catch {
               print("Storing data Failed")
           }
           
           self.fetchData()
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
    
    func allEmployeesFetchRequest() -> NSFetchRequest<NSFetchRequestResult> {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        fetchRequest.predicate = nil
        
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)

                fetchRequest.predicate = nil
                fetchRequest.sortDescriptors = [sortDescriptor]
                fetchRequest.fetchBatchSize = 20
        return fetchRequest
    }
    
    
    func deleteAllData(_ entity:String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        fetchRequest.returnsObjectsAsFaults = false
//        let managedContext = appDelegate.managedObjectContext

        do {
            
            let results = try context.fetch(fetchRequest)
                   for managedObject in results
                   {
                       let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                       context.delete(managedObjectData)
                   }
            
            
        } catch let error {
            print("Detele all data in \(entity) error :", error)
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
        var CurrentMFAobject : MovieViewModel.MovieResultViewModelStruct?
        if(isSearch){
            CurrentMFAobject = self.Obj_MovieViewModel.SerMovieList.value?[indexPath.row]
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

//
//extension ViewController:UIScrollViewDelegate{
//    
//    
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        
//        print("scrollViewWillBeginDragging")
//        //  isDataLoading = false
//    }
//    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
//        print("scrollViewWillBeginDecelerating")
//    }
//    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
//        print("scrollViewDidEndScrollingAnimation")
//    }
//    
//    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        print("scrollViewDidEndDecelerating")
//    }
//    //Pagination
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        
//        print("scrollViewDidEndDragging")
//        if ((tbl_MovieList.contentOffset.y + tbl_MovieList.frame.size.height) >= tbl_MovieList.contentSize.height)
//        {
//            if !isDataLoading{
//                DispatchQueue.main.async {
//                    self.activityIndicator.startAnimating()
//                }
//                //isDataLoading = true
//                var dataCount : Int
//                if(isSearch){
//                    dataCount =  self.Obj_MovieViewModel.SearchMovieList.value?.count ?? 0
//                }else{
//                    dataCount =   self.Obj_MovieViewModel.MovieList.value?.count ?? 0
//                }
//                
//                
//                if dataCount > 20 {
//                    self.offset=tempArr.count
//                    self.limit=self.offset+20
//                    addContactsList(offset: self.offset, limit: self.limit)
//                    
//                }
//                
//            }
//            
//            
//        }
//        
//        
//    }
//    
//    func addContactsList(offset:Int,limit:Int){
//        
//        var dataCount : Int
//        if(isSearch){
//            dataCount =  self.Obj_MovieViewModel.SearchMovieList.value?.count ?? 0
//        }else{
//            dataCount =   self.Obj_MovieViewModel.MovieList.value?.count ?? 0
//        }
//        
//        
//        if dataCount > limit{
//            
//            for i in offset..<limit{
//                tempArr.append(results[i])
//            }
//            self.tbl_MovieList.reloadData()
//        }else{
//            for i in offset..< dataCount{
//                tempArr.append(results[i])
//            }
//            self.tbl_MovieList.reloadData()
//            self.tbl_MovieList.tableFooterView?.isHidden=true
//            self.isDataLoading = true
//            
//        }
//    }
//}
