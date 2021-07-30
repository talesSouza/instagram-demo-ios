import UIKit

class FeedViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var feedTableView: UITableView!
    
    // MARK: - Properties
    var postList: [Post] = []
}

// MARK: - LifeCycle
extension FeedViewController {
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setupLayout()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		feedTableView.reloadData()
	}
}

// MARK: - Functions
extension FeedViewController {
    
}

// MARK: - Setup
extension FeedViewController {
	
	private func setupLayout() {
		setupTableView()
	}
	
	private func setupTableView() {
		feedTableView.delegate = self
		feedTableView.dataSource = self
		feedTableView.allowsSelection = false
	}
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let customCell = feedTableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! FeedTableViewCell
        
        customCell.photoSubtitleLabel.text = postList[indexPath.row].subtitle
        customCell.photoImage.image = postList[indexPath.row].photo
        
        return customCell
    }
}
