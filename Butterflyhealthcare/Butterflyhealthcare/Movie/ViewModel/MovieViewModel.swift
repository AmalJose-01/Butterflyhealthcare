//
//  MovieViewModel.swift
//  Butterflyhealthcare
//
//  Created by Gerald George on 31/12/2023.
//

import Foundation
import CoreData
import UIKit

class MovieViewModel: NSObject {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate //Singlton instance
       var context:NSManagedObjectContext!
    
    struct MovieViewModelStruct{
        var MovieList : Observable<[MovieResultViewModelStruct]> = Observable([])
        var SerMovieList : Observable<[MovieResultViewModelStruct]> = Observable([])

    }
    typealias MovieResultViewModelStruct = MovieModel.Result
    
    
    
    func getMovieList (completion: @escaping ((_ result: [String:AnyObject]? , _ outputData: Data?) ->Void))
    {
       // let urls_BaseUpi : String = eVeroVisitUrls.baseApiUrl.rawValue
        
        let commonUrlsAndConstants = CommonUrlsAndConstants()
        let urls_BaseUpi : String = commonUrlsAndConstants.getBaseUrl()
        
        let urls_endPoint = "/discover/movie"
        let urlFull = urls_BaseUpi + urls_endPoint
        let httpMethod = "GET"
        let inputData = Data()
        let networkObject = CommonNetworkSwiftClass()
        networkObject.callGetOrPostWebServiceHavingUnknownReturnTypeWithoutXAgency_AutoRefresh(urlString: urlFull, httpMethod: httpMethod, inputdata: inputData) { resultValue, outputDataValue in
            //return
            return completion(resultValue,outputDataValue)
        }
    }
    
    
    func OfflineSave_AfterOnlineSave(inputArray:[MovieModel.Result]?){
        self.deleteAllEntities()
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

           do {
               try context.save()
           } catch {
//               print("Storing data Failed")
           }
           
//           self.fetchData()
       }
    
    
    func deleteAllEntities() {
        let entities = appDelegate.persistentContainer.managedObjectModel.entities
        for entity in entities {
            delete(entityName: entity.name!)
        }
    }

    func delete(entityName: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try appDelegate.persistentContainer.viewContext.execute(deleteRequest)
        } catch let error as NSError {
            debugPrint(error)
        }
    }
    
    
    
    func deleteAllData(_ entity:String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        fetchRequest.returnsObjectsAsFaults = false

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
    
    func allEmployeesFetchRequest() -> NSFetchRequest<NSFetchRequestResult> {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        fetchRequest.predicate = nil
        
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)

                fetchRequest.predicate = nil
                fetchRequest.sortDescriptors = [sortDescriptor]
//                fetchRequest.fetchBatchSize = 20
        return fetchRequest
    }
    
    
}
