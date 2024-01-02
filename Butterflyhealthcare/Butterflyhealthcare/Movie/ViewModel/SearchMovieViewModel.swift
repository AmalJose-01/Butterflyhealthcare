//
//  SearchMovieModel.swift
//  Butterflyhealthcare
//
//  Created by Gerald George on 31/12/2023.
//

import Foundation

class SearchMovieViewModel: NSObject {
    
    
    struct SearchMovieViewModelStruct{
        var TempMovieList : Observable<[SearchMovieResultViewModelStruct]> = Observable([])
        var SearchMovieList : Observable<[SearchMovieResultViewModelStruct]> = Observable([])

    }
    typealias SearchMovieResultViewModelStruct = SearchMovieModel.results
    
    
    func searchMovieList (query:String ,page:Int  ,completion: @escaping ((_ result: [String:AnyObject]? , _ outputData: Data?) ->Void))
    {
       // let urls_BaseUpi : String = eVeroVisitUrls.baseApiUrl.rawValue
        
        let commonUrlsAndConstants = CommonUrlsAndConstants()
        let urls_BaseUpi : String = commonUrlsAndConstants.getBaseUrl()
        
        let urls_endPoint = "/search/movie?query=" + query + "&page=" +  String(page)
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
