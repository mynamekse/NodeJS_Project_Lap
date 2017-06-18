//  FetchData.swift
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
import Alamofire
import ObjectMapper
import AlamofireObjectMapper
import RealmSwift

class FetchData {
    static func get <T: Object where T:Mappable, T:Meta> (type: T.Type, success:() -> Void, fail:(error:NSError)->Void)->Void {
        Alamofire.request(Method.GET, type.url())
            .responseArray { (response: Response<[T], NSError>) in
                switch response.result {
                case .Success(let items):
                    autoreleasepool {
                        do {
                            let realm = try Realm()
                            try realm.write {
                                for item in items {
                                    realm.add(item, update: true)
                                }
                            }
                        } catch let error as NSError {
                            fail(error: error)
                        }
                    }
                    success()
                case .Failure(let error):
                    fail(error: error)
                }
        }
    }
}


