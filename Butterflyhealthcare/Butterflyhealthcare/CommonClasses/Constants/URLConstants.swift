//
//  URLConstants.swift
//  Butterflyhealthcare
//
//  Created by Gerald George on 31/12/2023.
//

import Foundation

class CommonUrlsAndConstants : NSObject{
    func getBaseUrl()  -> String{
        return "https://api.themoviedb.org/3"
    }
    func getAuthorizationToken()  -> String{
        return "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2ZTBiYWMzNjJjYTkwNzA0MDc1OTRhYWJjMjcwNTVhNSIsInN1YiI6IjY1OGY3NWY1ZWZjZWE5MDFmNWY5ZWVjMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.giLwC2hqd_0O9ShK8gaHSHRXXy8Pg6-hjDzLFU5nsQA"
    }
    
    func getPosterImageBaseUrl()  -> String{
        return "https://image.tmdb.org/t/p/w185/"
    }
    
}
