//
//  ViewController.swift
//  youtubeApp
//
//  Created by ByteDance on 2022/5/12.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,ModelDelegate {
    
    
    @IBOutlet weak var tableVIew: UITableView!
    
    var model=Model()
    var videos=[Video]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableVIew.dataSource=self
        tableVIew.delegate=self
        model.delegate=self
        model.getVideos()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //confirm that a video was selected
        guard tableVIew.indexPathForSelectedRow != nil else{
            return
        }
        //get reference to the video that was tapped on
        let selectedVideo=videos[tableVIew.indexPathForSelectedRow!.row]
        //to the detail view controller
        let detailVC=segue.destination as! DetailViewController

        //set the video property of the detail view controller
        detailVC.video=selectedVideo
    }
        //MARK: -Model Delegate Methods
        func videosFetched(_ videos: [Video]) {
            //set the returned videos to our video property
            self.videos=videos
            tableVIew.reloadData()
        }
          
        //MARK: -tableView Methods
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return videos.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell=tableView.dequeueReusableCell(withIdentifier: Constants.VIDEOCELL_ID, for: indexPath) as!VideoTableViewCell
            
            let video=self.videos[indexPath.row]
            
            cell.setCell(video)
            return cell
        }
        
   


}

