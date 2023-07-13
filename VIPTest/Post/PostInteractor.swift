//
//  PostInteractor.swift
//  VIPTest
//
//  Created by AnkurPipaliya on 12/07/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol PostInteractorProtocol {
    func fetchPostsfromApi(param: [PostModel])
}

class PostInteractor: PostInteractorProtocol  {
    var posts = [PostModel]()
    let url = "https://jsonplaceholder.typicode.com/posts/"
    var presenter: PostPresentationProtocol?
    
   
    func fetchPostsfromApi(param : [PostModel]){
        
        HTTPManager.shared.get(urlString: url) { [weak self] ress in
            guard let self = self else {return}
            switch ress {
            case .failure(let err):
                print ("failure", err)
            case .success(let dat):
                let decoder = JSONDecoder()
                do {
                    self.posts = try decoder.decode([PostModel].self, from: dat)
                    
                    self.presenter?.apiResponseForPost(body: self.posts, message: "success")
                   // completion(.success(try decoder.decode([PostModel].self, from: dat)))
                } catch let err{
                    print("error in completon \(err)")
                }
            }
        }
    }
    
}
