//
//  FileDownloadManager.swift
//  SwiftAppointments
//
//  Created by Venkata Vadigepalli on 09/01/2019.
//  Copyright © 2019 vvrmobilesolutions. All rights reserved.
//

import Foundation
class FileDownloadManager{
    func downloadFile(fileUrlString:String, completion: @escaping (ResultModel, URL?) -> Void){
        //later on move the directory to app private directory
        //so it will be easy to see if a file already exists or not - filename needs to be fixed for uniqueness
        //if exists don't download again but present the local existing copy - useful for offline
        let documentUrl: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first as URL!
        let destinationFileUrl = documentUrl.appendingPathComponent("pdf-test.pdf")
        // if file exists or not
        if(FileManager.default.fileExists(atPath: destinationFileUrl.path)){
            completion(ResultModel(result: true, message: ""), destinationFileUrl)
        }
        else {
            let url = URL(string: fileUrlString)!
            let request = URLRequest(url: url)
            
            let task = URLSession.shared.downloadTask(with: request) { data, response, error in
                if let tempdata = data{
                    if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                        print("Successfully downloaded. Status code: \(statusCode)")
                    }
                    
                    do{
                        try FileManager.default.copyItem(at: tempdata, to: destinationFileUrl)
                        completion(ResultModel(result: true, message: ""), destinationFileUrl)
                    }
                    catch(let writeError){
                        completion(ResultModel(result:false, message:writeError.localizedDescription), nil)
                        return
                    }
                }
                else{
                    completion(ResultModel(result:false, message:"Error while downloading file"), nil)
                    return
                }
            }
            
            task.resume()
        }
        
    }
}
