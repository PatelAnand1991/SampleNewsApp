//
//  ListManager.swift
//  NewsFeed
//
//  Created by Karan Bhatt on 09/07/21.
//  Copyright © 2021 Anand Patel. All rights reserved.
//

import Foundation


/// RequestParams
struct Query: Equatable{
    var country: String
    var page: String
    var id: String
    var count: String
}

/// Equate to avoid duplicates
func ==(lhs: Query, rhs: Query) -> Bool{
    return lhs.country == rhs.country
        && lhs.page == rhs.page
        && lhs.id == rhs.id
        && lhs.count == rhs.count
}


//API Response Type Enum
enum SResults<T>{
    case Success(result: T)
    case Failure(error: SErrorType)
}

// MARK: - SError
enum SErrorCodes: String{
    case OK
    case ERROR
    case UNAUTHORISED
}

// MARK: - SError
enum SErrorType: Equatable, Error{
    case CannotFetch(String)
    case CannotCreate(String)
    case CannotUpdate(String)
    case CannotDelete(String)
}


// MARK: SResultsProtocol
protocol SResultsProtocol{
    func fetchRecomendations(params: Query?,completionHandler: @escaping SResultsCompletionHandler)
}

// MARK: completionHandler
typealias SResultsCompletionHandler = (SResults<Meta?>) -> Void


class ListManager {

    ///  API Req Helper: https://newsapi.org/v2/top-headlines?country=us&apiKey=a13d06a9e79448f19acb9df5a537e934
    ///
    /// - Parameters:
    ///   - params:{ query }
    ///   - completionHandler: SResults<[Meta]>
    func fetch(params: Query?,completionHandler: @escaping SResultsCompletionHandler){
        guard let param = params else {
            assertionFailure("Query Missing")
            return
        }
        let url = setURL(model: param)
        print("Requesting 🚀 \(url)")
        ListManager.getDataRequest(url: url, token: nil, contentType: nil, auth: false) { (data, err) in
            guard let response = data else {
                completionHandler(SResults.Failure(error: SErrorType.CannotFetch("An Error Occured")))
                return
            }
            do {
                let decoder = JSONDecoder()
                let decoded = try decoder.decode(Meta.self, from: response)
                if decoded.articles?.count ?? 1 < 1{
                    let errored = try decoder.decode(SError.self, from: response)
                    do{
                        completionHandler(SResults.Failure(error: SErrorType.CannotFetch(errored.message ?? "")))
                    }
                }else{
                    completionHandler(SResults.Success(result: decoded))
                }
            }catch _ {
                completionHandler(SResults.Failure(error: SErrorType.CannotFetch("An Error Occured")))
            }
        }
    }
    
    /// getDataRequest - Decodable Result
    ///
    /// - Parameters:
    ///   - url: API url
    ///   - parameters: Body - Params
    ///   - token: token - Default : None
    ///   - auth: if token not required send §false§
    ///   - completionHandler: Data/Err
    class func getDataRequest(url:String,token:String?,contentType:String?, auth:Bool,completionHandler:@escaping (Data?, Error?) -> ()) -> (){
        let ephemeralConfiguration = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: ephemeralConfiguration)
        guard let urlStr = URL(string: url.replacingOccurrences(of: " ", with: "")) else {
            completionHandler( nil, nil)
            return
        }
        var request = URLRequest(url: urlStr)
        request.httpMethod = "GET"
        if let content = contentType {
            request.addValue(content.isEmpty ? "application/json":content, forHTTPHeaderField: "Content-Type")
        }else{
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            guard error == nil else{
                completionHandler(nil, error)
                return
            }
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            do {
                completionHandler(data, error)
            }
        })
        task.resume()
    }
    
    /// Request API
    ///
    /// - Parameters:
    ///   - query: country/ apiKey
    ///   - page: optional count for on demand - pull to refresh
    ///   - completion: Meta / Error
    func request(query :Query, completion: @escaping (Meta?) -> Void){
        let param = Query(country: query.country, page: query.page, id: query.id, count: query.count)
        self.fetch(params: param) { (result: SResults<Meta?>) -> Void in
            switch (result) {
            case .Success(let movies):
                completion(movies )
                print("Success  ✅ \n Total \(movies?.articles?.count ?? 1) \n PageTotal \(movies?.totalResults ?? 1)")
            case .Failure(_):
                completion(nil)
                print("Failure  ❌\(SErrorType.CannotFetch("Error"))")
            }
        }
    }
    
    ///Constructor : URL
    func setURL(model : Query) -> String {
        let baseurl     = BaseUrl + ServiceList.Topheadlines.rawValue + "?"
        let country     = "country=\(model.country)&"
        let key         = "apiKey=\(model.id)"
        let url         = baseurl + country + key
        return url
    }
}
