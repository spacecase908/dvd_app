//
//  ReccomendViewController.swift
//  MovieApp
//
//  Created by user194382 on 5/27/21.
//
// Swipe feature inspired by:
// youtube.com/watch?v=0fXR-Ksuqo4

import UIKit

class ReccomendViewController: UIViewController {

    @IBOutlet weak var swipeView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var movieGenreLabel: UILabel!

    @IBOutlet weak var movieTitleLabel: UILabel!
    

    
    var collection: [Film] = []
    var recs: [Film] = []
    var currentFilm: Film!
    
    @IBAction func panCard(_ sender: UIPanGestureRecognizer) {
        let swipeView = sender.view!
        let point = sender.translation(in: view)
        let xFromCenter = swipeView.center.x - view.center.x
        
        swipeView.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
        
        if xFromCenter > 0 {
            //.image = UIImage(systemName: "hand.thumbsup.fill")
            //reactionImageView.tintColor = UIColor.green
        } else {
            //reactionImageView.image = UIImage(systemName: "hand.thumbsdown.fill")
            //reactionImageView.tintColor = UIColor.red
        }
        
        //reactionImageView.alpha = abs(xFromCenter) / view.center.x
        
        if sender.state == UIGestureRecognizer.State.ended {
            
            if swipeView.center.x < 75 {
                UIView.animate(withDuration: 0.3, animations: {
                    swipeView.center = CGPoint(x: swipeView.center.x - 200, y: swipeView.center.y)
                    swipeView.alpha = 0
                })
                perform(#selector(resetSwipeView), with: nil, afterDelay: 0.8)
                return
            } else if swipeView.center.x > (view.frame.width - 75) {
                UIView.animate(withDuration: 0.3, animations: {
                    swipeView.center = CGPoint(x: swipeView.center.x + 200, y: swipeView.center.y)
                    swipeView.alpha = 0
                })
                addToWatchList()
                perform(#selector(resetSwipeView), with: nil, afterDelay: 0.8)
                return
            }
            UIView.animate(withDuration: 0.2, animations: {
                swipeView.center = self.view.center
                //self.reactionImageView.alpha = 0
            })
            
        }
        

        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        recs = []
        for _ in 1...5 {
            let x = Int.random(in: 1..<collection.count)
            if collection[x].watched == false || collection[x].watchList == false || recs.contains(where: {$0.name == collection[x].name}) == false {
                recs.append(collection[x])
            }
            
        }
        
        currentFilm = recs.popLast()!
        
        movieGenreLabel.text = currentFilm.genre
        movieTitleLabel.text = currentFilm.name
        
        DispatchQueue.global(qos: .userInitiated).async {
            let filmImageData = NSData(contentsOf: URL(string: self.currentFilm!.imageUrl)!)
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: filmImageData! as Data)
                
        

        // Do any additional setup after loading the view.
    }
        }
    }
    
    func updateSwipeView () {
        if recs.count == 0 {
            self.imageView.image = UIImage(systemName: "smiley")
            self.movieGenreLabel.text = "Enjoy!"
            self.movieTitleLabel.text = "Time to watch some movies"
        } else {
            currentFilm = recs.popLast()!
            
            movieGenreLabel.text = currentFilm.genre
            movieTitleLabel.text = currentFilm.name
            
        }
    }
    
    @objc func resetSwipeView() {
        
        if recs.count == 0 {
            self.imageView.image = UIImage(systemName: "smiley")
            self.movieGenreLabel.text = "Enjoy!"
            self.movieTitleLabel.text = "Time to watch some movies"
        } else {
            currentFilm = recs.popLast()!
            
            movieGenreLabel.text = currentFilm.genre
            movieTitleLabel.text = currentFilm.name
            
            
            DispatchQueue.global(qos: .userInitiated).async {
                let filmImageData = NSData(contentsOf: URL(string: self.currentFilm!.imageUrl)!)
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: filmImageData! as Data)
            

            // Do any additional setup after loading the view.
        }
            }
            
        }
        UIView.animate(withDuration: 0.2, animations: {
            self.swipeView.center = self.view.center
            self.swipeView.alpha = 1
        })
    }
    
    func addToWatchList() {
        let i = collection.firstIndex {$0.name == currentFilm.name}
        collection[i!].watchList = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
