//
//  VideoTableViewCell.swift
//  youtubeApp
//
//  Created by ByteDance on 2022/5/13.
//

import UIKit

class VideoTableViewCell: UITableViewCell {
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    var video:Video?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(_ v:Video){
        self.video=v
        //ensure that we have a video
        guard self.video != nil else {
            return
        }
        //set the title
        self.titleLabel.text=video?.title
        
        //set the date
        let df=DateFormatter()
        df.dateFormat="EEEE,MMM d,yyyy"
        self.dateLabel.text=df.string(from: video!.pushlished)
        
        //set the thumbnail
        guard self.video!.thumbnail != "" else {
            return
        }

        //check cache before downloading data
        if let cachedData = CacheManager.getVideoCache(self.video!.thumbnail){
            //set the thumbnailImageView
            self.thumbnailImageView.image=UIImage(data: cachedData)
            //already have the image in the cache, so don't bother to redownload it
            return
        }
        //download the thumbnail data
        let url=URL(string: self.video!.thumbnail)
        
        //get the shared URL session object
        let session=URLSession.shared
        
        //create a datatask
        let dataTask=session.dataTask(with: url!) { (data, response, error) in
            if error == nil && data != nil{
                //save the data in the cache
                CacheManager.setVideoCache(url!.absoluteString, data)
                //check that the downloaded url matches the video thumbnail url that this cell is currently set to display
                if url!.absoluteString != self.video?.thumbnail{
                    //video vell has been recycled for another video
                    return
                }
                //create the image object
                let image=UIImage(data: data!)
                //set the image view
                DispatchQueue.main.async {
                    self.thumbnailImageView.image=image
                }
            }
        }
        dataTask.resume()
    }
}
