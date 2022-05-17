//
//  DetailViewController.swift
//  youtubeApp
//
//  Created by ByteDance on 2022/5/17.
//

import UIKit
import WebKit
class DetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var textView: UITextView!
    var video:Video?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        //clear the video
        titleLabel.text=""
        dateLabel.text=""
        textView.text=""

        //check if there is a video
        guard video != nil else{
            return
        }
        let embedUrl=Constants.YT_EMBED_URL+video!.videoId
        //load it into webview
        let url=URL(string: embedUrl)
        let request=URLRequest(url: url!)
        webView.load(request)
        //set the title
        titleLabel.text=video!.title
        //set the date
        let df=DateFormatter()
        df.dateFormat="EEEE,MMM d,yyyy"
        dateLabel.text=df.string(from: video!.pushlished)

        textView.text=video!.description
    }

}

