//
//  Model.swift
//  youtubeApp
//
//  Created by ByteDance on 2022/5/12.
//

import Foundation

protocol ModelDelegate{
    func videosFetched(_ videos:[Video])
}
class Model{
    var delegate:ModelDelegate?
    func getVideos(){
        let url=URL(string: Constants.API_URL)
        guard url != nil else{
            return
        }
        
        let session=URLSession.shared
        //get a data task from the URLSession object
        let dataTask=session.dataTask(with: url!) { (data, response, error) in
            //check if there were any errors
            if error != nil||data==nil{
                return
            }
            
            do{
                //parsing the data to video objects
                let decoder=JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                let response=try decoder.decode(Response.self, from: data!)
                if response.items != nil{
                    DispatchQueue.main.async {
                        //call the videoFetched method of the delegate
                        self.delegate?.videosFetched(response.items!)
                    }
                    
                }
                
                dump(response)
            }
            catch{
                
            }
        }
        //kick off the task
        dataTask.resume()
    }
}
