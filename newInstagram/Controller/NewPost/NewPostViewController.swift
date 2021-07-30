import UIKit

class NewPostViewController: UIViewController {
	
	//MARK: - IBOutlets
	@IBOutlet weak var photoNameTextField: UITextField!
	@IBOutlet weak var subtitleTextField: UITextField!
	@IBOutlet weak var newPostButton: UIButton!
	@IBOutlet weak var nameOptionsTableView: UITableView!
	
	//MARK: - Properties
	var photoNameList: [String] = ["bruno", "bruno2", "tales", "tales2"]
}

//MARK: - LifeCycle
extension NewPostViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupLayout()
	}
}

//MARK: - IBActions
extension NewPostViewController {
	
	@IBAction func newPostTouchUpInside(_ sender: UIButton) {
		createNewPost()
	}
	
	@IBAction func showOptionsTouchUpInside(_ sender: UIButton) {
		nameOptionsTableView.isHidden = false
	}
}

//MARK: - Functions
extension NewPostViewController {
	
	private func createNewPost() {
		
		if let photoName = photoNameTextField.text,
		   let image = UIImage(named: "\(photoName)"),
		   let subtitle = subtitleTextField.text {
			
			let post = Post(photo: image, subtitle: subtitle)
			if passNewPostData(post) {
				cleanTextFields()
			}
		} else {
			print("invalid data")
		}
	}
	
	private func passNewPostData(_ post: Post) -> Bool {
		if let vc = self.tabBarController?.viewControllers?[1] as? FeedViewController {
			vc.postList.append(post)
			return true
		}
		return false
	}
	
	private func cleanTextFields() {
		photoNameTextField.text = ""
		subtitleTextField.text = ""
	}
}

// MARK: - Setup
extension NewPostViewController {
	
	private func setupLayout() {
		setupButton(button: newPostButton, width: 2, radius: 10, color: .systemBlue)
	}
	
	private func setupButton(button: UIButton, width: CGFloat, radius: CGFloat, color: UIColor) {
		button.layer.borderWidth = width
		button.layer.cornerRadius = radius
		button.layer.borderColor = color.cgColor
	}
}

//MARK: - UITextFieldDelegate
extension NewPostViewController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		
		photoNameTextField.resignFirstResponder()
		subtitleTextField.resignFirstResponder()
		return true
	}
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension NewPostViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return photoNameList.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let namesCell = nameOptionsTableView.dequeueReusableCell(withIdentifier: "namesCell", for: indexPath)
		namesCell.textLabel?.text = photoNameList[indexPath.row]
		
		return namesCell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		photoNameTextField.text = photoNameList[indexPath.row]
	}
}
