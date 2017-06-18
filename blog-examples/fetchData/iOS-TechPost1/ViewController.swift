//  ViewController.swift
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

import UIKit
import RealmSwift
import ObjectMapper

class ViewController: UIViewController {

    let realm = try! Realm()
    var books: Results<Book>?
    var music: Results<Music>?
    var movies: Results<Movie>?
    var albums: Results<Album>?


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.books = self.realm.objects(Book)
        self.music = self.realm.objects(Music)
        self.movies = self.realm.objects(Movie)
        self.albums = self.realm.objects(Album)


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnFetchMusicPressed(sender: UIButton) {
        FetchData.get(Music.self, success: {
            self.infoAlert("Music", message: "Successful fetched Music information\n\(self.music!.debugDescription)")
            }){ (error) in
            self.infoAlert("Music", message: "Unsuccessful fetched Music information\n\(error.description)")
        }
    }
    
    @IBAction func btnFetchBooksPressed(sender: UIButton) {
        FetchData.get(Book.self, success: {
            self.infoAlert("Music", message: "Successful fetched Book information\n\(self.books!.debugDescription)")
        }) { (error) in
            self.infoAlert("Music", message: "Unsuccessful fetched Book information\n\(error.description)")
        }
    }
    
    @IBAction func btnFetchMoviesPressed(sender: UIButton) {
        FetchData.get(Movie.self, success: {
            self.infoAlert("Music", message: "Successful fetched Movie information\(self.movies!.debugDescription)")
        }) { (error) in
            self.infoAlert("Music", message: "Unsuccessful fetched Movie information\n\(error.description)")
        }
    }
    
    @IBAction func btnFetchAlbumsPressed(sender: UIButton) {
        FetchData.get(Album.self, success: {
            self.infoAlert("Album", message: "Successful fetched Album informations\(self.albums!.debugDescription)")
        }) { (error) in
            self.infoAlert("Music", message: "Unsuccessful fetched Album information\n\(error.description)")
        }
    }
    
    @IBAction func btnOpenHypheBlogPressed(sender: UIButton) {
        let url: NSURL = NSURL(string: "https://blog.hyphe.me")!
        if UIApplication.sharedApplication().canOpenURL(url) {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    func infoAlert(title: String, message: String) -> Void {
        let actionSheetController: UIAlertController = UIAlertController(title:title, message:message, preferredStyle: .Alert)
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in }
        actionSheetController.addAction(cancelAction)
        self.presentViewController(actionSheetController, animated: true, completion: nil)
    }
}
