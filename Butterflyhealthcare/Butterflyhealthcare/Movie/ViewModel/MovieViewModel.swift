//
//  MovieViewModel.swift
//  Butterflyhealthcare
//
//  Created by Gerald George on 31/12/2023.
//

import Foundation

class MovieViewModel: NSObject {
    
    
    struct MovieViewModelStruct{
        var MovieList : Observable<[MovieResultViewModelStruct]> = Observable([])
        var SearchMovieList : Observable<[MovieResultViewModelStruct]> = Observable([])

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
}
