import UIKit

class FeedViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var feedTableView: UITableView!
    
    // MARK: - Properties
    var post: Post?
    var postList: [Post] = []
    var isNewPost: Bool = false
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if isNewPost {
            feedTableViewReload()
        }
    }
    
    // MARK: - Functions
    func setTableView() {
        feedTableView.delegate = self
        feedTableView.dataSource = self
        feedTableView.allowsSelection = false
    }
    
    func feedTableViewReload() {
        feedTableView.reloadData()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let customCell = feedTableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! FeedTableViewCell
        
        customCell.photoSubtitleLabel.text = postList[indexPath.row].photoSubtitle
        customCell.photoImage.image = postList[indexPath.row].photo
        
        return customCell
    }
}
