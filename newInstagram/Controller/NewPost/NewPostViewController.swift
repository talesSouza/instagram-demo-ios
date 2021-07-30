import UIKit

class NewPostViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var photoNameTextField: UITextField!
    @IBOutlet weak var subtitleTextField: UITextField!
    @IBOutlet weak var newPostButton: UIButton!
    @IBOutlet weak var nameOptionsTableView: UITableView!
    
    //MARK: - Properties
    var newPost: Post? = Post()
    var postList: [Post] = []
    var isNewPost: Bool = false
    //aqui quero acessar automaticamente
    var namesList: [String] = ["bruno", "bruno2", "tales", "tales2"]
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setButton(button: newPostButton, width: 2, radius: 10, color: .systemBlue)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        isNewPost = false
        passNewPostData()
    }
    
    //MARK: - IBActions
    @IBAction func newPostTouchUpInside(_ sender: UIButton) {
        isNewPost = true
        createNewPost()
        passNewPostData()
        cleanTextFields()
    }
    
    @IBAction func showOptionsTouchUpInside(_ sender: UIButton) {
        nameOptionsTableView.isHidden = false
    }
    
    //MARK: - Functions
    func setButton(button: UIButton, width: CGFloat, radius: CGFloat, color: UIColor) {
        button.layer.borderWidth = width
        button.layer.cornerRadius = radius
        button.layer.borderColor = color.cgColor
    }
    
    func createNewPost() {
        if let _ = newPost,
           let photoName = photoNameTextField.text,
           let subtitle = subtitleTextField.text,
           let imagem = UIImage(named: "\(photoName)") {
            newPost?.photo = imagem
            newPost?.photoSubtitle = subtitle
            //aqui coloquei em outro if let pois colocando no "geral" dava erro nos newposts anteriores
            if let newPost = newPost {
                postList.append(newPost)
            }
        }
    }
    
    func passNewPostData() {
        if let vc = self.tabBarController!.viewControllers![0] as? FeedViewController {
            vc.post = newPost
            vc.isNewPost = isNewPost
            vc.postList = postList
        }
    }
    
    func cleanTextFields() {
        photoNameTextField.text = ""
        subtitleTextField.text = ""
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
        return namesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let namesCell = nameOptionsTableView.dequeueReusableCell(withIdentifier: "namesCell", for: indexPath)
        namesCell.textLabel?.text = namesList[indexPath.row]
        
        return namesCell
    }
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		photoNameTextField.text = namesList[indexPath.row]
	}
}
