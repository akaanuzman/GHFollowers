import UIKit

class ChangeLanguageVC: UIViewController {

    let languageTableView = UITableView()
    let supportedLanguages = ["en", "tr"]
    let supportedLangList = [NSLocalizedString("english", comment: ""), NSLocalizedString("turkish", comment: "")]
    


    override func viewDidLoad() {
        super.viewDidLoad()
 
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        title = NSLocalizedString("select_language", comment: "")
    }

    func setupUI() {
        languageTableView.dataSource = self
        languageTableView.delegate = self
        languageTableView.register(UITableViewCell.self, forCellReuseIdentifier: "LanguageCell")
        view.addSubview(languageTableView)

        // NSLayoutConstraint kullanarak arayüzü yerleştirme
        languageTableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            languageTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            languageTableView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            languageTableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            languageTableView.heightAnchor.constraint(equalTo: view.heightAnchor),
        ])
    }

    func changeLanguage(_ selectedLanguage: String) {
        print("Selected Language: \(selectedLanguage)")

        UserDefaults.standard.set([selectedLanguage], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
    }
}

extension ChangeLanguageVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return supportedLangList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageCell", for: indexPath)
        cell.textLabel?.text = supportedLangList[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedLanguage = supportedLanguages[indexPath.row]
        changeLanguage(selectedLanguage)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
