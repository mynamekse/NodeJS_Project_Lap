//  Models.swift
//
// Copyright (c) 2016 Hyphe GbR
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation
import RealmSwift
import ObjectMapper

protocol Meta {
    static func url() -> String
}

class Music: Object, Mappable, Meta {
    dynamic var id = 0
    dynamic var title = ""
    dynamic var genre = ""
    dynamic var albumName = ""

    override static func primaryKey() -> String? {
        return "id"
    }

    //Impl. of Mappable protocol
    required convenience init?(_ map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        id    <- map["id"]
        title <- map["title"]
        genre <- map["genre"]
        albumName <- map["albumName"]

    }

    //Impl. of Meta protocol
    static func url() -> String {
        return "https://bitbucket.org/hyphe/blog-examples/raw/master/fetchData/demoapi/music"
    }
}

class Movie: Object, Mappable, Meta {
    dynamic var id = 0
    dynamic var title = ""
    dynamic var genre = ""

    override static func primaryKey() -> String? {
        return "id"
    }

    //Impl. of Mappable protocol
    required convenience init?(_ map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        id    <- map["id"]
        title <- map["title"]
        genre <- map["genre"]
    }

    //Impl. of Meta protocol
    static func url() -> String {
        return "https://bitbucket.org/hyphe/blog-examples/raw/master/fetchData/demoapi/movies"
    }
}

class Book: Object, Mappable, Meta {
    dynamic var id = 0
    dynamic var title = ""
    dynamic var autor = ""
    dynamic var genre = ""

    override static func primaryKey() -> String? {
        return "id"
    }

    //Impl. of Mappable protocol
    required convenience init?(_ map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        id    <- map["id"]
        title <- map["title"]
        autor <- map["autor"]
        genre <- map["genre"]
    }

    //Impl. of Meta protocol
    static func url() -> String {
        return "https://bitbucket.org/hyphe/blog-examples/raw/master/fetchData/demoapi/books"
    }
}

class Album: Object, Mappable, Meta {
    dynamic var id = 0
    dynamic var title = ""
    dynamic var genre = ""
    dynamic var albumName = ""
    var tracks = List<Track>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    //Impl. of Mappable protocol
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id    <- map["id"]
        title <- map["title"]
        genre <- map["genre"]
        albumName <- map["albumName"]
        let information = Mapper<Track>().mapArray(map["tracks"].currentValue)
        if let information = information {
            tracks.appendContentsOf(information)
        }
    }
    
    //Impl. of Meta protocol
    static func url() -> String {
        return "https://bitbucket.org/hyphe/blog-examples/raw/master/fetchData/demoapi/album"
    }
}

class Track: Object, Mappable {
    dynamic var id = 0
    dynamic var name = ""
    dynamic var runtime = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    //Impl. of Mappable protocol
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id    <- map["id"]
        name <- map["name"]
        runtime <- map["runtime"]
    }
}

