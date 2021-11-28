//
//  NoticiaResponse.swift
//  DAM-CL3
//
//  Created by kamaly on 27/11/21.
//

import Foundation

struct NoticiaResponse: Decodable{
    var status: String
    var total_hits: Int
    var page: Int
    var total_pages: Int
    var page_size: Int
    var articles: [Articles]
  
}

struct Articles: Decodable {
    var title: String
    var author: String?
    var published_date: String
    var summary: String
    var topic: String
    var media: String
    var twitter_account: String?
}


 
